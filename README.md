# Champlain Capstone-Repo
## Bash Scripting for Security Analysis Automation
### Overview
* Automated network recon and V-scan
* Use open source tools
  * Nmap
  * Metasploit
* HTML Reports that can be understood by the average user
### Background
* This is a script (might have a frontend later) that can scan a network and create a folder of security reports about the network and devices on it
* I was drawn to this idea because it is mostly automated and allows standard users to get crucial security reporting without either paying for specialized software or dealing with extremely confusing UI's such as that of OpenVAS
* This is meant to be a periodic check to see if there are any blaring security issues that allow an attacker to gain a shell on a local box

### USAGE
The script is composed of five modules: Recon, Vuln, Exploit, and Report. Main.bash runs them all 
together against each host on the network but they can also be used individually. 

* Recon finds live hosts off the network

* Vuln uses nmap NSE's to create XML (for exploit module) and HTML (for human review) reports
 
* Exploit uses XML reports and service info to find and run exploits. It also attempts a password guessing attack via the Nmap "Brute" NSE

* Report formats the files created by the previous modules and places copies of them in the "Final_Report" directory

### NOTES
* The setup script is optional. It updates the system and installs OpenVAS. If the Nmap NSE's encounter errors, you may need to use it.
* If you want to be more thorough, run the script and then follow up with OpenVAS and Armitage
## OpenVAS Guide
* Login with the auto generated password shown after the install (username admin)
* Change password
* Click on scans in menu bar
 * Click on task wizard
 * Add targets
 * Select scan type
 * Click save
* Run scan to create and browse reports/results
* Customize dashboard under dashboard tab to show a bird's eye view of results and hosts
 
