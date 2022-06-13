# zenhan

Switch the mode of input method editor from terminal. This is a tool similar to im-select.

see https://github.com/VSCodeVim/Vim#input-method

## Setting example

```
"vim.autoSwitchInputMethod.enable": true,
"vim.autoSwitchInputMethod.defaultIM": "0",
"vim.autoSwitchInputMethod.obtainIMCmd": "D:\\bin\\zenhan.exe",
"vim.autoSwitchInputMethod.switchIMCmd": "D:\\bin\\zenhan.exe {im}"
```

## see also

[Qiita (Japanese)](https://qiita.com/iuchi/items/9ddcfb48063fc5ab626c)

---

# spzenhan (for neovim)

'spzenhan' is slightly patched zenhan to control IME from neovim.

When exiting insert mode, turn off the IME if it is on.  
When re-enterring the insert mode, the IME state will return to the state it was in the last time.

The executable binary of spzenhan is include [in this repository](./zenhan/spzenhan.exe).

## Install and Setting example

dein.toml

```
[[plugins]]
repo = '~/repos/spzenhan.vim'
```

If you want to set the IME status always off when entering insert mode.

```
let g:spzenhan#default_status = 0
```

## Usage of spzenhan.exe

turn on IME

```
spzenhan 1
```


turn off IME

```
spzenhan 0
```

get current IME status (Return the IME status as exit code)

```
spzenhan
echo $?
```

## Differences from original zenhan

* Return the IME status as exit code (0:off, 1:on -1:error)

    If spzenhan is run without arguments, the current IME status will be returned.  
    If there is an argument, the IME status before the change will be returned.

* The build script compiles spzenhan with clang.
* Don't make 32-bit binary.


## Compatible mode

If you give `--compat` option as 1st argument of spzenhan, spzenhan works compatibility mode.  
In the compatibility mode, the return code of spzenhan process is always 0.  
It will works well with VScodeVim plugin .

