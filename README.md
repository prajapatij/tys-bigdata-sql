# tys-bigdata-sql
Teach yourself SQL in BigData using Hive and Spark queries on store database

### Setup  

#### Directory structure  

/ *bigdata*  
|  
|_ release_download.config <- configure 'Hadoop', 'Hive' and 'Spark' versions and download urls, Also, specify JAVA_HOME  
|_ setup.sh  <- Setup this build  
|_ sdk <- contains installed locations for 'Hadoop', 'Hive' and 'Spark'  
|_ installers <- downloaded binaries  
|_ examples <- Sample database and HQL files for DDL and data load  
|_ data <- HDFS data directory to hold Hive warehouse and other data files  
|_ workspace <- Holds all the working code  
|_ setenv.sh <- Contains all environment variables  
|_ hive-sql.sh <- Hive sql runner
|_ spark-sql.sh <- Spark sql runner
|_ spark-shell.sh <- Spark shell runner
|_ spark-submit.sh <- Spark submit job runner

1. Clone the repository to the location where you want to install 
