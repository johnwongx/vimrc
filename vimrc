" 脚本运行前需要安装的软件
" -需要安装vim-plug       https://github.com/junegunn/vim-plug
" -需要安装powerline字体，如：Fira Code、Source Code Pro、
" -安装fzf		https://github.com/junegunn/fzf
" -安装ripgrep  https://github.com/BurntSushi/ripgrep
" -安装bat		https://github.com/sharkdp/bat
" -安装以上三个软件后，配置环境变量 export FZF_DEFAULT_COMMAND='rg --files --sortr modified'

let is_windows = has('win32') || has('win64')

if is_windows
  set pythonthreedll=~\AppData\Local\Programs\Python\Python310-32\python310.dll
endif

" 防止在终端里边嵌套vim
if exists('$VIM_TERMINAL')
  echoerr 'Do not run Vim inside a Vim terminal'
  quit
endif

let mapleader = ","
inoremap jk <Esc>
set autowrite

"==========================plug split===========================
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'

" 代码注释
" <Leader>cc 把代码变为注释
" <Leader>cu 把注释起止符剥掉，恢复原先的代码
" 下面这些则只能工作于完整的一行或多行上：
" <Leader>c<Space> 用来切换注释和非注释
" <Leader>cb 用来加上“美观”的注释
" <Leader>cs 用来加上“性感”的注释
Plug 'preservim/nerdcommenter'

" 源代码中提取符号，通过f9打开关闭窗口
Plug 'majutsushi/tagbar'

" 构建时异步支持
Plug 'skywind3000/asyncrun.vim'

" 将单词外部加上双引号， ysiw\"
" 双引号变单引号，cs\"'
" 添加html标签，cs[<em>
" 删除，ds\"
" 删除标签，dst
Plug 'tpope/vim-surround'

" 可以重复非vim内部命令（插件命令）
Plug 'tpope/vim-repeat'

" 移动或重命名文件并保留撤销历史
" :Rename  :Move
Plug 'tpope/vim-eunuch'

" 全功能的 Git 支持插件
" Vim 里直接使用 Git 命令：只需要把“G”变成大写即可
Plug 'tpope/vim-fugitive'

" Git插件，单个文件内修改管理
" 在 Vim 的边栏里用 +、- 等符号和合适的配色来标注哪些行有了修改
" [c 和 ]c 可以用来跳转到上一个和下一个修改的位置
" <Leader>hp 可以将光标下的修改块和缓存区中的内容进行对比
" <Leader>hs 可以将光标下的修改块加入到暂存区中
" <Leader>hu 可以恢复暂存区中的内容
Plug 'airblade/vim-gitgutter'

" 界面
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 撤销树可视化
" :UndotreeToggle
Plug 'mbbill/undotree'

" 模糊文件查找
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" go支持
Plug 'fatih/vim-go'
Plug 'fatih/vim-go',{'do':':GoUpdateBinaries'}

" 代码提示
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 将光标放在多个位置上，同时使用命令
Plug 'mg979/vim-visual-multi'

" 函数原型提示，配合tag使用
Plug 'mbbill/echofunc'

" Python开发环境支持
Plug 'python-mode/python-mode'

" 批量修改文件名，:Renamer,完成后执行:Ren
Plug 'qpkorr/vim-renamer'

" 无限制撤销
" 因为该插件会映射正常模式下/按键，所以暂时去掉该插件
"Plug 'thoughtstream/Damian-Conway-s-Vim-Setup'

" 括号不同颜色
Plug 'frazrepo/vim-rainbow'

" 括号自动补全
Plug 'jiangmiao/auto-pairs'

" 快速打开大文件
Plug 'vim-scripts/LargeFile'

" Markdown预览
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" 日历
Plug 'mattn/calendar-vim'

" 无用插件
Plug 'uguu-org/vim-matrix-screensaver'

" python缩进线显示
Plug 'Yggdroot/indentLine'

" 配色方案
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
call plug#end()

"==========================set split===========================
set enc=utf-8
set nocompatible

set backup
set undofile
set nobackup
set undodir=~/.vim/undodir

set nu
set rnu

set mouse=a

set fileencodings=ucs-bom,utf-8,gb18030,latin1

set keywordprg=:Man

" 拼写检查
set mousemodel=popup_setpos
set spelllang=en_gb
set spelllang+=cjk

"set guifont=Source\ Code\ Pro\ 12
if is_windows
  set guifont=Fira\ Code:h12
else
  set guifont=FiraCode\ 12
endif

"colorscheme jellybeans
autocmd vimenter * ++nested colorscheme gruvbox
set background=dark

" 搜索高亮
set hlsearch
" 搜索输入内容变化时自动跳转
set incsearch

if is_windows
  set backspace=indent,eol,start
endif

"==========================map split===========================
" 复制粘贴
noremap <C-c> "+y
noremap <C-v> "+p

" 中断模式下esc退出
tnoremap <Esc>      <C-\><C-N>
tnoremap <C-V><Esc> <Esc>

" 替换光标下单词的键映射
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

nnoremap <Leader>v viw"0p
vnoremap <Leader>v    "0p

nnoremap <C-Tab>   <C-W>w
inoremap <C-Tab>   <C-O><C-W>w
nnoremap <C-S-Tab> <C-W>W
inoremap <C-S-Tab> <C-O><C-W>W

" 停止搜索高亮的键映射
nnoremap <silent> <F2>      :nohlsearch<CR>
inoremap <silent> <F2> <C-O>:nohlsearch<CR>

" 开关 Tagbar 插件的键映射
nnoremap <F9>      :TagbarToggle<CR>
inoremap <F9> <C-O>:TagbarToggle<CR>

" 用于 quickfix、标签和文件跳转的键映射
nmap <F11>   :cn<CR>
nmap <F12>   :cp<CR>
nmap <M-F11> :copen<CR>
nmap <M-F12> :cclose<CR>
nmap <C-F11> :tn<CR>
nmap <C-F12> :tp<CR>
nmap <S-F11> :n<CR>
nmap <S-F12> :prev<CR>

" 映射按键来快速启停构建
nnoremap <F5>  :if g:asyncrun_status != 'running'<bar>
                 \if &modifiable<bar>
                   \update<bar>
                 \endif<bar>
                 \exec 'Make'<bar>
               \else<bar>
                 \AsyncStop<bar>
               \endif<CR>
"==========================gvim split===========================
if v:version >= 800
	packadd! editexisting
endif

"==========================other split===========================
"启用man插件
source $VIMRUNTIME/ftplugin/man.vim

" python代码格式设置
if !exists("g:python_recommended_style") || g:python_recommended_style != 0
    " As suggested by PEP8.
    setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
endif

" 其他类型文件代码格式设置
au FileType c,cpp,objc  setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4 cinoptions=:0,g0,(0,w1
au FileType go          setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
au FileType json        setlocal expandtab shiftwidth=2 softtabstop=2
au FileType vim         setlocal expandtab shiftwidth=2 softtabstop=2

" 在帮助文档中按q退出窗口
au FileType help  nnoremap <buffer> q <C-W>c

" 异步运行命令时打开 quickfix 窗口，高度为 10 行
let g:asyncrun_open = 10

" 真彩色设置
if has('termguicolors') &&
      \($COLORTERM == 'truecolor' || $COLORTERM == '24bit')
  set termguicolors
endif

" vim-airline/vim-airline配置
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#overflow_marker = ''
let g:airline#extensions#tabline#show_tab_nr = 0
"let g:airline_theme='molokai'

if !has('gui_running')
  let g:NERDMenuMode = 0
endif

"==========================coc.nvim config===========================
" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" Some servers have issues with backup files, see #649
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" C语言环境设置
let g:c_space_errors = 1
let g:c_gnu = 1
let g:c_no_cformat = 1
let g:c_no_curly_error = 1
if exists('g:c_comment_strings')
  unlet g:c_comment_strings
endif

" python-mode配置
let g:pymode_python = 'python3'
function! IsGitRepo()
  " This function requires GitPython
  if has('pythonx')
pythonx << EOF
try:
    import git
except ImportError:
    pass
import vim

def is_git_repo():
    try:
        _ = git.Repo('.', search_parent_directories=True).git_dir
        return 1
    except:
        return 0
EOF
    return pyxeval('is_git_repo()')
  else
    return 0
  endif
endfunction

let g:pymode_rope = IsGitRepo()
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_syntax_print_as_function = 1
let g:pymode_syntax_string_format = 0
let g:pymode_syntax_string_templates = 0

" 代码检查器,使用:PymodeLintAuto
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']

let g:AutoPairsShortcutToggle = 'π'

let g:LargeFile = 100

" 自动关闭quickfix窗口
aug QFClose
  au!
  au WinEnter *  if winnr('$') == 1 && &buftype == "quickfix"|q|endif
aug END

" home键行首跳转
function! GoToFirstNonBlankOrFirstColumn()
  let cur_col = col('.')
  normal! ^
  if cur_col != 1 && cur_col == col('.')
    normal! 0
  endif
  return ''
endfunction

nnoremap <silent> <Home> :call GoToFirstNonBlankOrFirstColumn()<CR>
inoremap <silent> <Home> <C-R>=GoToFirstNonBlankOrFirstColumn()<CR>

" fatih/vim-go配置
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
let mapleader = ","
let g:go_fmt_command = "goimports"

" airblade/vim-gitgutter配色方案
highlight! link SignColumn LineNr
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
let g:gitgutter_set_sign_backgrounds = 1

" 隐藏gvim菜单栏，使用<M-F1>唤出
set guioptions-=m
set guioptions-=T
map <silent> <M-F1> :if &guioptions=~#'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
