Class {
	#name : #PWBBehaviorTracer,
	#superclass : #PWBAbstractTracer,
	#category : #PWBLoggers
}

{ #category : #accessing }
PWBBehaviorTracer >> belongsTo [
	^ focus parentType 
]

{ #category : #'as yet unclassified' }
PWBBehaviorTracer >> logOn: stream [
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
PWBBehaviorTracer >> startOn: stream [
	stream << 'f_mrl_logger().behavior_logger().ensure_save_behavior("'
]
