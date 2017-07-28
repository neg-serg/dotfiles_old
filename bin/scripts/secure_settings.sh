#!/bin/bash
# Partially taken from:
# https://github.com/marshyski/quick-secure


# --[ Set basic kernel parameters ]--
if [[ $(which sysctl 2>/dev/null) != "" ]]; then
  #Turn on Exec Shield for RHEL systems
  sysctl -w kernel.exec-shield=1
  #Turn on ASLR Conservative Randomization
  sysctl -w kernel.randomize_va_space=1
  #Hide Kernel Pointers
  sysctl -w kernel.kptr_restrict=1
  #Allow reboot/poweroff, remount read-only, sync command
  sysctl -w kernel.sysrq=176
  #Restrict PTRACE for debugging
  sysctl -w kernel.yama.ptrace_scope=1
  #Hard and Soft Link Protection
  sysctl -w fs.protected_hardlinks=1
  sysctl -w fs.protected_symlinks=1
  #Enable TCP SYN Cookie Protection
  sysctl -w net.ipv4.tcp_syncookies=1
  #Disable IP Source Routing
  sysctl -w net.ipv4.conf.all.accept_source_route=0
  #Disable ICMP Redirect Acceptance
  sysctl -w net.ipv4.conf.all.accept_redirects=0
  sysctl -w net.ipv6.conf.all.accept_redirects=0
  sysctl -w net.ipv4.conf.all.send_redirects=0
  sysctl -w net.ipv6.conf.all.send_redirects=0
  #Enable IP Spoofing Protection
  sysctl -w net.ipv4.conf.all.rp_filter=1
  sysctl -w net.ipv4.conf.default.rp_filter=1
  #Enable Ignoring to ICMP Requests
  sysctl -w net.ipv4.icmp_echo_ignore_all=1
  #Enable Ignoring Broadcasts Request
  sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
  #Enable Bad Error Message Protection
  sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
  #Enable Logging of Spoofed Packets, Source Routed Packets, Redirect Packets
  sysctl -w net.ipv4.conf.all.log_martians=1
  sysctl -w net.ipv4.conf.default.log_martians=1
  #Perfer Privacy Addresses
  sysctl -w net.ipv6.conf.all.use_tempaddr = 2
  sysctl -w net.ipv6.conf.default.use_tempaddr = 2
  sysctl -p
fi
