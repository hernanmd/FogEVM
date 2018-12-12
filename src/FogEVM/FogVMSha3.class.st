"
Compute Keccak-256 hash
"
Class {
	#name : #FogVMSha3,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMSha3 class >> byteCode [
<doc>
		^'0x20'.
	
]

{ #category : #'as yet unclassified' }
FogVMSha3 class >> description [ 
<doc>
	^ 'Compute Keccak-256 hash'
]

{ #category : #generated }
FogVMSha3 class >> expectedPops [
<doc>
		^2.
	
]

{ #category : #generated }
FogVMSha3 class >> expectedPushes [
<doc>
		^1.
	
]

{ #category : #'as yet unclassified' }
FogVMSha3 class >> gas [
<doc>
		^ self gasTable at: #gasSha3.
]

{ #category : #generated }
FogVMSha3 class >> goCode [
<doc>
	^ 'func opSha3(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset, size := stack.pop(), stack.pop()
	data := memory.Get(offset.Int64(), size.Int64())

	if interpreter.hasher == nil {
		interpreter.hasher = sha3.NewKeccak256().(keccakState)
	} else {
		interpreter.hasher.Reset()
	}
	interpreter.hasher.Write(data)
	interpreter.hasher.Read(interpreter.hasherBuf[:])

	evm := interpreter.evm
	if evm.vmConfig.EnablePreimageRecording {
		evm.StateDB.AddPreimage(interpreter.hasherBuf, data)
	}
	stack.push(interpreter.intPool.get().SetBytes(interpreter.hasherBuf[:]))

	interpreter.intPool.put(offset, size)
	return n'
]

{ #category : #'as yet unclassified' }
FogVMSha3 class >> memoryUsage [
<doc>
		^ self memoryTable at: #memorySha3.
]

{ #category : #generated }
FogVMSha3 class >> mnemonic [
<doc>
		^'SHA3'.
	
]

{ #category : #'as yet unclassified' }
FogVMSha3 >> readsMemory [
	^ true
]
