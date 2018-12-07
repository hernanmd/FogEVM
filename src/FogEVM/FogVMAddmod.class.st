"
Modulo addition operation
"
Class {
	#name : #FogVMAddmod,
	#superclass : #FogEVMInstruction,
	#category : 'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMAddmod class >> byteCode [
<doc>
	<doc>
	^ '0x08'
]

{ #category : #'as yet unclassified' }
FogVMAddmod class >> description [
<doc>
	<doc>
	^ 'Modulo addition operation'
]

{ #category : #generated }
FogVMAddmod class >> expectedPops [
<doc>
	<doc>
	^ 3
]

{ #category : #generated }
FogVMAddmod class >> expectedPushes [
<doc>
	<doc>
	^ 1
]

{ #category : #'as yet unclassified' }
FogVMAddmod class >> gas [
<doc>
	<doc>
	^ self gasTable at: #GasMidStep
]

{ #category : #generated }
FogVMAddmod class >> goCode [
<doc>
	<doc>
	^ 'func opAddmod(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
	x, y, z := stack.pop(), stack.pop(), stack.pop()
	if z.Cmp(bigZero) > 0 {
		x.Add(x, y)
		x.Mod(x, z)
		stack.push(math.U256(x))
	} else {
		stack.push(x.SetUint64(0))
	}
	interpreter.intPool.put(y, z)
	return'
]

{ #category : #generated }
FogVMAddmod class >> mnemonic [
<doc>
	<doc>
	^ 'ADDMOD'
]
