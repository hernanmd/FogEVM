"
Copy an accounts code to memory
"
Class {
	#name : #FogVMExtcodecopy,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMExtcodecopy class >> byteCode [
<doc>
		^'0x3c'.
	
]

{ #category : #'as yet unclassified' }
FogVMExtcodecopy class >> description [ 
<doc>
	^ 'Copy an accounts code to memory'
]

{ #category : #generated }
FogVMExtcodecopy class >> expectedPops [
<doc>
		^4.
	
]

{ #category : #generated }
FogVMExtcodecopy class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMExtcodecopy class >> gas [
<doc>
		^ self gasTable at: #gasExtCodeCopy.
]

{ #category : #generated }
FogVMExtcodecopy class >> goCode [
<doc>
	^ 'func opExtCodeCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		addr       = common.BigToAddress(stack.pop())
		memOffset  = stack.pop()
		codeOffset = stack.pop()
		length     = stack.pop()
	)
	codeCopy := getDataBig(interpreter.evm.StateDB.GetCode(addr), codeOffset, length)
	memory.Set(memOffset.Uint64(), length.Uint64(), codeCopy)

	interpreter.intPool.put(memOffset, codeOffset, length)
	return nil, nil
}

// opExtCodeHash returns the code hash of a specified account.
// There are sever'
]

{ #category : #'as yet unclassified' }
FogVMExtcodecopy class >> memoryUsage [
<doc>
		^ self memoryTable at: #memoryExtCodeCopy.
]

{ #category : #generated }
FogVMExtcodecopy class >> mnemonic [
<doc>
		^'EXTCODECOPY'.
	
]

{ #category : #'as yet unclassified' }
FogVMExtcodecopy >> writesMemory [
	^ true
]
