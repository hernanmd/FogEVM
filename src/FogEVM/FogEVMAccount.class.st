Class {
	#name : #FogEVMAccount,
	#superclass : #Object,
	#instVars : [
		'address'
	],
	#category : #'FogEVM-Environment-Objects'
}

{ #category : #accessing }
FogEVMAccount >> address: aFogEVMRegistry [ 
	address := aFogEVMRegistry
]

{ #category : #'as yet unclassified' }
FogEVMAccount >> values [
	^ { address  }
]
