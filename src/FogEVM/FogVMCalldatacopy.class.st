"
Copy input data in current environment to memory
"
Class {
	#name : #FogVMCalldatacopy,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMCalldatacopy class >> byteCode [
<doc>
		^'0x37'.
	
]

{ #category : #'as yet unclassified' }
FogVMCalldatacopy class >> description [ 
<doc>
	^ 'Copy input data in current environment to memory'
]

{ #category : #generated }
FogVMCalldatacopy class >> expectedPops [
<doc>
		^3.
	
]

{ #category : #generated }
FogVMCalldatacopy class >> expectedPushes [
<doc>
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMCalldatacopy class >> gas [
<doc>
		^ self gasTable at: #gasCallDataCopy.
]

{ #category : #generated }
FogVMCalldatacopy class >> goCode [
<doc>
	^ 'func opCallDataCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		memOffset  = stack.pop()
		dataOffset = stack.pop()
		length     = stack.pop()
	)
	memory.Set(memOffset.Uint64(), length.Uint64(), getDataBig(contract.Input, dataOffset, length))

	interpreter.intPool.put(memOffset, dataOffset, length)
	'
]

{ #category : #'as yet unclassified' }
FogVMCalldatacopy class >> memoryUsage [
<doc>
		^ self memoryTable at: #memoryCallDataCopy.
]

{ #category : #generated }
FogVMCalldatacopy class >> mnemonic [
<doc>
		^'CALLDATACOPY'.
	
]

{ #category : #'as yet unclassified' }
FogVMCalldatacopy >> writesMemory [
	^ true
]
