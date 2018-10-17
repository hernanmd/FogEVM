Class {
	#name : #FogEVMLoadStoreTest,
	#superclass : #FogEVMUnitaryTest,
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #test }
FogEVMLoadStoreTest >> testMLOAD [
		|  bytecode  |
		
		"should test over 
		func opMload(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset := stack.pop()
	val := interpreter.intPool.get().SetBytes(memory.Get(offset.Int64(), 32))
	stack.push(val)

	interpreter.intPool.put(offset)
	return "
		bytecode := self createBytecodeForMLOAD.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

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
		storeWord: (FogEVMRegistry forValue:16rABCABCABCC bytesLength: 6)
		startingAt: (FogEVMRegistry forValue: 1 bytesLength: 32).
	interpreter run.
	self assert: interpreter pop unsignedValue equals: 33
]

{ #category : #test }
FogEVMLoadStoreTest >> testMSTORE [
		|  bytecode  |
		
		"should test over 
		func opMstore(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// pop value of the stack
	mStart, val := stack.pop(), stack.pop()
	memory.Set32(mStart.Uint64(), val)

	interpreter.intPool.put(mStart, val)
	return"
		bytecode := self createBytecodeForMSTORE.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMLoadStoreTest >> testMSTORE8 [
		|  bytecode  |
		
		"should test over 
		func opMstore8(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	off, val := stack.pop().Int64(), stack.pop().Int64()
	memory.store[off] = byte(val & 0xff)

	retur"
		bytecode := self createBytecodeForMSTORE8.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMLoadStoreTest >> testSHA3 [
		|  bytecode  |
		
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
		bytecode := self createBytecodeForSHA3.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

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
		bytecode := self createBytecodeForSLOAD.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMLoadStoreTest >> testSSTORE [
		|  bytecode  |
		
		"should test over 
		func opSstore(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	loc := common.BigToHash(stack.pop())
	val := stack.pop()
	interpreter.evm.StateDB.SetState(contract.Address(), loc, common.BigToHash(val))

	interpreter.intPool.put(val)
	return"
		bytecode := self createBytecodeForSSTORE.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]
