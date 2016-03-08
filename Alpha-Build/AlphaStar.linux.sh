if [ -f "Installed.txt" ]
then
	echo "Hello boys and girls."
	echo "Today we're going to update the alpha version of Star Story for Linux"
	echo ""
	echo "VERY IMPORTANT!!"
	echo "Make sure the alpha version is not running. Make sure both the launcher and the game itself are NOT running during this update or your Mac can (and most likely will) come up with very undesirable behavior! So if the game and its launcher are running, make sure to quit them both!"
	echo ""
        echo "Please note that the Linux binaries are not always updated as quickly as the binaries for Mac and Windows. Version conflicts CAN be possible as a result."
	echo "Hit any key to continue..."
	read -n 1
	echo ""
    echo ""
    echo "- Updating game"
    cd AlphaBuild
    git pull origin master
else
	echo "Hello boys and girls."
	echo "Today we're going to install the alpha version of Star Story for Linux"
	echo ""
	echo "Please note, though I deem it very well possible this script works in Mac and other Unix-based systems, this script has been scrictly set up for Linux, and it's not much use to use it on a different OS"
	echo ""
	echo "The game does not appear to be installed yet. I will install it now for you. If you ever want to try running the game again, simply run this script and I will automatically update the alpha version for you to the latest version before running the game"
        echo ""
        echo "IMPORTANT NOTE!"
        echo "The Linux version is yet only in an experimental stage and has less priority than the Mac and Windows versions. The Binaries are not as often updated as for the other two platforms. Some bugs and crashes you may experience here may be the result of version conflicts."
	echo ""
	echo "Are you ready? Well, let's roll then"
	echo ""
	echo "Hit any key to continue..."
	read -n 1
	echo ""
	echo ""
	echo "- Installing Star Story Alpha"
    echo "   = Initializing git"
    mkdir AlphaBuild
    git init AlphaBuild
    cd AlphaBuild
    echo "  = Analysing git repository"
    git remote add -f origin https://github.com/Tricky1975/Star-Story.git
    echo "  = Configuring git"
    echo "Alpha-Build/LinBin/" >> .git/info/sparse-checkout
    echo "Alpha-Build/JCR/" >> .git/info/sparse-checkout
    echo "  = Checkout folders"
    cat .git\info\sparse-checkout
    git config core.sparseCheckout true
    echo "  = Downloading game"
    git pull origin master    
    cd ..
    echo "This file marks an installed version, so the installer will not install this game twice" > Installed.txt
fi

cd ..
chmod +x AlphaBuild/Alpha-Build/LinBin/*.linux
echo "- Running the game"
AlphaBuild/Alpha-Build/LinBin/Star\ Story.linux
echo "- Script has ended"	


# This file is (c) 2015 Jeroen P. Broks
# You may distribute it under the terms of the zlib license


# In case you wonder about the .linux suffixes in the binaries
# I know Linux doesn't need them, but I made my compiler add them by default in order to make sure they NEVER overwrite my Mac console apps, which just like Linux do not need an extention (since both Mac and Linux are members of the "Unix family")
# That's why ;)
