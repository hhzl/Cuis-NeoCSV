# Cuis-NeoCSV
Read and write CSV converting to or from Smalltalk objects.  Port from https://github.com/svenvc/NeoCVS


# Porting log section 1

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

# Evaluate result of section 1

- Run tests in SUnit. Result is that 48 out of 50 tests have an error.
- This mainly is caused by the construction of test data which is done ``String crlf join:`` as the following example shows
    input := (String crlf join: #( '"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '')).
  


