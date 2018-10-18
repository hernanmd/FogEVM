Class {
	#name : #FogEVMLoadStoreTest,
	#superclass : #FogEVMUnitaryTest,
	#instVars : [
		'generator',
		'value',
		'memoryStart'
	],
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #test }
FogEVMLoadStoreTest class >> testParameters [
	^ ParametrizedTestMatrix new forSelector: #generator addOptions: ((Integer primesUpTo: 512) collect: [ :p | Random seed: p ])
]

{ #category : #test }
FogEVMLoadStoreTest >> generator: aGenerator [
	value := 128 + (aGenerator nextInt: 256 * 31).
	memoryStart := 1 + (aGenerator nextInt: 10).
	generator := aGenerator
]

{ #category : #test }
FogEVMLoadStoreTest >> testMLOAD [
	| bytecode |
	"should test over 
		func opMload(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset := stack.pop()
	val := interpreter.intPool.get().SetBytes(memory.Get(offset.Int64(), 32))
	stack.push(val)

	interpreter.intPool.put(offset)
	return "
	bytecode := self createBytecodeForMSTORE: value at: memoryStart.
	interpreter bytecode: bytecode.
	interpreter run.
	bytecode := self createBytecodeForMLOAD: memoryStart.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop unsignedValue equals: value
]

{ #category : #test }
FogEVMLoadStoreTest >> testMSIZE [
	| bytecode |
	"should test over 
		func opMsize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetInt64(int64(memory.Len())))
	return "
	bytecode := self createBytecodeForMSIZE.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter pop unsignedValue equals: 0.
	interpreter memory
		storeWord: (FogEVMRegistry forValue: value bytesLength: value asByteArray size )
		startingAt: (FogEVMRegistry forValue: 1 bytesLength: 32).
	interpreter run.
	self assert: interpreter pop unsignedValue equals: 33
]

{ #category : #test }
FogEVMLoadStoreTest >> testMSTORE [
	| bytecode |
	"should test over 
		func opMstore(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// pop value of the stack
	mStart, val := stack.pop(), stack.pop()
	memory.Set32(mStart.Uint64(), val)

	interpreter.intPool.put(mStart, val)
	return"
	bytecode := self createBytecodeForMSTORE: value at: memoryStart.
	interpreter bytecode: bytecode.
	interpreter run.
	
	self assert: interpreter stack isEmpty.
	self assert: interpreter memory sizeInBytes equals: memoryStart + 32 
]

{ #category : #test }
FogEVMLoadStoreTest >> testMSTORE8 [
		|  bytecode  |
		
		"should test over 
		func opMstore8(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	off, val := stack.pop().Int64(), stack.pop().Int64()
	memory.store[off] = byte(val & 0xff)

	retur"
	
	bytecode := self createBytecodeForMSTORE8: value at: memoryStart.
	interpreter bytecode: bytecode.
	interpreter run.
	
	self assert: interpreter stack isEmpty.
	self assert: interpreter memory sizeInBytes equals: memoryStart + 1
]

{ #category : #test }
FogEVMLoadStoreTest >> testSHA3 [
	| bytecode  |
	"should test over 
		func opSha3(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
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
	return n"
	bytecode := self createBytecodeForMSTORE: value at: memoryStart.
	interpreter bytecode: bytecode.
	interpreter run.
	bytecode := self createBytecodeForSHA3: memoryStart+31 to: 0.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop unsignedValue equals: ('16r',(Keccak hashEncode: value)) asNumber 
]

{ #category : #test }
FogEVMLoadStoreTest >> testSLOAD [
		|  bytecode  |
		
		"should test over 
		func opSload(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	loc := stack.peek()
	val := interpreter.evm.StateDB.GetState(contract.Address(), common.BigToHash(loc))
	loc.SetBytes(val.Bytes())
	return "
	bytecode := self createBytecodeForSSTORE: value at: memoryStart.
	interpreter bytecode: bytecode.
	interpreter run.
	bytecode := self createBytecodeForSLOAD: memoryStart.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop unsignedValue equals: value
]

{ #category : #test }
FogEVMLoadStoreTest >> testSSTORE [
	| bytecode |
	"should test over 
		func opSstore(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	loc := common.BigToHash(stack.pop())
	val := stack.pop()
	interpreter.evm.StateDB.SetState(contract.Address(), loc, common.BigToHash(val))

	interpreter.intPool.put(val)
	return"
	bytecode := self createBytecodeForSSTORE: value at: memoryStart.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack isEmpty.
	self
		assert:
			((interpreter storageFor: interpreter contractAddress)
				getStorageAt: (FogEVMRegistry forValue: memoryStart bytesLength: 32))
				unsignedValue 
		equals: value
]
