# Links to practical videos

*Practical #1: How to install the Ubuntu subsystem for Windows 10*  https://www.youtube.com/watch?v=22VtIhzPB1o

*Practical #2: Plotting data with Python and xmgrace*  https://www.youtube.com/watch?v=KrcyFavMHiY

# How to install the Ubuntu subsystem for Windows	10

***Still on Windows 7 or 8?***

*-- Update to Windows 10 for free:* https://geeksadvice.com/upgrade-to-windows-10-for-free/ or ask Google

*-- Install Ubuntu from scratch or in dual-boot (might be a better option for slower computers)*

*-- University computer labs (soon!)*

#

**Step 1.**	Open the Windows 10 Start Menu and search "Turn Windows features on or off"

Select "Windows Subsystem for Linux"
 
Click "OK"
  
Restart your computer

**Step 2.**	Install Xming: https://sourceforge.net/projects/xming/

Install Xming-fonts: https://sourceforge.net/projects/xming/files/Xming-fonts/

Run Xming (It has to be running in the background before you open a terminal and has to be run every time your computer is rebooted.)

**Step 3.**	Install Ubuntu 20 through the Microsoft Store (you don't have to sign in unless you are using a VPN): https://www.microsoft.com/en-za/p/ubuntu-2004-lts/9n6svws3rx71?rtc=1

**Step 4.**	Set up username and password in the Ubuntu terminal (for safety reasons, the password does not show up as you type it)

**Step 5.**	To update librairies, paste (by using the right click of your mouse pad or middle click of your mouse) the following commands in the terminal:

    sudo apt update
    
and
    
    sudo apt upgrade

**Step 6.**	To check if a particular program is in the Ubuntu repository and install the figure editor "grace", paste the following commands in the terminal:

    sudo apt-cache search grace
      
and
  
    sudo apt install grace

**Step 7.**	Install the text editor "gedit" by pasting in the terminal:

    sudo apt install gedit

***Test:*** Type "gedit" in the terminal. If it complains about connection or display, paste the following line in the terminal:

    export DISPLAY=0:0
    
Then, type "gedit ~/.bashrc", add the line "export DISPLAY=0:0", save and close. Finally, paste in the terminal:

    source ~/.bashrc

***More support:***	https://wiki.ubuntu.com/WSL and Google


# How to install ROOT6 on Ubuntu	
**Step 1.**	Install all required and optional packages (https://root.cern/install/dependencies/) by pasting the two following commands in the terminal:

    sudo apt-get install dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev \
    libxft-dev libxext-dev python libssl-dev
 
and
 
    sudo apt-get install gfortran libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev python-dev libxml2-dev libkrb5-dev \
    libgsl0-dev

**Step 2.**	Download the ROOT6 release for the desired platform (https://root.cern/install/all_releases/) by pasting the following command in the terminal:

    wget https://root.cern/download/root_v6.22.08.Linux-ubuntu20-x86_64-gcc9.3.tar.gz

**Step 3.**	Unpack the archive by pasting the following command in the terminal:

    tar -xzvf root_v6.22.08.Linux-ubuntu20-x86_64-gcc9.3.tar.gz
    
**Step 4.**	In your home directory (cd ~), open your .bashrc file using gedit (gedit .bashrc) and add the following line before saving and closing the file:

    source root/bin/thisroot.sh

**Step 5.**	Paste the following command in the terminal:

    source ~/.bashrc

***Easy test:*** Type "root" in the terminal and press "Enter", then "2+2" and press "Enter", then ".q" to quit.

***Medium test:*** Run the germanium detection efficiency code to obtain the efficiency curve: https://github.com/UWCNuclear/RootEffi

Instructions are on the Github page. (To download, paste "git clone https://github.com/UWCNuclear/RootEffi.git" in your terminal)

***Advanced test:*** (Some editing required :-)) Reproduce the plots from the Covid19 minischool: https://github.com/UWCNuclear/Covid19_minischool

Watch the videos to find the commands. (To download, paste "git clone https://github.com/UWCNuclear/Covid19_minischool.git" in your terminal)

***More support:***	https://root.cern/install/  and Google


# How to install Anaconda, Spyder and Jupyter Notebook on Windows or Ubuntu
**Step 1.**	Follow instructions carefully for Windows (https://docs.anaconda.com/anaconda/install/windows/) or for Ubuntu/Debian (https://docs.anaconda.com/anaconda/install/linux/).

***Medium Test:*** Run the Monte Carlo code "pi.py" included in this repository. To download, click "Code" at the top right, click "Download ZIP". To run, open "pi.py" in Spyder, click the arrow (run) icon, click on "Plots" in the top right window.

***Medium Test:*** Run the muon flux plotting and fitting code "muon_flux_example.ipynb" included in this repository. 

***More support:***	https://docs.anaconda.com/anaconda/user-guide/troubleshooting/  and Google

***Python workshop:***	https://github.com/UWCNuclear/PythonWorkshop :-)


# How to install GRSISort on Ubuntu	[A very useful ROOT-based nuclear physics toolkit]
**Step 1.**	Follow Steps 1, 3, 4, and 5 carefully: https://github.com/GRIFFINCollaboration/GRSISort/wiki/Setting-up-GRSISort

"sudo apt-get install libblas3"	might be needed for newer versions.

Older versions might need an older ROOT version (for example: ROOT6.22 includes a major PyROOT upgrade).

***Test:*** All the tests for ROOT should still work: simply replace "root" by "grsisort"

***More support:*** https://github.com/GRIFFINCollaboration/GRSISort/wiki/troubleshooting  and Google
