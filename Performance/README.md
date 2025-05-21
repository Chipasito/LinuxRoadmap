Server Performance Monitoring Script

This script provides a comprehensive overview of your Linux server's performance metrics, including CPU, memory, and disk usage, as well as process and security information.

Features
System information (hostname, OS, kernel, uptime)

CPU usage statistics

Memory usage (total, used, free with percentages)

Disk usage (total, used, free with percentages)

Top 5 processes by CPU usage

Top 5 processes by memory usage

Additional metrics:

Logged-in users

Failed login attempts

Network interfaces

Requirements
Linux-based operating system

Bash shell

Standard GNU core utilities (awk, grep, sed, etc.)

Root/sudo privileges for some features (failed login attempts)

Installation
Clone or download the script:

bash
  git clone https://github.com/Chipasito/LinuxRoadmap.git
  Make the script executable:


bash
chmod +x PerfStats.sh
Usage
Basic execution (non-root):
bash
./PerfStats.sh
Full execution (with sudo privileges for all features):
bash
sudo ./PerfStats.sh

bash
server-stats
Output Example
The script provides color-coded output organized in sections:

=== Información del Sistema ===
Hostname: myserver.example.com
OS: Ubuntu 20.04.3 LTS
Kernel: 5.4.0-88-generic
Uptime: up 3 weeks, 2 days, 5 hours
Load Average: 0.15, 0.10, 0.05

=== Uso de CPU ===
Total CPU Usage: 12.5%
CPU Cores: 4

=== Uso de Memoria ===
Total: 7.7G, Used: 3.2G, Free: 4.5G
Memory Usage: 41.56%

[More sections...]
Customization
You can modify the script to:

Add additional metrics

Change output colors

Adjust the number of top processes shown

Output to a log file

