# Bootstrapping a Dev Environment for Axemoor

This is a collection of bash scripts and help files designed to facilitate setting up a web development environment on a new linux install for Axemoor webministers.
Built on and for Ubuntu and/or Raspbian. May work with other distros.

## First Steps

* Install the OS. Options include:
** Ubuntu on a computer
** Ubuntu in a VM
** Ubuntu in Windows 10 Subsystem for Linux
** Raspbian for Raspberry Pi
* Create a non-root user
** In the case of Raspbian, change the Pi and root passwords (and record the new ones someplace safe!)
* If you installed an OS version with a Window environment, launch Terminal
* At the command prompt, type

```
$ curl https://github.com/Cordelya/axemoor-bootstrap/[FILE} ## note: this file doesn't exist yet, so currently this will fail
$ chmod +x [FILE] ## note: this won't work until the line above works
$ [FILE] ## once the first line works, this will run the bootstrap file
```

The first line downloads the file. The second line makes it executable. The third line runs the file. It will prompt you to enter the password for the user *root*. The file will install all of the necessary software, do initial webserver configuration, and do initial git configuration, including making a new directory, "help" and cloning this repository to that location, which gives you access to the help files. Expect the install portion to take some time. Go do something else for 10 minutes and come back.

There are some actions you, the user must take before you are fully set up. They are:
* generate a set of SSH keys to identify yourself to GitHub. You need one set to use for deploying updates to /Axemoor/website. You need a second set for your own account if you intend to also use your Github account to track your own projects here.
* Copy & paste contents of .pub keyfiles into the appropriate Github SSH key form fields # TODO: link to Github help files for these
* Associate your Axemoor deploy key with the local Axemoor website repo
* Test by changing something unimportant, committing the change, and pushing the change to the remote. TODO: create a .txt file in the Axemoor repo where these test changes can be made. Have them add their SCA name, or add some extra characters next to their name for the test.
* Test that the server is functioning by viewing in a browser. These instructions will vary depending on your environment. If using Ubuntu on Linux subsystem for Win10, you'll use the browser you have installed on windows and enter "localhost" in the address bar. If you're using a separate machine and running it without a window environment, you'll need to look up the machine's local IP and enter that in the browser of another computer on the same network. TODO: a help file that only covers this topic.




```
