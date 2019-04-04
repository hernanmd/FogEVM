Class {
	#name : #FogEVMAstCall,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'address',
		'gas',
		'money',
		'input',
		'output'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #accessing }
FogEVMAstCall >> address: aFogEVMAstVariable [ 
	address := aFogEVMAstVariable
]

{ #category : #accessing }
FogEVMAstCall >> gas: aFogEVMAstVariable [ 
	gas := aFogEVMAstVariable
]

{ #category : #accessing }
FogEVMAstCall >> input: aFogEVMAstVariable [ 
	input := aFogEVMAstVariable
]

{ #category : #accessing }
FogEVMAstCall >> money: aFogEVMAstVariable [ 
	money := aFogEVMAstVariable
]

{ #category : #accessing }
FogEVMAstCall >> output: aFogEVMAstMemoryStore [ 
	output := aFogEVMAstMemoryStore
]
