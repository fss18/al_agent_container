Alert Logic AL Agent in Container (stand alone)
================
WARNING: this is non official container for Alert Logic AL Agent, use with caution.
There is no official support from Alert Logic for this Dockerfile.
Please contact author for further question

Requirements
------------
1. Docker daemon
2. Account with Alert Logic
3. Unique registration key

Supported Platform
================

* Kubernetes
* AWS ECS
* Docker (standalone)

Note, for AL Agent implementation in standalone Docker or ECS, I recommend to install AL Agent directly on the host and set docker bridge into promiscuous mode
more info: [click here](https://support.alertlogic.com/hc/en-us/articles/229487488-Supporting-Docker-with-the-Alert-Logic-Agent-Best-Practices)

Sample Usage in Kubernetes
================

* Look for the sample YAML file for how to use it as daemon set
* WARNING: This deployment model will have limitation on traffic inspection from/to the Pods

Sample Usage in Standalone Docker
================

* Set "--network=host" to allow the AL Agent to inspect the host network traffic
* Sample command: `docker run -d --network=host -t wellysiauw/al_agent_standard:latest "start" "UNIQUE REG KEY"


Arguments
================

``ACTION``
----------

* Select either 'start' , 'configure' or 'provision'.
* For normal operation, use 'start'


``ALERTLOGIC_KEY``
----------

This is the unique registration key that is required to register AL Agent.
If you want to force auto-claim, set ALERTLOGIC_KEY to "-".


``HOST``
----------

Set to IP address or DNS name of the Threat Manager if you like to use it as single point of egress.


License and Authors
===================
License:
Distributed under the Apache 2.0 license.

Authors:
Welly Siauw (welly.siauw@alertlogic.com)
