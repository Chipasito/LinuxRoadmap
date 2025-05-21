#!/bin/bash

# server-stats.sh - Script to display system performance statistics

# Function to display section with title
section() {
    echo -e "\n\e[1;34m=== $1 ===\e[0m"
}

# 1. Basic System Information
section "System Information"
echo -e "Date: \e[1;32m$(date)\e[0m"
echo -e "User: \e[1;32m$(whoami)\e[0m"
echo -e "IP: \e[1;32m$(hostname -I | awk '{print $1}')\e[0m"
echo -e "Hostname: \e[1;32m$(hostname)\e[0m"
echo -e "OS: \e[1;32m$(grep PRETTY_NAME /etc/os-release | cut -d '"' -f 2)\e[0m"
echo -e "Kernel: \e[1;32m$(uname -r)\e[0m"
echo -e "Uptime: \e[1;32m$(uptime -p)\e[0m"
echo -e "Load Average: \e[1;32m$(cat /proc/loadavg | awk '{print $1", "$2", "$3}')\e[0m"

# 2. CPU Usage
section "CPU Usage"
total_cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo -e "Total CPU Usage: \e[1;32m${total_cpu_usage}%\e[0m"
echo -e "CPU Cores: \e[1;32m$(nproc)\e[0m"

# 3. Memory Usage
section "Memory Usage"
free -h | awk '
/Mem:/ {
    printf "Total: \033[1;32m%s\033[0m, Used: \033[1;32m%s\033[0m, Free: \033[1;32m%s\033[0m\n", $2, $3, $4
    printf "Memory Usage: \033[1;32m%.2f%%\033[0m\n", ($3/$2)*100
}'

# 4. Disk Usage
section "Disk Usage"
df -h --total | grep -v "tmpfs" | grep -v "udev" | tail -n 1 | awk '
{
    printf "Total: \033[1;32m%s\033[0m, Used: \033[1;32m%s\033[0m, Free: \033[1;32m%s\033[0m\n", $2, $3, $4
    printf "Disk Usage: \033[1;32m%s\033[0m\n", $5
}'

# 5. Top 5 CPU processes
section "Top 5 CPU Processes"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6 | awk '
NR==1 {printf "\033[1;34m%-6s %-6s %-30s %-6s %-6s\033[0m\n", $1, $2, $3, $4, $5}
NR>1 {printf "%-6s %-6s %-30s \033[1;32m%-6s %-6s\033[0m\n", $1, $2, $3, $4, $5}'

# 6. Top 5 processes by Memory
section "Top 5 Memory Processes"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6 | awk '
NR==1 {printf "\033[1;34m%-6s %-6s %-30s %-6s %-6s\033[0m\n", $1, $2, $3, $4, $5}
NR>1 {printf "%-6s %-6s %-30s \033[1;32m%-6s %-6s\033[0m\n", $1, $2, $3, $4, $5}'

# 7. Connected Users
section "Connected Users"
who | awk '{printf "User: \033[1;32m%-10s\033[0m from \033[1;32m%-15s\033[0m on \033[1;32m%s\033[0m\n", $1, $5, $3}'

# 8. Failed Login Attempts
section "Failed Login Attempts"
sudo lastb -a | head -n 5 | awk '{printf "User: \033[1;31m%-10s\033[0m from \033[1;31m%-15s\033[0m on \033[1;31m%s\033[0m\n", $1, $3, $5}'

# 9. Network Interfaces
section "Network Interfaces"
ip -o -4 addr show | awk '{printf "Interface: \033[1;32m%-8s\033[0m IP: \033[1;32m%-15s\033[0m\n", $2, $4}'

echo ""