{ config, pkgs, lib, ... }:

let
  cfgp = config.neovim.plugins;
in {
  config = lib.mkIf (config.neovim.enable && cfgp.nvimcmp.enable)  {
    programs.neovim.plugins = let

      configText = ''
        local cmp = require('cmp')
      '' + lib.strings.optionalString cfgp.luasnip.enable ''
        local luasnip = require('luasnip')

        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup {}
      '' + ''

        cmp.setup {
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
      '' + lib.strings.optionalString cfgp.luasnip.enable ''
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
      '' + ''
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
      '' + lib.strings.optionalString cfgp.luasnip.enable ''
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
      '' + ''
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
      '' + lib.strings.optionalString cfgp.luasnip.enable ''
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            sources = {
                { name = 'luasnip' },
            },
      '' + ''
        }
      '';
    in with pkgs.vimPlugins; [
      {
        plugin = nvim-cmp;
        type = "lua";
        config = configText;
      }
    ];
  };
}
