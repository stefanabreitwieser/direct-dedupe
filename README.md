# direct-dedupe
Prints CSV file listing checksums for subdirectories (with file paths and file sizes) in order to help identify duplicate directories.

## Usage
Run the shell script in the command line. You will be prompted for a source directory, which will be the top-level directory you want to run a checksum on. You will also be prompted for a destination directory. A folder titled "dedupe" will be created there, and the final spreadsheet will appear in the dedupe folder. 

## Known issues
* Subdirectory names cannot use spaces; use command line tool [detox](http://detox.sourceforge.net/) to remove spaces. 
* If any of the subcommands return an error rather than a value, the different columns may become unaligned in the spreadsheet.
* If a directory contains and only contains one subdirectory, the directory and subdirectory will have the same checksum and appear as if they were duplicates.
