# ZBrowse [![Gitter][gitter-image]][gitter-link]

When doing shell work, it is often the case that `echo $variable` is invoked multiple times, to check result of a loop,
etc. With ZBrowse, you just need to press `Ctrl-B`, which invokes the `ZBrowse` – `Zshell` variable browser:

![ZBrowse](https://github.com/zdharma-continuum/zbrowse/blob/master/images/zbrowse.png)

(you can resize the video like any web page)

[![asciicast](https://asciinema.org/a/122018.png)](https://asciinema.org/a/122018)

## Installation

First install the [ZUI](https://github.com/zdharma-continuum/zui) plugin (it's an UI library).

**The plugin is "standalone"**, which means that only sourcing it is needed. So to install, unpack `zbrowse` somewhere
and add

```zsh
source {where-zbrowse-is}/zbrowse.plugin.zsh
```

to `zshrc`.

If using a plugin manager, then `zinit` is recommended, but you can use any other too, and also install with `Oh My Zsh`
(by copying directory to `~/.oh-my-zsh/custom/plugins`).

### [zinit](https://github.com/zdharma-continuum/zinit)

Add `zinit load zdharma-continuum/zbrowse` to your `.zshrc` file. zinit will handle cloning the plugin for you
automatically the next time you start zsh. To update run `zinit update zdharma-continuum/zbrowse` (`--all` can also
be used).

To remap the default bindkey (Ctrl+B) which conflicts with GNU readline, do the following:

```zsh
zinit ice wait"3" trackbinds bindmap"^B -> ^H;" lucid
zinit light zdharma-continuum/zbrowse
```

This will make Ctrl+H the default keybinding to invoke zbrowse.

### Antigen

Add `antigen bundle zdharma-continuum/zbrowse` to your `.zshrc` file. Antigen will handle cloning the plugin for you
automatically the next time you start zsh.

### Oh-My-Zsh

1. `cd ~/.oh-my-zsh/custom/plugins`
1. `git clone git@github.com:zdharma-continuum/zbrowse.git`
1. Add `zbrowse` to your plugin list

### Zgen

Add `zgen load zdharma-continuum/zbrowse` to your .zshrc file in the same place you're doing your other `zgen load`
calls.

[gitter-image]: https://badges.gitter.im/zdharma-continuum/community.svg
[gitter-link]: https://gitter.im/zdharma-continuum/community
