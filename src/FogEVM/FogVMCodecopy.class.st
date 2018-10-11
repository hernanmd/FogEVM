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
		^'0x39'.
	
]

{ #category : #'as yet unclassified' }
FogVMCodecopy class >> description [ 
	^ 'Copy code running in current environment to memory'
]

{ #category : #generated }
FogVMCodecopy class >> expectedPops [
		^3.
	
]

{ #category : #generated }
FogVMCodecopy class >> expectedPushes [
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMCodecopy class >> gas [
		^ self gasTable at: #gasCodeCopy.

]

{ #category : #generated }
FogVMCodecopy class >> goCode [
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
		^ self memoryTable at: #memoryCodeCopy.

]

{ #category : #generated }
FogVMCodecopy class >> mnemonic [
		^'CODECOPY'.
	
]

{ #category : #testing }
FogVMCodecopy >> isCopyCode [
	^ true
]
