#!/bin/sh

#DirectDedupe is a shell script that creates a spreadsheet listing the checksums for directories. This spreadsheet can be used (with conditional formatting in Excel for example) to identify and manually delete duplicate directories.

#The MIT License (MIT)
#Copyright (c) 2018 Stefana Breitwieser

# Known issue: Subdirectory names cannot use spaces; use command line tool detox to remove spaces. 
# Known issue: If any of the subcommands return an error rather than a value, the different columns may become unaligned in the spreadsheet.
# Known issue: If a directory contains and only contains one subdirectory, the directory and subdirectory will have the same checksum and appear as duplicates.


#creates directory if one does not already exist
if [ -d /home/bcadmin/Desktop/dedupe ]
	then
		echo "Cannot overwrite existing directory. Delete /home/bcadmin/Desktop/dedupe or wait until the current dedupe command finishes."
		exit
else 
	mkdir /home/bcadmin/Desktop/dedupe
fi

#prints CSV of file paths and file sizes
echo "Printing list of directories with their file sizes."
for D in $(find . -type d)
do 
	du -sh $D >> /home/bcadmin/Desktop/dedupe/filesizes.csv;
done
echo "List complete.
"

#prints CSV of checksums of subdirectories
echo "Printing list of checksums."
echo "This might take some time based on the size of the working directory and number of subdirectories -- please be patient!"
for D in $(find . -type d)
do find $D -type f -exec md5sum {} + | awk '{print $1}' | sort | md5sum >> /home/bcadmin/Desktop/dedupe/checksums.csv;
done
echo "List complete.
"

#concats spreadsheets
echo "Building final spreadsheet."
paste -d "," /home/bcadmin/Desktop/dedupe/filesizes.csv /home/bcadmin/Desktop/dedupe/checksums.csv >> /home/bcadmin/Desktop/dedupe/dedupes.csv && rm /home/bcadmin/Desktop/dedupe/filesizes.csv && rm /home/bcadmin/Desktop/dedupe/checksums.csv 

#inserts header into spreadsheet
( echo "filesize,filepath,checksum" ; cat /home/bcadmin/Desktop/dedupe/dedupes.csv ) > /home/bcadmin/Desktop/dedupe/dedupe.csv && rm /home/bcadmin/Desktop/dedupe/dedupes.csv 

echo "Process complete. Find the completed spreadsheet in /home/bcadmin/dedupe."
exit