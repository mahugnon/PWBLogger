Class {
	#name : #PWBBehaviorLoggerCreator,
	#superclass : #Object,
	#instVars : [
		'focus',
		'logger',
		'name'
	],
	#category : #PWBLoggers
}

{ #category : #'as yet unclassified' }
PWBBehaviorLoggerCreator class >> loggerFor: aFamixPWBBehavior [
	^ self new
		focus: aFamixPWBBehavior;
		createLogger;
		logger
]

{ #category : #api }
PWBBehaviorLoggerCreator >> createLogger [
		logger := PWBBehaviorLogger new
		focus: focus;
		position: focus signature sourceAnchor endPos + 1;
		yourself
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> focus: aFamixPWBBehavior [
	focus := aFamixPWBBehavior
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> logger [
	^ logger
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> logger: anObject [
	logger := anObject
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> name [
	name ifNil: [ name := focus name ].
	^ name
]

{ #category : #printing }
PWBBehaviorLoggerCreator >> printOn: aStrem [
	^ aStrem
		<< self name;
		space
]
