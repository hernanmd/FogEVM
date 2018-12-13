"
This object is used to wrap the association based memory entry of the tipical memory manager object. Is used for allowing the visualization as tree in a fasttable view
"
Class {
	#name : #FogEVMUIMemoryEntry,
	#superclass : #Object,
	#instVars : [
		'association'
	],
	#category : #'FogEVM-UIDebugger-Tools'
}

{ #category : #accessing }
FogEVMUIMemoryEntry >> association: anAssoc [
	association := anAssoc
]

{ #category : #accessing }
FogEVMUIMemoryEntry >> entries [
	^ association key = #'&contract'
		ifTrue: [ {(FogEVMUIMemoryEntry new
				association: #bytecode -> association value bytecode;
				yourself)} ]
		ifFalse: [ {} ]
]

{ #category : #accessing }
FogEVMUIMemoryEntry >> printOn: aStream [
	association key printOn: aStream.
	aStream nextPutAll: ' => '.
	association value printOn: aStream
]
