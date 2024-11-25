## CSV reading Examples 
taken from ``Dynabook.pck.st`` (https://github.com/Dynamic-Book/DyboApp)


````
DyStudent importFrom: readStream 
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


````
DyDayInterval importFrom: readStream
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




