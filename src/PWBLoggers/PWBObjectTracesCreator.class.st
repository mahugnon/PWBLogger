Class {
	#name : #PWBObjectTracesCreator,
	#superclass : #Object,
	#instVars : [
		'focus',
		'loggers',
		'completeSourceWithLogs',
		'logAccess',
		'name',
		'constraints'
	],
	#category : #PWBLoggers
}

{ #category : #'as yet unclassified' }
PWBObjectTracesCreator class >> loggersFor: aFamixPWBmajorObject [
	^ self new
		focus: aFamixPWBmajorObject;
		createLoggers;
		yourself
]

{ #category : #adding }
PWBObjectTracesCreator >> addConstraint: aConstraint [
	constraints add: aConstraint.
	aConstraint logsCreator: self
]

{ #category : #accessing }
PWBObjectTracesCreator >> completeSourceWithLogs [
	^ completeSourceWithLogs
]

{ #category : #accessing }
PWBObjectTracesCreator >> constraint [
	^ constraints
]

{ #category : #api }
PWBObjectTracesCreator >> createLoggers [
	loggers := (self focusBehaviors
		collect: [ :each | PWBBehaviorTracerCreator loggerFor: each ])
		groupedBy: #position
]

{ #category : #accessing }
PWBObjectTracesCreator >> focus [
	^ focus
]

{ #category : #accessing }
PWBObjectTracesCreator >> focus: aFamixPWBmajorObject [
	focus := aFamixPWBmajorObject
]

{ #category : #api }
PWBObjectTracesCreator >> focusBehaviors [
	^ (focus methods
		select:
			[ :each | each class = FamixPWBFunction or: [ each class = FamixPWBSubRoutine ] ])
		asSet
]

{ #category : #initialization }
PWBObjectTracesCreator >> initialize [
	super initialize.
	constraints := OrderedCollection new
]

{ #category : #accessors }
PWBObjectTracesCreator >> loggers [
	^ loggers
]

{ #category : #accessing }
PWBObjectTracesCreator >> loggers: aCollection [ 
	loggers := aCollection
]

{ #category : #accessing }
PWBObjectTracesCreator >> name [
	name ifNil: [ name := focus name ].
	^ name
]

{ #category : #api }
PWBObjectTracesCreator >> prepareLogs [
	| originalSource |
	originalSource := focus sourceAnchor completeText.
	completeSourceWithLogs := String
		streamContents: [ :stream | 
			| start |
			start := 1.
			(loggers keys sort: [ :a :b | a < b ])
				do: [ :key | 
					stream
						<< (originalSource copyFrom: start to: key - 1);
						tab.
					(loggers at: key) do: [ :value | value logOn: stream ].
					start := key ].
			stream << (originalSource copyFrom: start to: originalSource size) ]
]

{ #category : #printing }
PWBObjectTracesCreator >> printOn: aStrem [
	^ aStrem
		<< self name;
		space;
		<< '(';
		<< loggers size asString;
		<< ')'
]

{ #category : #actions }
PWBObjectTracesCreator >> save [
	| focusFile utf8bomHeader |
	self prepareLogs.
	utf8bomHeader := #[16rEF 16rBB 16rBF].
	focusFile := focus sourceAnchor fileReference.
	focusFile
		ensureDelete;
		binaryWriteStreamDo: [ :s | s nextPutAll: utf8bomHeader ].
	focusFile := focusFile
		writeStreamDo: [ :stream | 
			stream setToEnd.
			stream << completeSourceWithLogs ]
]
