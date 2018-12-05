#!/bin/bash

export bddir=$(pwd)

echo "Setup script running in - $bddir"

echo 'Creating directory structure...'
mkdir $bddir/data
mkdir $bddir/sdk
mkdir $bddir/installers
mkdir $bddir/tools
mkdir $bddir/workspace
echo 'Creating directory structure... Done.'

echo 'Downloading and installing builds configured in release_download.config... '

echo $'#!/bin/bash' > setenv.sh
echo -en "\n BIGDATA_HOME=$bddir" >> setenv.sh

while read line 
do  
  dwnldinf=( $line )
  echo "Processing entry: ${dwnldinf[0]},${dwnldinf[1]},${dwnldinf[2]}"
  $(wget --user="jignesh.prajapati" --ask-password ${dwnldinf[2]} -P $bddir/installers/)
  
  echo "Extracting to sdk..."
  tarname=$(basename ${dwnldinf[2]})
  
  case ${dwnldinf[0]} in
   "hadoop")
     $( tar xvzf $bddir/installers/$tarname -C $bddir/sdk/ )     
     $( mv $bddir/sdk/${tarname%.tar*} $bddir/sdk/hadoop )
     echo -en "\n export HADOOP_HOME=$bddir/sdk/hadoop" >> setenv.sh
     ;;
   "hive") 
     $( tar xvzf $bddir/installers/$tarname -C $bddir/sdk/ ) 
     $( mv $bddir/sdk/${tarname%.tar*} $bddir/sdk/hive )
     echo -en "\n export HIVE_HOME=$bddir/sdk/hive" >> setenv.sh
     ;;
   "spark")
     $( tar xvzf $bddir/installers/$tarname -C $bddir/sdk/ )
     $( mv $bddir/sdk/${tarname%.*} $bddir/sdk/spark )	
     echo -en "\n export SPARK_HOME=$bddir/sdk/spark" >> setenv.sh
     ;;
   "java")	
     echo -en "\n export JAVA_HOME=${dwnldinf[2]}" >> setenv.sh
     ;;
  esac
done < './release_download.config'

echo -en "\n export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin:\$HIVE_HOME/bin:\$SPARK_HOME/bin" >> setenv.sh

echo 'Downloading and installing builds configured in release_download.config... Done.'

source ./setenv.sh
echo "Setting up hive metastore as derby..."
$HIVE_HOME/bin/schematool -dbType 'derby' -initSchema
echo "Setting up hive metastore as derby... Done."

echo "Setting up hive warehouse directory to $bddir/data ..."
$HIVE_HOME/bin/hive -hiveconf hive.metastore.warehouse.dir="$bddir/data/warehouse" -e "create database tempdb; create table tempdb.temptab1(a int);insert into tempdb.temptab1 values(1)"
echo "Setting up hive warehouse directory to $bddir/data ... Done."

cat > ./hive-sql.sh <<- EOM
 cd $BIGDATA_HOME
 source ./setenv.sh
 hive \$@ -hiveconf hive.metastore.warehouse.dir="$BIGDATA_HOME/data/warehouse"
EOM

cat > ./spark-sql.sh <<- EOM
 cd $BIGDATA_HOME
 source ./setenv.sh
 spark-sql \$@ -hiveconf hive.metastore.warehouse.dir="$BIGDATA_HOME/data/warehouse"
EOM

cat > ./spark-shell.sh <<- EOM
 cd $BIGDATA_HOME
 source ./setenv.sh
 spark-shell \$@ --conf spark.sql.warehouse.dir="$BIGDATA_HOME/data/warehouse"
EOM

cat > ./spark-submit.sh <<- EOM
 cd $BIGDATA_HOME
 source ./setenv.sh
 spark-submit \$@ --conf spark.sql.warehouse.dir="$BIGDATA_HOME/data/warehouse"
EOM

echo "Setup script complete."
