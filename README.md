[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=D6XDCHDSBDSDG)

# ZBrowse

When doing shell work, it is often the case that `echo $variable` is invoked multiple times,
to check result of a loop, etc. With ZBrowse, you just need to press `Ctrl-B`, which invokes the `ZBrowse` – `Zshell`
variable browser:

![ZBrowse](https://github.com/zdharma/zbrowse/blob/master/images/zbrowse.png)

(you can resize the video like any web page)

[![asciicast](https://asciinema.org/a/122018.png)](https://asciinema.org/a/122018)

## Installation

First install the [ZUI](https://github.com/zdharma/zui) plugin (it's an UI library).

**The plugin is "standalone"**, which means that only sourcing it is needed. So to
install, unpack `zbrowse` somewhere and add

```zsh
source {where-zbrowse-is}/zbrowse.plugin.zsh
```

to `zshrc`.

If using a plugin manager, then `Zplugin` is recommended, but you can use any
other too, and also install with `Oh My Zsh` (by copying directory to
`~/.oh-my-zsh/custom/plugins`).

### [Zplugin](https://github.com/psprint/zplugin)

Add `zplugin load zdharma/zbrowse` to your `.zshrc` file. Zplugin will handle
cloning the plugin for you automatically the next time you start zsh. To update
run `zplugin update zdharma/zbrowse` (`update-all` can also be used).

### Antigen

Add `antigen bundle zdharma/zbrowse` to your `.zshrc` file. Antigen will handle
cloning the plugin for you automatically the next time you start zsh.

### Oh-My-Zsh

1. `cd ~/.oh-my-zsh/custom/plugins`
2. `git clone git@github.com:zdharma/zbrowse.git`
3. Add `zbrowse` to your plugin list

### Zgen

Add `zgen load zdharma/zbrowse` to your .zshrc file in the same place you're doing
your other `zgen load` calls.
