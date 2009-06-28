" *** КОНФИГУРАЦИЯ VIM ***

" Использованные источники:
" 1. http://hg.piranha.org.ua/conf
" 2. http://linuxforum.ru/index.php?showtopic=36820
" 3. http://dancingpenguinsoflight.com/2009/02/python-and-vim-make-your-own-ide/
" 4. http://pytune.wordpress.com/2009/04/11/vim-django-python-1/
" 5. http://konishchevdmitry.blogspot.com/2008/07/howto-vim.html

" Настройки {{{

" * Общие {{{

" Отключение совместимости настроек с Vi
set nocompatible

" Отключить перерисовку экрана во время выполнения макросов и других рутинных операций 
set lazyredraw

" Опции сессий
set sessionoptions=curdir,buffers,tabpages

" Работа с несколькими буферами одновременно
set hidden

" Использовать <Backspace>, вместо <x>
set backspace=indent,eol,start whichwrap+=<,>,[,]

" Включить режим Paste
set paste

" Включить определение типа файла
filetype on
filetype plugin on

"Количество отмен
set undolevels=1000

" Не делать резервные копии файлов
set nobackup

" Не создавать свап файл
set noswapfile

" Отключить оповещение об ошибка
set novb

" Поиск по набору текста
set incsearch report=0 title

" Скроллинг текста
set scrolljump=7
set scrolloff=7

" Поддержка мыши
set mouse=a
set mousemodel=popup

" }}}

" * Кодировки {{{

" Кодировка текста по умолчанию
set termencoding=utf-8

" Возможные кодировки файлов, если файл не в unicode кодировке, то будет использоваться cp1251
set fileencodings=utf8,cp1251 

" Меню для смены кодировки по клавише <Tab>
menu Encoding.windows-1251 :e! ++enc=cp1251<CR>
menu Encoding.koi8-r       :e! ++enc=koi8-r<CR>
menu Encoding.utf-8        :e! ++enc=utf-8 <CR>
set wildmenu
set wcm=<Tab>
map <C-C> :emenu Encoding.<TAB>

" }}}

" * Настройки Python {{{

" Табуляция равна 4-ем пробелам
set tabstop=4 
set softtabstop=4 
set expandtab
set smarttab

" Двигать блоки в визуальном режиме на 4 пробела с помощью клавиш < и >
set shiftwidth=4

" Включить автоотступ
set autoindent

"" Скрипт автоотступов лежит в .vim/indent/python.vim"
"filetype plugin indent on

" Полная подсветка синтаксиса языка
let python_highlight_all = 1

"au FileType python source ~/.vim/scripts/python.vim

" Автоматический отступ
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Удаление лишних пробелов
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

" Автодополнение из словаря
autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(

" }}}

" * Настройки omnicompletion {{{

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" }}}

" * Настройки MiniBufExplorer {{{

"let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1 

" }}}

" }}}

" Внешний вид {{{

" Подсветка синтаксиса
syntax on

" Цветовая схема
colorscheme wombat

" Шрифт в GVim
set guifont=Terminus\ 10 

" Метод сворачивания текста
set foldmethod=marker

" Отступ перед нумерацией строк
set foldcolumn=0

" Нумерация строк
set nu

" Отображение курсора все время
set ruler

" Высота строки комманд
set ch=1

" Показывать незавершенные команды
set showcmd showmatch showmode

" Подсветка строки, в которой находится в данный момент курсор
set cursorline

" Формат строки состояния
set statusline=%<%f%h%m%r\ %{&encoding}\ %l,%c%V\ %P 
set laststatus=2

" Использовать 256 цветов в терминале (настройка для плагина CSApprox)
set t_Co=256

" Отключаем панель инструментов
set guioptions-=T

" Отключаем графические диалоги
set guioptions-=c

" По умолчанию меню скрыто
set guioptions-=m

" Размеры окна при открытии
set lines=60
set columns=100

" Перенос строк
set nowrap

" }}}

" Горячие клавиши {{{

" Ускоренное передвижение по тексту
nmap <C-H> 5h
nmap <C-J> 5j
nmap <C-K> 5k
nmap <C-L> 5l

" Сохранить файл
nmap <C-S> :w<cr>
vmap <C-S> <esc>:w<cr>v
imap <C-S> <esc>:w<cr>i

" Открыть NERDTree
map  <C-Q> :NERDTreeToggle<cr>
vmap <C-Q> <esc>:NERDTreeToggle<cr>v
imap <C-Q> <esc>:NERDTreeToggle<cr>i

" Закрыть буфер
nmap <C-`> :bd<cr>
vmap <C-`> <esc>:bd<cr>v
imap <C-`> <esc>:bd<cr>i

" PyDoc
map gh <Leader>pW

" }}}

" Автоматизация {{{

" Aвтозавершение слов по tab =)
function InsertTabWrapper()
 let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
imap <tab> <c-r>=InsertTabWrapper()<cr>

" Слова откуда будем завершать
set complete=""
" Из текущего буфера
set complete+=.
" Из словаря
set complete+=k
" Из других открытых буферов
set complete+=b
" из тегов 
set complete+=t

" }}}
