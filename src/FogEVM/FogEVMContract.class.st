Class {
	#name : #FogEVMContract,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'bytecode',
		'address',
		'value',
		'salt'
	],
	#category : #'FogEVM-Environment-Objects'
}

{ #category : #accessing }
FogEVMContract >> accept: aVisitor [
	aVisitor visitContract: self
]

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

{ #category : #unifying }
FogEVMContract >> unify: aFogEVMAstVariable with: aFogEVMAstValue [
	bytecode = aFogEVMAstVariable
		ifTrue: [ bytecode := aFogEVMAstValue ].
	value = aFogEVMAstVariable
		ifTrue: [ value := aFogEVMAstValue ].
	salt = aFogEVMAstVariable
		ifTrue: [ salt := aFogEVMAstValue ]
]

{ #category : #'as yet unclassified' }
FogEVMContract >> value [ 
	^ value
]

{ #category : #'as yet unclassified' }
FogEVMContract >> value: anAmountOfMoney [
	value := anAmountOfMoney
]

{ #category : #'as yet unclassified' }
FogEVMContract >> values [
	^ { address . bytecode . salt}
]
