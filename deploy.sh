#!/bin/sh
# deploy.sh

BUILD_ID = DONTKILLME
. /etc/profile



export $PROJ_PATH = `pwd`

echo "project path is : $PROJ_PATH"

export $TOMCAT_APP_PATH = "/usr/local/src/tomcat"

echo "tomcat path is : $TOMCAT_APP_PATH"

sh $PROJ_PATH/OpenMDMServer/deploy.sh

killTomcat()
{
	pid=`ps -ef | grep tomcat |grep java | awk '{print $2}'`
	echo "tomcat Id list : $pid"
	if ["$pid" = ""]
	then 
	   echo "no tomcat pid alive"
	else 
	   kill -9 $pid
	fi
}
#cd $PROJ_PATH/OpenMDMServer
#mvn clean install
killTomcat

#删除原有工程

#rm -rf $TOMCAT_APP_PATH/webapps/TOOT
#rm -rf $TOMCAT_APP_PATH/webapps/TOOT.war
#rm -rf $TOMCAT_APP_PATH/webapps/OpenMDMServer.war
rm -rf $TOMCAT_APP_PATH/webapps/OpenMDMServer

#复制新的工程
cp $PROJ_PATH/OpenMDMServer $TOMCAT_APP_PATH/webapps/

# cd $TOMCAT_APP_PATH/webapps
# mv order.war ROOT.war

#启动tomcat 
cd $TOMCAT_APP_PATH/
sh bin/startup.sh
