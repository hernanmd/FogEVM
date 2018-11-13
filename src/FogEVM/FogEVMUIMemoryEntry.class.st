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
	^ { }
]

{ #category : #accessing }
FogEVMUIMemoryEntry >> printOn: aStream [
	association key printOn: aStream.
	aStream nextPutAll: ' => '.
	association value printOn: aStream
]
