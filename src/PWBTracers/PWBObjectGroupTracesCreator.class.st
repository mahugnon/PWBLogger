Class {
	#name : #PWBObjectGroupTracesCreator,
	#superclass : #SpPresenter,
	#instVars : [
		'focus',
		'name',
		'constraints',
		'tracers',
		'modelSelector'
	],
	#category : #PWBTracers
}

{ #category : #specs }
PWBObjectGroupTracesCreator class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #modelSelector
			withConstraints: [ :constraint | constraint height: self toolbarHeight ];
		yourself
]

{ #category : #examples }
PWBObjectGroupTracesCreator class >> run [
	<example>
	self new openWithSpec
]

{ #category : #'as yet unclassified' }
PWBObjectGroupTracesCreator class >> updateData: aBuilder [
	<worldMenu>
	(aBuilder item: #LoadingLastestTickets)
		parent: #PWBTools;
		help: 'Trace behaviors model root folder';
		label: 'PWBBehaviorTrace';
		action: [ self run ]
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

{ #category : #initialization }
PWBObjectGroupTracesCreator >> initializePresenters [
	modelSelector := self instantiate: SpLabelledDropList.
	modelSelector label: 'Select model:'.
	modelSelector dropList help: 'Select the PowerBuilder model'.
	modelSelector
		items: MooseModel root allModels;
		selectIndex: 1;
		display: [ :model | model name ];
		whenSelectedItemChangedDo: [ :model | 
			self window close.
			self runOn: model ]
]

{ #category : #initialization }
PWBObjectGroupTracesCreator >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'PWB Trace creator';
		initialExtent: 500 @ 100
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

{ #category : #initialization }
PWBObjectGroupTracesCreator >> runOn: model [
	self
		focus:
			(model entities
				select: [ :each | each isPWBClass and: [ each sourceAnchor isNotNil ] ]).
	self createTracers.
	self save
]

{ #category : #actions }
PWBObjectGroupTracesCreator >> save [
	tracers do: #save
]

{ #category : #accessing }
PWBObjectGroupTracesCreator >> tracers [
	^ tracers
]
