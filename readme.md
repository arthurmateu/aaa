# Arthur's Arch linux Auto-installer (AAA)
:battery: *My batteries for Arch!* :battery:

Archinstaller was giving me a lot of problems, so I decided to make this. This script gives you a guided installation to Arch Linux and/or install most packages I use daily.

## How to use
You will need the following:
- You will need a bootable USB drive with the [latest Arch image](https://archlinux.org/download/)
- An internet connection after booting (see [iwctl](https://wiki.archlinux.org/title/iwd#iwctl) if you plan on doing this through a wireless connection).

Afterwards, just run the following commands:
```
pacman -Sy git
git clone https://github.com/arthurmateu/aaa.git
cd aaa
./aaa.sh
```

## To-Do List
- [ ] Make a guided installer
- [ ] Make a prettier `readme.md` file
- [X] Make a post-installation helper (adjuster)
- [ ] Make it run with just curl ([similar to this](https://github.com/ChrisTitusTech/ArchTitus))
- [ ] Have an automatic option
  - [ ] Automatically detect region for localization
  - [ ] Automatically detect drivers necessary
  - [ ] Automatically adjust partition size

## Credits
We're all standing on the shoulders of giants! (aka I'm basically just ~~stealing~~ borrowing a lot of code and ideas). 
Please check all sources I used!
- [Arch Linux wiki](https://wiki.archlinux.org/title/Installation_guide)
- [ArchMatic](https://github.com/rickellis/ArchMatic)
- [ArchTitus](https://github.com/ChrisTitusTech/ArchTitus)
- [RobFisher's Framework Arch Install guide](https://gist.github.com/RobFisher/abd9b2b9fca4194ac8df112715045b61)
- [The Linux Command Line](https://linuxcommand.org/tlcl.php) by William Shotts
- [sandipsky's autoinstall script](https://github.com/sandipsky/arch)