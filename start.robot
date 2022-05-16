*** Settings ***
Library    Process    
Library    OperatingSystem
Library    String


*** Test Cases *** 
Start 3 Vagrant VMs and check reply from from
    ${result} =  Run Process    vagrant    up  shell=True  stdout=vm_start_log.txt
    Should Contain  ${result.stdout}    csp2s22c03: Running Iperf Server as a daemon


Execute IPERF test on VM net2s22c05
    ${result} =  Run Process    vagrant ssh net2s22c05 -c 'iperf -c 10.10.1.2'  shell=True  stdout=iperf.txt
    Should Contain  ${result.stdout}    connected with 10.10.1.2


Destroy Vagrant VMs and check shutdown message
    ${result} =  Run Process    vagrant destroy -f  shell=True  stdout=vm_shutdown_log.txt
    Should Contain  ${result.stdout}    Destroying VM and associated drives...