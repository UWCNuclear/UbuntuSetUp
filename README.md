**Jump to:**

- [Links to Practical Videos](https://github.com/UWCNuclear/UbuntuSetUp/#links-to-practical-videos)

- [How to install Windows Subsystem for Linux (Ubuntu) on Windows 11](https://github.com/UWCNuclear/UbuntuSetUp/#how-to-install-windows-subsystem-for-linux-ubuntu-on-windows-11)

- [How to install Windows Subsystem for Linux (Ubuntu) on Windows 10](https://github.com/UWCNuclear/UbuntuSetUp/#how-to-install-windows-subsystem-for-linux-ubuntu-on-windows-10)

- [How to install ROOT on Ubuntu](https://github.com/UWCNuclear/UbuntuSetUp/#how-to-install-root-on-ubuntu)

- [How to install GRSISort on Ubuntu [A useful ROOT-based nuclear physics toolkit :-) ]](https://github.com/UWCNuclear/UbuntuSetUp/#how-to-install-grsisort-on-ubuntua-useful-root-based-nuclear-physics-toolkit---)

- [How to install Geant4 on Ubuntu](https://github.com/UWCNuclear/UbuntuSetUp/#how-to-install-geant4-on-ubuntu)

- [How to install GOSIA on Ubuntu](https://github.com/UWCNuclear/UbuntuSetUp/#how-to-install-gosia-on-ubuntu)

- [How to install GREMLIN on Ubuntu](https://github.com/UWCNuclear/UbuntuSetUp/#how-to-install-gremlin-on-ubuntu)

- [How to install RadWare on Ubuntu](https://github.com/UWCNuclear/UbuntuSetUp/#how-to-install-radware-on-ubuntu)

- [How to install NuShellX on Ubuntu](https://github.com/UWCNuclear/UbuntuSetUp/#how-to-install-nushellx-on-ubuntu)

- [How to install Anaconda, Spyder and Jupyter on Windows or Ubuntu](https://github.com/UWCNuclear/UbuntuSetUp/#how-to-install-anaconda-spyder-and-jupyter-on-windows-or-ubuntu)

# Links to Practical Videos

*Practical #1: How to install the Ubuntu subsystem for Windows 10*: https://www.youtube.com/watch?v=22VtIhzPB1o

*Practical #2: Plotting data with Python and xmgrace*: https://www.youtube.com/watch?v=KrcyFavMHiY

*Practical #3: Detector Efficiency and Peak Fitting*: https://www.youtube.com/watch?v=OG-s4FhOMIk

*Practical #4: Semi-Empirical Mass Formula*: https://www.youtube.com/watch?v=B2W0OYhtddY

# How to install Windows Subsystem for Linux (Ubuntu) on Windows 11
**Step 1.**	Open the Windows 11 Start Menu and search "Terminal". Install Ubuntu 22 by pasting the following command:

    wsl --install -d Ubuntu-22.04 --enable-wsl1

When the process is complete, restart your computer.

**Step 2.**	Set up username and password in the Ubuntu terminal. Do not close the window until you have a username and password set up. (The password does not show up as you type it.)

**Step 3.**	Set the version of the subsystem to 1 by pasting the following command:

    wsl --set-version Ubuntu-22.04 1

**Step 4.**	Install and run Xming-fonts: https://sourceforge.net/projects/xming/files/Xming-fonts/7.7.0.10/

**Step 5.**	Install and run Xming: https://sourceforge.net/projects/xming/

 ***Note!*** Xming must be running in the background before you open a terminal and has to be run every time your computer is rebooted. :-)

**Step 6.**	To update libraries, paste (by using the right click of your mouse pad or middle click of your mouse) the following commands in the terminal:

    sudo apt update
    
and
    
    sudo apt upgrade
    
These commands should be used regularly to keep your system up to date :-)

**Step 7.**	Install the text editor "gedit" by pasting in the terminal:

    sudo apt install gedit
    
**Step 8.**	To check if a particular program is in the Ubuntu repository and install the figure editor "grace", paste the following commands in the terminal:

    sudo apt-cache search grace
      
and
  
    sudo apt install grace

***Test:*** Type "gedit" in the terminal. If it complains about connection or display, paste the following line in the terminal:

    export DISPLAY=0:0
    
Then, type "gedit .bashrc", add the line "export DISPLAY=0:0" at the top, save and close. Finally, paste in the terminal:

    source .bashrc

***More support:***	https://wiki.ubuntu.com/WSL and Google

***Fun fact #2:*** You can run the install command multiple times to install several Linux distributions on your system, but first use "wsl --set-default-version 1".

You can list the available Linux distributions by pasting the following command in the Windows Terminal:

    wsl --list --online

You can list all the Linux distros installed in your system with the command:

    wsl --list --verbose
    
***Fun fact #1:*** You can automatically backup a directory from the Ubuntu subsystem (WSL1) to OneDrive! After you set up OneDrive on your machine, run this command with your own paths in your Windows terminal:

    mklink /j "%UserProfile%\OneDrive\Backups\SaveUbuntu22" "C:\Users\Admin\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu22.04LTS_79rhkp1fndgsc\LocalState\rootfs\home"

To automatically backup to Google Drive, add the path of the Ubuntu directory (WSL1) to the list of folders to backup :-)

# How to install Windows Subsystem for Linux (Ubuntu) on Windows 10

***Still on Windows 7 or 8?***

- *Update to Windows 10 for free:* https://geeksadvice.com/upgrade-to-windows-10-for-free/ or ask Google

- *Install Ubuntu from scratch or in dual-boot (you can only use one system at a time) (might be a better option for slower computers)*

- *University computer labs*

#

**Step 1.**	Open the Windows 10 Start Menu and search "Turn Windows features on or off"

Select "Windows Subsystem for Linux"
 
Click "OK"
  
Restart your computer

**Step 2.**	Install and run Xming-fonts: https://sourceforge.net/projects/xming/files/Xming-fonts/7.7.0.10/

**Step 3.**	Install and run Xming: https://sourceforge.net/projects/xming/

 ***Note!*** Xming must be running in the background before you open a terminal and has to be run every time your computer is rebooted. :-)

**Step 4.**	Install Ubuntu 22 through the Microsoft Store or https://apps.microsoft.com/store/search/ubuntu (you don't have to sign in unless you are using a VPN)

**Step 5.**	Set up username and password in the Ubuntu terminal. Do not close the window until you have a username and password set up. (The password does not show up as you type it.)

**Step 6.**	To update libraries, paste (by using the right click of your mouse pad or middle click of your mouse) the following commands in the terminal:

    sudo apt update
    
and
    
    sudo apt upgrade
    
These commands should be used regularly to keep your system up to date :-)

**Step 7.**	Install the text editor "gedit" by pasting in the terminal:

    sudo apt install gedit
    
**Step 8.**	To check if a particular program is in the Ubuntu repository and install the figure editor "grace", paste the following commands in the terminal:

    sudo apt-cache search grace
      
and
  
    sudo apt install grace

***Test:*** Type "gedit" in the terminal. If it complains about connection or display, paste the following line in the terminal:

    export DISPLAY=0:0
    
Then, type "gedit .bashrc", add the line "export DISPLAY=0:0" at the top, save and close. Finally, paste in the terminal:

    source .bashrc

***More support:***	https://wiki.ubuntu.com/WSL and Google

***Fun fact:*** You can automatically backup a directory from the Ubuntu subsystem (WSL1) to OneDrive! After you set up OneDrive on your machine, run this command with your own paths in your Windows terminal:

    mklink /j "%UserProfile%\OneDrive\Backups\SaveUbuntu22" "C:\Users\Admin\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu22.04LTS_79rhkp1fndgsc\LocalState\rootfs\home"

To automatically backup to Google Drive, add the path of the Ubuntu directory (WSL1) to the list of folders to backup :-)

# How to install ROOT on Ubuntu	
**Step 1.**	Install all required and optional packages (https://root.cern/install/dependencies/) by pasting the two following commands in the terminal:

For Ubuntu 22:

    sudo apt-get install dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev \
    libxft-dev libxext-dev python2 libssl-dev
 
and
 
    sudo apt-get install gfortran libpcre3-dev \
    xlibmesa-glu-dev libglew-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev python2-dev libxml2-dev libkrb5-dev \
    libgsl0-dev qtwebengine5-dev

For Ubuntu 20:

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

For Ubuntu 22:

    wget https://root.cern/download/root_v6.30.04.Linux-ubuntu22.04-x86_64-gcc11.4.tar.gz

For Ubuntu 20:

    wget https://root.cern/download/root_v6.30.04.Linux-ubuntu20.04-x86_64-gcc9.4.tar.gz

**Step 3.**	Unpack the archive by using the following command with the appropriate file name:

    tar -xzvf	root_file_name.tar.gz
    
**Step 4.**	Open your .bashrc file using gedit (gedit .bashrc) and add the following line before saving and closing the file:

    source ~/root/bin/thisroot.sh

**Step 5.**	Paste the following command in the terminal:

    source .bashrc

***Easy test:*** Type "root" in the terminal and press "Enter", then "2+2" and press "Enter", then ".q" to quit.

***Medium test:*** Run the germanium detection efficiency code to obtain the efficiency curve: https://github.com/UWCNuclear/RootEffi

Instructions are on the Github page. (To download, paste "git clone https://github.com/UWCNuclear/RootEffi.git" in your terminal)

***Advanced test:*** (Some editing required :-)) Reproduce the plots from the Covid19 minischool: https://github.com/UWCNuclear/Covid19_minischool

Watch the videos to find the commands. (To download, paste "git clone https://github.com/UWCNuclear/Covid19_minischool.git" in your terminal)

***More support:***	https://root.cern/install/  and Google


# How to install GRSISort on Ubuntu	[A useful ROOT-based nuclear physics toolkit :-) ]

The installation of GRSISort requires ROOT (above).

**Step 1.**	 To download the newest version of GRSISort, go to your home directory (cd) and paste:

    git clone https://github.com/GRIFFINCollaboration/GRSISort.git

**Step 2.**	 Paste the following line in your .bashrc file (with gedit .bashrc):

    source ~/GRSISort/thisgrsi.sh
    
and paste this line in your terminal:

    source .bashrc

**Step 3.** Install libblas3 package:

    sudo apt-get install libblas3

**Step 4.** To compile GRSISort, go to your GRSISort directory (cd ~/GRSISort) and type:

    make

***Test:*** All the tests for ROOT should still work: replace "root" by "grsisort"

***More detailed instructions:*** https://github.com/GRIFFINCollaboration/GRSISort/wiki/Setting-up-GRSISort

***More support:*** https://github.com/GRIFFINCollaboration/GRSISort/wiki/troubleshooting  and Google

Older versions of GRSISort might need an older ROOT version (for example: ROOT6.22 includes a major PyROOT upgrade).


# How to install Geant4 on Ubuntu

**Step 1.**	Install Qt by pasting in the terminal:

On Ubuntu 22:

     sudo apt-get install qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools
     
On the Ubuntu 20 subsystem for Windows:

     sudo apt-get install qt5-default

and then:
     
     sudo strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
 
**Step 2.**	Install X11 Xmu library and headers by pasting in the terminal:
     
     sudo apt-get install libxaw7-dev libxaw7

**Step 3.**	 Download the zipped source files from https://geant4.web.cern.ch/support/download (using another browser than Chrome) and move it to your home directory on Ubuntu by editing the correct path in the following command:

    mkdir ~/G4
    mv /mnt/WHERE-IT-IS-ON-WINDOWS/geant4.10.06.p03.tar.gz ~/G4

**Step 4.**	 Unpack the Geant4 source package using:

     tar -xzvf geant4.10.06.p03.tar.gz

**Step 5.**	 Create a build directory alongside the unpacked source using:

    mkdir geant4.10.06.p03-build
    
and move into the build directory:

    cd geant4.10.06.p03-build

**Step 6.** Run CMake by pasting:

    cmake -DCMAKE_INSTALL_PREFIX=~/G4/geant4.10.06.p03-install  \
    -DGEANT4_INSTALL_DATA=ON -DGEANT4_USE_OPENGL_X11=ON -DGEANT4_USE_QT=ON ~/G4/geant4.10.06.p03
    
**Step 7.** To run the build, paste:

    make -j 4
    
 and then
  
    make install
    
**Step 8.** Paste the following line in your .bashrc file (with gedit .bashrc):

    source ~/G4/geant4.10.06.p03-install/bin/geant4.shh
    
and paste this line in your terminal:

    source .bashrc
    
***Test:*** Run ExampleB1 with the following instructions:

    cd ~/G4
    cp -r geant4.10.06.p03/examples/basic/B1 .
    mkdir B1-build
    cd B1-build
    cmake -DGeant_DIR=~/G4/geant4.10.06.p03-install/lib64/Geant4-G4VERSION ~/G4/B1
    cmake -DCMAKE_PREFIX_PATH=~/G4/geant4.10.06.p03-install ~/G4/B1
    make -j
    ./exampleB1
    
and then, in the Qt Session box, type:

    /run/beamOn 10

***More detailed instructions:*** https://geant4-userdoc.web.cern.ch/UsersGuides/AllGuides/html/InstallationGuide/installguide.html#buildandinstall

***Alternative:*** There is a virtual box that comes with Geant4 installed (requires at least 30 Gb of disk space): https://heberge.cenbg.in2p3.fr/G4VM/index.html

Intel Virtualization Technology might need to be enabled on Windows. Ask Google how :-)


# How to install GOSIA on Ubuntu

**Step 1.**	Install libraries with:

     sudo apt-get install gcc-7 gfortran-7

**Step 2.**	Download the code from https://www.ikp.uni-koeln.de/~warr/gosia/ and move it to your home directory on Ubuntu by editing the correct path in the following command:

    mv /mnt/WHERE-IT-IS-ON-WINDOWS/gosia_20110524.9.f ~

**Step 3.**	Compile with:

     gfortran -o gosia gosia_20110524.9.f

**Step 4.**	Tun with:

     ./gosia < filename.inp

**Step 5.** Use a script to integrate the yields:	https://github.com/UWCNuclear/IntegratedYields
     
***Sample files and more support:*** http://www.pas.rochester.edu/~cline/Gosia/


# How to install GREMLIN on Ubuntu

**Step 1.** Download the gremlin.f file from the Gosia homepage using the link:         http://www.pas.rochester.edu/~cline/Gosia/

Or compile the file attached to this repo :-)

**Step 2.** Compile the gremlin.f file by running the command:

      gfortran-7 -o gremlin gremlin.f 
or:

      gfortran -o gremlin gremlin.f 

**Step 3.** Warnings being displayed in the terminal is perfectly fine. If there are errors being produced in the compiling process, this will need to be addressed by a case by case bases. However, below are four errors that have been encounted while compiling GREMLIN on Ubuntu and the solutions to those errors:

        gremlin.f:1046:72:
        ATT   =   ATT  +  THICKN(J) * MU0 * EXP(SPLCURVE(J,'U',X))
        Error: Syntax error in argument list at (1)
        
        
        gremlin.f:1048:72:
        ATT   =   ATT  +  THICKN(J) * MU0 * EXP(SPLCURVE(J,'L',X))
        Error: Syntax error in argument list at (1)
        
        
        gremlin.f:1210:72:
        IF(SQRT(M1*E1).LT.COS(TH3/DEG)*SQRT(M3*E3_1)) TH4_1=180.-TH4_1
        Error: Syntax error in expression at (1)
        
        
        gremlin.f:1211:72:
        IF(SQRT(M1*E1).LT.COS(TH3/DEG)*SQRT(M3*E3_2)) TH4_1=180.-TH4_2
        Error: Syntax error in expression at (1)

For the first two errors, remove the blank spaces between each of the variables such that there is only one blank space between each of the variables. 
For the third and fourth error, place a blank space between the "180." and the "-Th4_2". 


**Step 4.** After compiling has been completed, a file called "gremlin" will have been created. This can be executed using the following command:
       
       ./gremlin

A prompt will appear asking for details to be placed into the prompt. If this appears, then GREMLIN is working perfectly.

Sample input files for Eu152, Co56 and Co60 (to be used with the option "Other") are attached to this repo.


# How to install RadWare on Ubuntu


**Step 1.** To install the following libraries, paste:

     sudo apt-get install gcc make libreadline-dev libgtk2.0-dev libmotif-dev xfonts-75dpi-transcoded xfonts-100dpi-transcoded
     
**Step 2.** To download the RadWare package in your home directory, paste the following lines in your Ubuntu terminal:

     cd
     git clone https://github.com/radforddc/rw05

**Step 3.** To set up the Makefile, go to the src directory and copy the Makefile for Linux:
    
    cd ~/rw05/src
    cp Makefile.linux Makefile

**Step 4.** With the command "gedit Makefile", edit the following lines in your Makefile to the rw05 directory and your username:

    INSTALL_DIR = ${HOME}/rw05
    INSTALL = /usr/bin/install -m 0644 -o USERNAME -g users
    INSTALL_BIN = /usr/bin/install -m 0755 -o USERNAME -g users
    
and comment out -lXp on lines 39 and 40 (by adding # in front of -lXp):
    
    MOTIF_LIBS = -lXm -lMrm -lXt -lXext #-lXp
    STATIC_MOTIF = -lXm -lMrm -lXpm -lXt -lSM -lICE -lXext #-lXp
    
**Step 5.** To compile and install, paste:
   
    make all

**Step 6.** To use the GTK versions of gls, escl8r, etc., then type:

    make gtk

**Step 7.** To use the Motif versions of gls, escl8r, etc., then type:

    make xm

**Step 8.** Paste the following lines in your .bashrc file in your home directory (with "cd && gedit .bashrc"):

    ## Radware
    #####################################
    #   these variables point to directories containing various RadWare files
    export RADWARE_FONT_LOC=~/rw05/font
    export RADWARE_ICC_LOC=~/rw05/icc
    export RADWARE_GFONLINE_LOC=~/rw05/doc
    export PATH=$PATH:~/rw05/src
    #export PATH=$PATH:/root/rw05/bin

    #   this variable specifies whether to ring the bell in RadWare cursor routines
    export RADWARE_CURSOR_BELL=n

    #   this variable specifies whether to overwrite existing files
    export RADWARE_OVERWRITE_FILE=ask

    #   this variable specifies whether to require the return key in Y/N questions
    export RADWARE_AWAIT_RETURN=n

    #   this variable specifies the requested initial size of the level scheme
    #   display in xmgls, xmesc and xmlev (width and height in pixels)
    export RADWARE_XMG_SIZE=600x500
    #####################################

and paste this line in your terminal:

    source .bashrc
    
    
***Test:*** Type "xmesc" in the terminal.

***More support:*** https://radware.phy.ornl.gov/download.html


# How to install NuShellX on Ubuntu

Ubuntu 20 doesn't seem to support libgfortran3, so the Ubuntu 18 subsystem would be required to run NuShellX. Or it can run directly on Windows :-)

**Step 1.**	Get the files from someone and unzip them in your home directory.

**Step 2.**	Paste the following lines in your .bashrc file (with gedit .bashrc):

    nuxhome=~ 
    export PATH=$nuxhome/nushellx/linux/nushellx-gfortran-bin:$PATH
    export nushellx_sps=$nuxhome/nushellx/sps/
    export mass_data=$nuxhome/nushellx/toi/mass-data/
    export toi_data=$nuxhome/nushellx/toi/toi-data/
    alias copy=cp
    alias del=rm
    alias q='qstat -u jnorce'
    alias qall='checknode -v ifi-003'
    alias sd='cd'
    alias di='ls -g -l -a'
    alias dis='ls -tr -l -g -a'
    alias d='ls -l | egrep ^d'
    alias ed='vi'
    alias md='mkdir'
    
**Step 3.**	Give permissions to run the executables:

    chmod +rwx ~/nushellx/linux/nushellx-gfortran-bin/*

***More support:*** nushellx/help/help.pdf


# How to install Anaconda, Spyder and Jupyter on Windows or Ubuntu
**Step 1.**	Follow the instructions carefully for Windows: https://docs.anaconda.com/anaconda/install/windows/

On Ubuntu, you can use Python directly by typing "python" or "python3". If you want to use Anaconda on Ubuntu, follow carefully the instructions for Ubuntu/Debian: https://docs.anaconda.com/anaconda/install/linux/

***Medium Test:*** Run the Monte Carlo code "pi.py" included in this repository. To download, click "Code" at the top right, click "Download ZIP". To run, open "pi.py" in Spyder, click the arrow (run) icon, click on "Plots" in the top right window.

***Medium Test:*** Run the muon flux plotting and fitting code "muon_flux_example.ipynb" included in this repository. 

***More support:***	https://docs.anaconda.com/anaconda/user-guide/troubleshooting/  and Google

***Python workshop:***	https://github.com/UWCNuclear/PythonWorkshop :-)

