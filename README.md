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

![alt text](https://github.com/ben3636/capstone-repo/blob/master/Mindmup_color.png?raw=true)

### Outline
* Kali Linux or Similar Distro
	* Master Script (Main.bash)

		Main bash script that just calls the internal modules in order for scheduled automation
		* Initialize/Update Module

			Updates the OS and Ensures all module dependencies are installed/updated
		* Recon Module

			Scans the selected subnet and exports a lists of "live" hosts for the next module
		* Vulnerability Analysis Module

			Scans the hosts from the previous modules for known CVE's using Nmap's scripting engine (NSE)
		* Exploit Module

			Parses the results of the v-scan and attempts to gain shells on targets with exploits
		* Report Module

			Places user-readable reports from all NSE scans in a directory for admin use
			* HTML Reports
				* Web Interface & Directory Listing

					Potentially used for remote access to the results directory
