Extension { #name : #String }

{ #category : #'*FogEVM' }
String >> asBKHexa: anInteger [
	^ self asNumber asBKHexa: anInteger
]
