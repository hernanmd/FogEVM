Extension { #name : #Number }

{ #category : #'*FogEVM' }
Number >> and: anInteger [
	^ self & anInteger
]

{ #category : #'*FogEVM' }
Number >> divide: anInteger [ 
	^ self / anInteger 
]

{ #category : #'*FogEVM' }
Number >> multiply: anInteger [
	^ self * anInteger
]

{ #category : #'*FogEVM' }
Number >> plus: anInteger [
	^ anInteger + self 
	
]
