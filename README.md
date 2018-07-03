# direct-dedupe
Prints CSV file listing checksums for subdirectories (with file paths and file sizes) in order to help identify duplicate directories.

## Usage
Run the shell script in the command line. You will be prompted for:

* A source directory -- the top-level directory containing all directories you'd like to run checksums for.
* A destination directory -- a directory titled "dedupe" will be created here, and the final spreadsheet will appear in the dedupe folder. The script will fail if there is already a directory title "dedupe" in that location.

The resulting spreadsheet can be used with conditional formatting in Microsoft Excel to highlight duplicate directories.

## Known issues
* Subdirectory names cannot use spaces; use command line tool [detox](http://detox.sourceforge.net/) to remove spaces. 
* If any of the subcommands return an error rather than a value, the different columns may become unaligned in the spreadsheet.
* If a directory contains and only contains one subdirectory, that directory and subdirectory will have the same checksum and appear as if they were duplicates.
