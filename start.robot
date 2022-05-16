*** Settings ***
Library    Process    
Library    OperatingSystem
Library    String


*** Test Cases *** 
Start Vagrant VPP csp2s22c03 VM and check reply from from
    ${result} =  Run Process    vagrant    up    csp2s22c03  shell=True  stdout=vm_csp2s22c03_start_log.txt
    Should Contain  ${result.stdout}    Setting up vpp-plugin-dpdk


Start Vagrant TREX net2s22c05 VM and check reply from from
    ${result} =  Run Process    vagrant    up    net2s22c05  shell=True  stdout=vm_net2s22c05_start_log.txt
    Should Contain  ${result.stdout}    DKMS: install completed.



Show run command on VPP csp2s22c03 before TREX tests
    ${result} =  Run Process    vagrant ssh csp2s22c03 -c 'sudo vppctl show run'  shell=True  stdout=VPP_show_run_0.txt
    Should Contain  ${result.stdout}    GigabitEthernet0/8/0-output


Execute TREX test on VM net2s22c05
    ${result} =  Run Process    vagrant ssh net2s22c05 -c 'cd v2.97 ; sudo ./t-rex-64 -f cap2/dns.yaml -c 1 -m 1 -d 10'  shell=True  stdout=trex.txt
    Should Contain  ${result.stdout}    Total-tx-pkt


Show run command on VPP csp2s22c03 after TREX tests
    ${result} =  Run Process    vagrant ssh csp2s22c03 -c 'sudo vppctl show run'  shell=True  stdout=VPP_show_run_1.txt
    Should Contain  ${result.stdout}    GigabitEthernet0/8/0-output


# Destroy Vagrant VMs and check shutdown message
#     ${result} =  Run Process    vagrant destroy -f  shell=True  stdout=vm_shutdown_log.txt
#     Should Contain  ${result.stdout}    Destroying VM and associated drives...
