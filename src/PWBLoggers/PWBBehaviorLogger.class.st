Class {
	#name : #PWBBehaviorLogger,
	#superclass : #PWBAbstractLogger,
	#category : #PWBLoggers
}

{ #category : #accessing }
PWBBehaviorLogger >> belongsTo [
	^ focus parentType 
]

{ #category : #'as yet unclassified' }
PWBBehaviorLogger >> logOn: stream [
	self startOn: stream.
	stream
		<< focus name;
		<< '"';
		<< ',"';
		<< focus parentType name.
	self endOn: stream.
	^ stream
]

{ #category : #public }
PWBBehaviorLogger >> startOn: stream [
	stream << 'f_mrl_logger().behavior_logger().ensure_save_behavior("'
]
