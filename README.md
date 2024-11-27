# Cuis-NeoCSV
Read and write CSV converting to or from Smalltalk objects.
 
Description from: https://github.com/svenvc/docs/blob/master/neo/neo-csv-paper.md

Basically, NeoCSV deals with a format that

- is text based (ASCII, Latin1, Unicode)
- consists of records, 1 per line (any line ending convention)
- where records consist of fields separated by a delimiter (comma, tab, semicolon)
- where every record has the same number of fields
- where fields can be quoted should they contain separators or line endings

https://github.com/svenvc/docs/blob/master/neo/neo-csv-paper.md

The port was done from from http://www.smalltalkhub.com/#!/~SvenVanCaekenberghe/Neo.

Now on github: https://github.com/svenvc/NeoCSV

To do: find out if there are changes in the meantime that need to be ported also.



## Log of port of 2015 version 


https://github.com/hhzl/Cuis-NeoCSV/issues/5

See Documentation folder.


## Changes for Cuis 7

Changes by Hilaire Fernandes to bring it up to Cuis 7 have been merged.


## Conclusion -- Port status

- The port is OK. All tests are green.
- [Documentation](https://github.com/svenvc/docs/blob/master/neo/neo-csv-paper.md)
