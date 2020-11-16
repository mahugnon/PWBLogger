Class {
	#name : #PWBObjectLogsCreator,
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
PWBObjectLogsCreator class >> loggersFor: aFamixPWBmajorObject [
	^ self new
		focus: aFamixPWBmajorObject;
		createLoggers;
		yourself
]

{ #category : #adding }
PWBObjectLogsCreator >> addConstraint: aConstraint [
	constraints add: aConstraint.
	aConstraint logsCreator: self
]

{ #category : #accessing }
PWBObjectLogsCreator >> completeSourceWithLogs [
	^ completeSourceWithLogs
]

{ #category : #accessing }
PWBObjectLogsCreator >> constraint [
	^ constraints
]

{ #category : #api }
PWBObjectLogsCreator >> createLoggers [
	loggers := (self focusBehaviors
		collect: [ :each | PWBBehaviorLoggerCreator loggerFor: each ])
		groupedBy: #position
]

{ #category : #accessing }
PWBObjectLogsCreator >> focus [
	^ focus
]

{ #category : #accessing }
PWBObjectLogsCreator >> focus: aFamixPWBmajorObject [
	focus := aFamixPWBmajorObject
]

{ #category : #api }
PWBObjectLogsCreator >> focusBehaviors [
	^ (focus methods
		select:
			[ :each | each class = FamixPWBFunction or: [ each class = FamixPWBSubRoutine ] ])
		asSet
]

{ #category : #initialization }
PWBObjectLogsCreator >> initialize [
	super initialize.
	constraints := OrderedCollection new
]

{ #category : #accessors }
PWBObjectLogsCreator >> loggers [
	^ loggers
]

{ #category : #accessing }
PWBObjectLogsCreator >> loggers: aCollection [ 
	loggers := aCollection
]

{ #category : #accessing }
PWBObjectLogsCreator >> name [
	name ifNil: [ name := focus name ].
	^ name
]

{ #category : #api }
PWBObjectLogsCreator >> prepareLogs [
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
PWBObjectLogsCreator >> printOn: aStrem [
	^ aStrem
		<< self name;
		space;
		<< '(';
		<< loggers size asString;
		<< ')'
]

{ #category : #actions }
PWBObjectLogsCreator >> save [
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
