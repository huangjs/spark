#!/bin/bash

export MAVEN_OPTS="-Xmx4g -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=512m"

mvn clean

# scala 2.10
#./dev/change-version-to-2.10.sh
#./make-distribution.sh -Pyarn -Phive -Phive-thriftserver -Phive-0.13.1 -Phadoop-2.4 -Djava.version=1.7 -Dhadoop.version=2.4.0.2.1.2.0-402 -Dyarn.version=2.4.0.2.1.2.0-402 -Dzookeeper.version=3.4.5.2.1.2.0-402 -DskipTests

# scala 2.11 (thriftserver not working)
./dev/change-version-to-2.11.sh
./make-distribution.sh -Pyarn -Phive -Phive-0.13.1 -Phadoop-2.4 -Djava.version=1.7 -Dhadoop.version=2.4.1 -Dyarn.version=2.4.1 -Dzookeeper.version=3.4.5 -DskipTests -Dscala-2.11
#./make-distribution.sh -Pyarn -Phive -Phive-0.13.1 -Phadoop-2.4 -Djava.version=1.7 -Dhadoop.version=2.4.0.2.1.2.0-402 -Dyarn.version=2.4.0.2.1.2.0-402 -Dzookeeper.version=3.4.5.2.1.2.0-402 -DskipTests -Dscala-2.11

# installing jars to local repository
#mvn clean install -Pyarn -Phive -Phive-0.13.1 -Phadoop-2.4 -Djava.version=1.7 -Dhadoop.version=2.4.0.2.1.2.0-402 -Dzookeeper.version=3.4.5.2.1.2.0-402 -DskipTests

# patch hdfs-7005
#jar uvf dist/lib/spark-assembly-*.jar -C ./patch/ org/apache/hadoop/hdfs/DFSClient.class

#mvn clean package -Pyarn -Phive -Phive-0.13.1 -Phadoop-2.4 -Djava.version=1.7 -Dhadoop.version=2.4.0.2.1.2.0-402 -Dzookeeper.version=3.4.5.2.1.2.0-402 -DskipTests

# permission fix
chmod -R +r dist

# make sure datanucleus are copied
cp lib_managed/jars/* dist/lib

# copy hive-site.xml to dist/conf
#cp conf/hive-site.stampy.xml dist/conf/hive-site.xml
#cp conf/spark-defaults.conf dist/conf/spark-defaults.conf
#cp conf/spark-env.sh dist/conf/spark-env.sh
#cp conf/log4j.properties dist/conf/log4j.properties
#cp conf/metrics.properties dist/conf/metrics.properties

cd dist && rm -rf conf && ln -s ../conf . && cd ..

