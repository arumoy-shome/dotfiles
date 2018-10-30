# Dotfiles #

A set of files that begin with a dot and are updated quite frequently.

## Dependencies ##

- osx as your operating system
- xcode developer tools
- [fish](http://fishshell.com/) as your command line shell
- [homebrew](https://brew.sh/) for package management

## Getting started ##

1. execute the `bootstrap` script with `./bootstrap`, this will install the core
dependencies
2. use `./deploy` to install, link/unlink & delete topics

```
    usage: ./deploy FLAGS TOPICS
    if no FLAGS are passed then given TOPICS are installed & linked

    valid FLAGS: -h -l -L -u -d
    -h: print this help message
    -L: list enabled topics
    -l: link given TOPICS
    -u: unlink given TOPICS
    -d: delete given TOPICS

    example usage:
    ./deploy base # install and link base
    ./deploy base zsh fish # install and link base, zsh & fish
    ./deploy -l base zsh fish # only link base, zsh & fish
    ./deploy -d tmux # delete tmux
```

Make sure to read the topic/README before installing for caveats and dependencies.

## Organisation ##

1. Each topic is under it's own directory
2. A topic must contain a `_init` script
3. `_init` must define an `install` function for the topic to be valid
4. Executables can be placed under topic/bin which will be automatically loaded
into the `PATH`
5. Additional shell configs can be placed under topic/topic.fish, these are (sym)linked
to `XDG_CONFIG_DIR/fish/conf.d` and are automatically picked up by fish
6. Use `topic/_init#install` to define how to install a topic. Additionally,
one off actions such as setting up `PATH` or exporting variables can be placed here
7. Use `topic/_init#link` to (sym)link config files to their appropriate locations
8. Use `topic/_init#unlink` to undo `topic/_init#link`. In essence, `link` &
`unlink` must only contain repeatable actions such that they may be executed multiple
times without any serious consequences
9. Use `topic/_init#delete` to undo `topic/_init#install`. In essence, `install`
& `delete` must only contain one off actions that cannot be executed multiple times.

## License ##

This project is open sourced and free to use under the [MIT license](LICENSE.md)].

## Credits ##

* [Thoughtbot](https://github.com/thoughtbot/dotfiles)
* [Greg Hurrell](https://github.com/wincent/wincent)
* [Chris Toomey](https://github.com/christoomey/dotfiles)
* [Henrik Lissner](https://github.com/hlissner/dotfiles)
