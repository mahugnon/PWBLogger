Class {
	#name : #PWBBehaviorLoggerCreator,
	#superclass : #Object,
	#instVars : [
		'focus',
		'loggers',
		'logAccess',
		'name'
	],
	#category : #PWBLoggers
}

{ #category : #'as yet unclassified' }
PWBBehaviorLoggerCreator class >> loggersFor: aFamixPWBBehavior [
	^ self new
		focus: aFamixPWBBehavior;
		createLoggers;
		loggers
]

{ #category : #api }
PWBBehaviorLoggerCreator class >> loggersFor: aFamixPWBFunction accessOption: aBolean [
	^ aBolean
		ifTrue: [ self loggersWithAccessFor: aFamixPWBFunction ]
		ifFalse: [ self loggersWithoutAccessFor: aFamixPWBFunction ]
]

{ #category : #'as yet unclassified' }
PWBBehaviorLoggerCreator class >> loggersWithAccessFor: aFamixPWBBehavior [
	^ self new
		focus: aFamixPWBBehavior;
		createLoggers;
		loggers
]

{ #category : #'as yet unclassified' }
PWBBehaviorLoggerCreator class >> loggersWithoutAccessFor: aFamixPWBBehavior [
	^ self new
		focus: aFamixPWBBehavior;
		logAccess: false;
		createLoggers;
		loggers
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> accessLoggers [
	^ loggers select: #isAccessLogger
]

{ #category : #api }
PWBBehaviorLoggerCreator >> createBehaviorLogger [
	
]

{ #category : #api }
PWBBehaviorLoggerCreator >> createLoggers [

self createBehaviorLogger
	
]

{ #category : #api }
PWBBehaviorLoggerCreator >> createReturnLogger: return [
	^ MrlReturnLogger new
		focus: return;
		position: return sourceAnchor startPos;
		yourself
]

{ #category : #api }
PWBBehaviorLoggerCreator >> createReturnLoggers [
	loggers
		addAll:
			(focus returns collect: [ :return | self createReturnLogger: return ])
]

{ #category : #api }
PWBBehaviorLoggerCreator >> createVariableLoggers: aTag [
	loggers
		addAll:
			(self variables
				flatCollect: [ :var | self createVariableLoggers: var withTag: aTag ])
]

{ #category : #api }
PWBBehaviorLoggerCreator >> createVariableLoggers: aVariable withTag: aTag [
	| logger |
	^ aTag = 'before'
		ifTrue: [ logger := (MrlAbstractLogger loggerFor: aVariable tag: aTag)
				position: focus signature sourceAnchor endPos + 1.
			{logger} ]
		ifFalse: [ focus returns
				collect: [ :return | 
					(MrlAbstractLogger loggerFor: aVariable tag: aTag)
						position: return sourceAnchor startPos ] ]
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> focus: aFamixPWBBehavior [
	focus := aFamixPWBBehavior
]

{ #category : #initialization }
PWBBehaviorLoggerCreator >> initialize [
	super initialize.
	loggers := OrderedCollection new.
	logAccess := true
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> logAccess: anObject [
	logAccess := anObject
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> loggers [
	^ loggers
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> loggers: anObject [
	loggers := anObject
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> name [
	name ifNil: [ name := focus name ].
	^ name
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> parameterLoggers [
	^ loggers select: #isParameterLogger
]

{ #category : #printing }
PWBBehaviorLoggerCreator >> printOn: aStrem [
	^ aStrem
		<< self name;
		space;
		<< '(';
		<< loggers size asString;
		<< ')'
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> returnLoggers [
	^ loggers select: #isReturnLogger
]

{ #category : #accessing }
PWBBehaviorLoggerCreator >> variables [
	^ logAccess
		ifTrue: [ focus parameters , focus instanceVariableAccesses ]
		ifFalse: [ focus parameters ]
]
