Currently this guide will be focused on a macOS worksation with the following minimum requirements:

- macOS High Sierra - version 10.13.5

```bash
system_profiler SPSoftwareDataType
Software:

    System Software Overview:

      System Version: macOS 10.13.5 (17F77)
...
```

### Xcode

Install the Xcode developer tools.

```
xcode-select --print-path
```

And you should see something like:

```
/Applications/Xcode.app/Contents/Developer
```

And the shell code will be a 0 if the developer tools are install and a 
non-0 value, 2, if they are not installed.

If they are not installed then, install them:


```
xcode-select --install
```

If this doesn't work you'll need to got to the 
[Xcode Site](https://developer.apple.com/xcode), download and install 
them.

### Make

This utility should get installed with the Xcode developer tools from 
the previous steps.

```
make --version
GNU Make 3.81
...
```

### cURL

```
curl --version
curl 7.54.0 (x86_64-apple-darwin17.0) libcurl/7.54.0 LibreSSL/2.0.20 zlib/1.2.11 nghttp2/1.24.0
...
```

### Ruby

```
ruby --version
ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-darwin17]
...
```

### Homebrew

This first step is to install the [Homebrew](../tools/homebrew) package 
management system.

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Once the installation is complete, check the installation.

```bash
brew --version
Homebrew 1.6.9
...
```

### Python

```
python --version
Python 2.7.13
```

If python doesn't exists, then you can install it now with:

```
brew install python
```

### Git

```bash
git --version
git version 2.15.1
```

Install the [Git](../tools/git) source control utility. 

```bash
brew install git
```
