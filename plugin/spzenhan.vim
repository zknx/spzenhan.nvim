scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

if exists('g:spzenhan')
    finish
endif
let g:spzenhan = 1

if !exists('g:spzenhan#wsl')
    if has('unix')
        let s:uname = system('uname -a')
        if (stridx(s:uname, 'Linux') != -1) && (stridx(s:uname, 'microsoft-standard') != -1)
            let g:spzenhan#wsl = 1
        else
            let g:spzenhan#wsl = 0
        endif
    else
        let g:spzenhan#wsl = 0
    endif
endif

if has('win32') || has('win32unix') || g:spzenhan#wsl == 1
    "let g:spzenhan#default_status = 0

    if !exists('g:spzenhan#executable')
        let g:spzenhan#executable = 'spzenhan.exe'
        let command_result = system([g:spzenhan#executable])
        if v:shell_error != 0 && v:shell_error != 1
            let g:spzenhan#executable = expand('<sfile>:h:h') . '/zenhan/spzenhan.exe'
            if (getftype(g:spzenhan#executable) != "file")
                let g:spzenhan#executable = expand('<sfile>:h:h') . '/spzenhan.exe'
                if (getftype(g:spzenhan#executable) != "file")
                    echo "spzenhan.exe is not found"
                    finish
                endif
            endif
        endif
    endif

    augroup zenhan
        autocmd!
        autocmd BufEnter * call system([g:spzenhan#executable])
                \ | let b:zenhan_ime_status = exists('g:spzenhan#default_status') ? g:spzenhan#default_status : v:shell_error
        autocmd InsertEnter * if b:zenhan_ime_status == 1 | call system([g:spzenhan#executable , ' 1']) | endif
        autocmd InsertLeave * call system([g:spzenhan#executable , ' 0'])
                \ | let b:zenhan_ime_status = exists('g:spzenhan#default_status') ? g:spzenhan#default_status : v:shell_error
    augroup END
endif

let &cpo = s:save_cpo
unlet s:save_cpo
