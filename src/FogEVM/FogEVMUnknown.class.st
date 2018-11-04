"
UNKNOWN
"
Class {
	#name : #FogEVMUnknown,
	#superclass : #FogEVMInstruction,
	#instVars : [
		'byteCode'
	],
	#category : #'FogEVM-ByteCode'
}

{ #category : #generated }
FogEVMUnknown class >> byteCode [
		^ nil 
]

{ #category : #'as yet unclassified' }
FogEVMUnknown class >> description [ 
	^ 'UNKNOWN'
]

{ #category : #generated }
FogEVMUnknown class >> expectedPops [
	^ self error: 'Shouldnot be here'

]

{ #category : #generated }
FogEVMUnknown class >> expectedPushes [
	^ self error: 'Shouldnot be here'

]

{ #category : #generated }
FogEVMUnknown class >> goCode [
	^ ''
]

{ #category : #generated }
FogEVMUnknown class >> mnemonic [ 
	^ 'UNKNOWN'
]

{ #category : #accessing }
FogEVMUnknown >> byteCode [
	^ byteCode 
]

{ #category : #accessing }
FogEVMUnknown >> byteCode: aString [
	byteCode := aString
]

{ #category : #polimorf }
FogEVMUnknown >> instance [
	^ self
]

{ #category : #polimorf }
FogEVMUnknown >> printOn: aStream [
	aStream
		nextPutAll: self mnemonic;
		nextPut: $(;
		nextPutAll: byteCode;
		nextPut: $)
]
