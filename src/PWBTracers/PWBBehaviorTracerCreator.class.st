Class {
	#name : #PWBBehaviorTracerCreator,
	#superclass : #Object,
	#instVars : [
		'focus',
		'name',
		'tracer'
	],
	#category : #PWBTracers
}

{ #category : #'as yet unclassified' }
PWBBehaviorTracerCreator class >> tracerFor: aFamixPWBBehavior [
	^ self new
		focus: aFamixPWBBehavior;
		createTracer;
		tracer
]

{ #category : #api }
PWBBehaviorTracerCreator >> createTracer [
		tracer := PWBBehaviorTracer new
		focus: focus;
		position: focus signature sourceAnchor endPos + 1;
		yourself
]

{ #category : #accessing }
PWBBehaviorTracerCreator >> focus: aFamixPWBBehavior [
	focus := aFamixPWBBehavior
]

{ #category : #accessing }
PWBBehaviorTracerCreator >> name [
	name ifNil: [ name := focus name ].
	^ name
]

{ #category : #printing }
PWBBehaviorTracerCreator >> printOn: aStrem [
	^ aStrem
		<< self name;
		space
]

{ #category : #accessing }
PWBBehaviorTracerCreator >> tracer [
	^ tracer
]

{ #category : #accessing }
PWBBehaviorTracerCreator >> tracer: anObject [
	tracer := anObject
]
