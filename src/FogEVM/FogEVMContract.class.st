Class {
	#name : #FogEVMContract,
	#superclass : #Object,
	#instVars : [
		'bytecode',
		'address'
	],
	#category : #'FogEVM-Envinronment-Objects'
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

{ #category : #'debugger ui' }
FogEVMContract >> values [
	^ { address . bytecode }
]
