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

{ #category : #'as yet unclassified' }
FogEVMActivation >> bytecodeSize [
	^ contract bytecode bytecodeSize
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
	self setInstructionPointerToByte: (FogEVMRegistry forValue: self executableMemory first byteNumber bytesLength: 8)
]

{ #category : #testing }
FogEVMActivation >> isFinished [
	^ isFinish ifNil: [ isFinish := false ]
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
