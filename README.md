# Bootstrapping a Dev Environment for Axemoor

**CAUTION: This repo is still under initial development and is untested. Do not follow these instructions until this line disappears from this file**

If you are helping to test these, make sure you grab from the appropriate branch for the time being.

This is a collection of bash scripts and help files designed to facilitate setting up a web development environment on a new linux install for Axemoor webministers, with heavy support for git on the CLI.
Built on and for Ubuntu and/or Raspbian. May work with other distros. Open a new issue to tell me about how it went with a different OS and we'll see about adding compatibility.

## Notes for those using this file
* Command line input is denoted by a leading $. This refers to the default use of $ as the command prompt on *nix systems. Don't type the $, just start right after it.
* You may be able to copy/paste. CTRL-C/V/X don't work in the terminal (not without changing some settings first). You can copy/paste into or out of terminal using right-clicks
    * Select text outside of a terminal window and CTRL-C or use the right-click -> Copy context menu. Return focus to the terminal and right-click. What you copied will be pasted at the command prompt. If you are pasting in a password, it won't show up - you just have to take it on faith and see what happens.
    * Select text inside a terminal window by highlighting with your mouse, then right-click. It will be copied to the clipboard and you can paste it outside of the Terminal window. This will come in handy if you encounter an error when installing.
* To report errors that are reported in Terminal, select the error and any related lines above it in Terminal and right-click to copy. Go to https://github.com/axemoor-bootstrap/issues and create a new issue. Give it a descriptive title (example: what part of the process you were trying to do, and the word "fails") and paste what you copied from the Terminal into the description field. Any information you can provide about what you wanted or expected to happen is helpful. When done, submit the issue.

## First Steps
* If you don't have a GitHub account, create one. The free level is sufficient for what you need.
* Install the OS. Options include:
    * Ubuntu installed directly on a computer
    * Ubuntu in a VM
    * Ubuntu in Windows 10 Subsystem for Linux
    * Raspbian for Raspberry Pi
* Create a non-root user
    * In the case of Raspbian, change the Pi and root passwords (and record the new ones someplace safe - but not so safe you can't find them later!)
* If you installed an OS version with a windowed desktop environment, launch Terminal
* At the command prompt, type

### If you're using Raspbian
```
$ curl https://raw.githubusercontent.com/Cordelya/axemoor-bootstrap/master/raspbian-init.sh > $HOME/raspbian-init.sh
$ chmod +x $HOME/raspbian-init.sh # this makes the file executable
$ PATH=$PATH:$HOME # this tells bash where to find the file
$ raspbian-init.sh # this begins the install and config process
````
### If you're using Ubuntu
````
# On Ubuntu:
$ curl https://raw.githubusercontent.com/Cordelya/axemoor-bootstrap/master/ubuntu-init.sh > $HOME/ubuntu-init.sh # Ubuntu
$ chmod +x $HOME/ubuntu-init.sh # this makes the file executable
$ PATH=$PATH:$HOME # this tells bash where to find the file
$ ubuntu-init.sh # this begins the install and config process
````

The first line downloads the file. The second line makes it executable. The third line runs the file. You may be prompted to enter the password for the user *root*, so have it handy. The file will install all of the necessary software, do initial webserver configuration, and do initial git configuration, including making a new directory, "help" and cloning this repository to that location, which gives you access to the help files. Expect the install portion to take some time. Go do something else for 10 minutes and come back.

## End-user intervention
There are some actions you, the user must take before you are fully set up. They are:
* generate a set of SSH keys to identify yourself to GitHub. You need one set to use for deploying updates to /Axemoor/website. You need a second set for your own account if you intend to also use your Github account to track your own projects here.
    * Directions for the Axemoor deploy keys are here: https://gist.github.com/Cordelya/1450ef798a6fcece64097aef853776ee
    * Directions for generating your personal keys and adding them to your Github account are here: https://docs.github.com/articles/generating-an-ssh-key/
    * If you plan to use git with Github for your own projects using this same system, you will need to do items 3 and 4 at the bottom of the deploy keys directions
* Test by changing something unimportant, committing the change, and pushing the change to the remote. TODO: create a .txt file in the Axemoor repo where these test changes can be made. Have them add their SCA name, or add some extra characters next to their name for the test.
* Test that the server is functioning by viewing in a browser. These instructions will vary depending on your environment. If using Ubuntu on Linux subsystem for Win10, you'll use the browser you have installed on windows and enter "localhost" in the address bar. If you're using a separate machine and running it without a window environment, you'll need to look up the machine's local IP and enter that in the browser of another computer on the same network. TODO: a help system topic that covers viewing sites.

This is the end of the startup instructions. Additional help is available in your development environment by typing

````
$ axemoor.sh # if you know the help topic keyword you're looking for, you can type it after axemoor.sh (but leave a space between)
````

Or you can browse the help files online in this repository, under /helpfiles
