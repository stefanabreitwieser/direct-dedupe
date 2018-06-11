# direct-dedupe
Prints CSV file listing checksums for subdirectories (with file paths and file sizes) in order to help identify duplicate directories.

## Usage
```
cd topDirectory
directdedupe.sh
```

This tool very much assumes you're running it on an instance of BitCurator under user bcadmin. 

## Known issues
* This tool very much assumes you're running it on an instance of BitCurator under user bcadmin. 
* Subdirectory names cannot use spaces; use command line tool [detox](http://detox.sourceforge.net/) to remove spaces. 
* If any of the subcommands return an error rather than a value, the different columns may become unaligned in the spreadsheet.
* If a directory contains and only contains one subdirectory, the directory and subdirectory will have the same checksum and appear as if they were duplicates.
