Class {
	#name : #BaselineOfPWBLoggers,
	#superclass : #BaselineOf,
	#category : #BaselineOfPWBLoggers
}

{ #category : #baselines }
BaselineOfPWBLoggers >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'PWBLoggers' ]
]
