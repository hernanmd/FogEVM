Class {
	#name : #FogEVMAccount,
	#superclass : #Object,
	#instVars : [
		'address'
	],
	#category : #'FogEVM-Envinronment-Objects'
}

{ #category : #accessing }
FogEVMAccount >> address: aFogEVMRegistry [ 
	address := aFogEVMRegistry
]

{ #category : #'debugger ui' }
FogEVMAccount >> values [
	^ { address  }
]
