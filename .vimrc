" Modeline and Notes {
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:
"
" inspired by Steve Francia´s .vimrc
" (Apache License, Version 2.0, https://github.com/spf13/spf13-vim)
" }

" Environment {

" Identify platform {
    silent function! OSX()
        return has('macunix')
    endfunction
    silent function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! CYGWIN()
        return has('unix') && has('win32unix')
    endfunction
    silent function! WINDOWS()
        return  (has('win32') || has('win64'))
    endfunction
" }

" Basics {
    set nocompatible        " Must be first line
    set background=dark     " Assume a dark background

    " Be nice and check for multi_byte even if the config requires
    " multi_byte support most of the time
    if has("multi_byte")
        set termencoding=utf-8
        " Let Vim use utf-8 internally, because many scripts require this
        set encoding=utf-8
        setglobal fileencoding=utf-8
        " Windows has traditionally used cp1252, so it's probably wise to
        " fallback into cp1252 instead of eg. iso-8859-15.
        " Newer Windows files might contain utf-8 or utf-16 LE so we might
        " want to try them first.
        set fileencodings=ucs-bom,utf-8,utf-16le,iso-8859-15
    endif
    if !WINDOWS()
        set shell=/bin/sh
    endif
" }

" Windows Compatible {
    " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
    " across (heterogeneous) systems easier.
    if WINDOWS()
      set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME

      " Be nice and check for multi_byte even if the config requires
      " multi_byte support most of the time
      if has("multi_byte")
        " Windows cmd.exe still uses cp850. If Windows ever moved to
        " Powershell as the primary terminal, this would be utf-8
        set termencoding=cp850
        " Let Vim use utf-8 internally, because many scripts require this
        set encoding=utf-8
        setglobal fileencoding=utf-8
        " Windows has traditionally used cp1252, so it's probably wise to
        " fallback into cp1252 instead of eg. iso-8859-15.
        " Newer Windows files might contain utf-8 or utf-16 LE so we might
        " want to try them first.
        set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
      endif
    endif
" }

" Arrow Key Fix {
    " https://github.com/spf13/spf13-vim/issues/780
    if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
        inoremap <silent> <C-[>OC <RIGHT>
    endif
" }

" Setup Bundle Support {
    " The next three lines ensure that the ~/.vim/bundle/ system works
    filetype off
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin('~/.vim/bundle')

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " Add an UnBundle command {
        function! UnPlugin(arg, ...)
            let bundle = vundle#config#init_bundle(a:arg, a:000)
            call filter(g:vundle#bundles, 'v:val["name_spec"] != "' . a:arg . '"')
        endfunction

        com! -nargs=+         UnPlugin
            \ call UnPlugin(<args>)
    " }
" }

" }

" my own options {

" Prevent automatically changing to open file directory
let g:rm_no_autochdir = 1

" Leader keys
let mapleader = ','
let maplocalleader = '_'

set notimeout ttimeout      " no timeout for mappings, but for keycodes

" Disable easier moving in tabs and windows
let g:rm_no_easyWindows = 1

" Disable wrap relative motion for start/end line motions
let g:rm_no_wrapRelMotion = 1

" Disable fast tab navigation
let g:rm_no_fastTabs = 1

" Clear search highlighting
let g:rm_clear_search_highlight = 1

" Disable neosnippet expansion
" This maps over <C-k> and does some Supertab
" emulation with snippets
let g:rm_no_neosnippet_expand = 1

" Disable whitespace stripping
let g:rm_keep_trailing_whitespace = 1

" Enable powerline symbols
let g:airline_powerline_fonts = 0

" vim files directory
let g:rm_consolidated_directory = $HOME . '/.vim/'

" This makes the completion popup strictly passive.
" Keypresses acts normally. <ESC> takes you of insert mode, words don't
" automatically complete, pressing <CR> inserts a newline, etc. Iff the
" menu is open, tab will cycle through it. If a snippet is selected, <C-k>
" expands it and jumps between fields.
let g:rm_noninvasive_completion = 1

" Don't turn conceallevel or concealcursor
let g:rm_no_conceal = 1

" For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
" Indent guides will attempt to set your colors smartly. If you
" want to control them yourself, do it here.
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=233
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=234

" Leave the default font and size in GVim
" To set your own font, do it from ~/.vimrc.local
let g:rm_no_big_font = 1

" Disable  omni complete
let g:rm_no_omni_complete = 1

" Don't create default mappings for multicursors
" See :help multiple-cursors-mappings
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" Require a special keypress to enter multiple cursors mode
let g:multi_cursor_start_key='+'

" Mappings for editing/applying rm config
let g:rm_edit_config_mapping='<leader>ev'
let g:rm_apply_config_mapping='<leader>sv'
" }

" Bundles {

    " Deps {
        Plugin 'kana/vim-textobj-user'
        Plugin 'MarcWeber/vim-addon-mw-utils'
        Plugin 'Shougo/vimproc.vim'
        Plugin 'tomtom/pluginstats_vim'
        Plugin 'tomtom/stakeholders_vim'
        Plugin 'tomtom/tlib_vim'
        Plugin 'tpope/vim-repeat'
    "         if executable('ag')
    "             Bundle 'mileszs/ack.vim'
    "             let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
    "         elseif executable('ack-grep')
    "             let g:ackprg="ack-grep -H --nocolor --nogroup --column"
    "             Bundle 'mileszs/ack.vim'
    "         elseif executable('ack')
    "             Bundle 'mileszs/ack.vim'
    "         endif
    " }
    let g:rm_bundle_groups=''
    " General {
        Plugin 'Aldlevine/nerdtree-git-plugin'
        Plugin 'bling/vim-bufferline'
        Plugin 'easymotion/vim-easymotion'
        Plugin 'flazz/vim-colorschemes'
        Plugin 'killphi/vim-textobj-signify-hunk'
        Plugin 'kana/vim-textobj-fold'
        Plugin 'kana/vim-textobj-indent'
        Plugin 'landock/vim-expand-region'
        Plugin 'MarcWeber/vim-addon-local-vimrc'
        Plugin 'mbbill/undotree'
        Plugin 'mhinz/vim-startify'
        Plugin 'mhinz/vim-signify'
        Plugin 'Shea690901/vim-colors-solarized'
        Plugin 'rhysd/conflict-marker.vim'
        Plugin 'rhysd/vim-textobj-anyblock'
        Plugin 'scrooloose/nerdtree'
        Plugin 'shea690901/tskeleton_vim'
        Plugin 'terryma/vim-multiple-cursors'
        Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
        Plugin 'tomtom/foldtext_vim'
        Plugin 'tpope/vim-abolish'
        Plugin 'tpope/vim-surround'
        Plugin 'vim-airline/vim-airline'
        Plugin 'vim-airline/vim-airline-themes'
        Plugin 'vim-scripts/marvim'
        Plugin 'vim-scripts/restore_view.vim'
        Plugin 'vim-scripts/sessionman.vim'

        packadd! matchit

"    Bundle 'jiangmiao/auto-pairs'
"    Bundle 'ctrlpvim/ctrlp.vim'
"    Bundle 'tacahiroy/ctrlp-funky'
"    Bundle 'jistr/vim-nerdtree-tabs'
"    Bundle 'mhinz/vim-signify'
"    Bundle 'osyo-manga/vim-over'
    " }

    " Markdown {
        Plugin 'mzlogin/vim-markdown-toc'
        Plugin 'rhysd/vim-gfm-syntax'
    " }

    " Writing {
        if has("python")
            Plugin 'vim-scripts/lookup.vim'
        endif
        Plugin 'vim-scripts/txt.vim'

        if count(g:rm_bundle_groups, 'writing')
            Bundle 'reedes/vim-litecorrect'
            Bundle 'reedes/vim-textobj-sentence'
            Bundle 'reedes/vim-textobj-quote'
            Bundle 'reedes/vim-wordy'
        endif
    " }

    " LaTeX {
        Plugin 'rbonvall/vim-textobj-latex'
    " }

    " General Programming {
        Plugin 'glts/vim-textobj-comment'
        Plugin 'nathanaelkane/vim-indent-guides'
        Plugin 'tpope/vim-fugitive'
        Plugin 'rhysd/github-complete.vim'
        Plugin 'shea690901/DoxygenToolkit.vim'

        if count(g:rm_bundle_groups, 'programming')
            " Pick one of the checksyntax, jslint, or syntastic
            Bundle 'scrooloose/syntastic'
            Bundle 'mattn/webapi-vim'
            Bundle 'mattn/gist-vim'
            Bundle 'scrooloose/nerdcommenter'
            Bundle 'tpope/vim-commentary'
            Bundle 'godlygeek/tabular'
            Bundle 'luochen1990/rainbow'
            if executable('ctags')
                Bundle 'majutsushi/tagbar'
            endif
        endif
    " }

    " Snippets & AutoComplete {
        if count(g:rm_bundle_groups, 'snipmate')
            Bundle 'garbas/vim-snipmate'
            Bundle 'honza/vim-snippets'
            " Source support_function.vim to support vim-snippets.
            if filereadable(expand("~/.vim/bundle/vim-snippets/snippets/support_functions.vim"))
                source ~/.vim/bundle/vim-snippets/snippets/support_functions.vim
            endif
        elseif count(g:rm_bundle_groups, 'youcompleteme')
            Bundle 'Valloric/YouCompleteMe'
            Bundle 'SirVer/ultisnips'
            Bundle 'honza/vim-snippets'
        elseif count(g:rm_bundle_groups, 'neocomplcache')
            Bundle 'Shougo/neocomplcache'
            Bundle 'Shougo/neosnippet'
            Bundle 'Shougo/neosnippet-snippets'
            Bundle 'honza/vim-snippets'
        elseif count(g:rm_bundle_groups, 'neocomplete')
            Bundle 'Shougo/neocomplete.vim.git'
            Bundle 'Shougo/neosnippet'
            Bundle 'Shougo/neosnippet-snippets'
            Bundle 'honza/vim-snippets'
        endif
    " }

    " C/C++/lpc {
        Plugin 'libclang-vim/libclang-vim'
        Plugin 'libclang-vim/vim-textobj-clang'
    " }

    " lua {
        if has("python")
            Plugin 'spacewander/vim-textobj-lua'
        endif
    " }

    " PHP {
        Plugin 'akiyan/vim-textobj-php'
        if count(g:rm_bundle_groups, 'php')
            Bundle 'rm/PIV'
            Bundle 'arnaud-lb/vim-php-namespace'
            Bundle 'beyondwords/vim-twig'
        endif
    " }

    " Python {
        Plugin 'bps/vim-textobj-python'
        if count(g:rm_bundle_groups, 'python')
            " Pick either python-mode or pyflakes & pydoc
            Bundle 'klen/python-mode'
            Bundle 'yssource/python.vim'
            Bundle 'python_match.vim'
            Bundle 'pythoncomplete'
        endif
    " }

    " Javascript {
        if count(g:rm_bundle_groups, 'javascript')
            Bundle 'elzr/vim-json'
            Bundle 'groenewege/vim-less'
            Bundle 'pangloss/vim-javascript'
            Bundle 'briancollins/vim-jst'
            Bundle 'kchmck/vim-coffee-script'
        endif
    " }

    " Scala {
        if count(g:rm_bundle_groups, 'scala')
            Bundle 'derekwyatt/vim-scala'
            Bundle 'derekwyatt/vim-sbt'
            Bundle 'xptemplate'
        endif
    " }

    " Haskell {
        if count(g:rm_bundle_groups, 'haskell')
            Bundle 'travitch/hasksyn'
            Bundle 'dag/vim2hs'
            Bundle 'Twinside/vim-haskellConceal'
            Bundle 'Twinside/vim-haskellFold'
            Bundle 'lukerandall/haskellmode-vim'
            Bundle 'eagletmt/neco-ghc'
            Bundle 'eagletmt/ghcmod-vim'
            Bundle 'Shougo/vimproc.vim'
            Bundle 'adinapoli/cumino'
            Bundle 'bitc/vim-hdevtools'
        endif
    " }

    " HTML {
        Plugin 'jasonlong/vim-textobj-css'
        if count(g:rm_bundle_groups, 'html')
            Bundle 'amirh/HTML-AutoCloseTag'
            Bundle 'hail2u/vim-css3-syntax'
            Bundle 'gorodinskiy/vim-coloresque'
            Bundle 'tpope/vim-haml'
            Bundle 'mattn/emmet-vim'
        endif
    " }

    " Ruby {
        if count(g:rm_bundle_groups, 'ruby')
            Bundle 'tpope/vim-rails'
            let g:rubycomplete_buffer_loading = 1
            "let g:rubycomplete_classes_in_global = 1
            "let g:rubycomplete_rails = 1
        endif
    " }

    " Puppet {
        if count(g:rm_bundle_groups, 'puppet')
            Bundle 'rodjek/vim-puppet'
        endif
    " }

    " Go Lang {
        if count(g:rm_bundle_groups, 'go')
            "Bundle 'Blackrush/vim-gocode'
            Bundle 'fatih/vim-go'
        endif
    " }

    " Elixir {
        if count(g:rm_bundle_groups, 'elixir')
            Bundle 'elixir-lang/vim-elixir'
            Bundle 'carlosgaldino/elixir-snippets'
            Bundle 'mattreduce/vim-mix'
        endif
    " }

    " vim {
            Plugin 'kana/vim-vspec'
            Plugin 'kana/vim-textobj-help'
    " }

    " Misc {
        if count(g:rm_bundle_groups, 'misc')
            Bundle 'rust-lang/rust.vim'
            Bundle 'tpope/vim-markdown'
            Bundle 'rm/vim-preview'
            Bundle 'tpope/vim-cucumber'
            Bundle 'cespare/vim-toml'
            Bundle 'quentindecock/vim-cucumber-align-pipes'
            Bundle 'saltstack/salt-vim'
        endif
    " }

    " LastToLoad {
            Plugin 'ryanoasis/vim-devicons'           " needs special font
    " }

    call vundle#end()
    filetype plugin indent on   " Automatically detect file types. [required by vundle]
" }

" General {

set background=dark         " Assume a dark background

" Allow to trigger background
function! ToggleBG()
    let s:tbg = &background
    " Inversion
    if s:tbg == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction
noremap <leader>bg :call ToggleBG()<CR>

" if !has('gui')
    "set term=$TERM          " Make arrow and other keys work
" endif
syntax on                   " Syntax highlighting
set mouse=""                " Automatically disable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8

if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

" Most prefer to automatically switch to the current file directory when
" a new buffer is opened; to prevent this behavior, add the following to
" your .vimrc.before.local file:
"   let g:rm_no_autochdir = 1
if !exists('g:rm_no_autochdir')
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    " Always switch to the current file directory
endif

"set autowrite                       " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
" To disable this, add the following to your .vimrc.before.local file:
"   let g:rm_no_restore_cursor = 1
if !exists('g:rm_no_restore_cursor')
    function! ResCur()
        if line("'\"") <= line("$")
            silent! normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END
endif

" Setting up the directories {
    set backup                  " Backups are nice ...
    if has('persistent_undo')
        set undofile                " So is persistent undo ...
        set undolevels=1000         " Maximum number of changes that can be undone
        set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    endif

    " To disable views add the following to your .vimrc.before.local file:
    "   let g:rm_no_views = 1
    if !exists('g:rm_no_views')
        " Add exclusions to mkview and loadview
        " eg: *.*, svn-commit.tmp
        let g:skipview_files = [
            \ '\[example pattern\]'
            \ ]
    endif
" }

" }

" Configure plugins {
    " Deps {
        " vim-addon-mw-utils {
            augroup vim-addon-mw-utils
                autocmd!
            augroup END
        " }

        " tlib_vim {
            augroup tlib_vim
                autocmd!
            augroup END
        " }

        " stakeholders_vim {
            augroup stakeholders_vim
                autocmd!
            augroup END
        " }

        " pluginstats_vim {
            let g:pluginstats_autoexport = 7        " Export every 7 days statistics about plugin usage
            augroup pluginstats_vim
                autocmd!
            augroup END
        " }
    " }

    " General {
        " vim-addon-local-vimrc {
            augroup vim-addon-local-vimrc
                autocmd!
            augroup END
        " }

        " tskeleton_vim {
            augroup tskeleton_vim
                autocmd!
            augroup END
        " }

        " foldtext_vim {
            augroup foldtext_vim
                autocmd!
            augroup END
        " }

        " NERDTree {
            let g:NERDTreeDirArrowExpandable = '▸'
            let g:NERDTreeDirArrowCollapsible = '▾'
            let NERDTreeShowBookmarks=1
            " let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=0
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
            map <leader><C-n> :NERDTreeToggle<CR>
            nmap <leader>nt :NERDTreeFind<CR>
            augroup NERDTree
                autocmd!
                autocmd StdinReadPre * let s:NERDTree_std_in=1
                autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:NERDTree_std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
            augroup END
        " }

        " restore_view.vim {
            set viewoptions=cursor,folds,slash,unix
            " let g:skipview_files = ['*\.vim']
            augroup restore_view.vim
                autocmd!
            augroup END
        " }

        " vim-nerdtree-syntax-highlight {
            let g:NERDTreeFileExtensionHighlightFullName = 1
            let g:NERDTreeExactMatchHighlightFullName = 1
            let g:NERDTreePatternMatchHighlightFullName = 1
            let g:NERDTreeHighlightFolders = 1                  " enables folder icon highlighting using exact match
            let g:NERDTreeHighlightFoldersFullName = 1          " highlights the folder name
            augroup vim-nerdtree-syntax-highlight
                autocmd!
            augroup END
        " }

        " vim-colors-solarized {
            let g:solarized_termcolors=256
            let g:solarized_termtrans=1
            let g:solarized_contrast="normal"
            let g:solarized_visibility="normal"
            color solarized             " Load a colorscheme
            call togglebg#map("<F5>")
            augroup vim-colors-solarized
                autocmd!
            augroup END
        " }

        " vim-multiple-cursors {
            " Called once right before you start selecting multiple cursors
            function! Multiple_cursors_before()
                if exists(':NeoCompleteLock')==2
                    exe 'NeoCompleteLock'
                endif
            endfunction

            " Called once only when the multiple selection is canceled (default <Esc>)
            function! Multiple_cursors_after()
                if exists(':NeoCompleteUnlock')==2
                    exe 'NeoCompleteUnlock'
                endif
            endfunction

            nnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>
            vnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<CR>
            augroup vim-multiple-cursors
                autocmd!
            augroup END
        " }

        " vim-startify {
            let g:startify_session_dir = '~/.vim/session'
            let g:startify_list_order = ['files', 'dir', 'bookmarks', 'sessions', 'commands']
            let g:startify_list_order = [
                    \ ['   recent files:'], 'files',
                    \ ['   recent files in current directory:'], 'dir',
                    \ ['   sessions:'], 'sessions',
                    \ ['   bookmarks:'], 'bookmarks',
                    \ ['   commands:'], 'commands',
            \ ]
            let g:startify_files_number = 10
            let g:startify_update_oldfiles = 1
            let g:startify_session_autoload = 0
            let g:startify_session_before_save = [
                \ 'echo "Cleaning up before saving.."',
                \ 'silent! NERDTreeTabsClose'
            \ ]
            let g:startify_session_persistence = 1
            let g:startify_session_delete_buffers = 1
            let g:startify_change_to_dir = 1
            let g:startify_change_to_vcs_root = 0
            let g:startify_skiplist = [
                \ 'COMMIT_EDITMSG',
                \ '/tmp/.*',
                \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
                \ 'bundle/.*/doc',
            \ ]
            let g:startify_fortune_use_unicode = 1
            let g:startify_padding_left = 4
            let g:startify_skiplist_server = []
            let g:startify_enable_special = 1
            let g:startify_enable_unsafe = 0
            let g:startify_session_remove_lines = []
            let g:startify_session_savevars = [
                   \ 'g:startify_session_savevars',
                   \ 'g:startify_session_savecmds'
           \ ]
            let g:startify_session_savecmds = []
            let g:startify_session_number = 10
            let g:startify_session_sort = 1
            let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
            let g:startify_custom_header = startify#fortune#boxed()
            " let g:startify_custom_header = join(startify#fortune#boxed(), "\n")
            let g:startify_custom_footer = ''
            let g:startify_disable_at_vimenter = 0
            let g:startify_relative_path = 0
            let g:startify_use_env = 1
            augroup vim-startify
                autocmd!
            augroup END
        " }

        " vim-airline {
            let g:airline_powerline_fonts = 1   " use oowerline symbols
            if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
                let g:airline_theme = 'solarized'
            endif
            augroup vim-airline
                autocmd!
            augroup END
        " }
    " }

    " General Programming {
        " vim-indent-guides {
            let g:indent_guides_enable_on_vim_startup = 1
            " let g:indent_guides_start_level = 1
            " let g:indent_guides_guide_size = 1
            augroup vim-indent-guides
                autocmd!
            augroup END
        " }

        " DoxygenToolkit.vim {

            function DoxygenToolkitNewfile()
                if(index(["cpp", "c", "lpc", "python"], &filetype) >= 0)
                    let b:DoxygenToolkit_briefTag_pre="@Brief    "
                    let b:DoxygenToolkit_briefTag_className="yes"
                    let b:DoxygenToolkit_briefTag_enumName="yes"
                    let b:DoxygenToolkit_briefTag_funcName="yes"
                    let b:DoxygenToolkit_briefTag_namespaceName="yes"
                    let b:DoxygenToolkit_briefTag_structName="yes"
                    let b:DoxygenToolkit_paramTag_pre="@Param    "
                    let b:DoxygenToolkit_returnTag="@Returns  "
                    let b:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
                    let b:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------"
                    let b:DoxygenToolkit_authorName="René Müller"
                    let b:DoxygenToolkit_versionString="0.0.0"
                    " let b:DoxygenToolkit_licenseTag="My own license"
                    " execute ":DoxAuthor"
                endif
            endfunction

            augroup DoxygenToolkit.vim
                autocmd!
                autocmd BufRead,BufNewFile *.c,*.h let b:DoxygenToolkit_commentType="C"
                autocmd BufRead,BufNewFile *.cc,*.hh let b:DoxygenToolkit_commentType="C++"
                autocmd BufRead,BufNewFile *.lpc,*.lph let b:DoxygenToolkit_commentType="C++"
                autocmd BufRead,BufNewFile * call DoxygenToolkitNewfile()
            augroup END
        " }
    " }

    " Markdown {
        " vim-gfm-syntax {
            let g:gfm_syntax_enable_always = 0
            let g:gfm_syntax_enable_filetypes = ['markdown.gfm']
            augroup vim-gfm-syntax
                autocmd!
                autocmd BufRead,BufNew,BufNewFile README.md setlocal ft=markdown.gfm
            augroup END
        " }
    " }

    " LastToLoad {
        " vim-devicons {
            if has("gui_running")
                set guifont=DroidSansMono\ Nerd\ Font\ 14

                " loading the plugin
                let g:webdevicons_enable = 1

                " adding the flags to NERDTree
                let g:webdevicons_enable_nerdtree = 1

                " adding the custom source to unite
                let g:webdevicons_enable_unite = 1

                " adding the column to vimfiler
                let g:webdevicons_enable_vimfiler = 1

                " adding to vim-airline's tabline
                let g:webdevicons_enable_airline_tabline = 1

                " adding to vim-airline's statusline
                let g:webdevicons_enable_airline_statusline = 1

                " ctrlp glyphs
                let g:webdevicons_enable_ctrlp = 1

                " adding to flagship's statusline
                let g:webdevicons_enable_flagship_statusline = 1

                " turn on/off file node glyph decorations (not particularly useful)
                let g:WebDevIconsUnicodeDecorateFileNodes = 1

                " use double-width(1) or single-width(0) glyphs only manipulates
                " padding, has no effect on terminal or set(guifont) font
                let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

                " whether or not to show the nerdtree brackets around flags
                let g:webdevicons_conceal_nerdtree_brackets = 1

                " the amount of space to use after the glyph character (default ' ')
                let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

                " Force extra padding in NERDTree so that the filetype icons
                " line up vertically
                let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

                " change the default character when no match found
                " let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'

                " set a byte character marker (BOM) utf-8 symbol when retrieving
                " file encoding disabled by default with no value
                " let g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = ''

                " enable folder/directory glyph flag
                let g:WebDevIconsUnicodeDecorateFolderNodes = 1

                " enable open and close folder/directory glyph flags
                let g:DevIconsEnableFoldersOpenClose = 1

                " enable pattern matching glyphs on folder/directory
                let g:DevIconsEnableFolderPatternMatching = 1

                " enable file extension pattern matching glyphs on folder/directory
                let g:DevIconsEnableFolderExtensionPatternMatching = 0

                " enable custom folder/directory glyph exact matching
                " (enabled by default when g:WebDevIconsUnicodeDecorateFolderNodes is set to 1)
                let WebDevIconsUnicodeDecorateFolderNodesExactMatches = 1

                " change the default folder/directory glyph/icon
                " let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = 'ƛ'

                " change the default open folder/directory glyph/icon (default is '')
                " let g:DevIconsDefaultFolderOpenSymbol = 'ƛ'

                " change the default dictionary mappings for file extension matches
                " let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
                " let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = 'ƛ'

                " change the default dictionary mappings for exact file node matches
                " let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {} " needed
                " let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['MyReallyCoolFile.okay'] = 'ƛ'

                " add or override individual additional filetypes
                " let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
                " let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['myext'] = 'ƛ'

                " add or override pattern matches for filetypes
                " these take precedence over the file extensions
                " let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {} " needed
                " let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols['.*jquery.*\.js$'] = 'ƛ'

                " specify OS to decide an icon for unix fileformat (not
                " defined by default)
                let g:WebDevIconsOS = 'CYGWIN_NT-6.1'
    set statusline=%f\ %{WebDevIconsGetFileTypeSymbol()}\ %h%w%m%r\ %=%(%l,%c%V\ %Y\ %=\ %P%)
                augroup vim-devicons
                    autocmd!
                augroup END
            endif
        " }

    " }
" }

    autocmd VimEnter *
                \   if !argc() && !exists("s:NERDTree_std_in")
                \ |   Startify
                \ |   NERDTree
                \ |   wincmd w
                \ | endif

" Vim UI {

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        if !exists('g:override_rm_bundles')
            set statusline+=%{fugitive#statusline()} " Git Hotness
        endif
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" }

" Formatting {

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.before.local file:
    "   let g:rm_keep_trailing_whitespace = 1
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:rm_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell

" }

" Key (re)Mappings {

    " The default mappings for editing and applying the rm configuration
    " are <leader>ev and <leader>sv respectively. Change them to your preference
    " by adding the following to your .vimrc.before.local file:
    "   let g:rm_edit_config_mapping='<leader>ec'
    "   let g:rm_apply_config_mapping='<leader>sc'
    if !exists('g:rm_edit_config_mapping')
        let s:rm_edit_config_mapping = '<leader>ev'
    else
        let s:rm_edit_config_mapping = g:rm_edit_config_mapping
    endif
    if !exists('g:rm_apply_config_mapping')
        let s:rm_apply_config_mapping = '<leader>sv'
    else
        let s:rm_apply_config_mapping = g:rm_apply_config_mapping
    endif

    " Easier moving in tabs and windows
    " The lines conflict with the default digraph mapping of <C-K>
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "   let g:rm_no_easyWindows = 1
    if !exists('g:rm_no_easyWindows')
        map <C-J> <C-W>j<C-W>_
        map <C-K> <C-W>k<C-W>_
        map <C-L> <C-W>l<C-W>_
        map <C-H> <C-W>h<C-W>_
    endif

    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk

    " End/Start of line motion keys act relative to row/wrap width in the
    " presence of `:set wrap`, and relative to line for `:set nowrap`.
    " Default vim behaviour is to act relative to text line in both cases
    " If you prefer the default behaviour, add the following to your
    " .vimrc.before.local file:
    "   let g:rm_no_wrapRelMotion = 1
    if !exists('g:rm_no_wrapRelMotion')
        " Same for 0, home, end, etc
        function! WrapRelativeMotion(key, ...)
            let vis_sel=""
            if a:0
                let vis_sel="gv"
            endif
            if &wrap
                execute "normal!" vis_sel . "g" . a:key
            else
                execute "normal!" vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
    endif

    " The following two lines conflict with moving to top and
    " bottom of the screen
    " If you prefer that functionality, add the following to your
    " .vimrc.before.local file:
    "   let g:rm_no_fastTabs = 1
    if !exists('g:rm_no_fastTabs')
        map <S-H> gT
        map <S-L> gt
    endif

    " Stupid shift key fixes
    if !exists('g:rm_no_keyfixes')
        if has("user_commands")
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif

        cmap Tabe tabe
    endif

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Most prefer to toggle search highlighting rather than clear the current
    " search results. To clear search highlighting rather than toggle it on
    " and off, add the following to your .vimrc.before.local file:
    "   let g:rm_clear_search_highlight = 1
    if exists('g:rm_clear_search_highlight')
        nmap <silent> <leader>/ :nohlsearch<CR>
    else
        nmap <silent> <leader>/ :set invhlsearch<CR>
    endif


    " Find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cmap cwd lcd %:p:h
    cmap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Easier formatting
    nnoremap <silent> <leader>q gwip

    " FIXME: Revert this f70be548
    " fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
    map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

" }

" Plugins {

    " GoLang {
        if count(g:rm_bundle_groups, 'go')
            let g:go_highlight_functions = 1
            let g:go_highlight_methods = 1
            let g:go_highlight_structs = 1
            let g:go_highlight_operators = 1
            let g:go_highlight_build_constraints = 1
            let g:go_fmt_command = "goimports"
            let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
            let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
            augroup GoLang
                autocmd!
                au FileType go nmap <Leader>s <Plug>(go-implements)
                au FileType go nmap <Leader>i <Plug>(go-info)
                au FileType go nmap <Leader>e <Plug>(go-rename)
                au FileType go nmap <leader>r <Plug>(go-run)
                au FileType go nmap <leader>b <Plug>(go-build)
                au FileType go nmap <leader>t <Plug>(go-test)
                au FileType go nmap <Leader>gd <Plug>(go-doc)
                au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
                au FileType go nmap <leader>co <Plug>(go-coverage)
            augroup END
        endif
        " }


    " TextObj Sentence {
        if count(g:rm_bundle_groups, 'writing')
            augroup textobj_sentence
              autocmd!
              autocmd FileType markdown call textobj#sentence#init()
              autocmd FileType textile call textobj#sentence#init()
              autocmd FileType text call textobj#sentence#init()
            augroup END
        endif
    " }

    " TextObj Quote {
        if count(g:rm_bundle_groups, 'writing')
            augroup textobj_quote
                autocmd!
                autocmd FileType markdown call textobj#quote#init()
                autocmd FileType textile call textobj#quote#init()
                autocmd FileType text call textobj#quote#init({'educate': 0})
            augroup END
        endif
    " }

    " PIV {
        if isdirectory(expand("~/.vim/bundle/PIV"))
            let g:DisableAutoPHPFolding = 0
            let g:PIVAutoClose = 0
        endif
    " }

    " Misc {
        if isdirectory(expand("~/.vim/bundle/nerdtree"))
            let g:NERDShutUp=1
        endif
        if isdirectory(expand("~/.vim/bundle/matchit.zip"))
            let b:match_ignorecase = 1
        endif
    " }

    " OmniComplete {
        " To disable omni complete, add the following to your .vimrc.before.local file:
        "   let g:rm_no_omni_complete = 1
        if !exists('g:rm_no_omni_complete')
            if has("autocmd") && exists("+omnifunc")
                autocmd Filetype *
                    \if &omnifunc == "" |
                    \setlocal omnifunc=syntaxcomplete#Complete |
                    \endif
            endif

            hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
            hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
            hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

            " Some convenient mappings
            "inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
            if exists('g:rm_map_cr_omni_complete')
                inoremap <expr> <CR>     pumvisible() ? "\<C-y>" : "\<CR>"
            endif
            inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
            inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
            inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
            inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

            " Automatically open and close the popup menu / preview window
            au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
            set completeopt=menu,preview,longest
        endif
    " }

    " Ctags {
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

    " AutoCloseTag {
        " Make it so AutoCloseTag works for xml and xhtml files as well
        au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
        nmap <Leader>ac <Plug>ToggleAutoCloseMappings
    " }

    " SnipMate {
        " Setting the author var
        " If forking, please overwrite in your .vimrc.local file
        let g:snips_author = 'Steve Francia <steve.francia@gmail.com>'
    " }


    " Tabularize {
        if isdirectory(expand("~/.vim/bundle/tabular"))
            nmap <Leader>a& :Tabularize /&<CR>
            vmap <Leader>a& :Tabularize /&<CR>
            nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            nmap <Leader>a=> :Tabularize /=><CR>
            vmap <Leader>a=> :Tabularize /=><CR>
            nmap <Leader>a: :Tabularize /:<CR>
            vmap <Leader>a: :Tabularize /:<CR>
            nmap <Leader>a:: :Tabularize /:\zs<CR>
            vmap <Leader>a:: :Tabularize /:\zs<CR>
            nmap <Leader>a, :Tabularize /,<CR>
            vmap <Leader>a, :Tabularize /,<CR>
            nmap <Leader>a,, :Tabularize /,\zs<CR>
            vmap <Leader>a,, :Tabularize /,\zs<CR>
            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        endif
    " }

    " Session List {
        set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
        if isdirectory(expand("~/.vim/bundle/sessionman.vim/"))
            nmap <leader>sl :SessionList<CR>
            nmap <leader>ss :SessionSave<CR>
            nmap <leader>sc :SessionClose<CR>
        endif
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }

    " PyMode {
        " Disable if python support not present
        if !has('python') && !has('python3')
            let g:pymode = 0
        endif

        if isdirectory(expand("~/.vim/bundle/python-mode"))
            let g:pymode_lint_checkers = ['pyflakes']
            let g:pymode_trim_whitespaces = 0
            let g:pymode_options = 0
            let g:pymode_rope = 0
        endif
    " }

    " ctrlp {
        if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
            let g:ctrlp_working_path_mode = 'ra'
            nnoremap <silent> <D-t> :CtrlP<CR>
            nnoremap <silent> <D-r> :CtrlPMRU<CR>
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            if executable('ag')
                let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
            elseif executable('ack-grep')
                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            " On Windows use "dir" as fallback command.
            elseif WINDOWS()
                let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
            else
                let s:ctrlp_fallback = 'find %s -type f'
            endif
            if exists("g:ctrlp_user_command")
                unlet g:ctrlp_user_command
            endif
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
            \ }

            if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
                " CtrlP extensions
                let g:ctrlp_extensions = ['funky']

                "funky
                nnoremap <Leader>fu :CtrlPFunky<Cr>
            endif
        endif
    "}

    " TagBar {
        if isdirectory(expand("~/.vim/bundle/tagbar/"))
            nnoremap <silent> <leader>tt :TagbarToggle<CR>
        endif
    "}

    " Rainbow {
        if isdirectory(expand("~/.vim/bundle/rainbow/"))
            let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
        endif
    "}

    " Fugitive {
        if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        endif
    "}

    " YouCompleteMe {
        if count(g:rm_bundle_groups, 'youcompleteme')
            let g:acp_enableAtStartup = 0

            " enable completion from tags
            let g:ycm_collect_identifiers_from_tags_files = 1

            " remap Ultisnips for compatibility for YCM
            let g:UltiSnipsExpandTrigger = '<C-j>'
            let g:UltiSnipsJumpForwardTrigger = '<C-j>'
            let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            " Haskell post write lint and check with ghcmod
            " $ `cabal install ghcmod` if missing and ensure
            " ~/.cabal/bin is in your $PATH.
            if !executable("ghcmod")
                autocmd BufWritePost *.hs GhcModCheckAndLintAsync
            endif

            " For snippet_complete marker.
            if !exists("g:rm_no_conceal")
                if has('conceal')
                    set conceallevel=2 concealcursor=i
                endif
            endif

            " Disable the neosnippet preview candidate window
            " When enabled, there can be too much visual noise
            " especially when splits are used.
            set completeopt-=preview
        endif
    " }

    " neocomplete {
        if count(g:rm_bundle_groups, 'neocomplete')
            let g:acp_enableAtStartup = 0
            let g:neocomplete#enable_at_startup = 1
            let g:neocomplete#enable_smart_case = 1
            let g:neocomplete#enable_auto_delimiter = 1
            let g:neocomplete#max_list = 15
            let g:neocomplete#force_overwrite_completefunc = 1


            " Define dictionary.
            let g:neocomplete#sources#dictionary#dictionaries = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

            " Define keyword.
            if !exists('g:neocomplete#keyword_patterns')
                let g:neocomplete#keyword_patterns = {}
            endif
            let g:neocomplete#keyword_patterns['default'] = '\h\w*'

            " Plugin key-mappings {
                " These two lines conflict with the default digraph mapping of <C-K>
                if !exists('g:rm_no_neosnippet_expand')
                    imap <C-k> <Plug>(neosnippet_expand_or_jump)
                    smap <C-k> <Plug>(neosnippet_expand_or_jump)
                endif
                if exists('g:rm_noninvasive_completion')
                    inoremap <CR> <CR>
                    " <ESC> takes you out of insert mode
                    inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
                    " <CR> accepts first, then sends the <CR>
                    inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                    " <Down> and <Up> cycle like <Tab> and <S-Tab>
                    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
                    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
                    " Jump up and down the list
                    inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
                    inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
                else
                    " <C-k> Complete Snippet
                    " <C-k> Jump to next snippet point
                    imap <silent><expr><C-k> neosnippet#expandable() ?
                                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                                \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
                    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

                    inoremap <expr><C-g> neocomplete#undo_completion()
                    inoremap <expr><C-l> neocomplete#complete_common_string()
                    "inoremap <expr><CR> neocomplete#complete_common_string()

                    " <CR>: close popup
                    " <s-CR>: close popup and save indent.
                    inoremap <expr><s-CR> pumvisible() ? neocomplete#smart_close_popup()."\<CR>" : "\<CR>"

                    function! CleverCr()
                        if pumvisible()
                            if neosnippet#expandable()
                                let exp = "\<Plug>(neosnippet_expand)"
                                return exp . neocomplete#smart_close_popup()
                            else
                                return neocomplete#smart_close_popup()
                            endif
                        else
                            return "\<CR>"
                        endif
                    endfunction

                    " <CR> close popup and save indent or expand snippet
                    imap <expr> <CR> CleverCr()
                    " <C-h>, <BS>: close popup and delete backword char.
                    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
                    inoremap <expr><C-y> neocomplete#smart_close_popup()
                endif
                " <TAB>: completion.
                inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
                inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

                " Courtesy of Matteo Cavalleri

                function! CleverTab()
                    if pumvisible()
                        return "\<C-n>"
                    endif
                    let substr = strpart(getline('.'), 0, col('.') - 1)
                    let substr = matchstr(substr, '[^ \t]*$')
                    if strlen(substr) == 0
                        " nothing to match on empty string
                        return "\<Tab>"
                    else
                        " existing text matching
                        if neosnippet#expandable_or_jumpable()
                            return "\<Plug>(neosnippet_expand_or_jump)"
                        else
                            return neocomplete#start_manual_complete()
                        endif
                    endif
                endfunction

                imap <expr> <Tab> CleverTab()
            " }

            " Enable heavy omni completion.
            if !exists('g:neocomplete#sources#omni#input_patterns')
                let g:neocomplete#sources#omni#input_patterns = {}
            endif
            let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    " }
    " neocomplcache {
        elseif count(g:rm_bundle_groups, 'neocomplcache')
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_enable_at_startup = 1
            let g:neocomplcache_enable_camel_case_completion = 1
            let g:neocomplcache_enable_smart_case = 1
            let g:neocomplcache_enable_underbar_completion = 1
            let g:neocomplcache_enable_auto_delimiter = 1
            let g:neocomplcache_max_list = 15
            let g:neocomplcache_force_overwrite_completefunc = 1

            " Define dictionary.
            let g:neocomplcache_dictionary_filetype_lists = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

            " Define keyword.
            if !exists('g:neocomplcache_keyword_patterns')
                let g:neocomplcache_keyword_patterns = {}
            endif
            let g:neocomplcache_keyword_patterns._ = '\h\w*'

            " Plugin key-mappings {
                " These two lines conflict with the default digraph mapping of <C-K>
                imap <C-k> <Plug>(neosnippet_expand_or_jump)
                smap <C-k> <Plug>(neosnippet_expand_or_jump)
                if exists('g:rm_noninvasive_completion')
                    inoremap <CR> <CR>
                    " <ESC> takes you out of insert mode
                    inoremap <expr> <Esc>   pumvisible() ? "\<C-y>\<Esc>" : "\<Esc>"
                    " <CR> accepts first, then sends the <CR>
                    inoremap <expr> <CR>    pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
                    " <Down> and <Up> cycle like <Tab> and <S-Tab>
                    inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<Down>"
                    inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
                    " Jump up and down the list
                    inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
                    inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"
                else
                    imap <silent><expr><C-k> neosnippet#expandable() ?
                                \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                                \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
                    smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

                    inoremap <expr><C-g> neocomplcache#undo_completion()
                    inoremap <expr><C-l> neocomplcache#complete_common_string()
                    "inoremap <expr><CR> neocomplcache#complete_common_string()

                    function! CleverCr()
                        if pumvisible()
                            if neosnippet#expandable()
                                let exp = "\<Plug>(neosnippet_expand)"
                                return exp . neocomplcache#close_popup()
                            else
                                return neocomplcache#close_popup()
                            endif
                        else
                            return "\<CR>"
                        endif
                    endfunction

                    " <CR> close popup and save indent or expand snippet
                    imap <expr> <CR> CleverCr()

                    " <CR>: close popup
                    " <s-CR>: close popup and save indent.
                    inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()."\<CR>" : "\<CR>"
                    "inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

                    " <C-h>, <BS>: close popup and delete backword char.
                    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
                    inoremap <expr><C-y> neocomplcache#close_popup()
                endif
                " <TAB>: completion.
                inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
                inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
            " }

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            " Enable heavy omni completion.
            if !exists('g:neocomplcache_omni_patterns')
                let g:neocomplcache_omni_patterns = {}
            endif
            let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
    " }
    " Normal Vim omni-completion {
    " To disable omni complete, add the following to your .vimrc.before.local file:
    "   let g:rm_no_omni_complete = 1
        elseif !exists('g:rm_no_omni_complete')
            " Enable omni-completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

        endif
    " }

    " Snippets {
        if count(g:rm_bundle_groups, 'neocomplcache') ||
                    \ count(g:rm_bundle_groups, 'neocomplete')

            " Use honza's snippets.
            let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

            " Enable neosnippet snipmate compatibility mode
            let g:neosnippet#enable_snipmate_compatibility = 1

            " For snippet_complete marker.
            if !exists("g:rm_no_conceal")
                if has('conceal')
                    set conceallevel=2 concealcursor=i
                endif
            endif

            " Enable neosnippets when using go
            let g:go_snippet_engine = "neosnippet"

            " Disable the neosnippet preview candidate window
            " When enabled, there can be too much visual noise
            " especially when splits are used.
            set completeopt-=preview
        endif
    " }

    " FIXME: Isn't this for Syntastic to handle?
    " Haskell post write lint and check with ghcmod
    " $ `cabal install ghcmod` if missing and ensure
    " ~/.cabal/bin is in your $PATH.
    if !executable("ghcmod")
        autocmd BufWritePost *.hs GhcModCheckAndLintAsync
    endif

    " UndoTree {
        if isdirectory(expand("~/.vim/bundle/undotree/"))
            nnoremap <Leader>u :UndotreeToggle<CR>
            " If undotree is opened, it is likely one wants to interact with it.
            let g:undotree_SetFocusWhenToggle=1
        endif
    " }

    " indent_guides {
        if isdirectory(expand("~/.vim/bundle/vim-indent-guides/"))
            let g:indent_guides_start_level = 2
            let g:indent_guides_guide_size = 1
            let g:indent_guides_enable_on_vim_startup = 1
        endif
    " }

" }

" GUI Settings {

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set lines=40                " 40 lines of text instead of 24
        if !exists("g:rm_no_big_font")
            if LINUX() && has("gui_running")
                set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
            elseif OSX() && has("gui_running")
                set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
            elseif WINDOWS() && has("gui_running")
                set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
            endif
        endif
    else
        if &term == 'xterm' || &term == 'screen'
            set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

" }
