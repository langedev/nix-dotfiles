{ config, inputs, pkgs, lib, ... }:
let rootPath = ./.; in
{
  options.hypr = {
    enable = lib.mkEnableOption "Enables hyprland";
    mod_key = lib.mkOption { default = "SUPER"; };
    monitor = { 
      details = lib.mkOption { default = []; };
    };
    workspace = {
      workspaces = lib.mkOption { default = {}; };
      scratchpad.enable = lib.mkEnableOption "Enables a scratchpad";
      defaults = lib.mkOption { default = {}; };
      # primary-secondary = {
      #   enable = lib.mkEnableOption "Enables the primary-secondary navigation style";
      #   primary = lib.mkOption { default = "DP-1"; };
      #   secondary = lib.mkOption { default = "DP-2"; };
      #   secondaries = lib.mkOption { default = []; };
      # };
    };
    windows.opaque = lib.mkOption { default = []; };
    background = {
      enable = lib.mkEnableOption "Enables a wallpaper";
      path = lib.mkOption { default = ""; };
    };
    cursor = {
      enable = lib.mkEnableOption "Enables custom cursor";
      theme = lib.mkOption { default = ""; };
      size = lib.mkOption { default = 64; };
    };
    xwayland.videobridge.enable = lib.mkEnableOption "Enable xwaylandvideobridge";
    mouse.sensitivity = lib.mkOption { default = 0; };
    master.mfact = lib.mkOption { default = 0.55; };
    polkit.enable = lib.mkEnableOption "Enables polkit agent";
    screenshot.enable = lib.mkEnableOption "Enables Screenshotting";
  };

  imports = [ inputs.hyprland.homeManagerModules.default ];

  config = let 
    lopts = lib.lists.optionals;
  in {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  } // lib.mkIf config.hypr.enable {
    wayland.windowManager.hyprland = let
      mod = config.hypr.mod_key;
      # p-s = let
      #   chw = config.hypr.workspace;
      #   findDefaultWs = id: if (builtins.hasAttr id chw.workspaces) 
      #     then (builtins.head (builtins.getAttr id chw.workspaces))
      #     else "";
      # in with config.hypr.workspace; lib.mkIf primary-secondary.enable {
      #   primaryWs = findDefaultWs primary-secondary.primary;
      #   secondaryWs = findDefaultWs primary-secondary.secondary;
      # };
    in {
      enable = true;
      settings = {
        monitor = config.hypr.monitor.details;
        workspace = let
          wsMonitor = monitor: wrksps: map (ws:
            if ws == (builtins.head wrksps)
            then "name:"+ws+", monitor:"+monitor+", persistent:true, default:true"
            else "name:"+ws+", monitor:"+monitor+", persistent:true"
          ) wrksps;
          makeRules = wsAttr: builtins.concatLists (builtins.attrValues (
            builtins.mapAttrs wsMonitor wsAttr
          ));
        in makeRules config.hypr.workspace.workspaces
        ++ lopts config.hypr.workspace.scratchpad.enable [
          "special:scratch, on-created-empty: [float; size 50% 50%; center] ${config.defaultApps.terminal}"
        ];
        input = {
          accel_profile = "flat";
          sensitivity = config.hypr.mouse.sensitivity;
        };
        general = {
          gaps_in = 3;
          gaps_out = 3;
          border_size = 2;
          "col.active_border" = "rgb(F5C2E7)";
          "col.inactive_border" = "rgb(1E1D2F)";
          layout = "master";
        };
        decoration = {
          rounding = 2;
          blur = {
              enabled = true;
              size = 12;
              passes = 2;
              special = true;
          };
        };
        animation = [
          "windows, 1, 4, default, popin 50%"
          "windowsOut, 1, 4, default, popin 50%"
          "windowsMove, 1, 3, default"
          "border, 1, 3, default"
          "fade, 1, 3, default"
          "workspaces, 1, 3, default"
        ];
        master = {
            no_gaps_when_only = 1;
            mfact = config.hypr.master.mfact;
        };
        misc = {
          focus_on_activate = true;
        };

        exec-once = lopts config.hypr.polkit.enable [
          "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
        ] ++ lopts config.hypr.background.enable [
          "${pkgs.swww}/swww init"
          "${pkgs.swww}/swww img ${config.hypr.background.path}"
        ] ++ lopts config.ags.enable [
          "ags"
        ] ++ lopts config.beeper.enable [
          "[workspace name:chat silent] Beeper"
        ];

        env = with config.hypr; [
          # "HYPR_MON_PRIMARY, ${workspace.primary-secondary.primary}"
          # "HYPR_MON_SECONDARY, ${workspace.primary-secondary.secondary}"
          "HYPR_WORK_DB, ${config.xdg.cacheHome}/hypr/workspace.db"
        ] ++ lopts cursor.enable [
          "HYPRCURSOR_THEME,${cursor.theme}"
          "HYPRCURSOR_SIZE,${cursor.size}"
        ] ++ lopts config.nvidia.enable [
          "LIBVA_DRIVER_NAME,nvidia"
          "XDG_SESSION_TYPE,wayland"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "WLR_RENDERER_ALLOW_SOFTWARE,1"
          "WLR_DRM_DEVICES,/dev/dri/card1"
        ];

        windowrulev2 = let
            workspaceDefaults = wsname: applist: map (
                app: "workspace " + wsname + ", " + app
              ) applist;
            allDefault = wsAttr: builtins.concatLists (builtins.attrValues (
                builtins.mapAttrs workspaceDefaults wsAttr
              ));
          in allDefault config.hypr.workspace.defaults
          ++ lopts config.hypr.xwayland.videobridge.enable [
            "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
            "noanim,class:^(xwaylandvideobridge)$"
            "noinitialfocus,class:^(xwaylandvideobridge)$"
            "maxsize 1 1,class:^(xwaylandvideobridge)$"
            "noblur,class:^(xwaylandvideobridge)$"
          ] ++ map (id: "opacity 1 override, " + id) config.hypr.windows.opaque 
          ++ [
            "opacity 0.94 fullscreen:0"
            "opacity 0.79 override, class:^(${config.defaultApps.terminal})$"
          ];

        # 1, exec, $XDG_CONFIG_HOME/hypr/scripts/changeprimary.xsh home
        # 2, exec, $XDG_CONFIG_HOME/hypr/scripts/changeprimary.xsh web
        # 3, exec, $XDG_CONFIG_HOME/hypr/scripts/changeprimary.xsh med
        # 4, exec, $XDG_CONFIG_HOME/hypr/scripts/changeprimary.xsh game
        # 5, exec, $XDG_CONFIG_HOME/hypr/scripts/changeprimary.xsh etc
        # _, exec, $XDG_CONFIG_HOME/hypr/scripts/changeprimary.xsh hell
        # TAB, exec, $XDG_CONFIG_HOME/hypr/scripts/changesecondary.xsh
        #
        # SHIFT, 1, movetoworkspacesilent, name:home
        # SHIFT, 2, movetoworkspacesilent, name:web
        # SHIFT, 3, movetoworkspacesilent, name:med
        # SHIFT, 4, movetoworkspacesilent, name:game
        # SHIFT, TAB, movetoworkspacesilent, r-1

        bind = let
          modPrefix = kb: if (lib.strings.hasPrefix "&" kb)
            then ("${mod}" + kb)
            else ("${mod}, " + kb);
        in map modPrefix ([
          "return, exec, ${config.defaultApps.terminal}"
          "&SHIFT, Q, exit"
          "h, focusmonitor, l"
          "l, focusmonitor, r"
          "j, cyclenext,"
          "k, cyclenext, prev"
          "&SHIFT, h, movecurrentworkspacetomonitor, -1"
          "&SHIFT, l, movecurrentworkspacetomonitor, +1"
          "&SHIFT, j, swapnext,"
          "&SHIFT, k, swapnext, prev"
          "c, killactive"
          "f, togglefloating"
          "&SHIFT, f, fullscreen"
        ] ++ (let
          workspaces = builtins.concatLists (
            builtins.attrValues config.hypr.workspace.workspaces);
          wsBinds = with builtins; wrksps: depth: if depth > (length wrksps)
            then []
            else let ws = builtins.elemAt wrksps (depth -1); in [
              "${toString depth}, workspace, name:${ws}"
              "&SHIFT, ${toString depth}, movetoworkspacesilent, name:${ws}"
            ] ++ wsBinds wrksps (depth + 1);
        in wsBinds workspaces 1) ++ lopts config.rofi.enable [
          "&SHIFT, return, exec, ${pkgs.rofi}/rofi -show run"
        ] ++ lopts config.hypr.screenshot.enable [
          "P, exec, ${pkgs.grimblast}/grimblast --freeze copy area"
          "&SHIFT, P, exec, ${pkgs.grimblast}/grimblast --freeze copysave area"
        ] ++ lopts config.hypr.workspace.scratchpad.enable [
          "i, togglespecialworkspace, scratch"
        ]);

        bindm = map (kb: "${mod}, " + kb) [
          "mouse:272, movewindow"
          "mouse:273, movewindow"
        ];
      };
    };

    home.packages = with pkgs; [
      wlr-randr # Xrandr for wayland
      wl-clipboard # Clipboard manager for wayland
      xdg-desktop-portal-hyprland # XDP for hyprland
    ] ++ lopts config.hypr.xwayland.videobridge.enable [
      xwaylandvideobridge
    ] ++ lopts config.hypr.cursor.enable [
      hyprcursor
    ] ++ lopts config.hypr.screenshot.enable [
      hyprpicker # Colorpicker, needed for screenshot tool
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    ];

    xdg.configFile."hypr-scripts" = {
      source = rootPath + "/scripts";
      target = "hypr/scripts";
      executable = true;
    };

    xdg.dataFile."hypr-icons" = lib.mkIf config.hypr.cursor.enable {
      source = rootPath + "/icons";
      target = "icons/";
      recursive = true;
    };
  };
}
