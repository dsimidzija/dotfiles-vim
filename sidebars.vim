" original source:
" https://vi.stackexchange.com/questions/40071/how-to-close-terminal-and-nerdtree-windows-if-they-are-the-last-windows

function! IsSideBar(buf_nr)
    " Returns 1 if the buffer is actual a side bar
    " - A terminal
    " - The NERDTree side bar
    " - The QuickFix window
    " - The Help window
    " - The UndoTree side bar
    " - ...
    let buf_name = bufname(a:buf_nr)
    let buf_type = getbufvar(a:buf_nr, '&filetype')
    let readonly = getbufvar(a:buf_nr, '&readonly')

    " 2024-02-29 - don't assume fugitive windows are sidebars
    if buf_type ==# 'git'
        return 0
    endif

    " we don't want this - otherwise we can't open read only files at all
    "if readonly
    "    return 1

    elseif buf_type ==# 'qf'
        " QuickFix, LocationList:
        " Not Read Only
        return 1

    elseif buf_type ==# 'help'
        " Read Only
        " Help Window:
        return 1

    elseif buf_type ==# 'undotree'
        " Not Read Only
        return 1

    elseif buf_type ==# 'nerdtree'
        " Read Only
        return 1

    elseif buf_type ==# 'terminal'
        " terminal
        return 1

    else
        return 0

    endif
endfunction

function! GetNumWindows()
    " Returns the number of window that are not side bars
    let num_windows = 0
    for win_nr in range(1, winnr('$'))
        let buf_nr = winbufnr(win_nr)

        if IsSideBar(buf_nr)
            continue
        endif

        let num_windows = num_windows + 1
    endfor

    return num_windows
endfunction

function! KillSideBars()
    let num_windows = GetNumWindows()
    if num_windows > 0
        " If there are some non side bar windows do nothing:
        return
    endif

    " Delete the terminal buffers that don't correspond to a window
    let term_buffers = term_list()
    for buf_nr in term_buffers
        if len(win_findbuf(buf_nr)) == 0
            " Exit terminal not associated to a window
            execute 'bd! ' . buf_nr
        endif
    endfor

    let term_buffers = term_list()
    let buf_nr = bufnr('%')
    if index(term_buffers, buf_nr) >= 0
        " Kill the terminal buffer and quit
        call feedkeys("\<C-w>:bd!\<CR>:quit\<CR>:\<BS>")
    else
        " Kill the side bar window
        call feedkeys(":quit\<CR>:\<BS>")
    endif
endfunction

autocmd BufEnter * call KillSideBars()
