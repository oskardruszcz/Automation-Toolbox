#!/usr/bin/env python3
import pwd
import grp
from datetime import datetime

# Script Name:  user_audit_tool.py
# Description:  Audits local system users for security misconfigurations.


def perform_audit():
    """Analyzes system users and flags potential security risks."""
    print(f"{'Username':<15} | {'UID':<6} | {'Group':<12} | {'Shell':<15} | {'Status'}")
    print("-" * 75)

    all_users = pwd.getpwall()

    for user in all_users:
        username = user.pw_name
        uid = user.pw_uid
        gid = user.pw_gid
        shell = user.pw_shell
        group_name = grp.getgrgid(gid).gr_name
        
        status = "OK"
        
        if uid == 0 and username != 'root':
            status = "SUSPICIOUS: Hidden Admin"
        elif uid >= 1000:
            status = "User Account"
        elif shell not in ['/usr/sbin/nologin', '/bin/false']:
            if uid != 0:
                status = "System (Interactive)"
        else:
            status = "Service (Locked)"

        print(f"{username:<15} | {uid:<6} | {group_name:<12} | {shell:<15} | {status}")

if __name__ == "__main__":
    print(f"--- System User Security Audit | {datetime.now().strftime('%Y-%m-%d')} ---")
    try:
        perform_audit()
    except PermissionError:
        print("Error: Higher privileges required to read some system data.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
