Class {
	#name : #PWBBehaviorTracer,
	#superclass : #PWBAbstractTracer,
	#category : #PWBTracers
}

{ #category : #accessing }
PWBBehaviorTracer >> belongsTo [
	^ focus parentType 
]

{ #category : #public }
PWBBehaviorTracer >> startOn: stream [
	stream << 'f_mrl_logger().behavior_logger().ensure_save_behavior("'
]

{ #category : #'as yet unclassified' }
PWBBehaviorTracer >> traceOn: stream [
	self startOn: stream.
	stream
		<< focus name;
		<< '"';
		<< ',"';
		<< focus parentType name.
	self endOn: stream.
	^ stream
]
