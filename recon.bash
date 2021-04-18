#!/bin/bash
function load(){
        for i in range {1..5}
        do
                echo "."
                echo
                sleep .02
        done
}
echo "" > target-list.txt
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

###---Scan Subnet for Hosts Using ARP---###
echo "Discovering Hosts With Layer 2 ARP"
echo
sudo nmap -sn $subnet -T5 -oG scan_results #Elevate privileges to allow ping scan to utilize ARP instead of ICMP, see -sn flag here: https://nmap.org/book/man-host-discovery.html

###---Scan Subnet for Hosts Using IP (If Requested)---###
load
echo -n "Would you like to run a network-level/Layer-3 scan as well? (y/n)"
read choice
if [[ $choice == y ]]
then 
        nmap $subnet -T5 -oG scan_results2
fi

###---Aggregate Hosts from Results---###
hosts=$(cat scan_results* | grep "Status: Up" | awk ' { print $2 } ' | sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n | uniq)
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
        echo $chosen_host >> target-list.txt
        echo -n "Would you like to add another host? y/n "
        read cont
        if [[ $cont != "y" ]]
        then
                break
        fi
done

###-List Targets---###
load
echo "Targets"
echo
cat target-list.txt
