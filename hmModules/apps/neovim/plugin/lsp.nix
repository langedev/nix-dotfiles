{ config, pkgs, lib, ... }:

{
  config = lib.mkIf config.neovim.enable {
    programs.neovim.plugins = let
      cfgp = config.neovim.plugins;
      cfgl = config.neovim.languages;

      configText = ''
        local on_attach = function(_, bufnr)

          local bufmap = function(keys, func)
            vim.keymap.set('n', keys, func, { buffer = bufnr })
          end

          bufmap('<leader>r', vim.lsp.buf.rename)
          bufmap('<leader>a', vim.lsp.buf.code_action)

          bufmap('gd', vim.lsp.buf.definition)
          bufmap('gD', vim.lsp.buf.declaration)
          bufmap('gI', vim.lsp.buf.implementation)
          bufmap('<leader>D', vim.lsp.buf.type_definition)

      '' + lib.strings.optionalString cfgp.telescope.enable ''
          bufmap('gr', require('telescope.builtin').lsp_references)
          bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
          bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)
      '' + ''

          bufmap('K', vim.lsp.buf.hover)

          vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
          end, {})
        end

        local capabilities = vim.lsp.protocol.make_client_capabilities()
      '' + lib.strings.optionalString cfgl.nix.enable ''
        require('lspconfig').nil_ls.setup {}
      '' + lib.strings.optionalString cfgl.c.enable ''
        require('lspconfig').clangd.setup {}
      '' + lib.strings.optionalString cfgl.rust.enable ''
        require('lspconfig').rustaceanvim.setup {}
      '';
    in with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = configText;
      }
    ];
  };
}
