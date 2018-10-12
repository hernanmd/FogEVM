Class {
	#name : #FogEVMRandomizedTest,
	#superclass : #FogEVMUnitaryTest,
	#instVars : [
		'generator',
		'x',
		'y',
		'z'
	],
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #'building suites' }
FogEVMRandomizedTest class >> testParameters [
	^ ParametrizedTestMatrix new forSelector: #generator addOptions: ((Integer primesUpTo: 512) collect: [ :p | Random seed: p ])
]

{ #category : #test }
FogEVMRandomizedTest >> generator: aGenerator [
	x := aGenerator nextInt: 512. 
	y := aGenerator nextInt: 512. 
	z := aGenerator nextInt: 512. 


]

{ #category : #test }
FogEVMRandomizedTest >> testADD [
	| bytecode |
	"should test over 
		func opAdd(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	math.U256(y.Add(x, y))

	interpreter.intPool.put(x)
	return ni"
	bytecode := self createBytecodeForADD: x plus: y.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: x + y 
	



]

{ #category : #test }
FogEVMRandomizedTest >> testADDMOD [
	| bytecode |
	"should test over 
		func opAddmod(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y, z := stack.pop(), stack.pop(), stack.pop()
	if z.Cmp(bigZero) > 0 {
		x.Add(x, y)
		x.Mod(x, z)
		stack.push(math.U256(x))
	} else {
		stack.push(x.SetUint64(0))
	}
	interpreter.intPool.put(y, z)
	return"
	bytecode := self createBytecodeForADDMOD: x and: y and: z.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: (x + y) \\ z
]

{ #category : #test }
FogEVMRandomizedTest >> testBYTE [
		|  bytecode  |
		
		"should test over 
		func opByte(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	th, val := stack.pop(), stack.peek()
	if th.Cmp(common.Big32) < 0 {
		b := math.Byte(val, 32, int(th.Int64()))
		val.SetUint64(uint64(b))
	} else {
		val.SetUint64(0)
	}
	interpreter.intPool.put(th)
	return n"
		bytecode := self createBytecodeForBYTE.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMRandomizedTest >> testDIV [
		|  bytecode  |
		
		"should test over 
		func opDiv(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if y.Sign() != 0 {
		math.U256(y.Div(x, y))
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return ni"
		bytecode := self createBytecodeForDIV.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMRandomizedTest >> testEQ [
	| bytecode |
	"should test over 
		func opEq(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if x.Cmp(y) == 0 {
		y.SetUint64(1)
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return nil"
	bytecode := self createBytecodeForEQ: x and: x.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 1.
	bytecode := self createBytecodeForEQ: x and: y.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: 0
]

{ #category : #test }
FogEVMRandomizedTest >> testEXP [
		|  bytecode  |
		
		"should test over 
		func opExp(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	base, exponent := stack.pop(), stack.pop()
	stack.push(math.Exp(base, exponent))

	interpreter.intPool.put(base, exponent)

	return ni"
		bytecode := self createBytecodeForEXP.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMRandomizedTest >> testGT [
	| bytecode |
	"should test over 
		func opGt(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if x.Cmp(y) > 0 {
		y.SetUint64(1)
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return nil"
	bytecode := self createBytecodeForGT: x and: y.
	interpreter bytecode: bytecode.
	interpreter run.
	self
		assert: interpreter stack pop asBKNumber
		equals:
			(x > y
				ifTrue: [ 1 ]
				ifFalse: [ 0 ]).
	bytecode := self createBytecodeForGT: y and: x.
	interpreter bytecode: bytecode.
	interpreter run.
	self
		assert: interpreter stack pop asBKNumber
		equals:
			(y > x
				ifTrue: [ 1 ]
				ifFalse: [ 0 ])
]

{ #category : #test }
FogEVMRandomizedTest >> testLT [
		|  bytecode  |
		
		"should test over 
		func opLt(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	if x.Cmp(y) < 0 {
		y.SetUint64(1)
	} else {
		y.SetUint64(0)
	}
	interpreter.intPool.put(x)
	return nil"
	bytecode := self createBytecodeForLT: x and: y.
	interpreter bytecode: bytecode.
	interpreter run.
	self
		assert: interpreter stack pop asBKNumber
		equals:
			(x < y
				ifTrue: [ 1 ]
				ifFalse: [ 0 ]).
	bytecode := self createBytecodeForLT: y and: x.
	interpreter bytecode: bytecode.
	interpreter run.
	self
		assert: interpreter stack pop asBKNumber
		equals:
			(y < x
				ifTrue: [ 1 ]
				ifFalse: [ 0 ])
]

{ #category : #test }
FogEVMRandomizedTest >> testMOD [
	| bytecode |
	"should test over 
		func opMod(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.pop()
	if y.Sign() == 0 {
		stack.push(x.SetUint64(0))
	} else {
		stack.push(math.U256(x.Mod(x, y)))
	}
	interpreter.intPool.put(y)
	return ni"
	bytecode := self createBytecodeForMOD: x and: y.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: x \\ y
]

{ #category : #test }
FogEVMRandomizedTest >> testMUL [
		|  bytecode  |
		
		"should test over 
		func opMul(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.pop()
	stack.push(math.U256(x.Mul(x, y)))

	interpreter.intPool.put(y)

	return ni"
	bytecode := self createBytecodeForMUL: x and: y.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: x * y 
		

]

{ #category : #test }
FogEVMRandomizedTest >> testMULMOD [
	| bytecode |
	"should test over 
		func opMulmod(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y, z := stack.pop(), stack.pop(), stack.pop()
	if z.Cmp(bigZero) > 0 {
		x.Mul(x, y)
		x.Mod(x, z)
		stack.push(math.U256(x))
	} else {
		stack.push(x.SetUint64(0))
	}
	interpreter.intPool.put(y, z)
	return nil, nil
}

// opSHL implements Shift Left
// The SHL instruction (shift left) pops 2 values from the stack, first arg1 and then arg2,
// and pushes on the stack arg2 shifted to the left by arg1 num"
	bytecode := self createBytecodeForMULMOD: x and: y and: z.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: x * y \\ z
]

{ #category : #test }
FogEVMRandomizedTest >> testPOP [
	| bytecode |
	"should test over 
		func opPop(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	interpreter.intPool.put(stack.pop())
	return ni" 
	bytecode := self createBytecodeForPOP: x.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack size asBKNumber equals: x
]

{ #category : #test }
FogEVMRandomizedTest >> testSAR [
		|  bytecode  |
		
		"should test over 
		func opSAR(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Note, S256 returns (potentially) a new bigint, so were popping, not peeking this one
	shift, value := math.U256(stack.pop()), math.S256(stack.pop())
	defer interpreter.intPool.put(shift) // First operand back into the pool

	if shift.Cmp(common.Big256) >= 0 {
		if value.Sign() >= 0 {
			value.SetUint64(0)
		} else {
			value.SetInt64(-1)
		}
		stack.push(math.U256(value))
		return nil, nil
	}
	n := uint(shift.Uint64())
	value.Rsh(value, n)
	stack.push(math.U256(value))

	return ni"
		bytecode := self createBytecodeForSAR.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMRandomizedTest >> testSDIV [
		|  bytecode  |
		
		"should test over 
		func opSdiv(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := math.S256(stack.pop()), math.S256(stack.pop())
	res := interpreter.intPool.getZero()

	if y.Sign() == 0 || x.Sign() == 0 {
		stack.push(res)
	} else {
		if x.Sign() != y.Sign() {
			res.Div(x.Abs(x), y.Abs(y))
			res.Neg(res)
		} else {
			res.Div(x.Abs(x), y.Abs(y))
		}
		stack.push(math.U256(res))
	}
	interpreter.intPool.put(x, y)
	return n"
 	bytecode := self createBytecodeForSDIV: x and: y.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: x / y .
	
	bytecode := self createBytecodeForSDIV: x negated and: y.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: x negated / y .
	
	bytecode := self createBytecodeForSDIV: x and: y negated.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: x / y negated
		

]

{ #category : #test }
FogEVMRandomizedTest >> testSGT [
	| bytecode |
	"should test over 
		func opSgt(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()

	xSign := x.Cmp(tt255)
	ySign := y.Cmp(tt255)

	switch {
	case xSign >= 0 && ySign < 0:
		y.SetUint64(0)

	case xSign < 0 && ySign >= 0:
		y.SetUint64(1)

	default:
		if x.Cmp(y) > 0 {
			y.SetUint64(1)
		} else {
			y.SetUint64(0)
		}
	}
	interpreter.intPool.put(x)
	return ni"
	bytecode := self createBytecodeForSGT: x negated and: x.
	interpreter bytecode: bytecode.
	interpreter run.
	self
		assert: interpreter stack pop asBKNumber
		equals:
			(x negated > x
				ifTrue: [ 1 ]
				ifFalse: [ 0 ]).
	bytecode := self createBytecodeForSGT: y and: y negated.
	interpreter bytecode: bytecode.
	interpreter run.
	self
		assert: interpreter stack pop asBKNumber
		equals:
			(y > y negated
				ifTrue: [ 1 ]
				ifFalse: [ 0 ])
]

{ #category : #test }
FogEVMRandomizedTest >> testSHA3 [
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
FogEVMRandomizedTest >> testSHL [
		|  bytecode  |
		
		"should test over 
		func opSHL(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Note, second operand is left in the stack; accumulate result into it, and no need to push it afterwards
	shift, value := math.U256(stack.pop()), math.U256(stack.peek())
	defer interpreter.intPool.put(shift) // First operand back into the pool

	if shift.Cmp(common.Big256) >= 0 {
		value.SetUint64(0)
		return nil, nil
	}
	n := uint(shift.Uint64())
	math.U256(value.Lsh(value, n))

	return nil, nil
}

// opSHR implements Logical Shift Right
// The SHR instruction (logical shift right) pops 2 values from the stack, first arg1 and then arg2,
// and pushes on the stack arg2 shifted to the right by arg1 number of bits with z"
		bytecode := self createBytecodeForSHL.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMRandomizedTest >> testSHR [
		|  bytecode  |
		
		"should test over 
		func opSHR(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	// Note, second operand is left in the stack; accumulate result into it, and no need to push it afterwards
	shift, value := math.U256(stack.pop()), math.U256(stack.peek())
	defer interpreter.intPool.put(shift) // First operand back into the pool

	if shift.Cmp(common.Big256) >= 0 {
		value.SetUint64(0)
		return nil, nil
	}
	n := uint(shift.Uint64())
	math.U256(value.Rsh(value, n))

	return nil, nil
}

// opSAR implements Arithmetic Shift Right
// The SAR instruction (arithmetic shift right) pops 2 values from the stack, first arg1 and then arg2,
// and pushes on the stack arg2 shifted to the right by arg1 number of bits with sign e"
		bytecode := self createBytecodeForSHR.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMRandomizedTest >> testSIGNEXTEND [
		|  bytecode  |
		
		"should test over 
		func opSignExtend(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	back := stack.pop()
	if back.Cmp(big.NewInt(31)) < 0 {
		bit := uint(back.Uint64()*8 + 7)
		num := stack.pop()
		mask := back.Lsh(common.Big1, bit)
		mask.Sub(mask, common.Big1)
		if num.Bit(int(bit)) > 0 {
			num.Or(num, mask.Not(mask))
		} else {
			num.And(num, mask)
		}

		stack.push(math.U256(num))
	}

	interpreter.intPool.put(back)
	re"
		bytecode := self createBytecodeForSIGNEXTEND.
		interpreter bytecode:bytecode.
		interpreter run. 
		
		self assert: false.
		

]

{ #category : #test }
FogEVMRandomizedTest >> testSLT [
		|  bytecode  |
		
		"should test over 
		func opSlt(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()

	xSign := x.Cmp(tt255)
	ySign := y.Cmp(tt255)

	switch {
	case xSign >= 0 && ySign < 0:
		y.SetUint64(1)

	case xSign < 0 && ySign >= 0:
		y.SetUint64(0)

	default:
		if x.Cmp(y) < 0 {
			y.SetUint64(1)
		} else {
			y.SetUint64(0)
		}
	}
	interpreter.intPool.put(x)
	return ni"
	bytecode := self createBytecodeForSLT: x negated and: x.
	interpreter bytecode: bytecode.
	interpreter run.
	self
		assert: interpreter stack pop asBKNumber
		equals:
			(x negated < x
				ifTrue: [ 1 ]
				ifFalse: [ 0 ]).
	bytecode := self createBytecodeForSLT: y and: y negated.
	interpreter bytecode: bytecode.
	interpreter run.
	self
		assert: interpreter stack pop asBKNumber
		equals:
			(y < y negated 
				ifTrue: [ 1 ]
				ifFalse: [ 0 ])

]

{ #category : #test }
FogEVMRandomizedTest >> testSMOD [
	| bytecode |
	"should test over 
		func opSmod(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := math.S256(stack.pop()), math.S256(stack.pop())
	res := interpreter.intPool.getZero()

	if y.Sign() == 0 {
		stack.push(res)
	} else {
		if x.Sign() < 0 {
			res.Mod(x.Abs(x), y.Abs(y))
			res.Neg(res)
		} else {
			res.Mod(x.Abs(x), y.Abs(y))
		}
		stack.push(math.U256(res))
	}
	interpreter.intPool.put(x, y)
	return n"
	bytecode := self createBytecodeForSMOD: x negated and: y.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: x negated \\ y.
	
	bytecode := self createBytecodeForSMOD: x and: y negated.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: x \\ y negated
]

{ #category : #test }
FogEVMRandomizedTest >> testSUB [
		|  bytecode  |
		
		"should test over 
		func opSub(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y := stack.pop(), stack.peek()
	math.U256(y.Sub(x, y))

	interpreter.intPool.put(x)
	return ni"
	bytecode := self createBytecodeForSUB: x and: y.
	interpreter bytecode: bytecode.
	interpreter run.
	self assert: interpreter stack pop asBKNumber equals: x - y 
	



]
