Class {
	#name : #PWBObjectGroupTracesCreator,
	#superclass : #Object,
	#instVars : [
		'focus',
		'name',
		'constraints',
		'tracers'
	],
	#category : #PWBTracers
}

{ #category : #'as yet unclassified' }
PWBObjectGroupTracesCreator class >> tracerFor: aCollection [
	^ self new
		focus: aCollection;
		createTracers;
		yourself
]

{ #category : #'as yet unclassified' }
PWBObjectGroupTracesCreator class >> tracerForModel: aFamixPWBModel [
	| objects |
	objects := aFamixPWBModel entities select: #isPWBClass.
	^ self tracerFor: objects
]

{ #category : #'as yet unclassified' }
PWBObjectGroupTracesCreator class >> updateData: aBuilder [
	<worldMenu>
	(aBuilder item: #LoadingLastestTickets)
		parent: #PWBTools;
		help: 'Trace behaviors model root folder';
		label: 'PWBBehaviorTrace';
		action: [ | model |
			model := MooseModel root first.
			(self tracerForModel: model) save ]
]

{ #category : #adding }
PWBObjectGroupTracesCreator >> addConstraint: aConstraint [
	tracers
		detect: [ :logger | logger name = aConstraint name ]
		ifFound: [ :founded | founded addConstraint: aConstraint ]
]

{ #category : #api }
PWBObjectGroupTracesCreator >> createTracers [
	tracers := focus
		collect: [ :each | PWBObjectTracesCreator tracersFor: each ]
]

{ #category : #accessing }
PWBObjectGroupTracesCreator >> focus: aCollection [ 
	focus := aCollection
]

{ #category : #printing }
PWBObjectGroupTracesCreator >> printOn: aStrem [
	^ aStrem
		<< 'Group';
		space;
		<< '(';
		<< tracers size asString;
		<< ')'
]

{ #category : #actions }
PWBObjectGroupTracesCreator >> save [
	tracers do: #save
]

{ #category : #accessing }
PWBObjectGroupTracesCreator >> tracers [
	^ tracers
]
