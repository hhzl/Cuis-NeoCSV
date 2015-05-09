'From Cuis 4.2 of 25 July 2013 [latest update: #2243] on 9 May 2015 at 7:17:46.231872 pm'!

!String methodsFor: 'copying' stamp: 'hjh 5/9/2015 16:32'!
join: aCollection 
	"'*' join: #('WWWWW' 'W  EW' 'zzzz')
		->  'WWWWW*W  EW*zzzz' "

	| w |		
	w := WriteStream on: String new.
	aCollection do: [ :elem | w nextPutAll: elem asString] separatedBy: [w nextPutAll: self].
	^String fromString: w contents! !

!String methodsFor: 'formatting' stamp: 'hjh 5/9/2015 17:03'!
withCRs
	"Return a copy of the receiver in which backslash (\) characters have been replaced with carriage returns."

	^ self collect: [ :c | c = $\ ifTrue: [ Character cr ] ifFalse: [ c ]].! !


!Symbol methodsFor: 'private' stamp: 'hjh 5/9/2015 17:37'!
value: anObject 
	^anObject perform: self.! !


!Character methodsFor: 'testing' stamp: 'hjh 5/9/2015 17:11'!
isCharacter

	^ true.! !

