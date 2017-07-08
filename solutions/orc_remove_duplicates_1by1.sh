#!/bin/bash

# Define table to search duplicates from
export tabname="mytemptab"
export outfile="dup_results.log"
export deloutfile="del_dup.hql"

hive -e "select id, min(updated_at) as udate from $tabname group by id having count(id) > 1" 1>./$outfile 2> ./qry_err.log

while read line 
do  
  prec=( $line )
  echo "delete from $tabname where id ='${prec[0]}' and updated_at=${prec[1]}" >> del_out.hql
done < ./$outfile

echo "Running hive -f del_out.hql"

#uncomment the line below to run delete queries
# hive -f ./$deloutfile

echo "Finished."



