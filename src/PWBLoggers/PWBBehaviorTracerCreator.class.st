Class {
	#name : #PWBBehaviorTracerCreator,
	#superclass : #Object,
	#instVars : [
		'focus',
		'logger',
		'name'
	],
	#category : #PWBLoggers
}

{ #category : #'as yet unclassified' }
PWBBehaviorTracerCreator class >> loggerFor: aFamixPWBBehavior [
	^ self new
		focus: aFamixPWBBehavior;
		createLogger;
		logger
]

{ #category : #api }
PWBBehaviorTracerCreator >> createLogger [
		logger := PWBBehaviorTracer new
		focus: focus;
		position: focus signature sourceAnchor endPos + 1;
		yourself
]

{ #category : #accessing }
PWBBehaviorTracerCreator >> focus: aFamixPWBBehavior [
	focus := aFamixPWBBehavior
]

{ #category : #accessing }
PWBBehaviorTracerCreator >> logger [
	^ logger
]

{ #category : #accessing }
PWBBehaviorTracerCreator >> logger: anObject [
	logger := anObject
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
