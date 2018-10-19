"
This class is in charge of the implementation of the ByteCode interpretation .
"
Class {
	#name : #FogEVMInterpreter,
	#superclass : #Object,
	#instVars : [
		'stack',
		'memory',
		'call',
		'executableMemory',
		'instructionPointer',
		'programFinished',
		'storage',
		'program',
		'return',
		'trace',
		'reverted'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #test }
FogEVMInterpreter class >> exampleCall [
	^ {
	'0xc3c5a547000000000000000000000000b4ebf466889c4a0239379125a7d0f9c4e8bf2a14' . 
	3000000 asBKHexa.
	'contract-hash'.
	'0xb4ebf466889c4a0239379125a7d0f9c4e8bf2a14'.
	'0xc0478ac7'.
	0.
	'?'.
	'?'.
	'?'.
	'?'}
	" (
            gas,
            value,
            to,
            sender,
            code_address,
            memory_input_start_position,
            memory_input_size,
            memory_output_start_position,
            memory_output_size,
            should_transfer_value,
        ) = self.get_call_params(computation)"
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter class >> exampleCallFor: aDataContent [
	^ {aDataContent.
	3000000 asBKHexa.
	'contract-hash'.
	'0xb4ebf466889c4a0239379125a7d0f9c4e8bf2a14'.
	'0xcontract-address'.
	0.
	'?'.
	'?'.
	'?'.
	'?'}
	" (
            gas,
            value,
            to,
            sender,
            code_address,
            memory_input_start_position,
            memory_input_size,
            memory_output_start_position,
            memory_output_size,
            should_transfer_value,
        ) = self.get_call_params(computation)"
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter class >> wordSize [
	^ 32
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> accessCallFrom0BaseIndex: anInteger [
	^ call at: anInteger + 1
]

{ #category : #accessing }
FogEVMInterpreter >> binary [
	^ program toBinary
]

{ #category : #accessing }
FogEVMInterpreter >> blockHashRegisty: aMinimalBlockNumber [ 
	 " Here we could put a strategy. maybe to be able to get information from running environment "
	^ FogEVMRegistry forMemoryContent: 16r687980987654abaca234.
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> booleanToHexa: aBoolean [
	^ (aBoolean
		ifTrue: [ 1 ]
		ifFalse: [ 0 ]) asBKHexa
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> breakOnAddress: anAddress [
	^ (executableMemory at: (self indexForMemoryAddress: anAddress)) breakpoint: true.
]

{ #category : #accessing }
FogEVMInterpreter >> call: aCall [
	call := aCall
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> callValue [
	^ call at: 6
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> callerAddress [
	^ FogEVMRegistry forMemoryContent: (call at: 4)
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> cancelBreakOnAddress: anAddress [
	^ (executableMemory at: (self indexForMemoryAddress: anAddress)) breakpoint: false.
]

{ #category : #accessing }
FogEVMInterpreter >> contract: aFogEVMMnemonicContract [
	executableMemory := aFogEVMMnemonicContract sequence copy.
	executableMemory do: #initialize.
	program := aFogEVMMnemonicContract
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> contractAddress [
	^ FogEVMRegistry forMemoryContent: (call at: 5)
]

{ #category : #convenience }
FogEVMInterpreter >> copyElement: anInteger [
	self push: (stack at: anInteger) copy
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> fetchNextInstruction [
	| instruction |
	instruction := (executableMemory at: instructionPointer) .
	instructionPointer := instructionPointer + 1.
	^ instruction
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> finishComputation [
	programFinished  := true. 
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> hexa [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> hexaToBoolean: anInteger [
	^ anInteger unsignedValue = 0
		ifTrue: [ false ]
		ifFalse: [ true ]
]

{ #category : #accessing }
FogEVMInterpreter >> indexForMemoryAddress: anAddress [
	^ executableMemory
		indexOf: (executableMemory detect: [ :i | i byteNumber = anAddress asBKNumber ])
]

{ #category : #initialization }
FogEVMInterpreter >> initialize [
	super initialize.
	stack := Stack new
]

{ #category : #'instruction decoding' }
FogEVMInterpreter >> interpret [
	| i |
	trace := OrderedCollection new.
	stack := Stack new.
	programFinished := false.
	self setInstructionPointerToByte: executableMemory first byteNumber.
	[ self programHasFinished ]
		whileFalse: [ i := self fetchNextInstruction.
			trace add: i.
			i accept: self with: nil ]
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> isTerminated [
	^ programFinished
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> keccack256: aString [
	^ Keccak hashEncode: aString 
]

{ #category : #accessing }
FogEVMInterpreter >> memory [
	^ memory ifNil: [ memory := FogEVMMemory new  ]
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> peekInstruction: anAddress [
	^ (executableMemory at: (self indexForMemoryAddress: anAddress)) instruction
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> peekNextInstruction [
	^ (executableMemory at: instructionPointer ) instruction
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> peekNextNextInstruction [
	^ (executableMemory at: instructionPointer + 1) instruction
]

{ #category : #accessing }
FogEVMInterpreter >> pop [
	^ stack pop 
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> programHasFinished [
	^ programFinished ifNil: [ programFinished := executableMemory size < instructionPointer ]
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> push: aPushableObject [
	stack push: aPushableObject asPushableRegistry
]

{ #category : #business }
FogEVMInterpreter >> revertComputation: reason [ 
	self finishComputation.
	self halt. 
	reverted := true .
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> runtimeState [
	" We should hash the states"
	^ 'latest'
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> setInstructionPointerToByte: anInteger [
	instructionPointer := executableMemory indexOf: (executableMemory detect: [ :i | i byteNumber = anInteger asBKNumber ])
]

{ #category : #utility }
FogEVMInterpreter >> stackSize [
	^ stack size 
]

{ #category : #accessing }
FogEVMInterpreter >> storage [
	^ storage ifNil: [ storage := Dictionary new ]
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> storageFor: anAddress [
	^ self storageFor: anAddress state: self runtimeState
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> storageFor: aContractAddress state: aStateHash [ 
	self flag: #WeshouldCareAboutTheMerkelTreeState. 
	^ self storage at: aContractAddress ifAbsentPut: [ FogEVMBucketStorage new ].
]

{ #category : #'stack operations' }
FogEVMInterpreter >> swapStackRegistry: anInteger with: anInteger2 [
	stack swap: anInteger with: anInteger2
]

{ #category : #'visit - arithmetics' }
FogEVMInterpreter >> visitAdd: aFogVMAdd [
	| a b |
	a := self pop.
	b := self pop.
	self push: a + b
]

{ #category : #visit }
FogEVMInterpreter >> visitAddmod: aFogVMAddmod [
	| x y z module |
	x := self pop .
	y := self pop .
	z := self pop .
	module := (x + y) \\ z.
	self push: module 
]

{ #category : #visiting }
FogEVMInterpreter >> visitAddress: aFogVMAddress [ 
	self push: self contractAddress 
]

{ #category : #'visit - boolean alebra' }
FogEVMInterpreter >> visitAnd: aFogVMAnd [
	| a b |
	a := self pop.
	b := self pop.
	self push: a & b
]

{ #category : #visiting }
FogEVMInterpreter >> visitBlockhash: aFogVMBlockhash [
	| minimalBlockNumber |
	minimalBlockNumber := self pop.
	self push: (self blockHashRegisty: minimalBlockNumber)
]

{ #category : #visiting }
FogEVMInterpreter >> visitByte: aFogVMByte [
	| chunk position |
	chunk := self pop.
	position := self pop.
	self push: (chunk byteAt: position)
]

{ #category : #'visit - call' }
FogEVMInterpreter >> visitCalldataload: aFogVMCalldataload [
	| id |
	id := self pop.
	self push: (self accessCallFrom0BaseIndex: id)
]

{ #category : #'visit - call' }
FogEVMInterpreter >> visitCalldatasize: aFogVMCalldatasize [
	self push: call size
]

{ #category : #'visit - call' }
FogEVMInterpreter >> visitCaller: aFogVMCaller [ 
	self push: self callerAddress
]

{ #category : #'visit - call' }
FogEVMInterpreter >> visitCallvalue: aFogVMCallvalue [
	self push: self callValue
]

{ #category : #visiting }
FogEVMInterpreter >> visitCodecopy: aFogVMCodecopy [
	| loadingArea fromInstruction amountOfInstructions hexa |
	loadingArea := self pop.
	fromInstruction := self pop.
	amountOfInstructions := self pop.
	self stageAt: loadingArea aCopyProgramFromByte: fromInstruction counting: amountOfInstructions
	"
	hexa := program toHexa.
	hexa := hexa copyFrom: 3 to: hexa size.
	hexa := hexa copyFrom: fromInstruction to: fromInstruction + amountOfInstructions - 1.
	memory storeChunck: hexa startingAt: loadingArea ensureBytes: amountOfInstructions / 2"
	"0 to: amountOfInstructions - 1 do: [ :i | memory store: (self hexa at: fromInstruction + i) at: (loadingArea + i) asBKHexa ]"
]

{ #category : #'visit - arithmetics' }
FogEVMInterpreter >> visitDiv: aFogVMDiv [
	| numerator denom |
	numerator := self pop.
	denom := self pop. 
	self
		push:
			(numerator isZero
				ifTrue: [ 0 ]
				ifFalse: [ numerator // denom ])
]

{ #category : #'visit - stack' }
FogEVMInterpreter >> visitDup: aFogVMDup [
	 self copyElement: aFogVMDup expectedPops
	"	self push: element copy"
]

{ #category : #'visit - comparision' }
FogEVMInterpreter >> visitEq: aFogVMEq [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 isEqualsTo: element2)
]

{ #category : #'visit - arithmetics' }
FogEVMInterpreter >> visitExp: aFogVMExp [
	| value exponent |
	value := self pop.
	exponent := self pop.
	self push: value ** exponent
]

{ #category : #'visit - comparision' }
FogEVMInterpreter >> visitGt: aFogVMGt [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 unsignedGT: element2)
]

{ #category : #'visit - boolean alebra' }
FogEVMInterpreter >> visitIszero: aFogVMIszero [
	self push: self pop isZero
]

{ #category : #'visit - flow' }
FogEVMInterpreter >> visitJump: aFogVMJump [
	| newInstructionPointer jumpDestInstruction |
	newInstructionPointer := self pop.
	jumpDestInstruction := self peekInstruction: newInstructionPointer.
	"self
		assert: jumpDestInstruction isValidJumpDestination
		description:
			('{1} is not a valid JUMP destination. {2} instruction founded'
				format:
					{newInstructionPointer.
					jumpDestInstruction}). should move to setInstruction "
	self setInstructionPointerToByte: newInstructionPointer
]

{ #category : #'visit - flow' }
FogEVMInterpreter >> visitJumpdest: aFogVMJumpdest [ 
	" nothing to do here "
]

{ #category : #'visit - flow' }
FogEVMInterpreter >> visitJumpi: aFogVMJumpi [
	| condition newInstructionPointer jumpDestInstruction |
	newInstructionPointer := self pop.
	jumpDestInstruction := self peekInstruction: newInstructionPointer.
	condition := self pop.
	condition
		ifTrue: [ "self
				assert: jumpDestInstruction isValidJumpDestination
				description:
					('{1} is not a valid JUMPI (Conditional JUMP) destination. {2} Instruction founded'
						format:
							{newInstructionPointer.
							jumpDestInstruction}). move this " self setInstructionPointerToByte: newInstructionPointer ]
]

{ #category : #'visit - comparision' }
FogEVMInterpreter >> visitLt: aFogVMGt [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 unsignedLesserThan: element2)
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> visitMload: aFogVMMload [
	| fromAddress toAddress |
	fromAddress := self pop.
	self push: (self memory loadWord: fromAddress)
]

{ #category : #visiting }
FogEVMInterpreter >> visitMod: aFogVMMod [
	| x y |
	x := self pop.
	y := self pop.
	self push: x \\ y
]

{ #category : #visiting }
FogEVMInterpreter >> visitMsize: aFogVMMsize [ 
	self push:( FogEVMRegistry forValue: (self memory sizeInBytes) bytesLength: 32).
]

{ #category : #visiting }
FogEVMInterpreter >> visitMstore8: aFogVMMstore8 [
	| address value |
	address := self pop.
	value := self pop.
	self memory storeByte: value at: address
]

{ #category : #'visit - memory' }
FogEVMInterpreter >> visitMstore: aFogVMMstore [
	| address value |
	address := self pop.
	value := self pop.
	self memory storeWord: value startingAt: address
]

{ #category : #'visit - arithmetics' }
FogEVMInterpreter >> visitMul: aFogVMMul [
	| numberA numberB |
	numberA := self pop.
	numberB := self pop.
	self push: numberA * numberB
]

{ #category : #visiting }
FogEVMInterpreter >> visitMulmod: aFogVMMulmod [
	| x y z module |
	x := self pop.
	y := self pop.
	z := self pop.
	module := x * y \\ z.
	self push: module
]

{ #category : #'visit - boolean alebra' }
FogEVMInterpreter >> visitNot: aFogVMNot [
	| value |
	value := self pop.
	self push: value not
]

{ #category : #'visit - boolean alebra' }
FogEVMInterpreter >> visitOr: aFogVMOr [
	| a b |
	a := self pop.
	b := self pop.
	self push: a | b
]

{ #category : #'visit - stack' }
FogEVMInterpreter >> visitPop: aFogVMPop [
	self pop
]

{ #category : #'visit - stack' }
FogEVMInterpreter >> visitPush: aFogVMPush [
	self push: aFogVMPush
]

{ #category : #'visit - flow' }
FogEVMInterpreter >> visitReturn: aFogVMReturn [
	| from to |
	from := self pop.
	to := self pop.
	return := self fetchMemoryFrom: from to: to.
	self finishComputation
]

{ #category : #visiting }
FogEVMInterpreter >> visitRevert: aFogVMRevert [ 
	| offset size content |
	offset := self pop. 
	size := self pop. 
	
	content := self copyMemoryFrom: offset bytes: size .
	self revertComputation: content.  
	
	
]

{ #category : #visiting }
FogEVMInterpreter >> visitSar: aFogVMSar [
	| shift value push |
	shift := self pop.
	value := self pop.  
	push := value signedRightShift: shift.
	self push: push
]

{ #category : #'as yet unclassified' }
FogEVMInterpreter >> visitSdiv: aFogVMSdiv [
	| x y |

	x := self pop.
	y := self pop.

	self push: (x signedDivision: y)	"y sign * x sign * (x abs // y abs)"
]

{ #category : #visiting }
FogEVMInterpreter >> visitSgt: aFogVMSgt [
	" Signed Greater than"

	| x y |
	x := self pop.
	y := self pop.
	self push: (x signedGreaterThan: y)
]

{ #category : #'visit - hashing' }
FogEVMInterpreter >> visitSha3: aFogVMSha3 [
	| fromAddress offset kck |
	fromAddress := self pop.
	offset := self pop.
	kck := self keccack256: (self memory loadWords: fromAddress to: offset).
	kck := FogEVMRegistry forValue: ('16r' , kck) asNumber bytesLength: 32.
	self push: kck
]

{ #category : #visiting }
FogEVMInterpreter >> visitShl: aFogVMShl [
	| shift value |
	shift := self pop.
	value := self pop.
	self push: value << shift
]

{ #category : #visiting }
FogEVMInterpreter >> visitShr: aFogVMShr [
	| shift value |
	shift := self pop.
	value := self pop.
	self push: value >> shift
]

{ #category : #visiting }
FogEVMInterpreter >> visitSignextend: aFogVMSignextend [
	| length value |
	length := self pop.
	value := self pop.
	self push: (value extendRepresentationTo: length)
]

{ #category : #'visit - storage' }
FogEVMInterpreter >> visitSload: aFogVMSload [ 
	| storageAddress value address | 
	storageAddress := self pop.
	address := FogEVMRegistry forValue: storageAddress unsignedValue bytesLength: 32.
	value := (self storageFor: self contractAddress) getStorageAt: address. 
	self push: value. 
]

{ #category : #'visit - comparision' }
FogEVMInterpreter >> visitSlt: aFogVMSlt [
	| element1 element2 |
	element1 := self pop.
	element2 := self pop.
	self push: (element1 signedLesserThan: element2)
]

{ #category : #visit }
FogEVMInterpreter >> visitSmod: aFogVMSmod [
	| x y |
	x := self pop.
	y := self pop.
	self push: (x smod: y)
]

{ #category : #'visit - storage' }
FogEVMInterpreter >> visitSstore: aFogVMSstore [
	| storageAddress value address |
	storageAddress := self pop.
	value := self pop.
	address := FogEVMRegistry forValue: storageAddress unsignedValue bytesLength: 32.
	value := (self storageFor: self contractAddress) atStorage: address put: value
]

{ #category : #'visiti stop' }
FogEVMInterpreter >> visitStop: aFogVMStop [
	programFinished := true
]

{ #category : #'visit - arithmetics' }
FogEVMInterpreter >> visitSub: aFogVMAdd [
	| a b |
	a := self pop.
	b := self pop.
	self push: a - b
]

{ #category : #'visit - stack' }
FogEVMInterpreter >> visitSwap: aFogVMSwap [
	self swapStackRegistry: 1 with: aFogVMSwap expectedPops 
]

{ #category : #visiting }
FogEVMInterpreter >> visitXor: aFogVMXor [
	| a b |
	a := self pop.
	b := self pop.
	self push: (a xor: b)
]
