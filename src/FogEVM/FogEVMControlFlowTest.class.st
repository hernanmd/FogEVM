Class {
	#name : #FogEVMControlFlowTest,
	#superclass : #FogEVMUnitaryTest,
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #test }
FogEVMControlFlowTest >> testDIFFICULTY [
		|  bytecode  |
		
		"should test over 
		func opDifficulty(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(math.U256(interpreter.intPool.get().Set(interpreter.evm.Difficulty)))
	re"
		bytecode := self createBytecodeForDIFFICULTY.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMControlFlowTest >> testINVALID [
		|  bytecode  |
		
		"should test over 
		"
		bytecode := self createBytecodeForINVALID.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMControlFlowTest >> testJUMP [
		|  bytecode  |
		
		"should test over 
		func opJump(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	pos := stack.pop()
	if !contract.validJumpdest(pos) {
		nop := contract.GetOp(pos.Uint64())
		return nil, fmt.Errorf(invalid jump destination (%v) %v, nop, pos)
	}
	*pc = pos.Uint64()

	interpreter.intPool.put(pos)
	return n"
		bytecode := self createBytecodeForJUMP.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMControlFlowTest >> testJUMPDEST [
		|  bytecode  |
		
		"should test over 
		func opJumpdest(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	retu"
		bytecode := self createBytecodeForJUMPDEST.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMControlFlowTest >> testJUMPI [
		|  bytecode  |
		
		"should test over 
		func opJumpi(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	pos, cond := stack.pop(), stack.pop()
	if cond.Sign() != 0 {
		if !contract.validJumpdest(pos) {
			nop := contract.GetOp(pos.Uint64())
			return nil, fmt.Errorf(invalid jump destination (%v) %v, nop, pos)
		}
		*pc = pos.Uint64()
	} else {
		*pc++
	}

	interpreter.intPool.put(pos, cond)
	return "
		bytecode := self createBytecodeForJUMPI.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMControlFlowTest >> testPC [
		|  bytecode  |
		
		"should test over 
		func opPc(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(*pc))
	return nil"
		bytecode := self createBytecodeForPC.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMControlFlowTest >> testRETURN [
		|  bytecode  |
		
		"should test over 
		func opReturnDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(uint64(len(interpreter.returnData))))
	return"
		bytecode := self createBytecodeForRETURN.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMControlFlowTest >> testRETURNDATACOPY [
		|  bytecode  |
		
		"should test over 
		func opReturnDataCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	var (
		memOffset  = stack.pop()
		dataOffset = stack.pop()
		length     = stack.pop()

		end = interpreter.intPool.get().Add(dataOffset, length)
	)
	defer interpreter.intPool.put(memOffset, dataOffset, length, end)

	if end.BitLen() > 64 || uint64(len(interpreter.returnData)) < end.Uint64() {
		return nil, errReturnDataOutOfBounds
	}
	memory.Set(memOffset.Uint64(), length.Uint64(), interpreter.returnData[dataOffset.Uint64():end.Uint64()])
"
		bytecode := self createBytecodeForRETURNDATACOPY.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMControlFlowTest >> testRETURNDATASIZE [
		|  bytecode  |
		
		"should test over 
		func opReturnDataSize(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(uint64(len(interpreter.returnData))))"
		bytecode := self createBytecodeForRETURNDATASIZE.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMControlFlowTest >> testREVERT [
		|  bytecode  |
		
		"should test over 
		
	func opRevert(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	offset, size := stack.pop(), stack.pop()
	ret := memory.GetPtr(offset.Int64(), size.Int64())

	interpreter.intPool.put(offset, size)
	return ret, nil
}
	"
		bytecode := self createBytecodeForREVERT.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter isReverted .
		

]

{ #category : #test }
FogEVMControlFlowTest >> testSTOP [
		|  bytecode  |
		
		"should test over 
		func opStop(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	return n"
		bytecode := self createBytecodeForSTOP.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: interpreter isTerminated .
		

]
