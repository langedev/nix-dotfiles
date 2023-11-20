{ config, pkgs, ... }:

{
  programs.neovim.enable = true;
  programs.neovim.extraConfig = ''
  	${builtins.readFile ./init.vim}
  '';
  programs.neovim.plugins = with pkgs.vimPlugins; [
    { # Personal Wiki
      plugin = vimwiki;
      config = ''
        let g:vimwiki_list = [{'path': '~/dox/wiki', 'links_space_char': '_',
                     \ 'ext': '.md', 'syntax': 'markdown'}]
      '';
    }
    { # NNN in vim
      plugin = nnn-vim;
      config = ''
        let g:nnn#layout = { 'window': {
            \ 'width': 0.35,
            \ 'height': 0.5,
            \ 'xoffset': 1.0,
            \ 'highlight': 'Debug' } } " hover window
        let g:nnn#action = {
            \ '<c-t>': 'tab split',
            \ '<c-s>': 'split',
            \ '<c-v>': 'vsplit' }
        let g:nnn#command = 'nnn -HoeT v'
        let g:nnn#replace_netrw = 1
        '';
    }
    { # Fuzzy searches
      plugin = fzf-vim;
      config = ''
        map <C-f> :Files<CR>
        map <C-a> :Ag<CR>
      '';
    }
    { # Auto completions
      plugin = coc-nvim;
      config = ''
        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
      '';
    }
    vim-commentary # multi-line comments
    vim-fugitive # Git Plugin
    vimtex # Latex support
    tagbar # File tagging

    # === LOOK AND FEEL ===
    { # Status Bar
      plugin = vim-airline;
      config = ''
        let g:airline#extensions#tagbar#flags = 'fs'
      '';
    }
    { # Rainbow Parenthesis
      plugin = rainbow;
      config = ''
        let g:rainbow_actve = 1
      '';
    }
    vim-polyglot # Syntax Highlighting
  ];
}
