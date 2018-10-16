"
Stream with utilities to build bytecode programs 
"
Class {
	#name : #FogEVMByteCodeWriteStream,
	#superclass : #WriteStream,
	#category : #'FogEVM-ByteCode'
}

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> assert: aBKHexaValue pushes: aByteLength [
	^ self assert: aBKHexaValue asHeadlessHexa size <= (aByteLength * 2)
]

{ #category : #accessing }
FogEVMByteCodeWriteStream >> currentByteNumber [
	^ (1 to: position) inject: 1 into: [ :acc :each | acc + (collection at: each) instruction size ]
]

{ #category : #put }
FogEVMByteCodeWriteStream >> nextPut: anObject [
	super nextPut: anObject
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutAdd [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMAdd instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutAddmod [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMAddmod instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutAddress [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMAddress instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutAnd [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMAnd instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutBalance [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMBalance instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutBlockhash [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMBlockhash instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutByte [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMByte instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCall [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCall instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCallcode [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCallcode instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCalldatacopy [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCalldatacopy instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCalldataload [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCalldataload instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCalldatasize [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCalldatasize instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCaller [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCaller instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCallvalue [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCallvalue instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCodecopy [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCodecopy instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCodesize [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCodesize instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCoinbase [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCoinbase instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCreate [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCreate instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutCreate2 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMCreate2 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDelegatecall [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDelegatecall instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDifficulty [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDifficulty instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDiv [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDiv instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup1 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup1 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup10 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup10 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup11 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup11 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup12 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup12 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup13 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup13 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup14 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup14 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup15 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup15 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup16 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup16 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup2 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup2 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup3 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup3 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup4 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup4 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup5 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup5 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup6 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup6 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup7 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup7 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup8 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup8 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutDup9 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMDup9 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutEq [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMEq instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutExp [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMExp instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutExtcodecopy [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMExtcodecopy instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutExtcodehash [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMExtcodehash instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutExtcodesize [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMExtcodesize instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutGas [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMGas instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutGaslimit [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMGaslimit instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutGasprice [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMGasprice instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutGt [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMGt instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutInvalid [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMInvalid instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutIszero [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMIszero instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutJump [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMJump instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutJumpdest [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMJumpdest instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutJumpi [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMJumpi instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutLog0 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMLog0 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutLog1 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMLog1 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutLog2 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMLog2 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutLog3 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMLog3 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutLog4 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMLog4 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutLt [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMLt instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutMload [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMMload instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutMod [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMMod instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutMsize [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMMsize instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutMstore [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMMstore instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutMstore8 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMMstore8 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutMul [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMMul instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutMulmod [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMMulmod instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutNot [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMNot instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutNumber [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMNumber instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutOr [
	self
		nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMOr instance)
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutOrigin [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMOrigin instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutPc [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMPc instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutPop [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMPop instance)
			
]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush10: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 10.
		self assert: value pushes: 10.
		bytecode := FogVMPush10 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush11: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 11.
		self assert: value pushes: 11.
		bytecode := FogVMPush11 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush12: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 12.
		self assert: value pushes: 12.
		bytecode := FogVMPush12 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush13: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 13.
		self assert: value pushes: 13.
		bytecode := FogVMPush13 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush14: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 14.
		self assert: value pushes: 14.
		bytecode := FogVMPush14 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush15: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 15.
		self assert: value pushes: 15.
		bytecode := FogVMPush15 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush16: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 16.
		self assert: value pushes: 16.
		bytecode := FogVMPush16 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush17: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 17.
		self assert: value pushes: 17.
		bytecode := FogVMPush17 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush18: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 18.
		self assert: value pushes: 18.
		bytecode := FogVMPush18 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush19: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 19.
		self assert: value pushes: 19.
		bytecode := FogVMPush19 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush1: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 1.
		self assert: value pushes: 1.
		bytecode := FogVMPush1 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush20: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 20.
		self assert: value pushes: 20.
		bytecode := FogVMPush20 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush21: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 21.
		self assert: value pushes: 21.
		bytecode := FogVMPush21 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush22: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 22.
		self assert: value pushes: 22.
		bytecode := FogVMPush22 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush23: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 23.
		self assert: value pushes: 23.
		bytecode := FogVMPush23 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush24: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 24.
		self assert: value pushes: 24.
		bytecode := FogVMPush24 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush25: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 25.
		self assert: value pushes: 25.
		bytecode := FogVMPush25 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush26: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 26.
		self assert: value pushes: 26.
		bytecode := FogVMPush26 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush27: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 27.
		self assert: value pushes: 27.
		bytecode := FogVMPush27 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush28: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 28.
		self assert: value pushes: 28.
		bytecode := FogVMPush28 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush29: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 29.
		self assert: value pushes: 29.
		bytecode := FogVMPush29 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush2: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 2.
		self assert: value pushes: 2.
		bytecode := FogVMPush2 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush30: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 30.
		self assert: value pushes: 30.
		bytecode := FogVMPush30 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush31: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 31.
		self assert: value pushes: 31.
		bytecode := FogVMPush31 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush32: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 32.
		self assert: value pushes: 32.
		bytecode := FogVMPush32 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush3: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 3.
		self assert: value pushes: 3.
		bytecode := FogVMPush3 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush4: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 4.
		self assert: value pushes: 4.
		bytecode := FogVMPush4 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush5: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 5.
		self assert: value pushes: 5.
		bytecode := FogVMPush5 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush6: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 6.
		self assert: value pushes: 6.
		bytecode := FogVMPush6 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush7: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 7.
		self assert: value pushes: 7.
		bytecode := FogVMPush7 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush8: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 8.
		self assert: value pushes: 8.
		bytecode := FogVMPush8 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #generated }
FogEVMByteCodeWriteStream >> nextPutPush9: aNumber [  
| value bytecode |
		value := self signAwareConversion: aNumber forBytesLength: 9.
		self assert: value pushes: 9.
		bytecode := FogVMPush9 instance parameter: value; 
					  yourself. 
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: bytecode)
			

]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutReturn [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMReturn instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutReturndatacopy [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMReturndatacopy instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutReturndatasize [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMReturndatasize instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutRevert [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMRevert instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSar [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSar instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSdiv [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSdiv instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSelfdestruct [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSelfdestruct instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSgt [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSgt instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSha3 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSha3 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutShl [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMShl instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutShr [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMShr instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSignextend [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSignextend instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSload [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSload instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSlt [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSlt instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSmod [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSmod instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSstore [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSstore instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutStaticcall [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMStaticcall instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutStop [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMStop instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSub [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSub instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap1 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap1 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap10 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap10 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap11 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap11 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap12 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap12 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap13 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap13 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap14 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap14 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap15 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap15 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap16 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap16 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap2 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap2 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap3 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap3 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap4 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap4 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap5 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap5 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap6 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap6 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap7 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap7 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap8 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap8 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutSwap9 [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMSwap9 instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutTimestamp [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMTimestamp instance)
			
]

{ #category : #'#generated - put' }
FogEVMByteCodeWriteStream >> nextPutXor [
		self nextPut:
			(FogEVMMnemonicExecutableMemoryEntry new
				byteNumber: self currentByteNumber;
				instruction: FogVMXor instance)
			
]

{ #category : #generated }
FogEVMByteCodeWriteStream >> signAwareConversion: aNumber forBytesLength: aBytesLength [
	^ (FogEVMRegistry forValue: aNumber bytesLength: aBytesLength) unsignedValue
]
