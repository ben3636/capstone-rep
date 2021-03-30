#!/bin/bash
function load(){
        for i in range {1..5}
        do
                echo "."
                echo
                sleep .02
        done
}
echo "" > target.txt
echo "" > hosts
clear
cat welcome.txt
load
###---Determine IP & Subnet---###
ip=$(ip a | grep -o ".*\.*\.*\/.. " | grep -v inet6)
subnet_part1=$(ip a | grep -o ".*\.*\.*\/.. " | grep -v inet6 | sed -e s/'inet'// -e s/" "// | awk -F '.' ' { print $1"."$2"."$3"." } ' | awk ' { print $1 } ')
subnet_part2="0"
mask=$(ip a | grep -o ".*\.*\.*\/.. " | grep -v inet6 | grep -o /..)
subnet=$subnet_part1$subnet_part2$mask

###---Scan Subnet for Hosts---###
echo "Scanning Subnet..."
echo
sudo nmap -sn $subnet -T5 -oG scan_results #Elevate privileges to allow ping scan to utilize ARP instead of ICMP, see -sn flag here: https://nmap.org/book/man-host-discovery.html
hosts=$(cat scan_results | grep "Status: Up" | awk ' { print $2 } ')
counter=1
for i in $hosts
do
	echo "$counter. $i" >> hosts
	((counter+=1))
done

###---Allow User to Select Hosts---###
echo "Hosts List"
echo
cat hosts
echo
cont="y"
while [[ $cont == "y" ]]
do
	echo
	echo -n "Which hosts would you like to scan? "
	read choice
	chosen_host=$(cat hosts | grep ^$choice | awk ' { print $2 } ')
	echo $chosen_host >> target.txt
	echo -n "Would you like to add another host? y/n "
	read cont
	if [[ $cont != "y" ]]
	then
		break
	fi
done

###-List Targets---###
clear
echo "Targets"
echo
cat target.txt
