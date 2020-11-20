Class {
	#name : #BaselineOfPWBTracers,
	#superclass : #BaselineOf,
	#category : #BaselineOfPWBTracers
}

{ #category : #baselines }
BaselineOfPWBTracers >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'PWBTracers' ]
]
