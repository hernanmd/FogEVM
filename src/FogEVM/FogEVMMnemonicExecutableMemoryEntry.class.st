"
This class represents a memory slot containing an instruction. 
It hs an instruction and it position in memory. 
"
Class {
	#name : #FogEVMMnemonicExecutableMemoryEntry,
	#superclass : #Object,
	#instVars : [
		'byteNumber',
		'instruction',
		'breakpoint'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #visiting }
FogEVMMnemonicExecutableMemoryEntry >> accept: anInterpreter with: anExecutableMemoryReificaiton [ 
	^ instruction accept: anInterpreter loadedAt: byteNumber of: self .
	
]

{ #category : #visiting }
FogEVMMnemonicExecutableMemoryEntry >> breakpoint: aBoolean [
	<doc: 'Receives a boolean, setting up if the interpreter should halt on this position'>
	breakpoint := aBoolean
]

{ #category : #'as yet unclassified' }
FogEVMMnemonicExecutableMemoryEntry >> byteNumber [
	<doc: 'Returns the byte where the instruction is placed (in the executing memory) '>
	^ byteNumber
]

{ #category : #'as yet unclassified' }
FogEVMMnemonicExecutableMemoryEntry >> byteNumber: anInteger [ 
	byteNumber := anInteger
]

{ #category : #visiting }
FogEVMMnemonicExecutableMemoryEntry >> initialize [
	super initialize.
	breakpoint := false.
]

{ #category : #'as yet unclassified' }
FogEVMMnemonicExecutableMemoryEntry >> instruction [
	<doc: 'Returns the instruction at this entry'>
	^ instruction
]

{ #category : #'as yet unclassified' }
FogEVMMnemonicExecutableMemoryEntry >> instruction: aFogVMPush1 [ 
	instruction := aFogVMPush1
]

{ #category : #printing }
FogEVMMnemonicExecutableMemoryEntry >> printOn: aStream [
	aStream
		nextPutAll: (byteNumber write0xHexadecimal: 8);
		nextPutAll: ' - ';
		nextPutAll: (instruction asString padRightTo: 50 with: Character space) ;
		nextPutAll: ' (';
		nextPutAll: instruction class comment;
		nextPutAll: ')'
]

{ #category : #accessing }
FogEVMMnemonicExecutableMemoryEntry >> readsMemory [
	^ instruction readsMemory
]

{ #category : #accessing }
FogEVMMnemonicExecutableMemoryEntry >> readsStorage [
	^ instruction readsStorage
]

{ #category : #'as yet unclassified' }
FogEVMMnemonicExecutableMemoryEntry >> shouldBreak [
	<doc: 'It return true or false according to the entry configuration, informing if it should halt or not on the execution of this instruction'>
	^ breakpoint
]

{ #category : #toggle }
FogEVMMnemonicExecutableMemoryEntry >> toggleBreakpoint [
	<doc: 'Toggles the breakpoint'>
	self breakpoint: self shouldBreak not
]

{ #category : #accessing }
FogEVMMnemonicExecutableMemoryEntry >> writesMemory [
	^ instruction writesMemory
]

{ #category : #accessing }
FogEVMMnemonicExecutableMemoryEntry >> writesStorage [
	^ instruction writesStorage
]
