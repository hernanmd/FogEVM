Class {
	#name : #FogEVMRegistry,
	#superclass : #Object,
	#instVars : [
		'value',
		'mask'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #mask }
FogEVMRegistry class >> createMaskFor: anInteger [
	^ 256 ** anInteger - 1
	" 256 == FF 
(256 ** 1) -1  == 0xFF
(256 ** 2)-1 == 0xFFFF 
...

"
]

{ #category : #mask }
FogEVMRegistry class >> createNegativeMaskFor: anInteger [
	^ 256 ** anInteger - 1.
	
	
	
	" 256 == FF 
(256 ** 1) -1  == 0xFF
(256 ** 2)-1 == 0xFFFF 
...

"
]

{ #category : #creating }
FogEVMRegistry class >> for: aFogVMPush [
	^ self new
		mask: (self createMaskFor: aFogVMPush bytes);
		value: aFogVMPush parameter asBKNumber ;
		yourself
]

{ #category : #accessing }
FogEVMRegistry >> isPositive [
	^ value <= mask
]

{ #category : #accessing }
FogEVMRegistry >> mask: anInteger [ 
	mask := anInteger
]

{ #category : #accessing }
FogEVMRegistry >> signedValue [
	^ self isPositive
		ifTrue: [ value ]
		ifFalse: [ ^ ((mask >> 1 bitXor: mask) bitXor: value) * -1 ]
]

{ #category : #accessing }
FogEVMRegistry >> unsignedValue [
	^ value
]

{ #category : #accessing }
FogEVMRegistry >> value: anInteger [
	value := anInteger bitAnd: mask
]
