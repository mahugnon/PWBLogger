Class {
	#name : #PWBObjectTracesCreator,
	#superclass : #Object,
	#instVars : [
		'focus',
		'completeSourceWithLogs',
		'name',
		'constraints',
		'tracers'
	],
	#category : #PWBLoggers
}

{ #category : #'as yet unclassified' }
PWBObjectTracesCreator class >> tracersFor: aFamixPWBmajorObject [
	^ self new
		focus: aFamixPWBmajorObject;
		createTracers;
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
PWBObjectTracesCreator >> createTracers [
	tracers := (self focusBehaviors
		collect: [ :each | PWBBehaviorTracerCreator tracerFor: each ])
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

{ #category : #accessing }
PWBObjectTracesCreator >> name [
	name ifNil: [ name := focus name ].
	^ name
]

{ #category : #api }
PWBObjectTracesCreator >> prepareTraces [
	| originalSource |
	originalSource := focus sourceAnchor completeText.
	completeSourceWithLogs := String
		streamContents: [ :stream | 
			| start |
			start := 1.
			(tracers keys sort: [ :a :b | a < b ])
				do: [ :key | 
					stream
						<< (originalSource copyFrom: start to: key - 1);
						tab.
					(tracers at: key) do: [ :value | value traceOn: stream ].
					start := key ].
			stream << (originalSource copyFrom: start to: originalSource size) ]
]

{ #category : #printing }
PWBObjectTracesCreator >> printOn: aStrem [
	^ aStrem
		<< self name;
		space;
		<< '(';
		<< tracers size asString;
		<< ')'
]

{ #category : #actions }
PWBObjectTracesCreator >> save [
	| focusFile utf8bomHeader |
	self prepareTraces.
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

{ #category : #accessors }
PWBObjectTracesCreator >> tracers [
	^ tracers
]

{ #category : #accessing }
PWBObjectTracesCreator >> tracers: aCollection [ 
	tracers := aCollection
]
