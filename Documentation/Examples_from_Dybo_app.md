The examples are taken from ``Dynabook.pck.st`` (https://github.com/Dynamic-Book/DyboApp)

## Domain classes 
The three classes given below have  #importFrom: and export:to: methods. They use streams with CSV data.

````Smalltalk
Object subclass: #DyPerson
	instanceVariableNames: 'lastName firstName email'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Dynabook-Model-Business'
````

````Smalltalk
Object subclass: #DyDayInterval
	instanceVariableNames: 'start end'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Dynabook-Model-Business'
````


````Smalltalk
Magnitude subclass: #DyTimeSlot
	instanceVariableNames: 'name startTime endTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Dynabook-Model-Business'
````




## CSV reading examples 

````Smalltalk
DyPerson class>> importFrom: readStream 
"Import person from a CSV file"
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



````Smalltalk
DyTimeSlot class>> importFrom: readStream
"Import time slots from a CSV file with header:
timeSlotName,start, end "
| reader |
	reader := NeoCSVReader on: readStream.
	reader readHeader = #('slotName' 'start' 'end')
		ifFalse: [self error: 'Headers should be slotName, start, end'].
	reader 
		recordClass: self;
		addField: #slotName:;
		addField: #start: converter: [:s | Time fromString: s];
		addField: #end: converter: [:s | Time fromString: s].
	^ reader upToEnd asSortedCollection 
````




## CSV writing examples 

````Smalltalk

DyPerson class>> export: persons to: writeStream
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


````Smalltalk
DyTimeSlot class>> export: timeSlots to: writeStream
	| writer |
	writer := NeoCSVWriter on: writeStream.
	writer writeHeader: #(slotName start end);
		addFields: #(slotName start end);
		nextPutAll: timeSlots

````
