# Arthur's Arch linux Auto-installer (AAA)
:battery: *My batteries for Arch!* :battery:

Archinstaller was giving me a lot of problems, so I decided to make this. The purpose of this script is to make an automatic Arch Linux install (with an encrypted drive) and/or install most packages I use daily.

## How to use
You will need the following:
- You will need a bootable USB drive with the [latest Arch image](https://archlinux.org/download/)
- An internet connection after booting (see [iwctl](https://wiki.archlinux.org/title/iwd#iwctl) if you plan on doing this through a wireless connection).

Afterwards, just run the following command:
```
curl -s https://raw.githubusercontent.com/arthurmateu/aaa/main/aaa.sh | bash
```

## To-Do List
- [ ] Make an automatic installer
  - [ ] Automatically detect region for localization
  - [ ] Automatically detect drivers necessary
  - [ ] Automatically adjust partition size
- [X] Make a post-installation helper (adjuster)
  - [ ] Have different package options depending on the profile chosen
  - [ ] If it has been run after the installer and a new user has been provided, add it to the necessary groups
- [X] Make it a one-line command ([similar to this](https://github.com/ChrisTitusTech/ArchTitus))
  - [ ] Make the one-liner shorter 
- [ ] Make the `readme.md` file prettier

## Credits
We're all standing on the shoulders of giants! (aka I'm basically just ~~stealing~~ borrowing a lot of code and ideas). 
Please check all sources I used!
- [Arch Linux wiki](https://wiki.archlinux.org/title/Installation_guide)
- [ArchMatic](https://github.com/rickellis/ArchMatic)
- [ArchTitus](https://github.com/ChrisTitusTech/ArchTitus)
- [LARBS](https://larbs.xyz/)
- [RobFisher's Framework Arch Install guide](https://gist.github.com/RobFisher/abd9b2b9fca4194ac8df112715045b61)
- [The Linux Command Line](https://linuxcommand.org/tlcl.php) by William Shotts
- [sandipsky's autoinstall script](https://github.com/sandipsky/arch)