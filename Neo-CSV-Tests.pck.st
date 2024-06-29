'From Cuis7.0 [latest update: #6452] on 28 June 2024 at 11:55:38 am'!
'Description Please enter a description for this package'!
!provides: 'Neo-CSV-Tests' 1 3!
SystemOrganization addCategory: #'Neo-CSV-Tests'!


!classDefinition: #NeoCSVReaderTests category: #'Neo-CSV-Tests'!
TestCase subclass: #NeoCSVReaderTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Neo-CSV-Tests'!
!classDefinition: 'NeoCSVReaderTests class' category: #'Neo-CSV-Tests'!
NeoCSVReaderTests class
	instanceVariableNames: ''!

!classDefinition: #NeoCSVWriterTests category: #'Neo-CSV-Tests'!
TestCase subclass: #NeoCSVWriterTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Neo-CSV-Tests'!
!classDefinition: 'NeoCSVWriterTests class' category: #'Neo-CSV-Tests'!
NeoCSVWriterTests class
	instanceVariableNames: ''!

!classDefinition: #NeoNumberParserTests category: #'Neo-CSV-Tests'!
TestCase subclass: #NeoNumberParserTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Neo-CSV-Tests'!
!classDefinition: 'NeoNumberParserTests class' category: #'Neo-CSV-Tests'!
NeoNumberParserTests class
	instanceVariableNames: ''!

!classDefinition: #NeoCSVTestObject category: #'Neo-CSV-Tests'!
Object subclass: #NeoCSVTestObject
	instanceVariableNames: 'x y z'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Neo-CSV-Tests'!
!classDefinition: 'NeoCSVTestObject class' category: #'Neo-CSV-Tests'!
NeoCSVTestObject class
	instanceVariableNames: ''!


!NeoCSVReaderTests commentStamp: '<historical>' prior: 0!
I am NeoCSVReaderTests, a suite of unit tests for NeoCSVReader.
!

!NeoCSVWriterTests commentStamp: '<historical>' prior: 0!
I am NeoCSVWriterTests, a suite of unit tests for NeoCSVWriter.
!

!NeoNumberParserTests commentStamp: '<historical>' prior: 0!
I am NeoNumberParserTests the unit test suite for NeoNumberParser.!

!NeoCSVTestObject commentStamp: '<historical>' prior: 0!
I am NeoCSVTestObject.!

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 1/14/2014 23:20'!
testEmbeddedQuotes
	self 
		assert: (NeoCSVReader on: '1,"x""y""z",3' readStream) upToEnd
		equals: #(('1' 'x"y"z' '3'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:41:59'!
testEmptyConversions
	| input |
	input := (String crlfString join: #( '1,2.5,foo' ',,' )).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					addIntegerField;
					addFloatField;
					addField;
					upToEnd)
		equals: { 
					#( 1 2.5 'foo' ). 
					#( nil nil nil ) }! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:42:11'!
testEmptyConversionsTestObject
	| input |
	input := (String crlfString join: #( '1,2.5,foo' ',,' )).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					recordClass: NeoCSVTestObject;
					addIntegerField: #x: ;
					addFloatField: #y: ;
					addField: #z: ;
					upToEnd)
		equals: { 
					NeoCSVTestObject x: 1 y: 2.5 z: 'foo'. 
					NeoCSVTestObject new }! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 5/13/2014 14:46'!
testEmptyFieldQuoted
	self 
		assert: (NeoCSVReader on: '"1",,"3"' readStream) upToEnd
		equals: #(('1' nil '3'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:47:01'!
testEmptyFieldSecondRecordQuoted
	self 
		assert: (NeoCSVReader on: '"foo","bar"\"100",' withNewLines readStream) upToEnd
		equals: #(('foo' 'bar')('100' nil))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:47:26'!
testEmptyFieldSecondRecordUnquoted
	self 
		assert: (NeoCSVReader on: 'foo,bar\100,' withNewLines readStream) upToEnd
		equals: #(('foo' 'bar')('100' nil))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 5/13/2014 14:47'!
testEmptyFieldUnquoted
	self 
		assert: (NeoCSVReader on: '1,,3' readStream) upToEnd
		equals: #(('1' nil '3'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:47:32'!
testEmptyFieldValue
	self 
		assert: ((NeoCSVReader on: '"1",,3,"","5"' readStream) 
						emptyFieldValue: #empty; 
						upToEnd)
		equals: #(('1' empty '3' empty '5')).
	self 
		assert: ((NeoCSVReader on: '"1",,3,"","5"' readStream) 
						emptyFieldValue: ''; 
						upToEnd)
		equals: #(('1' '' '3' '' '5')).
	self 
		assert: ((NeoCSVReader on: 'a,b,c\,,\"","",""\1,2,3\' withNewLines readStream)
						emptyFieldValue: #empty;
						upToEnd)
		equals: #(('a' 'b' 'c')(empty empty empty)(empty empty empty)('1' '2' '3'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 5/13/2014 14:47'!
testEmptyLastFieldQuoted
	self 
		assert: (NeoCSVReader on: '"1","2",""' readStream) upToEnd
		equals: #(('1' '2' nil))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 5/13/2014 10:57'!
testEmptyLastFieldUnquoted
	self 
		assert: (NeoCSVReader on: '1,2,' readStream) upToEnd
		equals: #(('1' '2' nil))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:48:06'!
testNamedColumnsConfiguration
	| input |
	input := String crlfString join: #( '"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '').
	self 
		assert: ((NeoCSVReader on: input readStream) 
					namedColumnsConfiguration;
					upToEnd)
		equals: { 
					Dictionary newFromPairs: #(x '100' y '200' z '300'). 
					Dictionary newFromPairs: #(x '100' y '200' z '300'). 
					Dictionary newFromPairs: #(x '100' y '200' z '300') }! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 6/14/2012 19:57'!
testOneLineEmpty
	self 
		assert: (NeoCSVReader on: '' readStream) upToEnd
		equals: #()! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 6/14/2012 19:56'!
testOneLineOneFieldQuoted
	self 
		assert: (NeoCSVReader on: '"1"' readStream) upToEnd
		equals: #(('1'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 6/14/2012 19:55'!
testOneLineOneFieldUnquoted
	self 
		assert: (NeoCSVReader on: '1' readStream) upToEnd
		equals: #(('1'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 6/14/2012 18:58'!
testOneLineQuoted
	self 
		assert: (NeoCSVReader on: '"1","2","3"' readStream) upToEnd
		equals: #(('1' '2' '3'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 6/14/2012 18:57'!
testOneLineUnquoted
	self 
		assert: (NeoCSVReader on: '1,2,3' readStream) upToEnd
		equals: #(('1' '2' '3'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:48:13'!
testReadAsByteArrays
	| input |
	input := (String crlfString join: #( '1,2,3' '1,2,3' '1,2,3' '')).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					recordClass: ByteArray;
					addIntegerField;
					addIntegerField ;
					addIntegerField;
					upToEnd)
		equals: {
			#[1 2 3].
			#[1 2 3].
			#[1 2 3].}! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:48:21'!
testReadAsIntegerArrays
	| input |
	input := (String crlfString join: #( '100,200,300' '100,200,300' '100,200,300' '')).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					recordClass: IntegerArray;
					addIntegerField;
					addIntegerField ;
					addIntegerField;
					upToEnd)
		equals: {
			#(100 200 300) asIntegerArray.
			#(100 200 300) asIntegerArray.
			#(100 200 300) asIntegerArray }! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:48:25'!
testReadDictionaries
	| input |
	input := String crlfString join: #( '"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '').
	self 
		assert: ((NeoCSVReader on: input readStream) 
					skipHeader;
					recordClass: Dictionary;
					addIntegerFieldAt: #x ;
					addIntegerFieldAt: #y ;
					addIntegerFieldAt: #z ;
					upToEnd)
		equals: { 
					Dictionary newFromPairs: #(x 100 y 200 z 300). 
					Dictionary newFromPairs: #(x 100 y 200 z 300). 
					Dictionary newFromPairs: #(x 100 y 200 z 300) }! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:48:30'!
testReadHeader
	| input |
	input := (String crlfString join: #( '"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '')).
	self 
		assert: (NeoCSVReader on: input readStream) readHeader
		equals: #('x' 'y' 'z')! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 7/23/2023 13:07:44'!
testReadHeaderUnicode
	| input |
	input := (UnicodeString newFrom:  'x,y,z
100,200,300
100,200,300
100,200,300').
	self 
		assert: (NeoCSVReader on: input readStream) readHeader
		equals: #('x' 'y' 'z')! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:48:34'!
testReadIntegers
	| input |
	input := (String crlfString join: #( '"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '')).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					skipHeader;
					addIntegerField;
					addIntegerField ;
					addIntegerField;
					upToEnd)
		equals: #((100 200 300)(100 200 300)(100 200 300))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:48:39'!
testReadIntegersReadingHeaderAfterFieldDefinitions
	| input |
	input := (String crlfString join: #( '"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '')).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					addIntegerField;
					addIntegerField ;
					addIntegerField;
					skipHeader;
					upToEnd)
		equals: #((100 200 300)(100 200 300)(100 200 300))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:48:46'!
testReadTestsObjects
	| input |
	input := (String crlfString join: #( '"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '')).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					skipHeader;
					recordClass: NeoCSVTestObject;
					addIntegerField: #x: ;
					addIntegerField: #y: ;
					addIntegerField: #z: ;
					upToEnd)
		equals: { 
					NeoCSVTestObject example. 
					NeoCSVTestObject example. 
					NeoCSVTestObject example }! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:48:51'!
testReadTestsObjectsUsingBlockAccessors
	| input |
	input := (String crlfString join: #( '"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '')).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					skipHeader;
					recordClass: NeoCSVTestObject;
					addIntegerField: [ :object :value | object x: value ];
					addIntegerField: [ :object :value | object y: value ];
					addIntegerField: [ :object :value | object z: value ];
					upToEnd)
		equals: { 
					NeoCSVTestObject example. 
					NeoCSVTestObject example. 
					NeoCSVTestObject example }! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:48:56'!
testReadTestsObjectsWithIgnoredField
	| input |
	input := (String crlfString join: #( '"x","y",''-'',"z"' '100,200,a,300' '100,200,b,300' '100,200,c,300' '')).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					skipHeader;
					recordClass: NeoCSVTestObject;
					addIntegerField: #x: ;
					addIntegerField: #y: ;
					addIgnoredField;
					addIntegerField: #z: ;
					upToEnd)
		equals: { 
					NeoCSVTestObject example. 
					NeoCSVTestObject example. 
					NeoCSVTestObject example }! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:49:01'!
testReadWithIgnoredField
	| input |
	input := (String crlfString join: #( '1,2,a,3' '1,2,b,3' '1,2,c,3' '')).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					addIntegerField;
					addIntegerField;
					addIgnoredField;
					addIntegerField;
					upToEnd)
		equals: {
			#(1 2 3).
			#(1 2 3).
			#(1 2 3).}! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:49:05'!
testSimpleCrLfQuoted
	| input |
	input := (String crlfString join: #('"1","2","3"' '"4","5","6"' '"7","8","9"' '')).
	self 
		assert: (NeoCSVReader on: input readStream) upToEnd
		equals: #(('1' '2' '3')('4' '5' '6')('7' '8' '9'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:49:19'!
testSimpleCrLfUnquoted
	| input |
	input := (String crlfString join: #('1,2,3' '4,5,6' '7,8,9' '')).
	self 
		assert: (NeoCSVReader on: input readStream) upToEnd
		equals: #(('1' '2' '3')('4' '5' '6')('7' '8' '9'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:49:25'!
testSimpleCrQuoted
	| input |
	input := (String crString join: #('"1","2","3"' '"4","5","6"' '"7","8","9"' '')).
	self 
		assert: (NeoCSVReader on: input readStream) upToEnd
		equals: #(('1' '2' '3')('4' '5' '6')('7' '8' '9'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:49:57'!
testSimpleCrUnquoted
	| input |
	input := (String crString join: #('1,2,3' '4,5,6' '7,8,9' '')).
	self 
		assert: (NeoCSVReader on: input readStream) upToEnd
		equals: #(('1' '2' '3')('4' '5' '6')('7' '8' '9'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:50:02'!
testSimpleLfQuoted
	| input |
	input := (String lfString join: #('"1","2","3"' '"4","5","6"' '"7","8","9"' '')).
	self 
		assert: (NeoCSVReader on: input readStream) upToEnd
		equals: #(('1' '2' '3')('4' '5' '6')('7' '8' '9'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:50:07'!
testSimpleLfUnquoted
	| input |
	input := (String lfString join: #('1,2,3' '4,5,6' '7,8,9' '')).
	self 
		assert: (NeoCSVReader on: input readStream) upToEnd
		equals: #(('1' '2' '3')('4' '5' '6')('7' '8' '9'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:50:12'!
testSimpleSemiColonDelimited
	| input |
	input := (String crlfString join: #('1;2;3' '4;5;6' '7;8;9' '')).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					separator: $; ;
					upToEnd)
		equals: #(('1' '2' '3')('4' '5' '6')('7' '8' '9'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:50:16'!
testSimpleTabDelimited
	| input |
	input := (String crlfString join: #('1	2	3' '4	5	6' '7	8	9' '')).
	self 
		assert: ((NeoCSVReader on: input readStream) 
					separator: Character tab ;
					upToEnd)
		equals: #(('1' '2' '3')('4' '5' '6')('7' '8' '9'))! !

!NeoCSVReaderTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:50:52'!
testSkippingEmptyRecords
	| input output |
	input := '1,2,3\\4,5,6\,,\7,8,9' withNewLines.
	output := (NeoCSVReader on: input readStream) 
		select: [ :each | each notEmpty and: [ (each allSatisfy: #isNil) not ] ].
	self assert: output equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9')).
	output := (NeoCSVReader on: input readStream) 
		emptyFieldValue: '';
		select: [ :each | each notEmpty and: [ (each allSatisfy: #isEmpty) not ] ].
	self assert: output equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9'))! !

!NeoCSVWriterTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:51:06'!
testEmptyFieldValue
	self
		assert: (String streamContents: [ :stream |
					(NeoCSVWriter on: stream)
						nextPut: #(one two three);
						nextPutAll: #( (1 2 nil) (4 nil 6) (nil 8 9)) ])
		equals: (String crlfString join: #( '"one","two","three"' '"1","2",""' '"4","","6"' '"","8","9"' '')).
	self
		assert: (String streamContents: [ :stream |
					(NeoCSVWriter on: stream)
						emptyFieldValue: #empty;
						nextPut: #(one two three);
						nextPutAll: #( (1 2 empty) (4 empty 6) (empty 8 9)) ])
		equals: (String crlfString join: #( '"one","two","three"' '"1","2",""' '"4","","6"' '"","8","9"' '')).
	self
		assert: (String streamContents: [ :stream |
					(NeoCSVWriter on: stream)
						emptyFieldValue: Object new;
						nextPut: #(one two three);
						nextPutAll: #( (1 2 nil) (4 nil 6) (nil 8 9)) ])
		equals: (String crlfString join: #( '"one","two","three"' '"1","2","nil"' '"4","nil","6"' '"nil","8","9"' ''))! !

!NeoCSVWriterTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:51:10'!
testNamedColumnsConfiguration
	self
		assert: (String streamContents: [ :stream |
					(NeoCSVWriter on: stream)
						namedColumnsConfiguration: #(x y z);
						nextPutAll: { 
							Dictionary newFromPairs: #(x 100 y 200 z 300).
							Dictionary newFromPairs: #(x 400 y 500 z 600). 
							Dictionary newFromPairs: #(x 700 y 800 z 900) } ])
		equals: (String crlfString join: #( '"x","y","z"' '"100","200","300"' '"400","500","600"' '"700","800","900"' ''))! !

!NeoCSVWriterTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:51:16'!
testObjectFieldsTestObjects
	self
		assert: (String streamContents: [ :stream |
					(NeoCSVWriter on: stream)
						nextPut: #(x y z);
						addObjectFields: #(x y z); 
						nextPutAll: { 
							NeoCSVTestObject example. 
							NeoCSVTestObject example. 
							NeoCSVTestObject example } ])
		equals: (String crlfString join: #( '"x","y","z"' '100,200,300' '100,200,300' '100,200,300' ''))! !

!NeoCSVWriterTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:51:23'!
testObjectFieldsTestObjectsExtra
	self
		assert: (String streamContents: [ :stream |
					(NeoCSVWriter on: stream)
						fieldWriter: #raw;
						nextPut: #(x empty y constant z);
						addObjectField: #x;
						addEmptyField;
						addObjectField: #y;
						addConstantField: 'X';
						addObjectField: #z; 
						nextPutAll: { 
							NeoCSVTestObject example. 
							NeoCSVTestObject example. 
							NeoCSVTestObject example } ])
		equals: (String crlfString join: #( 
					'x,empty,y,constant,z' 
					'100,,200,X,300' 
					'100,,200,X,300' 
					'100,,200,X,300' ''))! !

!NeoCSVWriterTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:51:28'!
testObjectFieldsTestObjectsUsingBlockAccessors
	self
		assert: (String streamContents: [ :stream |
					(NeoCSVWriter on: stream)
						nextPut: #(x y z);
						addObjectFields: { 
							[ :object | object x ].
							[ :object | object y ].
							[ :object | object z ] }; 
						nextPutAll: { 
							NeoCSVTestObject example. 
							NeoCSVTestObject example. 
							NeoCSVTestObject example } ])
		equals: (String crlfString join: #( '"x","y","z"' '100,200,300' '100,200,300' '100,200,300' ''))! !

!NeoCSVWriterTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:51:32'!
testRawFieldsDictionaries
	self
		assert: (String streamContents: [ :stream |
					(NeoCSVWriter on: stream)
						nextPut: #(x y z);
						addRawFieldsAt: #(x y z); 
						nextPutAll: { 
							Dictionary newFromPairs: #(x 100 y 200 z 300).
							Dictionary newFromPairs: #(x 400 y 500 z 600). 
							Dictionary newFromPairs: #(x 700 y 800 z 900) } ])
		equals: (String crlfString join: #( '"x","y","z"' '100,200,300' '400,500,600' '700,800,900' ''))! !

!NeoCSVWriterTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:51:37'!
testRawFieldsTestObjects
	self
		assert: (String streamContents: [ :stream |
					(NeoCSVWriter on: stream)
						nextPut: #(x y z);
						addRawFields: #(x y z); 
						nextPutAll: { 
							NeoCSVTestObject example. 
							NeoCSVTestObject example. 
							NeoCSVTestObject example } ])
		equals: (String crlfString join: #( '"x","y","z"' '100,200,300' '100,200,300' '100,200,300' ''))! !

!NeoCSVWriterTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:51:41'!
testSimple
	self
		assert: (String streamContents: [ :stream |
					(NeoCSVWriter on: stream)
						nextPut: #(one two three);
						nextPutAll: #( (1 2 3) (4 5 6) (7 8 9)) ])
		equals: (String crlfString join: #( '"one","two","three"' '"1","2","3"' '"4","5","6"' '"7","8","9"' ''))! !

!NeoCSVWriterTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:51:46'!
testSimpleRaw
	self
		assert: (String streamContents: [ :stream |
					(NeoCSVWriter on: stream)
						fieldWriter: #raw;
						nextPut: #(one two three);
						nextPutAll: #( (1 2 3) (4 5 6) (7 8 9)) ])
		equals: (String crlfString join: #( 'one,two,three' '1,2,3' '4,5,6' '7,8,9' ''))! !

!NeoCSVWriterTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:51:54'!
testWriteEmbeddedQuote
	| header |
	header := String streamContents: [ :out |
		(NeoCSVWriter on: out)
			nextPut: #(foo 'x"y"z') ].
	self assert: header equals: '"foo","x""y""z"', String crlfString ! !

!NeoCSVWriterTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:52:02'!
testWriteHeader
	| header |
	header := String streamContents: [ :out |
		(NeoCSVWriter on: out)
			writeHeader: #(foo bar) ].
	self assert: header equals: '"foo","bar"', String crlfString ! !

!NeoNumberParserTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 12/2/2012 17:02'!
testBinaryIntegers
	self assert: (NeoNumberParser parse: '1111011' base: 2) equals: 123.
	self assert: (NeoNumberParser parse: '-1111011' base: 2) equals: -123.
	self assert: (NeoNumberParser parse: '0' base: 2) equals: 0.

! !

!NeoNumberParserTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 12/2/2012 17:03'!
testDecimalIntegers
	self assert: (NeoNumberParser parse: '123') equals: 123.
	self assert: (NeoNumberParser parse: '-123') equals: -123.
	self assert: (NeoNumberParser parse: '0') equals: 0.
	self assert: (NeoNumberParser parse: '12345678901234567890') equals: 12345678901234567890.
		
	self assert: (NeoNumberParser parse: '00123ABC') equals: 123.
	self assert: (NeoNumberParser parse: '-0') equals: 0.
! !

!NeoNumberParserTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 12/2/2012 17:42'!
testErrors
	self should: [ NeoNumberParser parse: nil ] raise: Error.
	self should: [ NeoNumberParser parse: '' ] raise: Error.
	self should: [ NeoNumberParser parse: '.5' ] raise: Error.! !

!NeoNumberParserTests methodsFor: 'testing' stamp: 'hlsf 6/28/2024 11:55:26'!
testFloats
	#('1.5' 1.5 '-1.5' -1.5 '0.0' 0.0 '3.14159' 3.14159 '1e3' 1000.0 '1e-2' 0.01)
		pairsDo: [ :string :float | 
			self assert: (((NeoNumberParser parse: string) - float)) abs < 1e-10 ]! !

!NeoNumberParserTests methodsFor: 'testing' stamp: 'hjh 5/14/2015 20:06'!
testHexadecimalIntegers
	self assert: (NeoNumberParser parse: '7B' base: 16) equals: 123.
	"self assert: (NeoNumberParser parse: '7b' base: 16) equals: 123."
	self assert: (NeoNumberParser parse: '-7B' base: 16) equals: -123.
	"self assert: (NeoNumberParser parse: '-7b' base: 16) equals: -123."
	self assert: (NeoNumberParser parse: '0' base: 16) equals: 0.

! !

!NeoNumberParserTests methodsFor: 'testing' stamp: 'SvenVanCaekenberghe 12/2/2012 17:02'!
testOctalIntegers
	self assert: (NeoNumberParser parse: '173' base: 8) equals: 123.
	self assert: (NeoNumberParser parse: '-173' base: 8) equals: -123.
	self assert: (NeoNumberParser parse: '0' base: 8) equals: 0.

! !

!NeoCSVTestObject methodsFor: 'comparing' stamp: 'SvenVanCaekenberghe 6/16/2012 18:58'!
= anObject
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ x = anObject x
		and: [
			y = anObject y
				and: [
					z = anObject z ] ]! !

!NeoCSVTestObject methodsFor: 'comparing' stamp: 'SvenVanCaekenberghe 6/16/2012 18:58'!
hash
	^ x hash bitXor: (y hash bitXor: z)! !

!NeoCSVTestObject methodsFor: 'accessing' stamp: 'SvenVanCaekenberghe 6/15/2012 22:40'!
x
	^ x! !

!NeoCSVTestObject methodsFor: 'accessing' stamp: 'SvenVanCaekenberghe 6/15/2012 22:40'!
x: anObject
	x := anObject! !

!NeoCSVTestObject methodsFor: 'accessing' stamp: 'SvenVanCaekenberghe 6/15/2012 22:40'!
y
	^ y! !

!NeoCSVTestObject methodsFor: 'accessing' stamp: 'SvenVanCaekenberghe 6/15/2012 22:40'!
y: anObject
	y := anObject! !

!NeoCSVTestObject methodsFor: 'accessing' stamp: 'SvenVanCaekenberghe 6/15/2012 22:40'!
z
	^ z! !

!NeoCSVTestObject methodsFor: 'accessing' stamp: 'SvenVanCaekenberghe 6/15/2012 22:40'!
z: anObject
	z := anObject! !

!NeoCSVTestObject class methodsFor: 'instance creation' stamp: 'SvenVanCaekenberghe 11/4/2012 19:40'!
example
	^ self x: 100 y: 200 z: 300! !

!NeoCSVTestObject class methodsFor: 'instance creation' stamp: 'SvenVanCaekenberghe 11/4/2012 19:39'!
x: x y: y z: z
	^ self new
		x: x;
		y: y;
		z: z;
		yourself! !
