#!/usr/bin/env python3
import socket
import ssl
from datetime import datetime

# Script Name:  ssl_expiry_checker.py
# Description:  Checks SSL certificate expiration dates for a list of domains.


def get_ssl_expiry_date(hostname):
    """Fetches the expiration date of the SSL certificate for a given hostname."""
    context = ssl.create_default_context()

    with socket.create_connection((hostname, 443), timeout=5) as sock:
        with context.wrap_socket(sock, server_hostname=hostname) as ssock:
            cert = ssock.getpeercert()
            expire_date_str = cert.get('notAfter')
            expire_date = datetime.strptime(expire_date_str, '%b %d %H:%M:%S %Y %Z')
            return expire_date

def audit_domains(domains):
    print(f"{'Domain':<25} | {'Status':<15} | {'Days Left'}")
    print("-" * 55)

    for domain in domains:
        try:
            expiry_date = get_ssl_expiry_date(domain)
            days_left = (expiry_date - datetime.now()).days
            
            if days_left <= 0:
                status = "EXPIRED"
            elif days_left < 14:
                status = "CRITICAL"
            elif days_left < 30:
                status = "WARNING"
            else:
                status = "VALID"
                
            print(f"{domain:<25} | {status:<15} | {days_left} days")
            
        except Exception as e:
            print(f"{domain:<25} | ERROR          | {str(e)[:20]}...")

if __name__ == "__main__":
    target_domains = [
        "google.com",
        "github.com",
        "microsoft.com"
    ]
    
    print(f"--- SSL Expiration Audit ({datetime.now().strftime('%Y-%m-%d')}) ---")
    audit_domains(target_domains)
  
