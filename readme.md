# autofuzz

This is a simple fuzzer, based on the mqtt_fuzzer by F-Secure (https://github.com/F-Secure/mqtt_fuzz).   
The primary objective is to optimize this package for general purpose and make it compatible with IoT CI Systems. The whole system runs in a dockerized environment.  

This package is used as a replay system for captured packages with a lil bit of fuzzing, so it should also work with other protocols with minor modifications.  


## Requirements
Fuzz cases are generated using Radamsa. The tool has been tested with version 0.4a, which should be auto compiled on first run. Twisted will be installed via pip.


## Usage
DO NOT RUN THE TOOL AGAINST A TARGET THAT YOU DO NOT HAVE AN
AUTHORIZATION TO TEST.

This tool is intended to be used inside a docker container.

ARG PROTOCOL = Valid source packages in folder valid/ - ex: mqtt
ARG TARGET = HOST/IP of the target 
ARG PORT = Port of the target 
ARG ADD = Additional parameters
ARG TIMEOUT = Runtime of the Fuzzing attack  
ARG LOGID = String/Number attached to the logfile  
ARG TRUNCATE = Number of last lines which should be saved in logfile  


### Possible additional parameters (not required)
'-ratio', default=3, How many control packets should be fuzzed per 10 packets sent (0 = fuzz nothing, 10 = fuzz all packets)  
'-delay', default=50, How many milliseconds to wait between control packets sent  

## Example execution
docker run -e "PROTOCOL=mqtt" -e "TARGET=10.188.101.114" -e "PORT=1883" -e "TIMEOUT=60" -e "LOGID=3" -e "TRUNCATE=50" --volume /tmp/flog:/log:Z wmchris/autofuzz:latest

## Example for a 24h DoS
```
#!/bin/bash
for i in {1..20}
do
        docker run -d -e "PROTOCOL=mqtt" -e "TARGET=10.188.101.114" -e "PORT=1883" -e "TIMEOUT=86400" -e "LOGID=$i" -e "TRUNCATE=50" --volume /tmp/flog:/log:Z wmchris/autofuzz:latest
done
```

## Legal
See LICENCE.  
Original tool author: Antti Vähä-Sipilä.
