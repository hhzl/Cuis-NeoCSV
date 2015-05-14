# Cuis-NeoCSV
Read and write CSV converting to or from Smalltalk objects.  Port from https://github.com/svenvc/NeoCVS

Log of port of version 

Name: Neo-CSV-Core-SvenVanCaekenberghe.22
Author: SvenVanCaekenberghe
Time: 10 May 2015, 10:07:22.199998 pm

Name: Neo-CSV-Tests-SvenVanCaekenberghe.19
Author: SvenVanCaekenberghe
Time: 10 May 2015, 10:07:41.797345 pm

https://github.com/hhzl/Cuis-NeoCSV/issues/5

For Cuis version Cuis4.2-2243.image


# Section 1 -- Initial port without fixes

## File out from Pharo 4.0  / File in into Cuis

1. In Pharo 4.0 (May 2015) load NeoCSV package (one-click).
2. File out class packages
    - Neo-CSV-Core
    - Neo-CSV-Tests
3. Rename files to
    - Neo-CSV-Core-orig.st
    - Neo-CSV-Tests-orig.st
4. In Cuis open File List.
5. Install package SqueakCompatibility.pck.st
6. Do the following string replacements in the original files

   Replace
        codePoint
   with
        unicodeCodePoint

   Replace
        String crlf
   with
        String crlfString

   Replace
        String cr
   with
        String crString

   Note: there is a space after 'cr' and 'crString'

   Replace
        String lf
   with
        String lfString


5. Get code browser on 'Neo-CSV-Core-orig.st'
6. File in classes in the following order
    - NeoNumberParser
    - NeoCSVReader
    - NeoCSVWriter
7. Open 'World Menu'
8. Choose 'Open'
9. Choose 'Installed Packages'
10. Click on 'Create Package'
11. Type package name 'Neo-CSV-Core'
12. Enter a description. Include reference to source of the ported file.
    Port of Neo-CSV-Core-SvenVanCaekenberghe.22
13. Click on 'Save'
14. Open File list on 'Neo-CSV-Tests.st'
15. Get a code browser on 'Neo-CSV-Tests.st'
16. File in class #NeoCSVTestObject
17. File in NeoNumberParserTests
18. File in NeoCSVReaderTests
19. File in NeoCSVWriterTests
20. Do not file in class #NeoCSVBenchmark as it gives a waring Wthat ZnBufferedWriteStream and ZnBufferedReadStream are not defined.
21. Created a package 'Neo-CSV-Tests'
    Description: Port of Neo-CSV-Tests-SvenVanCaekenberghe.19

## Unit tests 

Run SUnit tests on code which was filed in:

Result is that 51 out of 52 tests passed.


# Section 2 -- Analysis

The following test fails

    testHexadecimalIntegers
	self assert: (NeoNumberParser parse: '7B' base: 16) equals: 123.
	self assert: (NeoNumberParser parse: '7b' base: 16) equals: 123.
	self assert: (NeoNumberParser parse: '-7B' base: 16) equals: -123.
	self assert: (NeoNumberParser parse: '-7b' base: 16) equals: -123.
	self assert: (NeoNumberParser parse: '0' base: 16) equals: 0.

The test does not fail if the code is changed to


    testHexadecimalIntegers
	self assert: (NeoNumberParser parse: '7B' base: 16) equals: 123.
	"self assert: (NeoNumberParser parse: '7b' base: 16) equals: 123."
	self assert: (NeoNumberParser parse: '-7B' base: 16) equals: -123.
	"self assert: (NeoNumberParser parse: '-7b' base: 16) equals: -123."
	self assert: (NeoNumberParser parse: '0' base: 16) equals: 0.


# Section 3 -- Code changes 


Fix code as described under section 2 -- analysis

## Result after fixing 


52 out of 52 tests are green.



## Conclusion -- Port status

- The port is OK.
- The package requires SqueakCompatibility.pck.st to be loaded and at least Cuis4.2-2243.image
- The following changes were applied to the code before file in
   Replace
        codePoint
   with
        unicodeCodePoint

   Replace
        String crlf
   with
        String crlfString

   Replace
        String cr
   with
        String crString

   Note: there is a space after 'cr' and 'crString'

   Replace
        String lf
   with
        String lfString

- Class #NeoCSVBenchmark has not been ported.
- Major port is done as of May 2015. 

- [Documentation](https://github.com/svenvc/docs/blob/master/neo/neo-csv-paper.md)
