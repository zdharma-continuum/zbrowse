# ZBrowse

[![Gitter][gitter-image]][gitter-link]

When doing shell work, `echo $variable` is often invoked multiple times to check the result of a loop.
With Zbrowse, you need to press `Ctrl-B`, which invokes the `ZBrowse` – `Zshell` variable browser:

![ZBrowse](https://github.com/zdharma-continuum/zbrowse/blob/master/images/zbrowse.png)

[![asciicast](https://asciinema.org/a/122018.png)](https://asciinema.org/a/122018)

## Install

First, install [ZUI](https://github.com/zdharma-continuum/zui) plugin (it's a UI library).

**The plugin is "standalone"**, meaning only sourcing it is needed. So to install, unpack `zbrowse` somewhere
and add the following snippet to your `zshrc`.

```zsh
source <PATH TO ZBROWSE DIRECTORY>/zbrowse.plugin.zsh
```

If using a plugin manager, then `zinit` is recommended, but you can use any other too, and also install with `Oh My Zsh`
(by copying directory to `~/.oh-my-zsh/custom/plugins`).

### [zinit](https://github.com/zdharma-continuum/zinit)

Add `zinit load zdharma-continuum/zbrowse` to your `.zshrc` file. Zinit will automatically handle cloning the plugin for you
the next time you start zsh. To update, run `zinit update zdharma-continuum/zbrowse`.

To remap the default key binding `Ctrl+B`, which conflicts with GNU readline, use the following snippet:

```zsh
zinit ice \
  bindmap"^B -> ^H" \
  lucid \
  trackbinds \
  wait"3"
zinit light @zdharma-continuum/zbrowse
```

This will make `Ctrl`+`H` the default keybinding to invoke Zbrowse.

### Antigen

Add `antigen bundle zdharma-continuum/zbrowse` to your `.zshrc` file. Antigen will handle cloning the plugin for you
automatically the next time you start zsh.

### Oh-My-Zsh

1. `cd ~/.oh-my-zsh/custom/plugins`
1. `git clone https://github.com/zdharma-continuum/zbrowse`
1. Add `zbrowse` to your plugin list

### Zgen

Add `zgen load zdharma-continuum/zbrowse` to your .zshrc file in the same place you're doing your other `zgen load`
calls.

[gitter-image]: https://badges.gitter.im/zdharma-continuum/community.svg
[gitter-link]: https://gitter.im/zdharma-continuum/community