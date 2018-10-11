"
Documentation says nothing about
"
Class {
	#name : #FogVMReturndatacopy,
	#superclass : #FogEVMInstruction,
	#category : #'FogEVM-ByteCode'
}

{ #category : #generated }
FogVMReturndatacopy class >> byteCode [
	^ '0x3e'
]

{ #category : #generated }
FogVMReturndatacopy class >> expectedPops [
		^3.
	
]

{ #category : #generated }
FogVMReturndatacopy class >> expectedPushes [
		^0.
	
]

{ #category : #'as yet unclassified' }
FogVMReturndatacopy class >> gas [
		^ self gasTable at: #gasReturnDataCopy.

]

{ #category : #generated }
FogVMReturndatacopy class >> goCode [
	^ 'func opReturnDataCopy(pc *uint64, interpreter *EVMInterpreter, contract *Contract, memory *Memory, stack *Stack) ([]byte, error) {
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
'
]

{ #category : #'as yet unclassified' }
FogVMReturndatacopy class >> memoryUsage [
		^ self memoryTable at: #memoryReturnDataCopy.

]

{ #category : #generated }
FogVMReturndatacopy class >> mnemonic [
		^'RETURNDATACOPY'.
	
]
