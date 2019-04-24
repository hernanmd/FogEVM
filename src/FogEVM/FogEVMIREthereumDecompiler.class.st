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
	messageSend := FogEVMAstMessageSend new.
	messageSend receiver: receiver.
	messageSend selector: selector.
	messageSend arguments: {argument}.
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
	| read |
	read := aFogEVMAstVariable read.
	^ (program detect: [ :b | b byteNumber = read ] ifNone: [ ^ false ]) instruction
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
	memoryStoreNode amount: FogEVMAbstractInterpreter byteSize.
	^ memoryStoreNode
]

{ #category : #convenience }
FogEVMIREthereumDecompiler >> memoryWriteAt: at value: value amount: anAmount [
	| memoryStoreNode |
	memoryStoreNode := FogEVMAstMemoryStore new.
	memoryStoreNode address: at .
	memoryStoreNode value: value.
	memoryStoreNode amount: anAmount.
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
	
	variable := self
		binaryMessageSend: #plus:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self visitNode: aFogVMAdd .
	self push: variable
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitAddmod: aFogVMAddmod [
	| variable |
	
	variable := self
		binaryMessageSend: #plus:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	variable := self
		binaryMessageSend: #mod:
		receiver: variable
		argument: (self literalOrVariable: self pop).
	self visitNode: aFogVMAddmod.
	self push: variable
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitAddress: aFogVMAddress [
	self push: self runningContractAddress.
	self visitNode: aFogVMAddress
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitAnd: aFogVMAnd [
	| variable |
	variable := self
		binaryMessageSend: #and:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMAnd
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitBalance: aFogVMBalance [
	| var |
	var := self
		messageSend: #balanceFor:
		receiver: self runtimeGlobal
		arguments: {(self literalOrVariable: self pop)}.
	self push: var.
	self visitNode: aFogVMBalance
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitBlockhash: aFogVMBlockhash [
	self
		push:
			(self
				messageSend: #blockHashFor:
				receiver: self runtimeGlobal
				arguments: {(self literalOrVariable: self pop)}).
	self visitNode: aFogVMBlockhash
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitByte: aFogVMByte [
	| chunk position |
	chunk := self literalOrVariable: self pop.
	position := self literalOrVariable: self pop.
	self push: (self messageSend: #at: receiver: chunk arguments: {position}).
	self visitNode: aFogVMByte
]

{ #category : #calling }
FogEVMIREthereumDecompiler >> visitCall: aFogVMCall [
	| var call |
	call := FogEVMAstCall new.
	call gas: (self literalOrVariable: self pop).
	call address: (self literalOrVariable: self pop).
	call money: (self literalOrVariable: self pop).
	call
		input:
			(self
				memoryReadfrom: (self literalOrVariable: self pop)
				to: (self literalOrVariable: self pop)).
	call
		output:
			(self
				memoryWriteAt: (self literalOrVariable: self pop)
				value: (self literalOrVariable: self pop)).
	var := self messageSend: #output receiver: call arguments: {}.
	self push: var.
	self visitNode: aFogVMCall


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
	memOffset := self literalOrVariable: self pop.
	dataOffset := self literalOrVariable: self pop.
	length := self literalOrVariable: self pop.
	var := self
		messageSend: #readFrom:to:
		receiver: self calldata
		arguments:
			{dataOffset.
			length}.
	self scope sequence addStatement: (self memoryWriteAt: memOffset value: var).
	self visitNode: aFogVMCalldatacopy
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCalldataload: aFogVMCalldataload [
	| var |
	var := self
		messageSend: #wordAt:
		receiver: self calldata
		arguments: {(self literalOrVariable: self pop)}.
	self push: var.
	self visitNode: aFogVMCalldataload
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCalldatasize: aFogVMCalldatasize [
	| sizeMessage |
	sizeMessage := self messageSend: #size receiver: self calldata arguments: {}.
	self push: sizeMessage.
	self visitNode: aFogVMCalldatasize
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCaller: aFogVMCaller [
	self push: self caller.
	self visitNode: aFogVMCaller
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCallvalue: aFogVMCallvalue [
	self push: 6 write0xHexadecimal.
	self visitCalldataload: aFogVMCallvalue.
	self visitNode: aFogVMCallvalue
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCodecopy: aFogVMCodecopy [
	| value writeAt |
	writeAt := self literalOrVariable: self pop.
	value := self
		messageSend: #copyInstructionsFrom:amount:
		receiver: self runningContract
		arguments:
			{(self literalOrVariable: self pop).
			(self literalOrVariable: self pop)}.
	self scope sequence addStatement: (self memoryWriteAt: writeAt value: value).
	self visitNode: aFogVMCodecopy
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitCodesize: aFogVMCodesize [
	| var |
	var := self messageSend: #codeSize receiver: self runningContract arguments: {}.
	self push: var.
	self visitNode: aFogVMCodesize
]

{ #category : #'visit globals' }
FogEVMIREthereumDecompiler >> visitCoinbase: aFogVMCoinbase [
	self push: (self messageSend: #address receiver: self coinbase arguments: {}).
	self visitNode: aFogVMCoinbase
]

{ #category : #'visit globals' }
FogEVMIREthereumDecompiler >> visitDifficulty: aFogVMDifficulty [
	self push: (self messageSend: #difficulty receiver: self currentBlock arguments: {}).
	self visitNode: aFogVMDifficulty
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitDiv: aFogVMDiv [
	| variable |
	variable := self
		binaryMessageSend: #divide:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMDiv
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitDup: aFogVMDup [
	| element |
	"	(self stack size = (aFogVMDup expectedPops -1)) ifTrue: [ self halt ]."
	element := self stack at: aFogVMDup expectedPops.
	self stack push: element.
	self visitNode: aFogVMDup
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitEq: aFogVMEq [
	| variable |
	variable := self
		binaryMessageSend: #equals:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMEq.
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitExp: aFogVMExp [
	| variable |
	variable := self
		binaryMessageSend: #power:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMExp
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitExtcodecopy: aFogVMExtcodecopy [
	| value writeAt contractAddress |
	contractAddress := self literalOrVariable: self pop.
	writeAt := self literalOrVariable: self pop.
	value := self
		messageSend: #copyInstructionsFrom:amount:
		receiver: (self getContractAt: contractAddress)
		arguments:
			{(self literalOrVariable: self pop).
			(self literalOrVariable: self pop)}.
	self scope sequence addStatement: (self memoryWriteAt: writeAt value: value).
	self visitNode: aFogVMExtcodecopy
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitExtcodehash: aFogVMExtcodehash [
	| var |
	var := self
		messageSend: #blockHashFor:
		receiver: self runtimeGlobal
		arguments: {(self literalOrVariable: self pop)}.
	self push: var.
	self visitNode: aFogVMExtcodehash
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitExtcodesize: aFogVMExtcodesize [
	| var |
	var := self
		messageSend: #codeSizeForContract:
		receiver: self runtimeGlobal
		arguments: {(self literalOrVariable: self pop)}.
	self push: var.
	self visitNode: aFogVMExtcodesize
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitGas: aFogVMGas [
	self push: self currentGas.
	self visitNode: aFogVMGas
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitGaslimit: aFogVMGaslimit [
	self push: (self messageSend: #gasLimit receiver: self currentBlock arguments: {}).
	self visitNode: aFogVMGaslimit
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitGasprice: aFogVMGasprice [
	self push: self currentGasPrice.
	self visitNode: aFogVMGasprice
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitGt: aFogVMGt [
	| variable |
	variable := self
		binaryMessageSend: #greaterThan:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMGt
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitInvalid: aFogVMInvalid [
	| invalid |
	invalid := FogEVMAstInvalid new.
	invalid instruction: self currentInstruction.
	self scope sequence addStatement: invalid.
	self visitNode: aFogVMInvalid
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitIszero: aFogVMIszero [
	| variable |
	variable := self
		binaryMessageSend: #equals:
		receiver: self pop
		argument: (FogEVMLiteral for: '0x0').
	self push: variable.
	self visitNode: aFogVMIszero
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitJump: aFogVMJump [
	| jump |
	jump := FogEVMAstJump new.
	jump address: self pop.
	(jump address isAccessible and: [ self isValidDestination: jump address ])
		ifTrue: [ (destinations includesKey: jump address read)
				ifTrue: [ self scope sequence isClosed: true ]
				ifFalse: [ jump instruction: self currentInstruction.
					jump instruction: (self setNextInstructionToByte: jump address read).
					self scope sequence addStatement: jump.
					self visitNode: aFogVMJump ] ]
		ifFalse: [ self error: 'Error' ]
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitJumpDestinationTo: jump [
	| ip destination |
	(jump address isAccessible and: [ self isValidDestination: jump address ])
		ifTrue: [ ip := instructionPointer.
			self setNextInstructionToByte: jump address read.
			destination := (self scope
				getProcessedInstruction: self currentInstruction
				ifNone: [ | new |
					jump instruction: self currentInstruction.
					new := self getOrCreateJumpDestination.
					new scope ifNil: [ new scope: (self newScopeDuring: [ self basicDecompile ]) ].
					new ]) jumpDestination.
			destination addOrigin: jump.
			self setNextInstruction: ip.
			^ destination ]
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitJumpdest: aFogVMJumpdest [
	self visitNode: aFogVMJumpdest.
	self getOrCreateJumpDestination
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitJumpi: aFogVMJumpi [
	| conditionalJump |
	conditionalJump := FogEVMAstConditionalJump new.
	conditionalJump
		address: self pop;
		condition: self pop.

	self scope sequence addStatement: conditionalJump.
	conditionalJump jumpDestination: (self visitJumpDestinationTo: conditionalJump).
	self visitNode: aFogVMJumpi
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitLog: aFogVMLog [
	| log message |
	log := FogEVMAstLog new.
	message := self memoryReadfrom: self pop to: self pop.
	log message: message.
	aFogVMLog topicsAmount
		timesRepeat: [ log topics add: (self literalOrVariable: self pop) ].
	log instruction: self currentInstruction.
	self assignToTemporaryVariable: log.
	self visitNode: aFogVMLog
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitLt: aFogVMLt [
	| variable |
	variable := self
		binaryMessageSend: #lesserThan:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMLt
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMload: aFogVMMload [
	| memoryLoadNode from amount var |
	memoryLoadNode := FogEVMAstMemoryLoad new.
	from := self literalOrVariable: self pop.
	amount := self literalOrVariable: FogEVMAbstractInterpreter wordSize write0xHexadecimal.
	memoryLoadNode fromAddress: from.
	memoryLoadNode amountOfBytes: amount.
	var := self assignToTemporaryVariable: memoryLoadNode.
	self push: var.
	self visitNode: aFogVMMload
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMod: aFogVMMod [
	| variable |
	variable := self
		binaryMessageSend: #mod:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMMod
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMsize: aFogVMMsize [
	self push: (self runtimeGlobal: #memorySize).
	self visitNode: aFogVMMsize
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMstore8: aFogVMMstore8 [
	| val |
	val := self
		memoryWriteAt: (self literalOrVariable: self pop)
		value: (self literalOrVariable: self pop)
		amount: (self literalOrVariable: FogEVMAbstractInterpreter byteSize write0xHexadecimal).
	self scope sequence addStatement: val.
	self visitNode: aFogVMMstore8
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMstore: aFogVMMstore [
	self scope sequence
		addStatement:
			(self
				memoryWriteAt: (self literalOrVariable: self pop)
				value: (self literalOrVariable: self pop)
				amount: (self literalOrVariable: FogEVMAbstractInterpreter wordSize write0xHexadecimal)).
	self visitNode: aFogVMMstore
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMul: aFogVMMul [
	| variable |
	variable := self
		binaryMessageSend: #multiply:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMMul
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitMulmod: aFogVMMulmod [
	| variable |
	variable := self
		binaryMessageSend: #multiply:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	variable := self
		binaryMessageSend: #mod:
		receiver: variable
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMMulmod
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitNode: aNode [
	| sequence |
	sequence := self scope sequence statements
		ifEmpty: [ self scope parent sequence ]
		ifNotEmpty: [ self scope sequence ].
	sequence statements last instruction: aNode
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitNot: aFogVMNot [
	| variable |
	variable := self
		messageSend: #not
		receiver: (self literalOrVariable: self pop)
		arguments: {}.
	self push: variable.
	self visitNode: aFogVMNot
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitNumber: aFogVMNumber [
	| var |
	var := self messageSend: #number receiver: self currentBlock arguments: {}.
	self push: var.
	self visitNode: aFogVMNumber
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitOr: aFogVMOr [
	| variable |
	variable := self
		binaryMessageSend: #or:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMOr
]

{ #category : #'visit globals' }
FogEVMIREthereumDecompiler >> visitOrigin: aFogVMOrigin [
	self push: self origin.
	self visitNode: aFogVMOrigin
]

{ #category : #'visit globals' }
FogEVMIREthereumDecompiler >> visitPc: aFogVMPc [
	self push: (self runtimeGlobal: #currentProgramCounter).
	self visitNode: aFogVMPc
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitPop: aFogVMPop [
	"	| pop |
	pop := FogEVMAstPop new.
	pop variable: "

	self pop.
	self visitNode: aFogVMPop
	"	self currentScope sequence addStatement: pop"
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitPush: aFogVMPush1 [
	| variable literal |
	literal := self literalOrVariable: aFogVMPush1 parameter.
	variable := self assignToTemporaryVariable: literal.
	self push: variable.
	self visitNode: aFogVMPush1
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitReturn: aFogVMReturn [
	| var |
	var := self
		messageSend: #readFrom:to:
		receiver: self returningData
		arguments:
			{(self literalOrVariable: self pop).
			(self literalOrVariable: self pop)}.
	self scope sequence addStatement: var.
	self scope sequence isClosed: true.
	self visitNode: aFogVMReturn
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitReturndatacopy: aFogVMReturndatacopy [
	| memOffset dataOffset length var |
	memOffset := self literalOrVariable: self pop.
	dataOffset := self literalOrVariable: self pop.
	length := self literalOrVariable: self pop.
	var := self
		messageSend: #readFrom:to:
		receiver: self returningData
		arguments:
			{dataOffset.
			length}.
	self scope sequence addStatement: (self memoryWriteAt: memOffset value: var).
	self visitNode: aFogVMReturndatacopy
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitReturndatasize: aFogVMReturndatasize [
	| var |
	var := self messageSend: #size receiver: self returningData arguments: {}.
	self push: var.
	self visitNode: aFogVMReturndatasize
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitRevert: aFogVMRevert [
	| rev |
	rev := FogEVMAstRevert new.
	rev message: (self memoryReadfrom: self pop to: self pop).
	rev instruction: self currentInstruction.
	self scope sequence addStatement: rev.
	self visitNode: aFogVMRevert
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSar: aFogVMSar [
	| variable |
	variable := self
		binaryMessageSend: #sar:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMSar
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSdiv: aFogVMSdiv [
	| variable |
	variable := self
		binaryMessageSend: #signedDivision:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMSdiv
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSelfdestruct: aFogVMSelfdestruct [
	| sd |
	sd := FogEVMAstSelfDestruct new.
	sd account: (self literalOrVariable: self pop).
	sd instruction: self currentInstruction.
	self scope sequence addStatement: sd.
	self visitNode: aFogVMSelfdestruct
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSgt: aFogVMSgt [
	| variable |
	variable := self
		binaryMessageSend: #signedGreaterThan:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMSgt
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSha3: aFogVMSha3 [
	| content result |
	content := self memoryReadfrom: self pop to: self pop.
	result := self messageSend: #sha3: receiver: self runtimeGlobal arguments: {content}.
	self push: result.
	self visitNode: aFogVMSha3
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitShl: aFogVMShl [
	| variable |
	variable := self
		binaryMessageSend: #shiftLeft:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMShl
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitShr: aFogVMShr [
	| variable |
	variable := self
		binaryMessageSend: #shiftRight:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMShr
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSignextend: aFogVMSignextend [
	| variable |
	variable := self
		binaryMessageSend: #extendRepresentationTo:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMSignextend
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSload: aFogVMSload [
	| storageLoadNode from var amount |
	storageLoadNode := FogEVMAstStorageLoad new.
	from := self literalOrVariable: self pop.
	amount := self literalOrVariable: FogEVMAbstractInterpreter wordSize write0xHexadecimal.
	storageLoadNode address: from.
	storageLoadNode amount: amount.
	var := self assignToTemporaryVariable: storageLoadNode.
	self push: var.
	self visitNode: aFogVMSload
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSlt: aFogVMSlt [
	| variable |
	variable := self
		messageSend: #signedIsLesserThan:
		receiver: (self literalOrVariable: self pop)
		arguments: {(self literalOrVariable: self pop)}.
	self push: variable.
	self visitNode: aFogVMSlt
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSmod: aFogVMSmod [
	| variable |
	variable := self
		binaryMessageSend: #signedMod:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMSmod
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSstore: aFogVMSstore [
	| sStoreNode |
	sStoreNode := FogEVMAstStorageStore new.
	sStoreNode address: (self literalOrVariable: self pop).
	sStoreNode value: (self literalOrVariable: self pop).
	self scope sequence addStatement: sStoreNode.
	self visitNode: aFogVMSstore
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitStop: aFogVMStop [
	self scope sequence isClosed: true.
	self visitNode: aFogVMStop
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSub: aFogVMSub [
	| variable |
	variable := self
		binaryMessageSend: #minus:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMSub
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitSwap: aFogVMSwap [
	self stack swap: 1 with: aFogVMSwap expectedPops.
	self visitNode: aFogVMSwap
]

{ #category : #'visiting global' }
FogEVMIREthereumDecompiler >> visitTimestamp: aFogVMTimestamp [
	self push: (self messageSend: #timestamp receiver: self currentBlock arguments: {}).
	self visitNode: aFogVMTimestamp
]

{ #category : #visiting }
FogEVMIREthereumDecompiler >> visitXor: aFogVMXor [
	| variable |
	variable := self
		binaryMessageSend: #xor:
		receiver: (self literalOrVariable: self pop)
		argument: (self literalOrVariable: self pop).
	self push: variable.
	self visitNode: aFogVMXor
]
