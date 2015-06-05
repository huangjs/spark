#!/bin/bash

export MAVEN_OPTS="-Xmx2g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"

./make-distribution.sh -Pyarn -Phive -Phive-thriftserver -Phive-0.13.1 -Phadoop-2.4 -Djava.version=1.7 -Dhadoop.version=2.4.0.2.1.5.0-695 -Dyarn.version=2.4.0.2.1.5.0-695 -Dzookeeper.version=3.4.5.2.1.5.0-695 -DskipTests

# installing jars to local repository
#mvn clean install -Pyarn -Phive -Phive-0.13.1 -Phadoop-2.4 -Djava.version=1.7 -Dhadoop.version=2.4.0.2.1.5.0-695 -Dzookeeper.version=3.4.5.2.1.5.0-695 -DskipTests

# patch hdfs-7005
#jar uvf dist/lib/spark-assembly-*.jar -C /root/tmp/patch/ org/apache/hadoop/hdfs/DFSClient.class

#mvn clean package -Pyarn -Phive -Phive-0.13.1 -Phadoop-2.4 -Djava.version=1.7 -Dhadoop.version=2.4.0.2.1.5.0-695 -Dzookeeper.version=3.4.5.2.1.5.0-695 -DskipTests

# permission fix
chmod -R +r dist

# make sure datanucleus are copied
cp lib_managed/jars/* dist/lib

# copy hive-site.xml to dist/conf
cp conf/hive-site.stampy.xml dist/conf/hive-site.xml
