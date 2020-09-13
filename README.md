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
## Social Engineering Dropbox
### Overview
* Leverage SE tools like SE-Toolkit to create a Pi/SBC dropbox to test users to a variety of MITM attacks requiring user intervention/trust
### Background
* I was drawn to this idea after playing around with SE-Toolkit
* While some of the SE attacks require a bit of technical knowledge, this script would allow a user to simply launch the script and perform a series of SE attacks





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
