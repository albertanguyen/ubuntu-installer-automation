# UBUNTU INSTALLER SEMI-AUTOMATION
Created with :blue_heart: by <a href="https://www.linkedin.com/in/anh-nguyen2/">Anh</a>  

A small script to speed up the ubuntu installation or any OS that will be installed along side with the current OS. The detailed explanation for this repository could be found in <a href="https://escapingpill.wordpress.com/2020/03/19/install-ubuntu-linux-without-usb/#toc" target="_blank">this article</a>

![ubuntu focal](/images/ubuntu-focal.png)

# Architecture
Main script to be executed is *ubuntu-installer-automation.bat*
Other scripts have to be put under the same directory with the main script

# Execution
The script is designed for a single partition of GPT disk on Window 10 OS that is run on UEFI BIOS mode. If your current system fits this description, you can run the main script, start the installation process from ubuntu live environment then go back to finish the cleanup steps. Otherwise, you will need to modify the script in Configure bootloader (Section 1) and Partitioning (Section 2)

# Improvements needed
* retrieve the information of total volumn of SDD in the pre-installation examination
* retrieve the information of graphic display (important for other OS for instance: <a href="https://pop.system76.com/">Pop!_OS</a> )
* Convert Manual steps in Pre-installation into Automation Flow (Download Linux Distro, Download Boot manager for Window)
* Add more conditions for disk checkup before partitioning
