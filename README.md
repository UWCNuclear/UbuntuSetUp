# How to install the Ubuntu subsystem for Windows	10
Step 1.	Open the Windows 10 Start Menu and search "Turn Windows features on or off"

Select "Windows Subsystem for Linux"
 
Click "OK"
  
Restart your computer

Step 2.	Install Xming: https://sourceforge.net/projects/xming/

Run Xming (It has to be running in the background before you open a terminal and has to be run every time your computer is rebooted.)

Step 3.	Install Ubuntu version (18 or 20) through the Microsoft Store: https://wiki.ubuntu.com/WSL#Installing_Ubuntu_on_WSL_via_the_Microsoft_Store_.28Recommended.29

Step 4.	Set up username and password in the Ubuntu terminal

Step 5.	Type in the terminal:

    sudo apt upgrade

Step 6.	Install a text editor (gedit or emacs) by typing in the terminal:

    sudo apt-get install gedit

*Test*: Type "gedit" in the terminal

*More support*:	https://wiki.ubuntu.com/WSL


# How to install ROOT6 on Ubuntu	
Step 1.	Install all required and optional packages (https://root.cern/install/dependencies/) by typing the two following commands in the terminal:

    sudo apt-get install dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev \
    libxft-dev libxext-dev python libssl-dev
    
    sudo apt-get install gfortran libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev python-dev libxml2-dev libkrb5-dev \
    libgsl0-dev libqt4-dev

Step 2.	Download the ROOT6 release for the desired platform (https://root.cern/install/all_releases/):

    wget https://root.cern/download/root....tar.gz

Step 3.	Unpack the archive:

    tar -xzvf root....tar.gz"
    
Step 4.	Using a text editor, add the line "source root/bin/thisroot.sh" to your /home/.bashrc file

Step 5.	Type in the terminal:

    source .bashrc

*Easy test*: Type "root" in the terminal and press "Enter", then "2+2" and press "Enter", then ".q" to quit.

*Medium test*: Run the germanium detection efficiency code to obtain the efficiency curve: https://github.com/UWCNuclear/RootEffi

Instructions are on the Github page. (To download, type "git clone https://github.com/UWCNuclear/RootEffi.git" in your terminal)

*Advanced test*: (Some editing required :-)) Reproduce the plots from the Covid19 minischool: https://github.com/UWCNuclear/Covid19_minischool

Watch the videos to find the commands. (To download, type "git clone https://github.com/UWCNuclear/Covid19_minischool.git" in your terminal)

*More support*:	https://root.cern/install/


# How to install Anaconda, Spyder and Jupyter Notebook on Windows
Step 1.	Follow instructions carefully: https://docs.anaconda.com/anaconda/install/windows/

*Test*: Run the Monte Carlo code "pi.py" included in this repository. To download, click "Code" at the top right, click "Download ZIP". To run, open "pi.py" in Spyder, click the arrow (run) icon, click on "Plots" in the top right window.

*More support*:	https://docs.anaconda.com/anaconda/user-guide/troubleshooting/

*Python workshop*:	https://github.com/UWCNuclear/PythonWorkshop  :-)


# [If interested :-)] How to install GRSISort on Ubuntu	[A very useful ROOT-based nuclear physics toolkit]
Step 1.	Follow Steps 1 to 5 carefully: https://github.com/GRIFFINCollaboration/GRSISort/wiki/Setting-up-GRSISort

"sudo apt-get install libblas3"	might be needed

*Test*: All the tests for ROOT should still work: simply replace "root" by "grsisort"

*More support*: https://github.com/GRIFFINCollaboration/GRSISort/wiki/troubleshooting
