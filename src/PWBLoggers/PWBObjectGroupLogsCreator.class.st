Class {
	#name : #PWBObjectGroupLogsCreator,
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
PWBObjectGroupLogsCreator class >> loggerFor: aCollection [
	^ self new
		focus: aCollection;
		createLoggers;
		yourself
]

{ #category : #'as yet unclassified' }
PWBObjectGroupLogsCreator class >> loggerForModel: aFamixPWBModel [
	| objects |
	objects := aFamixPWBModel entities select: #isPWBClass.
	^ self loggerFor: objects
]

{ #category : #'as yet unclassified' }
PWBObjectGroupLogsCreator class >> updateData: aBuilder [
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
PWBObjectGroupLogsCreator >> addConstraint: aConstraint [
	loggers
		detect: [ :logger | logger name = aConstraint name ]
		ifFound: [ :founded | founded addConstraint: aConstraint ]
]

{ #category : #api }
PWBObjectGroupLogsCreator >> createLoggers [
	loggers := focus
		collect: [ :each | PWBObjectLogsCreator loggersFor: each ]
]

{ #category : #accessing }
PWBObjectGroupLogsCreator >> focus: aCollection [ 
	focus := aCollection
]

{ #category : #accessing }
PWBObjectGroupLogsCreator >> loggers [
	^ loggers
]

{ #category : #printing }
PWBObjectGroupLogsCreator >> printOn: aStrem [
	^ aStrem
		<< 'Group';
		space;
		<< '(';
		<< loggers size asString;
		<< ')'
]

{ #category : #actions }
PWBObjectGroupLogsCreator >> save [
	loggers do: #save
]
