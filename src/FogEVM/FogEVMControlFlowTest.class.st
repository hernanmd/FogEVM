Class {
	#name : #FogEVMControlFlowTest,
	#superclass : #FogEVMUnitaryTest,
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #test }
FogEVMControlFlowTest >> testJUMP [
	| bytecode |
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
	bytecode := self createBytecodeForJUMP: 36.
	interpreter bytecode: bytecode.
	
	interpreter run.
	self assert: interpreter currentInstructionPointer unsignedValue equals: 5.
	bytecode := self createBytecodeForJUMP: 35.
	interpreter bytecode: bytecode.
	self should: [ interpreter run ] raise: FogEVMRuntimeError
]

{ #category : #test }
FogEVMControlFlowTest >> testJUMPI [
	| bytecode |
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
	bytecode := self createBytecodeForJUMPI: 1 Pointer: 69.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter currentInstructionPointer unsignedValue equals: 6.
	bytecode := self createBytecodeForJUMPI: 0 Pointer: 69.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter currentInstructionPointer unsignedValue equals: 4
]

{ #category : #test }
FogEVMControlFlowTest >> testPC [
		|  bytecode  |
		
		"should test over 
		func opPc(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	stack.push(interpreter.intPool.get().SetUint64(*pc))
	return nil"
		bytecode := self createBytecodeForPC.
		interpreter bytecode: bytecode.
		interpreter run. 
		
		self assert: interpreter pop unsignedValue equals: 2 .
		

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
