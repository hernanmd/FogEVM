Trait {
	#name : #DecompilerAssertions,
	#category : #'FogEVM-Decompiler-Tests'
}

{ #category : #'one parameter global' }
DecompilerAssertions >> assertGlobalWithOneParameter: sequence [

	"BYTECODE(Parameter)->
		sequence + 
		 value := parameter
	    runtime := Runtime.
	    valueToPush := runtime valueForParameter: parameter.
	   stack +
	    valueToPush
	"

	self assert: self decompiler programHasFinished.
	self assertIsSequence: sequence.
	self assert: sequence allInstructions size equals: 3.
	self assert: sequence statements size equals: 3.
	self assertIsAssignment: sequence statements first.
	self assertIsAssignment: sequence statements second.
	self assertIsAssignment: sequence statements third.
	self assertIsLiteral: sequence statements first value.
	self assertIsVariable: sequence statements second variable named: #Runtime.
	self assertIsMessageSend: sequence statements third value.
	self assertIsRuntimeGlobal: sequence statements second value.
	self assert: sequence statements second variable equals: sequence statements third value receiver.
	self assert: sequence statements first variable equals: sequence statements third value arguments first.
	self assert: self decompiler scope stack size equals: 1.
	self assert: self decompiler scope stack pop equals: sequence statements third variable
]

{ #category : #'one parameter global' }
DecompilerAssertions >> assertGlobalWithOneParameterAndOneIndirection: sequence [
	"BYTECODE(Parameter)->
		sequence + 
		 value := parameter
	    runtime := Runtime.
	    valueToPush := runtime valueForParameter: parameter.
	   stack +
	    valueToPush
	"

	self assert: self decompiler programHasFinished.
	self assertIsSequence: sequence.
	self assert: sequence allInstructions size equals: 3.
	self assert: sequence statements size equals: 4.
	self assertIsAssignment: sequence statements first.
	self assertIsAssignment: sequence statements second.
	self assertIsAssignment: sequence statements third.
	self assertIsAssignment: sequence statements fourth.
	self assertIsLiteral: sequence statements first value.
	self assertIsVariable: sequence statements second variable named: #Runtime.
	self assertIsMessageSend: sequence statements third value.
	self assertIsRuntimeGlobal: sequence statements second value.
	self assert: sequence statements second variable equals: sequence statements third value receiver.
	self assert: sequence statements third variable equals: sequence statements fourth value receiver.
	self assert: self decompiler scope stack size equals: 1.
	self assert: self decompiler scope stack pop equals: sequence statements fourth variable
]

{ #category : #'no parameter global' }
DecompilerAssertions >> assertGlobalWithoutParameter: sequence [

   "BYTECODE->
		sequence + 
	    runtime := Runtime.
	    relatedData := runtime getRelatedData.
		 transform := relatedData transform.
	   stack +
	    transform
	"

	self assert: self decompiler programHasFinished.
	self assertIsSequence: sequence.
	self assert: sequence allInstructions size equals: 2.
	self assert: sequence statements size equals: 3.
	
	self assertIsAssignment: sequence statements first.
	self assertIsAssignment: sequence statements second.
	self assertIsAssignment: sequence statements third.
	
	self assertIsVariable: sequence statements first variable named: #Runtime.
	self assertIsMessageSend: sequence statements second value.
	self assertIsMessageSend: sequence statements third value.
	self assertIsRuntimeGlobal: sequence statements first value.
	
	self assert: sequence statements second value receiver equals: sequence statements first variable.
	self assert: sequence statements first variable equals: sequence statements second value receiver.
	self assert: sequence statements second variable equals: sequence statements third value receiver.
	
	self assert: self decompiler scope stack size equals:1 .
	self assert: self decompiler scope stack pop equals: sequence statements third variable.
	
]

{ #category : #asserting }
DecompilerAssertions >> assertIsAssignment: aFogEVMAssignation [
	self assert: (aFogEVMAssignation isKindOf: FogEVMAssignation).
	^ true.
]

{ #category : #assertions }
DecompilerAssertions >> assertIsBinaryOperation: aFogAstNode selector: aSelector [ 
	self assert: aFogAstNode isEVMMessageSend .
	self assert: aFogAstNode selector equals: aSelector.
	self assert: aFogAstNode arguments size equals: 1.
]

{ #category : #asserting }
DecompilerAssertions >> assertIsBinaryOperationBytecode: sequence stack: stack selector: aSelector [
   "BYTECODE(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 addition := a OP b
	  stack + 
	    addition
	"
	self assert: sequence statements size equals: 3.
	self assert: sequence allInstructions size equals: 4.
	self assertIsBinaryOperation: sequence statements last value selector: aSelector.
	self assert: stack size equals: 1.
	self assert: stack pop equals: sequence statements last variable
]

{ #category : #asserting }
DecompilerAssertions >> assertIsLiteral: aFogEVMLiteral [
	self assert: (aFogEVMLiteral isKindOf: FogEVMLiteral)
]

{ #category : #assertion }
DecompilerAssertions >> assertIsMemoryLoad: aFogEVMAstMemoryLoad [
	self assert: (aFogEVMAstMemoryLoad isKindOf: FogEVMAstMemoryLoad)
]

{ #category : #assertion }
DecompilerAssertions >> assertIsMemoryWrite: aFogEVMAstMemoryStore [
	self assert: (aFogEVMAstMemoryStore isKindOf: FogEVMAstMemoryStore)
]

{ #category : #asserting }
DecompilerAssertions >> assertIsMessageSend: aFogEVMAstMessageSend [
	self assert: (aFogEVMAstMessageSend isKindOf: FogEVMAstMessageSend)
]

{ #category : #asserting }
DecompilerAssertions >> assertIsRuntimeGlobal: aFogEVMAstContractAccess [
	self assert: (aFogEVMAstContractAccess isKindOf: FogEVMAstRuntimeGlobal)
]

{ #category : #assertions }
DecompilerAssertions >> assertIsUnaryMessageSend: aFogAstNode selector: aSelector [ 
	self assert: aFogAstNode isEVMMessageSend .
	self assert: aFogAstNode selector equals: aSelector.
	self assert: aFogAstNode arguments size equals: 1.
]

{ #category : #asserting }
DecompilerAssertions >> assertIsUnaryMessageSendBytecode: sequence stack: stack selector: aSelector [
   "BYTECODE(A,B)->
	  sequence +
	    a := A.
		 b := B.
		 addition := a OP b
	  stack + 
	    addition
	"
	self assert: sequence statements size equals: 3.
	self assert: sequence allInstructions size equals: 4.
	self assertIsUnaryMessageSend: sequence statements last value selector: aSelector.
	self assert: stack size equals: 1.
	self assert: stack pop equals: sequence statements last variable
]

{ #category : #asserting }
DecompilerAssertions >> assertIsVariable: aFogEVMAstVariable named: aString [ 
	self assert: (aFogEVMAstVariable isKindOf: FogEVMAstVariable).
	self assert: aFogEVMAstVariable name equals: aString
]

{ #category : #'no parameter global' }
DecompilerAssertions >> assertRuntimeDirectGlobalWithoutParameter: sequence [

   "BYTECODE->
		sequence + 
	    runtime := Runtime.
	    relatedData := runtime getRelatedData.
		 transform := relatedData transform.
	   stack +
	    transform
	"

	self assert: self decompiler programHasFinished.
	self assertIsSequence: sequence.
	self assert: sequence allInstructions size equals: 2.
	self assert: sequence statements size equals: 2.
	
	self assertIsAssignment: sequence statements first.
	self assertIsAssignment: sequence statements second.

	
	self assertIsVariable: sequence statements first variable named: #Runtime.
	self assertIsMessageSend: sequence statements second value.
	self assertIsRuntimeGlobal: sequence statements first value.
	
	self assert: sequence statements second value receiver equals: sequence statements first variable.
	self assert: sequence statements first variable equals: sequence statements second value receiver.
	
	self assert: self decompiler scope stack size equals:1 .
	self assert: self decompiler scope stack pop equals: sequence statements second variable.
	
]
