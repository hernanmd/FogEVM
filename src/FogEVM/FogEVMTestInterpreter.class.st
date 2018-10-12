Class {
	#name : #FogEVMTestInterpreter,
	#superclass : #FogEVMInterpreter,
	#category : #'FogEVM-ByteCode-Interpreter-Tests'
}

{ #category : #accessing }
FogEVMTestInterpreter >> bytecode: aFogEVMByteCode [
	self contract: aFogEVMByteCode
]

{ #category : #'running arbitrary code' }
FogEVMTestInterpreter >> run [
	self interpret
]

{ #category : #accessing }
FogEVMTestInterpreter >> stack [
	^ stack
]
