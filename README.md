# How to install the Ubuntu subsystem for Windows	10
Step 1:	Open the Windows 10 Start Menu and search "Turn Windows features on or off"

Select "Windows Subsystem for Linux"
 
Click "OK"
  
Restart your computer

Step 2:	Install Xming: https://sourceforge.net/projects/xming/

Run Xming (It has to be running in the background before you open a terminal and has to be run every time your computer is rebooted.)

Step 3:	Install Ubuntu version (18 or 20) through the Microsoft Store: https://wiki.ubuntu.com/WSL#Installing_Ubuntu_on_WSL_via_the_Microsoft_Store_.28Recommended.29

Step 4:	Set up username and password in the Ubuntu terminal

Step 5:	Type "sudo apt upgrade" in the terminal

Step 6:	Install the text editor "gedit" by typing "sudo apt-get install gedit" in the terminal

*Test*: Type "gedit" in the terminal

*More support*:	https://wiki.ubuntu.com/WSL


# How to install ROOT6 on Ubuntu	
Step 1:	Install all required and optional packages: https://root.cern/install/dependencies/

Step 2:	Download the ROOT6 release for the desired platform (https://root.cern/install/all_releases/) using "wget https://root.cern/download/root....tar.gz"

Step 3:	Unpack the archive: "tar -xzvf root....tar.gz"

Step 4:	Add the line "source root/bin/thisroot.sh" to your /home/.bashrc file

Step 5:	Type "source .bashrc" in the terminal

*Easy test*: Type "root" in the terminal and press "Enter", then "2+2" and press "Enter", then ".q" to quit.

*Medium test*: Run the germanium detection efficiency code to obtain the efficiency curve: https://github.com/UWCNuclear/RootEffi (Instructions on the Github page) (To download, type "git clone https://github.com/UWCNuclear/RootEffi.git" in your terminal)

*Advanced test*: (Some editing required :-)) Reproduce the plots from the Covid19 minischool: https://github.com/UWCNuclear/Covid19_minischool (Watch the videos to find the commands) (To download, type "git clone https://github.com/UWCNuclear/Covid19_minischool.git" in your terminal)

*More support*:	https://root.cern/install/


# How to install Anaconda, Spyder and Jupyter Notebook on Windows
Step 1:	Follow instructions carefully: https://docs.anaconda.com/anaconda/install/windows/

*Test*: Run the Monte Carlo code "pi.py" included in this repository. To download, click "Code" at the top right, click "Download ZIP". To run, open "pi.py" in Spyder, click the arrow (run) icon, click on "Plots" in the top right window.

*More support*:	https://docs.anaconda.com/anaconda/user-guide/troubleshooting/


# [If interested :-)] How to install GRSISort on Ubuntu	[A very useful ROOT-based nuclear physics toolkit]
Step 1:	Follow Steps 1 to 5 carefully: https://github.com/GRIFFINCollaboration/GRSISort/wiki/Setting-up-GRSISort

"sudo apt-get install libblas3"	might be needed

*Test*: All the tests for ROOT should still work: simply replace "root" by "grsisort"

*More support*: https://github.com/GRIFFINCollaboration/GRSISort/wiki/troubleshooting
