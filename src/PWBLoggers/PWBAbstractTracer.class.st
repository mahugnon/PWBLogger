Class {
	#name : #PWBAbstractTracer,
	#superclass : #Object,
	#instVars : [
		'position',
		'tag',
		'focus'
	],
	#category : #PWBLoggers
}

{ #category : #'as yet unclassified' }
PWBAbstractTracer class >> canlog: anObject [
	^ false
]

{ #category : #'as yet unclassified' }
PWBAbstractTracer class >> canlog: anObject withTag: aTag [
	^ false
]

{ #category : #'as yet unclassified' }
PWBAbstractTracer class >> loggerFor: anObject tag: aTag [
	^ (self subclasses
		detect: [ :sub | sub canlog: anObject withTag: aTag ]
		ifNone: [ NotFound signal: 'Logger not found ... ' ]) new
		focus: anObject;
		tag: aTag;
		yourself
]

{ #category : #accessing }
PWBAbstractTracer >> belongsTo [
self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PWBAbstractTracer >> endOn: stream [
	stream
		<< '");';
		tab
]

{ #category : #accessors }
PWBAbstractTracer >> focus [
	^ focus
]

{ #category : #accessing }
PWBAbstractTracer >> focus: aFamixPWBParameter [
	focus := aFamixPWBParameter.

]

{ #category : #testing }
PWBAbstractTracer >> isAccessLogger [
	^ false
]

{ #category : #testing }
PWBAbstractTracer >> isEmptyLogger [
	^ false
]

{ #category : #testing }
PWBAbstractTracer >> isParameterLogger [
	^ false
]

{ #category : #testing }
PWBAbstractTracer >> isReturnLogger [
	^ false
]

{ #category : #'as yet unclassified' }
PWBAbstractTracer >> logOn: aStream [ 
self subclassResponsibility 
]

{ #category : #accessors }
PWBAbstractTracer >> position [
	^ position
]

{ #category : #accessor }
PWBAbstractTracer >> position: anInteger [ 
	position := anInteger
]

{ #category : #accessors }
PWBAbstractTracer >> tag [
	^ tag
]

{ #category : #accessing }
PWBAbstractTracer >> tag: aString [ 
	tag := aString
]
