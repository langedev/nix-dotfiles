{ config, pkgs, lib, ... }:

{
  options.neovim = {
    enable = lib.mkEnableOption "Enables neovim";
    languages = {
      nix.enable = lib.mkEnableOption "Enables nix support";
      c.enable = lib.mkEnableOption "Enables c support";
    };
    plugins = {
      comments.enable = lib.mkEnableOption "Enables nvim-comment";
      fugitive.enable = lib.mkEnableOption "Enables git-fugitive";
      lualine.enable = lib.mkEnableOption "Enables lualine";
      luasnip.enable = lib.mkEnableOption "Enables luasnip snippets";
      nvimcmp.enable = lib.mkEnableOption "Enables nvim completion";
      telescope = {
        enable = lib.mkEnableOption "Enables telescope";
        fzf.enable = lib.mkEnableOption "Enables telescope-fzf";
      };
      treesitter.enable = lib.mkEnableOption "Enables treesitter";
      wiki.enable = lib.mkEnableOption "Enables a wiki";
    };
  };

  imports = [
    ./plugin/lsp.nix
    ./plugin/nvimcmp.nix
    ./plugin/telescope.nix
    ./plugin/treesitter.nix
  ];

  config = lib.mkIf config.neovim.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraLuaConfig = ''
        ${builtins.readFile ./options.lua}
      '';

      extraPackages = with pkgs; [
        (lib.mkIf config.neovim.languages.nix.enable nil)
        (lib.mkIf config.neovim.languages.c.enable libclang)
      ];

      # Additional packages are added through imports
      plugins = let
        lopts = lib.lists.optionals;
        cfgp = config.neovim.plugins;
        cfgl = config.neovim.languages;

        comments = lopts cfgp.comments.enable (with pkgs.vimPlugins; [
          {
            plugin = comment-nvim;
            type = "lua";
            config = "require(\"Comment\").setup()";
          }
        ]);

        fugitive = lopts cfgp.fugitive.enable (with pkgs.vimPlugins; [
          vim-fugitive
        ]);

        luasnip-pkg = lopts cfgp.luasnip.enable (with pkgs.vimPlugins; [
          luasnip
          friendly-snippets
          (lib.mkIf cfgp.nvimcmp.enable cmp_luasnip)
        ]);

        lualine = lopts cfgp.lualine.enable (with pkgs.vimPlugins; [
          {
            plugin = lualine-nvim;
            type = "lua";
            config = ''
              require("lualine").setup({
                icons_enabled = true,
              })
            '';
          }
          nvim-web-devicons
        ]);

        nix-pkg = lopts cfgl.nix.enable (with pkgs.vimPlugins; [
          vim-nix
        ]);

        wiki = lopts cfgp.wiki.enable (with pkgs.vimPlugins; [
          {
            plugin = vimwiki;
            type = "lua";
            config = ''
              vim.g.vimwiki_list = {
                {
                  path = '${config.xdg.userDirs.documents}/wiki',
                  links_space_char = '_',
                  ext = '.md',
                  syntax = 'markdown',
                }
              }
            '';
          }
        ]);
      in comments ++ fugitive ++ luasnip-pkg ++ lualine ++ nix-pkg ++ wiki;
    };
  };
}
