Class {
	#name : #MrlBehaviorLogger,
	#superclass : #PWBAbstractLogger,
	#category : #PWBLoggers
}

{ #category : #accessing }
MrlBehaviorLogger >> belongsTo [
	^ focus parentType 
]

{ #category : #'as yet unclassified' }
MrlBehaviorLogger >> logOn: stream [
	self startOn: stream.
	stream
		<< focus name;
		<< '"';
		<< ',"';
		<< focus parentType name;
		<< '"'.
	self endOn: stream.
	^ stream
]

{ #category : #public }
MrlBehaviorLogger >> startOn: stream [
	stream << 'f_mrl_logger().ensure_save_behavior().log("'
]
