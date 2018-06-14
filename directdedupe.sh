#!/bin/sh

#direct-dedupe is a shell script that creates a spreadsheet listing the checksums for directories. This spreadsheet can be used (with conditional formatting in Excel for example) to identify and manually delete duplicate directories.

#The MIT License (MIT)
#Copyright (c) 2018 Stefana Breitwieser

#input source directory and remove quotes if they exist
echo "Source directory?"
read srcinput
src=$(echo $srcinput | tr -d \')

#input destination directory and remove quotes if they exist
echo "Destination directory?"
read destinput
dest=$(echo $destinput | tr -d \')

#creates directory if one does not already exist
if [ -d $dest/dedupe ]
	then
		echo "Cannot overwrite existing dedupe directory."
		exit
else 
	mkdir $dest/dedupe
fi

#prints CSV of file paths and file sizes
echo "Printing list of directories with their file sizes."
for D in $(find $src -type d)
do 
	du -sh $D >> $dest/dedupe/filesizes.csv;
done
echo "List complete.
"

#prints CSV of checksums of subdirectories
echo "Printing list of checksums."
echo "This might take some time based on the size of the working directory and number of subdirectories -- please be patient!"
for D in $(find $src -type d)
do find $D -type f -exec md5sum {} + | awk '{print $1}' | sort | md5sum >> $dest/dedupe/checksums.csv;
done
echo "List complete.
"

#concats spreadsheets
echo "Building final spreadsheet."
paste -d "," $dest/dedupe/filesizes.csv $dest/dedupe/checksums.csv >> $dest/dedupe/dedupes.csv && rm $dest/dedupe/filesizes.csv && rm $dest/dedupe/checksums.csv 

#inserts header into spreadsheet
( echo "filesize,filepath,checksum" ; cat $dest/dedupe/dedupes.csv ) > $dest/dedupe/dedupe.csv && rm $dest/dedupe/dedupes.csv 

echo "Process complete. Find the completed spreadsheet in the dedupe folder."
exit
