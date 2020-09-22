#!/bin/bash
###------------------------------DEFINE FUNCTIONS------------------------------###
function load(){
        for i in range {1..5}
        do
                echo "."
                echo
                sleep .05
        done
}

###------------------------------READ // COLLECT TARGET IP ADDRESS------------------------------###
clear
target=$(cat target.txt)
if [[ $target == "" ]]
then
        echo -n "Enter a target: "
        read target
	echo $target > target.txt
	load
else
        :
fi

###------------------------------CHECK FOR // CREATE TARGET INTEL FILES------------------------------###
#Run nmap vuln scan if no file exists/user chooses to
if [[ ! -f nmap-vuln-$target.xml ]]
then
echo "No existing nmap vulnerability scan file present"
echo "Initiating scan..."
load
nmap $target -T5 -A -sV -oX nmap-vuln-$target.xml --script=vuln
load
else
        echo "Existing nmap vulnerability xml scan report found, would you like to continue or rescan?"
        echo -n "[C]ontinue or [R]escan: "
        read choice
        case $choice in
                [Cc] )
                        echo
                        echo "Continuing with existing scan file"
                        load
			;;
                [Rr] )
                        rm nmap-vuln-$target.xml
                        nmap $target -T5 -A -sV -oX nmap-vuln-$target.xml --script=vuln
			load
			;;
esac
fi

#Convert XML file to human-readable HTML for final report
xsltproc nmap-vuln-$target.xml -o nmap-vuln-$target.html

#Run nmap malware scan if no file exists/user chooses to
if [[ ! -f nmap-mal-$target.xml ]]
then
echo "No existing nmap malware scan file present"
echo "Initiating scan..."
load
nmap $target -T5 -A -sV -oX nmap-mal-$target.xml --script=malware
load
else
        echo "Existing nmap malware xml scan report found, would you like to continue or rescan?"
        echo -n "[C]ontinue or [R]escan: "
        read choice
        case $choice in
                [Cc] )
                        echo
                        echo "Continuing with existing scan file"
                        load
                        ;;
                [Rr] )
                        rm nmap-mal-$target.xml
                        nmap $target -T5 -A -sV -oX nmap-mal-$target.xml --script=malware
			load
                        ;;
esac
fi

#Convert XML file to human-readable HTML for final report
xsltproc nmap-mal-$target.xml -o nmap-malware-$target.html

echo "VULNERABILITY ANALYSIS OF $target COMPLETE"
