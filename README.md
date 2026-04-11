# Automation-Toolbox
A curated collection of Bash and Python scripts designed to automate routine system administration tasks, enhance server security, and streamline infrastructure management.

# 🛠️ IT Automation & Ops Toolbox

![Bash](https://img.shields.io/badge/bash-%234EAA25.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

A collection of professional scripts designed to automate system administration, monitoring, and security auditing. This toolbox focuses on efficiency, reliability, and the "Infrastructure as Code" (IaC) approach.

---

## 📋 Table of Contents
- [Project Overview](#-project-overview)
- [Script Descriptions](#-script-descriptions)
- [Prerequisites](#-prerequisites)
- [Installation & Usage](#-installation--usage)
- [Security Best Practices](#-security-best-practices)

---

## 🚀 Project Overview
This repository contains production-ready automation assets developed to eliminate repetitive operational tasks. It showcases my ability to work with both low-level shell scripting and high-level Python logic to manage Linux environments.

---

## 📂 Script Descriptions

### 🔹 Bash: System Administration
* **`backup_rotator.sh`**: Creates compressed `.tar.gz` backups of specified directories with a 7-day retention policy (auto-deletes old backups).
* **`user_onboarding.sh`**: Automates the creation of system users from a CSV list, including directory permissions and SSH key setup.
* **`health_check.sh`**: A lightweight diagnostic tool that monitors CPU load, RAM usage, and disk space, logging results to a central file.

### 🔹 Python: Security & Integration
* **`log_security_audit.py`**: Parses `/var/log/auth.log` to identify failed SSH login attempts and exports suspected malicious IPs to a report.
* **`uptime_monitor.py`**: Checks the availability of specific web services and sends real-time alerts via Discord/Slack Webhooks if a service is down.
* **`resource_watcher.py`**: Uses the `psutil` library to monitor system processes and alerts the admin if a specific process exceeds memory limits.

---

## ⚙️ Installation & Usage

### 1. Clone the repository
```bash
git clone [https://github.com/yourusername/automation-toolbox.git](https://github.com/yourusername/automation-toolbox.git)
cd automation-toolbox
