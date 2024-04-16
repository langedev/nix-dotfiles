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

      treeplugs = p: lib.lists.optional cfgl.nix.enable p.tree-sitter-nix;
    in with pkgs.vimPlugins; [
      {
        plugin = (nvim-treesitter.withPlugins treeplugs);
        type = "lua";
        config = configText;
      }
    ];
  };
}
