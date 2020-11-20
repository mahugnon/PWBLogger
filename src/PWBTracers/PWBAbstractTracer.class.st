Class {
	#name : #PWBAbstractTracer,
	#superclass : #Object,
	#instVars : [
		'position',
		'tag',
		'focus'
	],
	#category : #PWBTracers
}

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

{ #category : #'as yet unclassified' }
PWBAbstractTracer >> traceOn: aStream [ 
self subclassResponsibility 
]
