Class {
	#name : #FogEVMContract,
	#superclass : #Object,
	#instVars : [
		'bytecode',
		'address'
	],
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #accessing }
FogEVMContract >> address [
	^ address
]

{ #category : #accessing }
FogEVMContract >> address: aFogEVMRegistry [ 
	address := aFogEVMRegistry
]

{ #category : #accessing }
FogEVMContract >> bytecode [
	^ bytecode
]

{ #category : #accessing }
FogEVMContract >> bytecode: aFogEVMByteCode [ 
	bytecode := aFogEVMByteCode
]
