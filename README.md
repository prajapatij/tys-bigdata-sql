# tys-bigdata-sql
Teach yourself SQL in BigData using Hive and Spark queries on store database

### Directory structure  
Following directory structure will be created after setup completes.  
```  
/ *bigdata*  
|_ release_download.config <- configure 'Hadoop', 'Hive' and 'Spark' versions and download urls, Also, specify JAVA_HOME  
|_ setup.sh  <- Setup this build  
|_ sdk <- contains installed locations for 'Hadoop', 'Hive' and 'Spark'  
|_ installers <- downloaded binaries  
|_ examples <- Sample database and HQL files for DDL and data load  
|_ data <- HDFS data directory to hold Hive warehouse and other data files  
___     |_ warehouse <- Hive warehouse  
|_ workspace <- Holds all the working code  
|_ setenv.sh <- Contains all environment variables  
|_ hive-sql.sh <- Hive sql runner  
|_ spark-sql.sh <- Spark sql runner  
|_ spark-shell.sh <- Spark shell runner  
|_ spark-submit.sh <- Spark submit job runner  
```  

### Setup Steps   
1. Clone the repository to the location where you want to install  
2. Copy 'release_download.config', 'setup.sh' to the directory where you want to install everything  
3. Modify 'release_download.config' to set Hadoop, Hive and Spark versions and download urls. Also, change the configuration of 'java' configuration to setup to your JAVA_HOME location.   
4. Run setup.sh  
  `/bigdata/setup.sh`  
5. After setup completes successfully, you should have above directory structure in place.  
6. Copy 'examples' into 'workspace' directory of the install  
  `/bigdata/workspace/examples`  
7. Run hive -f command to setup the 'storedb'.  
  ` hive-sql.sh -f ./workspace/examples/db/store_db.ddls.hql `  
8. Run hive -f command to load data into storedb from the datafiles.  
  ` hive-sql.sh -f ./workspace/examples/db/store_db.dataload.hql`   
9. Go through the SQL tutorial online and start executing one by one. URL: https://www.w3schools.com/sql  
10. Use hive-sql.sh, spark-sql.sh to start Hive and Spark sql consoles or follow the commands inside sh files.  
11. Use spark-shell.sh, spark-submit.sh to work with Spark APIs and SQLs or follow the commands inside sh files.  

#### Local mode setup information
Hadoop is installed in local mode. This means your local file system is hdfs. Try running hdfs commands after sourcing setenv.sh.  e.g.  
```  
  hadoop version  
  hdfs dfs -ls \    
```
It uses default derby as Hive metastore. Make sure to use it from the install directory e.g. /bigdata to make derby available.

### Upgrades Information
* Use release_download_3_1_1.config file to upgrade to the latest versions of the setup.   
* Use setup_with_auth.sh to download the installers with given user id.

##### Derby databse conflict between Hive & Spark
In latest versions of Hive & Spark there is a conflict between the default derby driver (derby-10.14.1.0 vs derby-10.12.1.1). Due to this there will be exception while running the spark. To solve this, remove the deby jar (derby-10.14.1.0.jar) from ./sdk/hive/lib and copy the one from ./sdk/spark/jars.
