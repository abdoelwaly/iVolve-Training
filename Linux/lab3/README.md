# Lab 3: Shell Scripting Basics


## Objective: 
Create a shell script that would ping every single server in the 172.16.17.x subnet where x is a number between 0 and 255. If a ping succeeds, statement "Server 172.16.17.x is up and running" will be displayed. Otherwise, if a ping fails, statement "Server 172.16.17.x is unreachable" will be displayed.



## How It Works
- The script iterates through all possible IP addresses in the `172.25.250.x` range.
- It sends a single ping request (`-c 1`) with a 1-second timeout (`-W 1`) to each IP.
- If the ping is successful, the script outputs: `Server 172.25.250.x is up and running`.
- If the ping fails, the script outputs: `Server 172.25.250.x is unreachable`.


## Usage
1. Save the script as `ping_servers.sh`.
2. Grant execution permissions:
   ```bash
   chmod +x ping_servers.sh
   ```
3. Run the script:
   ```bash
   ./ping_servers.sh
   ```

##  Output
```
[root@workstation ~]# ./ping_servers.sh
Server 172.25.250.0 is unreachable
Server 172.25.250.1 is unreachable
Server 172.25.250.2 is unreachable
Server 172.25.250.3 is unreachable
Server 172.25.250.4 is unreachable
Server 172.25.250.5 is unreachable
Server 172.25.250.6 is unreachable
Server 172.25.250.7 is unreachable
Server 172.25.250.8 is unreachable
Server 172.25.250.9 is up and running
Server 172.25.250.10 is up and running
Server 172.25.250.11 is up and running
Server 172.25.250.12 is up and running
Server 172.25.250.13 is up and running
Server 172.25.250.14 is unreachable
...
```


