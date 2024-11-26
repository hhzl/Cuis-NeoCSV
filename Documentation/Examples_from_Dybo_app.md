The examples are taken from ``Dynabook.pck.st`` (https://github.com/Dynamic-Book/DyboApp)

## CSV reading examples 

````Smalltalk
DyStudent class>> importFrom: readStream 
"Import student from a CSV file"
| reader |
    reader := NeoCSVReader on: readStream.
    reader readHeader = #('firstName' 'lastName' 'email')
        ifFalse: [self error: 'Headers should be firstName, lastName, email'].
    reader
        recordClass: self;
        addFields: #(firstName: lastName: email:).
    ^ reader upToEnd asSortedCollection
````


````Smalltalk
DyDayInterval class>> importFrom: readStream
"Import days off from a CSV file with header: start, end "
| reader |
    reader := NeoCSVReader on: readStream.
    reader readHeader = #('start' 'end')
        ifFalse: [self error: 'Headers should be start, end'].
    reader
        recordClass: self;
        addField: #start: converter: [:d | Date fromString: d];
        addField: #end: converter: [:d | Date fromString: d].
    ^ reader upToEnd asSortedCollection
````


## CSV writing examples 

````Smalltalk

DyStudent class>> export: persons to: writeStream
	| writer |
	writer := NeoCSVWriter on: writeStream.
	writer writeHeader: #(firstName lastName email);
		addFields: #(firstName lastName email);
		nextPutAll: persons 
````




````Smalltalk
DyDayInterval class>>export: daysOff to: writeStream
	| writer |
	writer := NeoCSVWriter on: writeStream.
	writer writeHeader: #(start end);
		addFields: #(start end);
		nextPutAll: daysOff 
````