Class {
	#name : #FogEVMIREthereumDecompiler,
	#superclass : #Object,
	#instVars : [
		'program',
		'instructionPointer',
		'scope',
		'instruction',
		'destinations'
	],
	#category : #'FogEVM-Decompiler'
}

{ #category : #convenience }
FogEVMIREthereumDecompiler >> assignToTemporaryVariable: aNode [
	| var assignment |
	var := FogEVMAstVariable new.
	var createdAt: self currentInstruction.  
	self scope addTemporary: var.
	assignment := FogEVMAssignation new.
	assignment
		variable: var;
		value: aNode.
	var lastValue: aNode.
	self scope sequence addStatement: assignment.
	^ var
]

{ #category : #public }
FogEVMIREthereumDecompiler >> basicDecompile [
	[ self programHasFinished ] whileFalse: [ self fetchNextInstruction accept: self with: nil ]
]

{ #category : #convenience }
FogEVMIREthereumDecompiler >> binaryMessageSend: selector receiver: receiver argument: argument [
	| messageSend variable  |
	messageSend := FogEVMAstBinaryMessageSend new.
	messageSend receiver: receiver.
	messageSend selector: selector.
	messageSend argument: argument.
	variable := self assignToTemporaryVariable: messageSend.
	^ variable
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> calldata [
	^ self runtimeGlobal: #calldata
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> caller [
	^ self messageSend: #sender receiver: self message arguments: {}
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> coinbase [
	^ self runtimeGlobal: #coinbase
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> currentBlock [
	^ self runtimeGlobal: #currentBlock
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> currentGas [
	^ self runtimeGlobal: #currentGas
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> currentGasPrice [
	^ self messageSend: #gasPrice receiver: self calldata arguments: {}
]

{ #category : #public }
FogEVMIREthereumDecompiler >> currentInstruction [
	^ instruction 
]

{ #category : #public }
FogEVMIREthereumDecompiler >> decompile: aFogEVMMnemonicContract [
	program := aFogEVMMnemonicContract content copy.
	instructionPointer := 1.
	destinations := Dictionary new.
	self newScope.
	self basicDecompile.
	^ scope sequence 
]

{ #category : #decompiling }
FogEVMIREthereumDecompiler >> decompilePackage: aFogPackage [
	^( aFogPackage descriptions
		collect: [ :d | 
			| deploy lookup | 
			deploy := self decompile: (FogEVMByteCode fromBinary: d binary).
			lookup :=  self decompile: (FogEVMByteCode fromBinary: d runtime).
			d -> ({deploy . lookup }) ]) asDictionary 
]

{ #category : #public }
FogEVMIREthereumDecompiler >> fetchNextInstruction [
	instruction := program at: instructionPointer.
	self trace add: instruction.
	instructionPointer := instructionPointer + 1.
	^ instruction
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> getContractAt: contractAddress [
	^ self messageSend: 'getContractAt:' receiver: self runtimeGlobal arguments: {contractAddress}
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> getOrCreateJumpDestination [
	^ destinations
		at: self currentInstruction byteNumber
		ifAbsentPut: [ | destination |
			destination := FogEVMAstJumpDestination new.
			destination address: self currentInstruction byteNumber.
			destination instruction: self currentInstruction ]
]

{ #category : #testing }
FogEVMIREthereumDecompiler >> isValidDestination: aFogEVMAstVariable [
	^ (program detect: [ :b | b byteNumber = aFogEVMAstVariable read ] ifNone: [ ^ false ]) instruction
		isValidJumpDestination
]

{ #category : #convenience }
FogEVMIREthereumDecompiler >> literalOrVariable: anObject [
	^ anObject isString
		ifTrue: [ FogEVMLiteral for: anObject ]
		ifFalse: [ (anObject isEVMLiteral or: [ anObject isEVMVariable ])
				ifTrue: [ anObject ]
				ifFalse: [ self halt: 'Should be string!' ] ]
]

{ #category : #convenience }
FogEVMIREthereumDecompiler >> memoryReadfrom: from to: to [
	| node fromAddress toAddress |
	node := FogEVMAstMemoryLoad new.
	fromAddress := self literalOrVariable: from .
	toAddress := self literalOrVariable: to.
	node fromAddress: fromAddress.
	node amountOfBytes: toAddress.
	^ self assignToTemporaryVariable: node
]

{ #category : #convenience }
FogEVMIREthereumDecompiler >> memoryWriteAt: at value: value [
	| memoryStoreNode |
	memoryStoreNode := FogEVMAstMemoryStore new.
	memoryStoreNode address: at .
	memoryStoreNode value: value.
	^ memoryStoreNode
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> message [
	^ self runtimeGlobal: #message
]

{ #category : #convenience }
FogEVMIREthereumDecompiler >> messageSend: selector receiver: receiver arguments: arguments [
	| messageSend variable  |
	messageSend := FogEVMAstMessageSend new.
	messageSend receiver: receiver.
	messageSend selector: selector.
	messageSend arguments: arguments.
	variable := self assignToTemporaryVariable: messageSend.
	^ variable
]

{ #category : #public }
FogEVMIREthereumDecompiler >> newScope [
	^ scope := FogEVMAstScope new
		initializeWith: nil;
		yourself
]

{ #category : #public }
FogEVMIREthereumDecompiler >> newScopeDuring: aBlock [
	| sp |
	sp := self newSubScope.
	aBlock value.
	scope := scope parent.
	^ sp
]

{ #category : #public }
FogEVMIREthereumDecompiler >> newSubScope [
	^ scope := scope newScope
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> origin [
	^ self runtimeGlobal: #origin
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> pop [
	^ self stack pop
]

{ #category : #convenience }
FogEVMIREthereumDecompiler >> programHasFinished [
	^ instructionPointer > program size or: [ scope isClosed  ]
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> push: anObject [ 
	^ self stack push: anObject
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> returningData [
	^ self runtimeGlobal: #returningData
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> runningContract [
	^ self runtimeGlobal: #runningContract
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> runningContractAddress [
	^ self messageSend: #address receiver: self runningContract arguments: {}
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> runtimeGlobal [
	^ self specialVariableNamed: #Runtime loadedWith: FogEVMAstRuntimeGlobal new
]

{ #category : #globals }
FogEVMIREthereumDecompiler >> runtimeGlobal: anAccessor [
	^ self messageSend: anAccessor receiver: self runtimeGlobal arguments: {}
]

{ #category : #public }
FogEVMIREthereumDecompiler >> scope [
	^ scope
]

{ #category : #public }
FogEVMIREthereumDecompiler >> setNextInstruction: anInstructionPointer [
	instructionPointer := anInstructionPointer
]

{ #category : #public }
FogEVMIREthereumDecompiler >> setNextInstructionToByte: anInstructionPointer [ 
	instruction := program detect:[ :b | b byteNumber = anInstructionPointer].
	self assert: instruction instruction isValidJumpDestination.
	instructionPointer := program indexOf: instruction.
	^ instruction
]

{ #category : #convenience }
FogEVMIREthereumDecompiler >> specialVariableNamed: aName loadedWith: aNode [
	| variable |
	variable := self scope temporaries
		detect: [ :t | t name = aName ]
		ifNone: [ | var assign |
			var := FogEVMAstVariable new.
			var createdAt: self currentInstruction.
			var name: aName. 
			assign := FogEVMAssignation new.
			assign variable: var.
			assign value: aNode.
			self scope addTemporary: var.
			self scope sequence addStatement: assign.
			var ].
	^ variable
]

{ #category : #public }
FogEVMIREthereumDecompiler >> stack [
	^ scope stack
]

{ #category : #utility }
FogEVMIREthereumDecompiler >> stackSize [
	^ self stack size
]

{ #category : #public }
FogEVMIREthereumDecompiler >> trace [
	^ scope trace
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitAdd: aFogVMAdd [
	| variable |
	self visitNode: aFogVMAdd .
	variable := self
		binaryMessageSend: #+
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitAddress: aFogVMAddress [
	self visitNode: aFogVMAddress.
	self push: self runningContractAddress
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitAnd: aFogVMAnd [
	| variable |
	self visitNode: aFogVMAnd.
	variable := self binaryMessageSend: #& receiver: (self literalOrVariable: self pop) argument: (self literalOrVariable: self pop).
	self push: variable
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitBalance: aFogVMBalance [
	| var |
	self visitNode: aFogVMBalance.
	var := self
		messageSend: #balanceFor:
		receiver: self runtimeGlobal
		arguments: {(self literalOrVariable: self pop)}.
	self push: var
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitBlockhash: aFogVMBlockhash [
	self visitNode: aFogVMBlockhash.
	self
		push:
			(self
				messageSend: #blockHashFor:
				receiver: self runtimeGlobal
				arguments: {(self literalOrVariable: self pop)})
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitByte: aFogVMByte [
	| chunk position |
	self visitNode: aFogVMByte.
	chunk := self literalOrVariable: self pop.
	position := self literalOrVariable: self pop.
	self push: (self messageSend: #at: receiver: chunk arguments: {position})
]

{ #category : #calling }
FogEVMIREthereumDecompiler >> visitCall: aFogVMCall [
	| var call |
	self visitNode: aFogVMCall.
	call := FogEVMAstCall new.
	call gas: (self literalOrVariable: self pop).
	call address: (self literalOrVariable: self pop).
	call money: (self literalOrVariable: self pop).
	call input: (self memoryReadfrom: (self literalOrVariable: self pop) to: (self literalOrVariable: self pop)).
	call output: (self memoryWriteAt: (self literalOrVariable: self pop) value: (self literalOrVariable: self pop)).
	var := self messageSend: #output receiver: call arguments: {}.
	self push: var


	"^ '
func opCall(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Pop gas. The actual gas in interpreter.evm.callGasTemp.
	interpreter.intPool.put(stack.pop())
	gas := interpreter.evm.callGasTemp
	// Pop other call parameters.
	addr, value, inOffset, inSize, retOffset, retSize := stack.pop(), stack.pop(), stack.pop(), stack.pop(), stack.pop(), stack.pop()
	toAddr := common.BigToAddress(addr)
	value = math.U256(value)
	// Get the arguments from the memory.
	args := memory.Get(inOffset.Int64(), inSize.Int64())

	if value.Sign() != 0 {
		gas += params.CallStipend
	}
	ret, returnGas, err := interpreter.evm.Call(contract, toAddr, args, gas, value)
	if err != nil {
		stack.push(interpreter.intPool.getZero())
	} else {
		stack.push(interpreter.intPool.get().SetUint64(1))
	}
	if err == nil || err == errExecutionReverted {
		memory.Set(retOffset.Uint64(), retSize.Uint64(), ret)
	}
	contract.Gas += returnGas

	interpreter.intPool.put(addr, value, inOffset, inSize, retOffset, retSize)
	return ret, nil
}'"
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCalldatacopy: aFogVMCalldatacopy [
	| memOffset dataOffset length var |
	self visitNode: aFogVMCalldatacopy.
	memOffset := self literalOrVariable: self pop.
	dataOffset := self literalOrVariable: self pop.
	length := self literalOrVariable: self pop.
	var := self
		messageSend: #readFrom:to:
		receiver: (self calldata)
		arguments:
			{dataOffset.
			length}.
	self scope sequence addStatement: (self memoryWriteAt: memOffset value: var)
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCalldataload: aFogVMCalldataload [
	| var |
	self visitNode: aFogVMCalldataload.
	var := self messageSend: #wordAt: receiver: self calldata arguments: {(self literalOrVariable: self pop)}.
	self push: var
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCalldatasize: aFogVMCalldatasize [
	| sizeMessage |
	self visitNode: aFogVMCalldatasize.
	sizeMessage := self messageSend: #size receiver: self calldata arguments: {}.
	self push: sizeMessage
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCaller: aFogVMCaller [
	self visitNode: aFogVMCaller.
	self push: self caller
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCallvalue: aFogVMCallvalue [
	self visitNode: aFogVMCallvalue.
	self push: 6 write0xHexadecimal.
	self visitCalldataload: aFogVMCallvalue
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCodecopy: aFogVMCodecopy [
	| value writeAt |
	self visitNode: aFogVMCodecopy.
	writeAt := (self literalOrVariable:  self pop).
	value := self
		messageSend: #copyInstructionsFrom:amount:
		receiver: self runningContract
		arguments:
			{(self literalOrVariable: self pop).
			(self literalOrVariable: self pop)}.
	self scope sequence addStatement: (self memoryWriteAt: writeAt value: value)
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCodesize: aFogVMCodesize [
	|  var |
	self visitNode: aFogVMCodesize.
	var := self messageSend: #codeSize receiver: self runningContract arguments: {}.
	self push: var
]

{ #category : #'visit globals' }
FogEVMIREthereumDecompiler >> visitCoinbase: aFogVMCoinbase [ 
	self visitNode: aFogVMCoinbase.
	self push: (self messageSend: #address receiver: self coinbase arguments: {})
]

{ #category : #'visit globals' }
FogEVMIREthereumDecompiler >> visitDifficulty: aFogVMDifficulty [ 
	self visitNode: aFogVMDifficulty.
	self push: (self messageSend: #difficulty receiver: self currentBlock arguments: {}).
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitDiv: aFogVMDiv [
	| variable |
	self visitNode: aFogVMDiv.
	variable := self
		binaryMessageSend: #/
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitDup: aFogVMDup [
	| element |
	self visitNode: aFogVMDup.
"	(self stack size = (aFogVMDup expectedPops -1)) ifTrue: [ self halt ]."
	element := self stack at: aFogVMDup expectedPops.
	self stack push: element 
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitEq: aFogVMEq [
	| variable |
	self visitNode: aFogVMEq.
	variable := self
		binaryMessageSend: #=
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitExp: aFogVMExp [
	| variable |
	self visitNode: aFogVMExp.
	variable := self
		binaryMessageSend: #**
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitExtcodecopy: aFogVMExtcodecopy [
	| value writeAt contractAddress |
	self visitNode: aFogVMExtcodecopy.
	contractAddress := self literalOrVariable: self pop.
	writeAt := self literalOrVariable: self pop.
	value := self
		messageSend: #copyInstructionsFrom:amount:
		receiver: (self getContractAt: contractAddress)
		arguments:
			{(self literalOrVariable: self pop).
			(self literalOrVariable: self pop)}.
	self scope sequence addStatement: (self memoryWriteAt: writeAt value: value)
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitExtcodehash: aFogVMExtcodehash [ 
	| var |
	self visitNode: aFogVMExtcodehash.
	var := self
		messageSend: #blockHashFor:
		receiver: self runtimeGlobal
		arguments: {(self literalOrVariable: self pop)}.
	self push: var
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitExtcodesize: aFogVMExtcodesize [
	| var |
	self visitNode: aFogVMExtcodesize.
	var := self
		messageSend: #codeSizeForContract:
		receiver: self runtimeGlobal
		arguments: {(self literalOrVariable: self pop)}.
	self push: var
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitGas: aFogVMGas [
	self visitNode: aFogVMGas.
	self push: self currentGas
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitGaslimit: aFogVMGaslimit [
	self visitNode: aFogVMGaslimit.
	self push: (self messageSend: #gasLimit receiver: self currentBlock arguments: {})
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitGasprice: aFogVMGasprice [
	self visitNode: aFogVMGasprice.
	self push: self currentGasPrice
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitGt: aFogVMGt [
	| variable |
	self visitNode: aFogVMGt.
	variable := self
		binaryMessageSend: #>
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitInvalid: aFogVMInvalid [
	| invalid |
	self visitNode: aFogVMInvalid.
	invalid := FogEVMAstInvalid new.
	invalid instruction: self currentInstruction.
	self scope sequence addStatement: invalid
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitIszero: aFogVMIszero [
	| variable |
	self visitNode: aFogVMIszero.
	variable := self
		binaryMessageSend: #=
		receiver: self pop
		argument: (FogEVMLiteral for: '0x0').
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitJump: aFogVMJump [
	| jump |
	self visitNode: aFogVMJump.
	jump := FogEVMAstJump new.
	jump address: self pop.
	(jump address isAccessible and: [ self isValidDestination: jump address ])
		ifTrue: [ 
			jump instruction: self currentInstruction.
			jump instruction: (self setNextInstructionToByte: jump address read).
			self scope sequence addStatement: jump 
		] ifFalse: [ 
			self error: 'Error' 
		]
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitJumpDestinationTo: jump [
	| ip destination |
	(jump address isAccessible and: [ self isValidDestination: jump address ])
		ifTrue: [ ip := instructionPointer.
			self setNextInstructionToByte: jump address read.
			destination := self scope
				getProcessedInstruction: self currentInstruction
				ifNone: [ | new |
					new := self getOrCreateJumpDestination.
					new scope ifNil: [ new scope: (self newScopeDuring: [ self basicDecompile ]) ].
					new ].
			destination addOrigin: jump.
			self setNextInstruction: ip.
			^ destination ]
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitJumpdest: aFogVMJumpdest [
	| destination |
	self visitNode: aFogVMJumpdest.
"	destination := self getOrCreateJumpDestination.
	self scope sequence addStatement: destination.
	^ destination"
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitJumpi: aFogVMJumpi [
	| conditionalJump |
	self visitNode: aFogVMJumpi.
	conditionalJump := FogEVMAstConditionalJump new.
	conditionalJump
		address: self pop;
		condition: self pop.
	self scope sequence addStatement: conditionalJump.
	conditionalJump destination: (self visitJumpDestinationTo: conditionalJump) scope
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitLog: aFogVMLog [
	| log topics var |
	self visitNode: aFogVMLog.
	topics := OrderedCollection new.
	log := FogEVMAstLog new.
	log message: (self memoryReadfrom: self pop to: self pop).
	aFogVMLog topicsAmount timesRepeat: [ topics add: (self literalOrVariable: self pop) ].
	log instruction: self currentInstruction.
	var := self assignToTemporaryVariable: log.
	self scope sequence addStatement: var
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitLt: aFogVMLt [
	| variable |
	self visitNode: aFogVMLt.
	variable := self
		binaryMessageSend: #<
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMload: aFogVMMload [
	| memoryLoadNode from amount var |
	self visitNode: aFogVMMload.
	memoryLoadNode := FogEVMAstMemoryLoad new.
	from := self literalOrVariable: self pop.
	amount := self literalOrVariable: FogEVMAbstractInterpreter wordSize write0xHexadecimal.
	memoryLoadNode fromAddress: from.
	memoryLoadNode amountOfBytes: amount.
	var := self assignToTemporaryVariable: memoryLoadNode.
	self push: var
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMod: aFogVMMod [
	| variable |
	self visitNode: aFogVMMod.
	variable := self
		binaryMessageSend: #mod
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMstore8: aFogVMMstore8 [
	| val |
	self visitNode: aFogVMMstore8.
	val := self memoryWriteAt: (self literalOrVariable: self pop) value: (self literalOrVariable: self pop).
	val isByteStore: true.
	self scope sequence addStatement: val
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMstore: aFogVMMstore [
	self visitNode: aFogVMMstore.
	self scope sequence
		addStatement:
			(self
				memoryWriteAt: (self literalOrVariable: self pop)
				value: (self literalOrVariable: self pop))
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMul: aFogVMMul [
	| variable |
	self visitNode: aFogVMMul.
	variable := self
		binaryMessageSend: #*
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitNode: aNode [
	self scope sequence instruction: aNode.
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitNot: aFogVMNot [
	| variable |
	self visitNode: aFogVMNot.
	variable := self
		messageSend: #not
		receiver: (self literalOrVariable: self pop)
		arguments: {}.
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitNumber: aFogVMNumber [
	| var |
	self visitNode: aFogVMNumber.
	var := self messageSend: #number receiver: self currentBlock arguments: {}.
	self push: var
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitOr: aFogVMOr [
	| variable |
	self visitNode: aFogVMOr.
	variable := self
		binaryMessageSend: #'||'
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable
]

{ #category : #'visit globals' }
FogEVMIREthereumDecompiler >> visitOrigin: aFogVMOrigin [
	self visitNode: aFogVMOrigin.
	self push: self origin
]

{ #category : #'visit globals' }
FogEVMIREthereumDecompiler >> visitPc: aFogVMPc [
	self push: (self runtimeGlobal: #currentProgramCounter)
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitPop: aFogVMPop [
	"	| pop |
	pop := FogEVMAstPop new.
	pop variable: "
	self visitNode: aFogVMPop.
	self pop
	"	self currentScope sequence addStatement: pop"
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitPush: aFogVMPush1 [
	| variable literal |
	self visitNode: aFogVMPush1.
	literal := self literalOrVariable: aFogVMPush1 parameter.
	variable := self assignToTemporaryVariable: literal.
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitReturn: aFogVMReturn [
	| var |
	self visitNode: aFogVMReturn.
	var := self
		messageSend: #readFrom:to:
		receiver: self returningData
		arguments:
			{(self literalOrVariable: self pop).
			(self literalOrVariable: self pop)}.
	self scope sequence addStatement: var.
	self scope finishesAt: self currentInstruction
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitReturndatacopy: aFogVMReturndatacopy [
	| memOffset dataOffset length var |
	self visitNode: aFogVMReturndatacopy.
	memOffset := self literalOrVariable: self pop.
	dataOffset := self literalOrVariable: self pop.
	length := self literalOrVariable: self pop.
	var := self
		messageSend: #readFrom:to:
		receiver: self returningData
		arguments:
			{dataOffset.
			length}.
	self scope sequence addStatement: (self memoryWriteAt: memOffset value: var)
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitReturndatasize: aFogVMReturndatasize [
	| var |
	self visitNode: aFogVMReturndatasize.
	var := self messageSend: #size receiver: self returningData arguments: {}.
	self push: var
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitRevert: aFogVMRevert [
	| rev |
	self visitNode: aFogVMRevert.
	rev := FogEVMAstRevert new.
	rev message: (self memoryReadfrom: self pop to: self pop).
	rev instruction: self currentInstruction.
	self scope sequence addStatement: rev
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSelfdestruct: aFogVMSelfdestruct [
	| sd |
	self visitNode: aFogVMSelfdestruct.
	sd := FogEVMAstSelfDestruct new.
	sd account: (self literalOrVariable: self pop).
	sd instruction: self currentInstruction.
	self scope sequence addStatement: sd
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSha3: aFogVMSha3 [
	| content result |
	self visitNode: aFogVMSha3.
	content := self memoryReadfrom: self pop to: self pop.
	result := self messageSend: #sha3: receiver: self runtimeGlobal arguments: {content}.
	self push: result
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSload: aFogVMSload [
	| storageLoadNode from var |
	self visitNode: aFogVMSload.
	storageLoadNode := FogEVMAstStorageLoad new.
	from := self literalOrVariable: self pop.
	storageLoadNode address: from.
	var := self assignToTemporaryVariable: storageLoadNode.
	self push: var
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSlt: aFogVMSlt [
	| variable |
	self visitNode: aFogVMSlt.
	variable := self
		messageSend: #signedIsLesserThan:
		receiver: (self literalOrVariable: self pop)
		arguments: {(self literalOrVariable: self pop)}.
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSstore: aFogVMSstore [
	| sStoreNode |
	self visitNode: aFogVMSstore.
	sStoreNode := FogEVMAstStorageStore new.
	sStoreNode address: (self literalOrVariable: self pop).
	sStoreNode value: (self literalOrVariable: self pop).
	self scope sequence addStatement: sStoreNode
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitStop: aFogVMStop [
	self visitNode: aFogVMStop.
	self scope sequence isClosed: true
	"	stop := FogEVMAstStop new.
	stop address: self currentInstruction.
	self scope sequence addStatement: stop.
	"
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSub: aFogVMSub [
	| variable |
	self visitNode: aFogVMSub.
	variable := self
		binaryMessageSend: #-
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSwap: aFogVMSwap [
	self visitNode: aFogVMSwap.
	self stack swap: 1 with: aFogVMSwap expectedPops - 1
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitTimestamp: aFogVMTimestamp [
	self visitNode: aFogVMTimestamp.
	self push: (self messageSend: #timestamp receiver: self currentBlock arguments: {})
]
