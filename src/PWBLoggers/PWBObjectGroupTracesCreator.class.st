Class {
	#name : #PWBObjectGroupTracesCreator,
	#superclass : #Object,
	#instVars : [
		'focus',
		'loggers',
		'name',
		'constraints'
	],
	#category : #PWBLoggers
}

{ #category : #'as yet unclassified' }
PWBObjectGroupTracesCreator class >> loggerFor: aCollection [
	^ self new
		focus: aCollection;
		createLoggers;
		yourself
]

{ #category : #'as yet unclassified' }
PWBObjectGroupTracesCreator class >> loggerForModel: aFamixPWBModel [
	| objects |
	objects := aFamixPWBModel entities select: #isPWBClass.
	^ self loggerFor: objects
]

{ #category : #'as yet unclassified' }
PWBObjectGroupTracesCreator class >> updateData: aBuilder [
	<worldMenu>
	(aBuilder item: #LoadingLastestTickets)
		order: 10;
		help: 'Trace behaviors model root folder';
		label: 'PWBBehaviorTrace';
		action: [ | model |
			model := MooseModel root first.
			(self loggerForModel: model) save ]
]

{ #category : #adding }
PWBObjectGroupTracesCreator >> addConstraint: aConstraint [
	loggers
		detect: [ :logger | logger name = aConstraint name ]
		ifFound: [ :founded | founded addConstraint: aConstraint ]
]

{ #category : #api }
PWBObjectGroupTracesCreator >> createLoggers [
	loggers := focus
		collect: [ :each | PWBObjectTracesCreator loggersFor: each ]
]

{ #category : #accessing }
PWBObjectGroupTracesCreator >> focus: aCollection [ 
	focus := aCollection
]

{ #category : #accessing }
PWBObjectGroupTracesCreator >> loggers [
	^ loggers
]

{ #category : #printing }
PWBObjectGroupTracesCreator >> printOn: aStrem [
	^ aStrem
		<< 'Group';
		space;
		<< '(';
		<< loggers size asString;
		<< ')'
]

{ #category : #actions }
PWBObjectGroupTracesCreator >> save [
	loggers do: #save
]
