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
<doc>
		^ nil 
]

{ #category : #'as yet unclassified' }
FogEVMUnknown class >> description [ 
<doc>
	^ 'UNKNOWN'
]

{ #category : #generated }
FogEVMUnknown class >> expectedPops [
<doc>
	^ self error: 'Shouldnot be here'
]

{ #category : #generated }
FogEVMUnknown class >> expectedPushes [
<doc>
	^ self error: 'Shouldnot be here'
]

{ #category : #generated }
FogEVMUnknown class >> goCode [
<doc>
	^ ''
]

{ #category : #generated }
FogEVMUnknown class >> mnemonic [ 
<doc>
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

{ #category : #accessing }
FogEVMUnknown >> instance [
	^ self
]

{ #category : #printing }
FogEVMUnknown >> printOn: aStream [
	aStream
		nextPutAll: self mnemonic;
		nextPut: $(;
		nextPutAll: byteCode;
		nextPut: $)
]
