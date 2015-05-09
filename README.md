# Cuis-NeoCSV
Read and write CSV converting to or from Smalltalk objects.  Port from https://github.com/svenvc/NeoCVS


# Section 1 -- Initial port without fixes

## File out from Pharo 4.0  / File in into Cuis

1. In Pharo 4.0 (May 2015) load NeoCSV package (one-click).
2. File out class packages
    - Neo-CSV-Core
    - Neo-CSV-Tests
3. In Cuis open File List.
4. Get code browser on 'Neo-CSV-Core.st'
5. File in classes in the following order
    - NeoNumberParser
    - NeoCSVReader
    - NeoCSVWriter
6. Open 'World Menu'
7. Choose 'Open'
8. Choose 'Installed Packages'
9. Click on 'Create Package'
10. Type package name 'Neo-CSV-Core'
11. Enter a description. Include reference to source of the ported file.
12. Click on 'Save'
13. Open File list on 'Neo-CSV-Tests.st'
14. Get a code browser on 'Neo-CSV-Tests.st'
15. File in class #NeoCSVTestObject
16. File in NeoNumberParserTests
17. File in NeoCSVReaderTests
18. File in NeoCSVWriterTests
19. Do not file in class #NeoCSVBenchmark as it gives a waring Wthat ZnBufferedWriteStream and ZnBufferedReadStream are not defined.
20. Created a package 'Neo-CSV-Tests'

## Unit tests 

Run SUnit tests on code which was filed in:

Result is that 48 out of 50 tests have an error.


# Section 2 -- Analysis

1. [Failing tests caused by changed selector names](https://github.com/hhzl/Cuis-NeoCSV/issues/1)
2. [Failing tests caused by unimplemented methods with a straightforward alternative](https://github.com/hhzl/Cuis-NeoCSV/issues/2)
3. [Failing tests caused by missing methods in Cuis](https://github.com/hhzl/Cuis-NeoCSV/issues/3)

# Section 3 -- Code changes 

## Result after fixing issues 1 to 3

After fixing issues #1 to #3

49 out of 50 tests are green.

## Known  bug

It is left with issue [#4 #testHexadecimalIntegers] (https://github.com/hhzl/Cuis-NeoCSV/issues/4)


## Conclusion -- Port status
- Issue #4 is a minor error and needs no fixing in order to use this package.
- Class #NeoCSVBenchmark has not been ported.
- Major port is done as of May 2015. Minor fixes later.
- [Documentation](https://github.com/svenvc/docs/blob/master/neo/neo-csv-paper.md)
