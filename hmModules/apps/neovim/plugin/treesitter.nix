{ config, pkgs, lib, ... }:

let
  cfgp = config.neovim.plugins;
  cfgl = config.neovim.languages;
in {
  config = lib.mkIf (config.neovim.enable && cfgp.treesitter.enable)  {
    programs.neovim.plugins = let
      configText = ''
        require('nvim-treesitter.configs').setup {
          ensure_installed = {},

          auto_install = false,

          highlight = { enable = true },

          indent = { enable = true },
        }
      '';

      # I've tried many things, and can't get treesitter plugins changing
      # dynamically. For not just have them always loaded regardless of config
      treeplugs = p: [
        p.tree-sitter-c
        p.tree-sitter-go
        p.tree-sitter-nix
        p.tree-sitter-rust
      ];
    in with pkgs.vimPlugins; [
      {
        plugin = (nvim-treesitter.withPlugins treeplugs);
        type = "lua";
        config = configText;
      }
    ];
  };
}
