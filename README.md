# How to install the Ubuntu subsystem for Windows	10
Step 1:	Open the Windows 10 Start Menu and search "Turn Windows features on or off"

Select "Windows Subsystem for Linux"
 
Click "OK"
  
Restart your computer

Step 2:	Install XMing: https://sourceforge.net/projects/xming/

Run XMing (It has to be running in the background before you open a terminal and has to be run every time your computer is rebooted.)

Step 3:	Install Ubuntu version through the Microsoft Store: https://wiki.ubuntu.com/WSL#Installing_Ubuntu_on_WSL_via_the_Microsoft_Store_.28Recommended.29

Step 4:	Set up username and password in the Ubuntu terminal

Step 5:	Paste "sudo apt upgrade" in the terminal

*More support*:	https://wiki.ubuntu.com/WSL


# How to install ROOT on Ubuntu	
Step 1:	Install all required and optional packages: https://root.cern/install/dependencies/

Step 2:	Download the ROOT release for the desired platform (https://root.cern/install/all_releases/) using "wget https://root.cern/download/root....tar.gz"

Step 3:	Unpack the archive: "tar -xzvf root....tar.gz"

Step 4:	Add the line "source root/bin/thisroot.sh" to your /home/.bashrc file

Step 5:	Paste "source .bashrc" in the terminal

*More support*:	https://root.cern/install/


# How to install GRSISort on Ubuntu	
Step 1:	Follow Steps 1 to 5 carefully: https://github.com/GRIFFINCollaboration/GRSISort/wiki/Setting-up-GRSISort

Maybe need "sudo apt-get install libblas3"	

*More support*: https://github.com/GRIFFINCollaboration/GRSISort/wiki/troubleshooting
