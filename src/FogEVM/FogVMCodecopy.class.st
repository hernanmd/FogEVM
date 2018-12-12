"
Copy code running in current environment to memory
"
Class {
	#name : #FogVMCodecopy,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCodecopy class >> byteCode [
<doc>
		^'0x39'.
	
]

{ #category : #'as yet unclassified' }
FogVMCodecopy class >> description [ 
<doc>
	^ 'Copy code running in current environment to memory'
]

{ #category : #generated }
FogVMCodecopy class >> expectedPops [
<doc>
		^3.
	
]

{ #category : #generated }
FogVMCodecopy class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMCodecopy class >> gas [
<doc>
		^ self gasTable at: #gasCodeCopy.
]

{ #category : #generated }
FogVMCodecopy class >> goCode [
<doc>
	^ 'func opCodeCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		memOffset  = stack.pop()
		codeOffset = stack.pop()
		length     = stack.pop()
	)
	codeCopy := getDataBig(contract.Code, codeOffset, length)
	memory.Set(memOffset.Uint64(), length.Uint64(), codeCopy)

	interpreter.intPool.put(memOffset, codeOffset, length)
	retu'
]

{ #category : #'as yet unclassified' }
FogVMCodecopy class >> memoryUsage [
<doc>
		^ self memoryTable at: #memoryCodeCopy.
]

{ #category : #generated }
FogVMCodecopy class >> mnemonic [
<doc>
		^'CODECOPY'.
	
]

{ #category : #testing }
FogVMCodecopy >> isCopyCode [
	^ true
]

{ #category : #testing }
FogVMCodecopy >> writesMemory [
	^ true
]
