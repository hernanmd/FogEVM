Class {
	#name : #FogEVMEnvironmentalInformationAccessTest,
	#superclass : #FogEVMUnitaryTest,
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testADDRESS [
	| bytecode |
	"should test over 
		func opAddress(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(contract.Address().Big())
	retur"
	bytecode := self createBytecodeForADDRESS.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop equals: interpreter contractAddress
]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testBALANCE [
	| bytecode |
	"should test over 
		func opBalance(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	slot := stack.peek()
	slot.Set(interpreter.evm.StateDB.GetBalance(common.BigToAddress(slot)))
	retur"
	bytecode := self createBytecodeForBALANCE: interpreter contractAddress unsignedValue.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter pop unsignedValue equals: 0.
	(interpreter storageFor: interpreter contractAddress state: interpreter runtimeState) atStorage: #balance put: (FogEVMRegistry forValue: 20 bytesLength: 32).
	interpreter run.
	self assert: interpreter pop unsignedValue equals: 20
]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testBLOCKHASH [
	| bytecode blockNumber |
	"should test over 
		func opBlockhash(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	num := stack.pop()

	n := interpreter.intPool.get().Sub(interpreter.evm.BlockNumber, common.Big257)
	if num.Cmp(n) > 0 && num.Cmp(interpreter.evm.BlockNumber) < 0 {
		stack.push(interpreter.evm.GetHash(num.Uint64()).Big())
	} else {
		stack.push(interpreter.intPool.getZero())
	}
	interpreter.intPool.put(num, n)
	ret"
	blockNumber := 4323543.
	bytecode := self createBytecodeForBLOCKHASH: blockNumber.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter pop equals: (interpreter blockHashRegisty: blockNumber)
]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testCALLDATACOPY [
	| bytecode |
	"should test over 
		func opCallDataCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		memOffset  = stack.pop()
		dataOffset = stack.pop()
		length     = stack.pop()
	)
	memory.Set(memOffset.Uint64(), length.Uint64(), getDataBig(contract.Input, dataOffset, length))

	interpreter.intPool.put(memOffset, dataOffset, length)
	"
	bytecode := self createBytecodeForCALLDATACOPY: 1 data: 3 length: 5.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: (interpreter memory loadFrom: 1 bytes: 5) = (interpreter contractInput copyFrom: 3 to: 8)
]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testCALLDATALOAD [
	| bytecode |
	"should test over 
		func opCallDataLoad(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetBytes(getDataBig(contract.Input, stack.pop(), big32)))
	"
	bytecode := self createBytecodeForCALLDATALOAD: 1.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: (interpreter contractInput copyFrom: 1 to: 32) asInteger equals: interpreter stack pop unsignedValue
]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testCALLDATASIZE [
		|  bytecode  |
		
		"should test over 
		func opCallDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetInt64(int64(len(contract.Input))))
	"
		bytecode := self createBytecodeForCALLDATASIZE.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter contractInput size equals: interpreter pop unsignedValue .
		

]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testCALLER [
	| bytecode |
	"should test over 
		func opCaller(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(contract.Caller().Big())
	return"
	bytecode := self createBytecodeForCALLER.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter pop unsignedValue equals: interpreter callerAddress unsignedValue 
]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testCALLVALUE [
		|  bytecode  |
		
		"should test over 
		func opCallValue(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().Set(contract.value))
	ret"
		bytecode := self createBytecodeForCALLVALUE.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter pop unsignedValue equals: FogEVMInterpreter exampleCall callValue unsignedValue 
		

]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testCODECOPY [
	| bytecode |
	"should test over 
		func opCodeCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		memOffset  = stack.pop()
		codeOffset = stack.pop()
		length     = stack.pop()
	)
	codeCopy := getDataBig(contract.Code, codeOffset, length)
	memory.Set(memOffset.Uint64(), length.Uint64(), codeCopy)

	interpreter.intPool.put(memOffset, codeOffset, length)
	retu"
	bytecode := self createBytecodeForCODECOPY: 1 code: 2 length: 3.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: (interpreter memory loadFrom: 1 bytes: 3) equals: (bytecode toBinary copyFrom: 2 to: 2 + 3)
]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testCODESIZE [
		|  bytecode  |
		
		"should test over 
		func opCodeSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	l := interpreter.intPool.get().SetInt64(int64(len(contract.Code)))
	stack.push(l)

	retu"
		bytecode := self createBytecodeForCODESIZE.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter pop unsignedValue equals: bytecode bytecodeSize .
		

]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testCOINBASE [
		|  bytecode  |
		
		"should test over 
		func opCoinbase(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.evm.Coinbase.Big())
	retu"
		bytecode := self createBytecodeForCOINBASE.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter pop equals: interpreter minerAddress.
		

]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testDIFFICULTY [
		|  bytecode  |
		
		"should test over 
		func opDifficulty(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.Difficulty)))
	re"
		bytecode := self createBytecodeForDIFFICULTY.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter pop equals: interpreter blockDifficulty.
		

]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testEXTCODECOPY [
	| bytecode |
	"should test over 
		func opExtCodeCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
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
// There are sever"
	bytecode := self
		createBytecodeForEXTCODE: interpreter contractAddress unsignedValue
		COPY: 1
		code: 3
		length: 5.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: (interpreter memory loadFrom: 1 bytes: 3) equals: (bytecode toBinary copyFrom: 2 to: 2 + 3)
]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testEXTCODEHASH [
	| bytecode |
	"should test over 
		func opExtCodeHash(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	slot := stack.peek()
	slot.SetBytes(interpreter.evm.StateDB.GetCodeHash(common.BigToAddress(slot)).Bytes())
	r"
	bytecode := self createBytecodeForEXTCODEHASH: interpreter contractAddress unsignedValue.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter pop equals: (interpreter keccack256: bytecode toBinary)
]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testEXTCODESIZE [
		|  bytecode  |
		
		"should test over 
		func opExtCodeSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	slot := stack.peek()
	slot.SetUint64(uint64(interpreter.evm.StateDB.GetCodeSize(common.BigToAddress(slot))))

	r"
		bytecode := self createBytecodeForEXTCODESIZE: interpreter contractAddress unsignedValue .
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter pop unsignedValue equals: bytecode bytecodeSize .
		

]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testGAS [
		|  bytecode  |
		
		"should test over 
		func opGasprice(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().Set(interpreter.evm.GasPrice))
	return ni"
		bytecode := self createBytecodeForGAS.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter pop equals: interpreter callGas.
		

]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testGASLIMIT [
	| bytecode |
	"should test over 
		func opGasLimit(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().SetUint64(interpreter.evm.GasLimit)))
	retu"
	bytecode := self createBytecodeForGASLIMIT.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter pop equals: interpreter gasLimit
]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testGASPRICE [
		|  bytecode  |
		
		"should test over 
		func opGasprice(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().Set(interpreter.evm.GasPrice))
	retu"
		bytecode := self createBytecodeForGASPRICE.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter pop equals: interpreter callGasPrice .
		

]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testNUMBER [
		|  bytecode  |
		
		"should test over 
		func opNumber(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.BlockNumber)))
	return"
		bytecode := self createBytecodeForNUMBER.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter pop equals: interpreter currentBlockNumber .
		

]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testORIGIN [
		|  bytecode  |
		
		"should test over 
		func opOrigin(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.evm.Origin.Big())
	return"
		bytecode := self createBytecodeForORIGIN.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter pop equals: interpreter originAddress .
		

]

{ #category : #test }
FogEVMEnvironmentalInformationAccessTest >> testTIMESTAMP [
		|  bytecode  |
		
		"should test over 
		func opTimestamp(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.Time)))
	ret"
		bytecode := self createBytecodeForTIMESTAMP.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter pop  equals: interpreter timestamp.
		

]
