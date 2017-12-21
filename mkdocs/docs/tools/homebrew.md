[Homebrew](https://brew.sh), The macOS package management system.

!!! note
    Guide version: **1.3.8**

### Install the system

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Check the version

```bash
brew --version
```

### Search for a base package

```bash
brew search <pakage>
```

### Install a base package

```bash
brew install <pakage>
```

### Search for a cask package

Browse to the [Cask search page](https://caskroom.github.io/search)

### Install a cask package

```bash
brew cask install <pakage>
```

### Install a list of packages

Change directories to a directory with a **Brewfile** and type:

```bash
brew bundle
```

# Reference

- [Project page](https://brew.sh)
- [Homebrew Cask](https://caskroom.github.io) - UI packages
    - [Search page](https://caskroom.github.io/search)
- [Brew Bundle](https://github.com/Homebrew/homebrew-bundle) Install packages listed in a **Brewfile**
