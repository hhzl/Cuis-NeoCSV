'From Cuis 4.2 of 25 July 2013 [latest update: #2243] on 9 May 2015 at 2:30:33.261404 pm'!
'Description Please enter a description for this package'!
!provides: 'Neo-CSV-Tests' 1 0!
!classDefinition: #NeoCSVTestObject category: #'Neo-CSV-Tests'!
Object subclass: #NeoCSVTestObject
	instanceVariableNames: 'x y z'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Neo-CSV-Tests'!
!classDefinition: 'NeoCSVTestObject class' category: #'Neo-CSV-Tests'!
NeoCSVTestObject class
	instanceVariableNames: ''!

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


!NeoCSVTestObject methodsFor: 'comparing'!
= arg1
	self == arg1 ifTrue: [ ^ true ].
	self class = arg1 class ifFalse: [ ^ false ].
	^ x = arg1 x and: [
		y = arg1 y and: [ z = arg1 z ]].! !

!NeoCSVTestObject methodsFor: 'comparing'!
hash
	^ x hash bitXor: (y hash bitXor: z).! !

!NeoCSVTestObject methodsFor: 'accessing'!
x
	^ x.! !

!NeoCSVTestObject methodsFor: 'accessing'!
x: arg1
	x _ arg1.! !

!NeoCSVTestObject methodsFor: 'accessing'!
y
	^ y.! !

!NeoCSVTestObject methodsFor: 'accessing'!
y: arg1
	y _ arg1.! !

!NeoCSVTestObject methodsFor: 'accessing'!
z
	^ z.! !

!NeoCSVTestObject methodsFor: 'accessing'!
z: arg1
	z _ arg1.! !

!NeoCSVTestObject class methodsFor: 'instance creation'!
example
	^ self
		x: 100
		y: 200
		z: 300.! !

!NeoCSVTestObject class methodsFor: 'instance creation'!
x: arg1 y: arg2 z: arg3
	^ self new
		x: arg1;
		y: arg2;
		z: arg3;
		yourself.! !

!NeoCSVReaderTests methodsFor: 'testing'!
testEmbeddedQuotes
	self
		assert: (NeoCSVReader on: '1,"x""y""z",3' readStream) upToEnd
		equals: #(#('1' 'x"y"z' '3') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testEmptyConversions
	| temp1 |
	temp1 _ String crlfString join: #('1,2.5,foo' ',,' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				addIntegerField;
				addFloatField;
				addField;
				upToEnd)
		equals: {#(1 2.5 'foo' ). #(nil nil nil )}.! !

!NeoCSVReaderTests methodsFor: 'testing'!
testEmptyConversionsTestObject
	| temp1 |
	temp1 _ String crlfString join: #('1,2.5,foo' ',,' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				recordClass: NeoCSVTestObject;
				addIntegerField: #x:;
				addFloatField: #y:;
				addField: #z:;
				upToEnd)
		equals: {NeoCSVTestObject
				x: 1
				y: 2.5
				z: 'foo'. NeoCSVTestObject new}.! !

!NeoCSVReaderTests methodsFor: 'testing'!
testEmptyFieldQuoted
	self
		assert: (NeoCSVReader on: '"1",,"3"' readStream) upToEnd
		equals: #(#('1' nil '3') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testEmptyFieldSecondRecordQuoted
	self
		assert: (NeoCSVReader on: '"foo","bar"\"100",' withCRs readStream) upToEnd
		equals: #(#('foo' 'bar') #('100' nil) ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testEmptyFieldSecondRecordUnquoted
	self
		assert: (NeoCSVReader on: 'foo,bar\100,' withCRs readStream) upToEnd
		equals: #(#('foo' 'bar') #('100' nil) ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testEmptyFieldUnquoted
	self
		assert: (NeoCSVReader on: '1,,3' readStream) upToEnd
		equals: #(#('1' nil '3') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testEmptyFieldValue
	self
		assert:
			((NeoCSVReader on: '"1",,3,"","5"' readStream)
				emptyFieldValue: #empty;
				upToEnd)
		equals: #(#('1' #empty '3' #empty '5') ).
	self
		assert:
			((NeoCSVReader on: '"1",,3,"","5"' readStream)
				emptyFieldValue: '';
				upToEnd)
		equals: #(#('1' '' '3' '' '5') ).
	self
		assert:
			((NeoCSVReader on: 'a,b,c\,,\"","",""\1,2,3\' withCRs readStream)
				emptyFieldValue: #empty;
				upToEnd)
		equals: #(#('a' 'b' 'c') #(#empty #empty #empty) #(#empty #empty #empty) #('1' '2' '3') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testEmptyLastFieldQuoted
	self
		assert: (NeoCSVReader on: '"1","2",""' readStream) upToEnd
		equals: #(#('1' '2' nil) ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testEmptyLastFieldUnquoted
	self
		assert: (NeoCSVReader on: '1,2,' readStream) upToEnd
		equals: #(#('1' '2' nil) ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testOneLineEmpty
	self
		assert: (NeoCSVReader on: '' readStream) upToEnd
		equals: #().! !

!NeoCSVReaderTests methodsFor: 'testing'!
testOneLineOneFieldQuoted
	self
		assert: (NeoCSVReader on: '"1"' readStream) upToEnd
		equals: #(#('1') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testOneLineOneFieldUnquoted
	self
		assert: (NeoCSVReader on: '1' readStream) upToEnd
		equals: #(#('1') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testOneLineQuoted
	self
		assert: (NeoCSVReader on: '"1","2","3"' readStream) upToEnd
		equals: #(#('1' '2' '3') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testOneLineUnquoted
	self
		assert: (NeoCSVReader on: '1,2,3' readStream) upToEnd
		equals: #(#('1' '2' '3') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testReadAsByteArrays
	| temp1 |
	temp1 _ String crlfString join: #('1,2,3' '1,2,3' '1,2,3' '' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				recordClass: ByteArray;
				addIntegerField;
				addIntegerField;
				addIntegerField;
				upToEnd)
		equals: {#[1 2 3]. #[1 2 3]. #[1 2 3]}.! !

!NeoCSVReaderTests methodsFor: 'testing'!
testReadAsIntegerArrays
	| temp1 |
	temp1 _ String crlfString join: #('100,200,300' '100,200,300' '100,200,300' '' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				recordClass: IntegerArray;
				addIntegerField;
				addIntegerField;
				addIntegerField;
				upToEnd)
		equals: {#(100 200 300 ) asIntegerArray. #(100 200 300 ) asIntegerArray. #(100 200 300 ) asIntegerArray}.! !

!NeoCSVReaderTests methodsFor: 'testing'!
testReadDictionaries
	| temp1 |
	temp1 _ String crlfString join: #('"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				skipHeader;
				recordClass: Dictionary;
				addIntegerFieldAt: #x;
				addIntegerFieldAt: #y;
				addIntegerFieldAt: #z;
				upToEnd)
		equals: {Dictionary newFromPairs: #(#x 100 #y 200 #z 300 ). Dictionary newFromPairs: #(#x 100 #y 200 #z 300 ). Dictionary newFromPairs: #(#x 100 #y 200 #z 300 )}.! !

!NeoCSVReaderTests methodsFor: 'testing'!
testReadHeader
	| temp1 |
	temp1 _ String crlfString join: #('"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '' ).
	self
		assert: (NeoCSVReader on: temp1 readStream) readHeader
		equals: #('x' 'y' 'z' ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testReadIntegers
	| temp1 |
	temp1 _ String crlfString join: #('"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				skipHeader;
				addIntegerField;
				addIntegerField;
				addIntegerField;
				upToEnd)
		equals: #(#(100 200 300) #(100 200 300) #(100 200 300) ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testReadIntegersReadingHeaderAfterFieldDefinitions
	| temp1 |
	temp1 _ String crlfString join: #('"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				addIntegerField;
				addIntegerField;
				addIntegerField;
				skipHeader;
				upToEnd)
		equals: #(#(100 200 300) #(100 200 300) #(100 200 300) ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testReadTestsObjects
	| temp1 |
	temp1 _ String crlfString join: #('"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				skipHeader;
				recordClass: NeoCSVTestObject;
				addIntegerField: #x:;
				addIntegerField: #y:;
				addIntegerField: #z:;
				upToEnd)
		equals: {NeoCSVTestObject example. NeoCSVTestObject example. NeoCSVTestObject example}.! !

!NeoCSVReaderTests methodsFor: 'testing'!
testReadTestsObjectsUsingBlockAccessors
	| temp1 |
	temp1 _ String crlfString join: #('"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				skipHeader;
				recordClass: NeoCSVTestObject;
				addIntegerField: [ :arg2 :arg3 |
					arg2 x: arg3 ];
				addIntegerField: [ :arg2 :arg3 |
					arg2 y: arg3 ];
				addIntegerField: [ :arg2 :arg3 |
					arg2 z: arg3 ];
				upToEnd)
		equals: {NeoCSVTestObject example. NeoCSVTestObject example. NeoCSVTestObject example}.! !

!NeoCSVReaderTests methodsFor: 'testing'!
testReadTestsObjectsWithIgnoredField
	| temp1 |
	temp1 _ String crlfString join: #('"x","y",''-'',"z"' '100,200,a,300' '100,200,b,300' '100,200,c,300' '' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				skipHeader;
				recordClass: NeoCSVTestObject;
				addIntegerField: #x:;
				addIntegerField: #y:;
				addIgnoredField;
				addIntegerField: #z:;
				upToEnd)
		equals: {NeoCSVTestObject example. NeoCSVTestObject example. NeoCSVTestObject example}.! !

!NeoCSVReaderTests methodsFor: 'testing'!
testReadWithIgnoredField
	| temp1 |
	temp1 _ String crlfString join: #('1,2,a,3' '1,2,b,3' '1,2,c,3' '' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				addIntegerField;
				addIntegerField;
				addIgnoredField;
				addIntegerField;
				upToEnd)
		equals: {#(1 2 3 ). #(1 2 3 ). #(1 2 3 )}.! !

!NeoCSVReaderTests methodsFor: 'testing'!
testSimpleCrLfQuoted
	| temp1 |
	temp1 _ String crlfString join: #('"1","2","3"' '"4","5","6"' '"7","8","9"' '' ).
	self
		assert: (NeoCSVReader on: temp1 readStream) upToEnd
		equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testSimpleCrLfUnquoted
	| temp1 |
	temp1 _ String crlfString join: #('1,2,3' '4,5,6' '7,8,9' '' ).
	self
		assert: (NeoCSVReader on: temp1 readStream) upToEnd
		equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testSimpleCrQuoted
	| temp1 |
	temp1 _ String crString join: #('"1","2","3"' '"4","5","6"' '"7","8","9"' '' ).
	self
		assert: (NeoCSVReader on: temp1 readStream) upToEnd
		equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testSimpleCrUnquoted
	| temp1 |
	temp1 _ String crString join: #('1,2,3' '4,5,6' '7,8,9' '' ).
	self
		assert: (NeoCSVReader on: temp1 readStream) upToEnd
		equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testSimpleLfQuoted
	| temp1 |
	temp1 _ String lfString join: #('"1","2","3"' '"4","5","6"' '"7","8","9"' '' ).
	self
		assert: (NeoCSVReader on: temp1 readStream) upToEnd
		equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testSimpleLfUnquoted
	| temp1 |
	temp1 _ String lfString join: #('1,2,3' '4,5,6' '7,8,9' '' ).
	self
		assert: (NeoCSVReader on: temp1 readStream) upToEnd
		equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testSimpleSemiColonDelimited
	| temp1 |
	temp1 _ String crlfString join: #('1;2;3' '4;5;6' '7;8;9' '' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				separator: $;;
				upToEnd)
		equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testSimpleTabDelimited
	| temp1 |
	temp1 _ String crlfString join: #('1	2	3' '4	5	6' '7	8	9' '' ).
	self
		assert:
			((NeoCSVReader on: temp1 readStream)
				separator: Character tab;
				upToEnd)
		equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9') ).! !

!NeoCSVReaderTests methodsFor: 'testing'!
testSkippingEmptyRecords
	| temp1 temp2 |
	temp1 _ '1,2,3\\4,5,6\,,\7,8,9' withCRs.
	temp2 _ (NeoCSVReader on: temp1 readStream) select: [ :arg3 |
		arg3 notEmpty and: [ (arg3 allSatisfy: #isNil) not ]].
	self
		assert: temp2
		equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9') ).
	temp2 _ (NeoCSVReader on: temp1 readStream)
		emptyFieldValue: '';
		select: [ :arg3 |
			arg3 notEmpty and: [ (arg3 allSatisfy: #isEmpty) not ]].
	self
		assert: temp2
		equals: #(#('1' '2' '3') #('4' '5' '6') #('7' '8' '9') ).! !

!NeoCSVWriterTests methodsFor: 'testing'!
testEmptyFieldValue
	self
		assert:
			(String streamContents: [ :arg1 |
				(NeoCSVWriter on: arg1)
					nextPut: #(#one #two #three );
					nextPutAll: #(#(1 2 nil) #(4 nil 6) #(nil 8 9) ) ])
		equals: (String crlfString join: #('"one","two","three"' '"1","2",""' '"4","","6"' '"","8","9"' '' )).
	self
		assert:
			(String streamContents: [ :arg1 |
				(NeoCSVWriter on: arg1)
					emptyFieldValue: #empty;
					nextPut: #(#one #two #three );
					nextPutAll: #(#(1 2 #empty) #(4 #empty 6) #(#empty 8 9) ) ])
		equals: (String crlfString join: #('"one","two","three"' '"1","2",""' '"4","","6"' '"","8","9"' '' )).
	self
		assert:
			(String streamContents: [ :arg1 |
				(NeoCSVWriter on: arg1)
					emptyFieldValue: Object new;
					nextPut: #(#one #two #three );
					nextPutAll: #(#(1 2 nil) #(4 nil 6) #(nil 8 9) ) ])
		equals: (String crlfString join: #('"one","two","three"' '"1","2","nil"' '"4","nil","6"' '"nil","8","9"' '' )).! !

!NeoCSVWriterTests methodsFor: 'testing'!
testObjectFieldsTestObjects
	self
		assert:
			(String streamContents: [ :arg1 |
				(NeoCSVWriter on: arg1)
					nextPut: #(#x #y #z );
					addObjectFields: #(#x #y #z );
					nextPutAll: {NeoCSVTestObject example. NeoCSVTestObject example. NeoCSVTestObject example} ])
		equals: (String crlfString join: #('"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '' )).! !

!NeoCSVWriterTests methodsFor: 'testing'!
testObjectFieldsTestObjectsExtra
	self
		assert:
			(String streamContents: [ :arg1 |
				(NeoCSVWriter on: arg1)
					fieldWriter: #raw;
					nextPut: #(#x #empty #y #constant #z );
					addObjectField: #x;
					addEmptyField;
					addObjectField: #y;
					addConstantField: 'X';
					addObjectField: #z;
					nextPutAll: {NeoCSVTestObject example. NeoCSVTestObject example. NeoCSVTestObject example} ])
		equals: (String crlfString join: #('x,empty,y,constant,z' '100,,200,X,300' '100,,200,X,300' '100,,200,X,300' '' )).! !

!NeoCSVWriterTests methodsFor: 'testing'!
testObjectFieldsTestObjectsUsingBlockAccessors
	self
		assert:
			(String streamContents: [ :arg1 |
				(NeoCSVWriter on: arg1)
					nextPut: #(#x #y #z );
					addObjectFields: {[ :arg2 |
						arg2 x ]. [ :arg2 |
						arg2 y ]. [ :arg2 |
						arg2 z ]};
					nextPutAll: {NeoCSVTestObject example. NeoCSVTestObject example. NeoCSVTestObject example} ])
		equals: (String crlfString join: #('"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '' )).! !

!NeoCSVWriterTests methodsFor: 'testing'!
testRawFieldsDictionaries
	self
		assert:
			(String streamContents: [ :arg1 |
				(NeoCSVWriter on: arg1)
					nextPut: #(#x #y #z );
					addRawFieldsAt: #(#x #y #z );
					nextPutAll: {Dictionary newFromPairs: #(#x 100 #y 200 #z 300 ). Dictionary newFromPairs: #(#x 400 #y 500 #z 600 ). Dictionary newFromPairs: #(#x 700 #y 800 #z 900 )} ])
		equals: (String crlfString join: #('"x","y","z"' '100,200,300' '400,500,600' '700,800,900' '' )).! !

!NeoCSVWriterTests methodsFor: 'testing'!
testRawFieldsTestObjects
	self
		assert:
			(String streamContents: [ :arg1 |
				(NeoCSVWriter on: arg1)
					nextPut: #(#x #y #z );
					addRawFields: #(#x #y #z );
					nextPutAll: {NeoCSVTestObject example. NeoCSVTestObject example. NeoCSVTestObject example} ])
		equals: (String crlfString join: #('"x","y","z"' '100,200,300' '100,200,300' '100,200,300' '' )).! !

!NeoCSVWriterTests methodsFor: 'testing'!
testSimple
	self
		assert:
			(String streamContents: [ :arg1 |
				(NeoCSVWriter on: arg1)
					nextPut: #(#one #two #three );
					nextPutAll: #(#(1 2 3) #(4 5 6) #(7 8 9) ) ])
		equals: (String crlfString join: #('"one","two","three"' '"1","2","3"' '"4","5","6"' '"7","8","9"' '' )).! !

!NeoCSVWriterTests methodsFor: 'testing'!
testSimpleRaw
	self
		assert:
			(String streamContents: [ :arg1 |
				(NeoCSVWriter on: arg1)
					fieldWriter: #raw;
					nextPut: #(#one #two #three );
					nextPutAll: #(#(1 2 3) #(4 5 6) #(7 8 9) ) ])
		equals: (String crlfString join: #('one,two,three' '1,2,3' '4,5,6' '7,8,9' '' )).! !

!NeoCSVWriterTests methodsFor: 'testing'!
testWriteEmbeddedQuote
	| temp1 |
	temp1 _ String streamContents: [ :arg2 |
		(NeoCSVWriter on: arg2) nextPut: #(#foo 'x"y"z' ) ].
	self
		assert: temp1
		equals: '"foo","x""y""z"' , String crlfString.! !

!NeoCSVWriterTests methodsFor: 'testing'!
testWriteHeader
	| temp1 |
	temp1 _ String streamContents: [ :arg2 |
		(NeoCSVWriter on: arg2) writeHeader: #(#foo #bar ) ].
	self
		assert: temp1
		equals: '"foo","bar"' , String crlfString.! !

!NeoNumberParserTests methodsFor: 'testing'!
testBinaryIntegers
	self
		assert:
			(NeoNumberParser
				parse: '1111011'
				base: 2)
		equals: 123.
	self
		assert:
			(NeoNumberParser
				parse: '-1111011'
				base: 2)
		equals: -123.
	self
		assert:
			(NeoNumberParser
				parse: '0'
				base: 2)
		equals: 0.! !

!NeoNumberParserTests methodsFor: 'testing'!
testDecimalIntegers
	self
		assert: (NeoNumberParser parse: '123')
		equals: 123.
	self
		assert: (NeoNumberParser parse: '-123')
		equals: -123.
	self
		assert: (NeoNumberParser parse: '0')
		equals: 0.
	self
		assert: (NeoNumberParser parse: '12345678901234567890')
		equals: 12345678901234567890.
	self
		assert: (NeoNumberParser parse: '00123ABC')
		equals: 123.
	self
		assert: (NeoNumberParser parse: '-0')
		equals: 0.! !

!NeoNumberParserTests methodsFor: 'testing'!
testErrors
	self
		should: [ NeoNumberParser parse: nil ]
		raise: Error.
	self
		should: [ NeoNumberParser parse: '' ]
		raise: Error.
	self
		should: [ NeoNumberParser parse: '.5' ]
		raise: Error.! !

!NeoNumberParserTests methodsFor: 'testing'!
testFloats
	#('1.5' 1.5 '-1.5' -1.5 '0.0' 0.0 '3.14159' 3.14159 '1e3' 1000.0 '1e-2' 0.01 ) pairsDo: [ :arg1 :arg2 |
		self assert: ((NeoNumberParser parse: arg1) closeTo: arg2) ].! !

!NeoNumberParserTests methodsFor: 'testing'!
testHexadecimalIntegers
	self
		assert:
			(NeoNumberParser
				parse: '7B'
				base: 16)
		equals: 123.
	self
		assert:
			(NeoNumberParser
				parse: '7b'
				base: 16)
		equals: 123.
	self
		assert:
			(NeoNumberParser
				parse: '-7B'
				base: 16)
		equals: -123.
	self
		assert:
			(NeoNumberParser
				parse: '-7b'
				base: 16)
		equals: -123.
	self
		assert:
			(NeoNumberParser
				parse: '0'
				base: 16)
		equals: 0.! !

!NeoNumberParserTests methodsFor: 'testing'!
testOctalIntegers
	self
		assert:
			(NeoNumberParser
				parse: '173'
				base: 8)
		equals: 123.
	self
		assert:
			(NeoNumberParser
				parse: '-173'
				base: 8)
		equals: -123.
	self
		assert:
			(NeoNumberParser
				parse: '0'
				base: 8)
		equals: 0.! !
