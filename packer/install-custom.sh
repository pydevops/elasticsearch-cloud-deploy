#!/bin/bash
set -e

JMX_PORT=9999

# install stackdriver agent here
curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh
sudo bash install-monitoring-agent.sh

# install jvm 
cd /opt/stackdriver/collectd/etc/collectd.d/ && sudo curl -O https://raw.githubusercontent.com/Stackdriver/stackdriver-agent-service-configs/master/etc/collectd.d/jvm-sun-hotspot.conf
cd /opt/stackdriver/collectd/etc/collectd.d/ && sudo curl -O https://raw.githubusercontent.com/Stackdriver/stackdriver-agent-service-configs/master/etc/collectd.d/elasticsearch-1.conf
# replace JMX_PORT
cd /opt/stackdriver/collectd/etc/collectd.d/ && sudo sed -i "s/localhost:JMX_PORT/localhost:$JMX_PORT/g" jvm-sun-hotspot.conf

# append JMX to /etc/elasticsearch/jvm.options
sudo bash -c "cat <<EOF >>/etc/elasticsearch/jvm.options
-Dcom.sun.management.jmxremote.port=9999
-Dcom.sun.management.jmxremote.authenticate=false
-Dcom.sun.management.jmxremote.ssl=false
EOF"
