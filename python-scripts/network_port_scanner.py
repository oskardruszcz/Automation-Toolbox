#!/usr/bin/env python3
import socket
from datetime import datetime

# Script Name:  network_port_scanner.py
# Description:  Simple TCP port scanner to audit open services on a host.

def scan_host(host, ports):
    print(f"--- Scanning Target: {host} ---")
    print(f"--- Started at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')} ---\n")
    
    open_ports = []

    for port in ports:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        
        s.settimeout(0.5)
        
        result = s.connect_ex((host, port))
        
        if result == 0:
            print(f"Port {port:<5}: ✅ OPEN")
            open_ports.append(port)
        else:
            pass
            
        s.close()
    
    return open_ports

if __name__ == "__main__":
    target_host = input("Enter target IP or hostname (e.g., 127.0.0.1): ")
    
    common_ports = [21, 22, 23, 25, 53, 80, 110, 443, 3306, 3389, 8080]
    
    try:
        results = scan_host(target_host, common_ports)
        
        print(f"\n--- Scan Report Summary ---")
        if results:
            print(f"Total open ports found: {len(results)}")
            print(f"Open ports list: {results}")
        else:
            print("No open ports detected in the common range.")
            
    except KeyboardInterrupt:
        print("\n[!] Scan interrupted by user.")
    except socket.gaierror:
        print("\n[!] Hostname could not be resolved.")
    except socket.error:
        print("\n[!] Could not connect to the server.")
