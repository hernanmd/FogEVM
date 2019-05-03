Class {
	#name : #FogEVMContract,
	#superclass : #Object,
	#instVars : [
		'bytecode',
		'address',
		'value',
		'salt'
	],
	#category : #'FogEVM-Environment-Objects'
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

{ #category : #'as yet unclassified' }
FogEVMContract >> salt [
	^ salt
]

{ #category : #'as yet unclassified' }
FogEVMContract >> salt: aSalt [
	salt := aSalt
]

{ #category : #'as yet unclassified' }
FogEVMContract >> value: anAmountOfMoney [
	value := anAmountOfMoney
]

{ #category : #'as yet unclassified' }
FogEVMContract >> values [
	^ { address . bytecode . salt}
]
