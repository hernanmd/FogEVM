"
Halt execution and register account for later deletion
"
Class {
	#name : #FogVMSelfdestruct,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSelfdestruct class >> byteCode [
		^'0xff'.
	
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> description [ 
	^ 'Halt execution and register account for later deletion'
]

{ #category : #generated }
FogVMSelfdestruct class >> expectedPops [
		^1.
	
]

{ #category : #generated }
FogVMSelfdestruct class >> expectedPushes [
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> gas [
		^ self gasTable at: #gasSuicide.

]

{ #category : #generated }
FogVMSelfdestruct class >> goCode [
	^ ''
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> halts [
		^ true.

]

{ #category : #generated }
FogVMSelfdestruct class >> mnemonic [
		^'SELFDESTRUCT'.
	
]

{ #category : #generated }
FogVMSelfdestruct class >> mnemonicForCrawl [
	^ 'SUICIDE'
]

{ #category : #'as yet unclassified' }
FogVMSelfdestruct class >> writes [
		^ true.

]
