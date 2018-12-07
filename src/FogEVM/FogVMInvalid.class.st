"
Designated invalid instruction
"
Class {
	#name : #FogVMInvalid,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMInvalid class >> byteCode [
<doc>
		^'0xfe'.
	
]

{ #category : #'as yet unclassified' }
FogVMInvalid class >> description [ 
<doc>
	^ 'Designated invalid instruction'
]

{ #category : #generated }
FogVMInvalid class >> expectedPops [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMInvalid class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #generated }
FogVMInvalid class >> goCode [
<doc>
	^ ''
]

{ #category : #generated }
FogVMInvalid class >> mnemonic [
<doc>
		^'INVALID'.
	
]
