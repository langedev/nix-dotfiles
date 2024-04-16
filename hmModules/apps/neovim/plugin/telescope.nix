{ config, pkgs, lib, ... }:

let
  cfgp = config.neovim.plugins;
in {
  config = lib.mkIf (config.neovim.enable && cfgp.telescope.enable)  {
    programs.neovim.plugins = let
      configText = ''
        require('telescope').setup({
          extensions = {
      '' + lib.strings.optionalString cfgp.telescope.fzf.enable ''
            fzf = {
              fuzzy = true,                    -- false will only do exact matching
              override_generic_sorter = true,  -- override the generic sorter
              override_file_sorter = true,     -- override the file sorter
              case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                             -- the default case_mode is "smart_case"
            }
      '' + ''
          }
        })

      '' + lib.strings.optionalString cfgp.telescope.fzf.enable ''
        require('telescope').load_extension('fzf')
      '';
    in with pkgs.vimPlugins; [
      {
        plugin = telescope-nvim;
        type = "lua";
        config = configText;
      }
      (lib.mkIf cfgp.nvimcmp.enable telescope-fzf-native-nvim)
    ];

    home.packages = with pkgs; [
      (lib.mkIf cfgp.telescope.fzf.enable fzf)
    ];

  };
}
