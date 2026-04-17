# 🛠️ IT Automation Toolbox

![Bash](https://img.shields.io/badge/bash-%234EAA25.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)

A collection of scripts designed to automate system administration, monitoring, and security auditing. This toolbox focuses on efficiency and reliability.

---

## 📋 Table of Contents
- [Project Overview](#-project-overview)
- [Script Descriptions](#-script-descriptions)
- [Installation & Usage](#-installation--usage)

---

## 🚀 Project Overview
A curated collection of Bash, Python, and PowerShell scripts designed to automate routine system administration tasks, enhance cross-platform security, and streamline infrastructure management across Linux and Windows environments.

---

## 📂 Script Descriptions

### 🔹 Bash:
* **`user_provisioner.sh`**: An automation tool for bulk user creation on Linux systems. It reads a list of usernames from a text file and handles the entire onboarding process.
* **`daily_health_check.sh`**: A lightweight diagnostic tool providing a quick snapshot of the server's operational status. Designed to be run manually or as a scheduled cron job.
* **`auto_backuper.sh`**: A reliable backup automation tool that ensures data safety through scheduled snapshots and automated storage management.
* **`firewall_hardening.sh`**: A security-focused script that implements a "Deny by Default" posture using the UFW framework.

### 🔹 Python:
* **`network_port_scanner.py`**: A fast TCP port discovery tool used to audit network services and identify potential entry points on a target host.
* **`ssl_expiry_checker.py`**: A proactive monitoring tool that verifies the validity and expiration dates of SSL certificates for a list of target domains.
* **`user_audit_tool.py`**: A security compliance utility that parses the system's identity database to detect unauthorized administrative privileges and insecure account configurations.

### 🔹 PowerShell:
* **`AD_user_onboarding.ps1`**: A PowerShell utility designed for bulk user provisioning in Active Directory environments. It streamlines the onboarding process by automating account creation.
* **`old_file_archiver.ps1`**: A storage management utility that automates the lifecycle of stale data by identifying, moving, and compressing old files.
* **`bulk_file_permission_audit.ps1`**: A security-focused auditing tool designed to identify over-permissive NTFS Access Control Lists within file server hierarchies.

---

## ⚙️ Installation & Usage

### 1. Clone the repository
```bash
git clone [https://github.com/yourusername/automation-toolbox.git](https://github.com/yourusername/automation-toolbox.git)
cd automation-toolbox
