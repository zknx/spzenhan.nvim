# spzenhan.nvim

A simple Neovim plugin for automatic IME (Input Method Editor) control on Windows and WSL.
This plugin automatically switches your IME to OFF when you leave insert mode and restores its state when you re-enter insert mode.
The executable binary of spzenhan is include in this repository.

## Installation

### Using `lazy.nvim`

```lua
{
  "zknx/spzenhan.nvim",
  event = "BufEnter",
  opts = {
    -- Path to the spzenhan.exe executable.
    -- If nil, the plugin will automatically search for it in the system's PATH
    -- and within the plugin's own directory.
    executable = nil,

    -- If true, plugin will search spzenhan.exe from path.
    find_executable_from_path = false,

    -- The default IME status after you leave insert mode or switch buffers.
    -- 0:   Always turn IME OFF. This is the classic behavior.
    -- 1:   Always turn IME ON.
    -- nil: Keep the IME state as it was when the buffer was first entered.
    default_status = 0,
  },
}
```

## Credits

This plugin is heavily inspired by the following projects:

- [spzenhan.vim](https://github.com/kaz399/spzenhan.vim) by [kaz399](https://github.com/kaz399)
- [zenhan](https://github.com/iuchim/zenhan) by [iuchim](https://github.com/iuchim)

Many thanks to the original authors for their great work.
