#!/usr/bin/env bash

task=${1:-all}

case $task in
  help)
    echo """Tasks you can run with this script:
 Optional:
  - create_schema: uses csvkit to guess SQL titles and dtypes as a create table statement
  - edit_schema: uses sed to change dtypes to TEXT and NUMERIC; leaves DATE
  - copy_headers: copies csvkit suggested import method from header folder to main 
 Default:
  - database: creates psql DB
  - import: runs all common core data imports
  - filter: limits school-level data to in-scope states
  - combine: adds district IDs and other characteristics to school-level data
If you don't specify a task, the script runs all of the default tasks in sequence. Optional tasks must be run manually.
    """
  ;;

  # HEADERS: generate createtable from headers (must be manually run)
  headers | create_schema)
    echo "=== Pulling headers to create schemas"
    pushd data
    mkdir -p headers
    for csv in *.csv; do
      base="${csv%.csv}"
      file_name="import_${base,,}"
      table_name="${base,,}"
      echo "drop table if exists ${table_name} cascade;"$'\n' > headers/$file_name.sql;
      head -n 500 $csv | tr "[:upper:]" "[:lower:]" | csvsql --no-constraints --tables $table_name >> headers/$file_name.sql;        
      echo $'\n'"\copy ${table_name} from 'data/${table_name}.csv' csv header;" >> headers/$file_name.sql;
    done
    popd
  ;;&

  headers | edit_schema)
    echo "=== Changing dtypes to TEXT, NUMERIC and DATE"
    for file in data/headers/*.sql; do
      sed 's/BOOLEAN/TEXT/g; s/VARCHAR/TEXT/g; s/DECIMAL/TEXT/g' $file > $file.tmp; mv $file.tmp $file;
    done
  ;;&

  headers | copy_headers)
    echo "=== Adding header files to root directory"
    cp -a data/headers/*.sql .
  ;;

  # ALL: main tasks (run by default)
  all | database)
    echo "=== Creating and populating database..."
    dropdb quick_sql
    createdb quick_sql
  ;;&

  # create folders
  all | folders)
    echo "=== Creating file structure"
    mkdir -p output
  ;;&

  # load data
  all | import)
    echo "=== Loading ccd data..."
    for import in import*.sql; do
      psql quick_sql -f $import;
    done
  ;;&

  # filter ccd data to in-scope topics
  all | filter)
    echo "=== Filtering ccd data..."
    for filter in filter*.sql; do
      psql quick_sql -f $filter;
    done
  ;;&

  # combine ccd enrollment with ccd directory info
  all | combine)
    echo "=== Joining ccd directory to ccd student data..."
    for combine in combine*.sql; do
      psql quick_sql -f $combine;
    done
  ;;&
esac