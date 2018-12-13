"
An activation is the response to a call, as a context in smalltalk or other languages. 

This object is in charge of holding the bytecode to execute, the instruction pointer of this activation, as well it does control the management of stop, revert and return.
An activation lasts as much as the related running function / method.


"
Class {
	#name : #FogEVMActivation,
	#superclass : #Object,
	#instVars : [
		'call',
		'instructionPointer',
		'isFinish',
		'contract',
		'return',
		'contextualAccount'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #accessing }
FogEVMActivation >> binaryBytecode [
	^ contract bytecode toBinary 
]

{ #category : #initialization }
FogEVMActivation >> breakOnAddress: anAddress [
	^ (self executableMemory at: (self indexForMemoryAddress: anAddress)) breakpoint: true.
]

{ #category : #accessing }
FogEVMActivation >> bytecodeSize [
	^ contract bytecode bytecodeSize
]

{ #category : #accessing }
FogEVMActivation >> call [
	^ call
]

{ #category : #accessing }
FogEVMActivation >> call: aFogEVMCall [ 
	call := aFogEVMCall
]

{ #category : #accessing }
FogEVMActivation >> callValue [
	^ call callValue
]

{ #category : #accessing }
FogEVMActivation >> callerAddress [
	^ call callerAddress 
]

{ #category : #initialization }
FogEVMActivation >> cancelBreakOnAddress: anAddress [
	^ (self executableMemory at: (self indexForMemoryAddress: anAddress)) breakpoint: false.
]

{ #category : #accessing }
FogEVMActivation >> contextualAccount [
	^ contextualAccount
]

{ #category : #accessing }
FogEVMActivation >> contextualAccount: aContextAccount [
	contextualAccount := aContextAccount
]

{ #category : #accessing }
FogEVMActivation >> contract [
	^ contract
]

{ #category : #accessing }
FogEVMActivation >> contract: aFogEVMContract [
	contract := aFogEVMContract
]

{ #category : #accessing }
FogEVMActivation >> contractAddress [
	^ contract address
]

{ #category : #accessing }
FogEVMActivation >> currentInstruction [
	^ self executableMemory at: self currentInstructionPointer 
]

{ #category : #accessing }
FogEVMActivation >> currentInstructionPointer [
	^ instructionPointer - 1
]

{ #category : #accessing }
FogEVMActivation >> executableMemory [
	^ contract bytecode content 
]

{ #category : #initialization }
FogEVMActivation >> fetchNextInstruction [
	| instruction |
	instruction := self executableMemory at: instructionPointer.
	instructionPointer := instructionPointer + 1.
	^ instruction
]

{ #category : #accessing }
FogEVMActivation >> gas [
	^ call gas
]

{ #category : #accessing }
FogEVMActivation >> gasPrice [
	^ call gasPrice
]

{ #category : #accessing }
FogEVMActivation >> hexadecimalReturn [
	^  (return ifNil: [ return := FogEVMRegistry zero ]) hex
]

{ #category : #initialization }
FogEVMActivation >> indexForMemoryAddress: anAddress [
	^ self indexForMemoryAddress: anAddress ifNone: [  FogEVMRuntimeError signal: 'Invalid Address. Out Of Memory' ]
]

{ #category : #initialization }
FogEVMActivation >> indexForMemoryAddress: anAddress ifNone: aBlock [
	| index |
	index := self executableMemory
		detect: [ :i | i byteNumber = anAddress unsignedValue ]
		ifNone: [ ^ aBlock value ].
	^ self executableMemory indexOf: index
]

{ #category : #initialization }
FogEVMActivation >> initializeInstructionPointer [
	self setInstructionPointerToByte: (FogEVMRegistry forValue: self executableMemory first byteNumber bytesLength: 8).
	isFinish := false.
	
]

{ #category : #testing }
FogEVMActivation >> isContractDeploy [
	^ call contractAddress isNil
]

{ #category : #testing }
FogEVMActivation >> isFinished [
	^ isFinish ifNil: [ isFinish := false ]
]

{ #category : #accessing }
FogEVMActivation >> nextInstruction [
	^ self executableMemory at: instructionPointer 
]

{ #category : #accessing }
FogEVMActivation >> nextInstructionPointer [
	^ instructionPointer
]

{ #category : #initialization }
FogEVMActivation >> peekInstruction: anAddress [
	^ (self executableMemory at: (self indexForMemoryAddress: anAddress)) instruction
]

{ #category : #accessing }
FogEVMActivation >> return [
	^ return ifNil: [  return := FogEVMRegistry zero ]
]

{ #category : #accessing }
FogEVMActivation >> return: aCollection [ 
	return := aCollection.
	isFinish := true.
]

{ #category : #imp }
FogEVMActivation >> revert [
	self halt: #ShouldImplement
]

{ #category : #testing }
FogEVMActivation >> setFinished: aBool [
	isFinish := aBool.
]

{ #category : #initialization }
FogEVMActivation >> setInstructionPointerToByte: anInteger [
	instructionPointer := self executableMemory
		indexOf: (self executableMemory detect: [ :i | i byteNumber = anInteger unsignedValue ])
]

{ #category : #accessing }
FogEVMActivation >> stop [
	isFinish := true.
]
