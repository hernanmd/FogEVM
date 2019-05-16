Class {
	#name : #FogEVMDecompileAndUnifyShapingTests,
	#superclass : #TestCase,
	#instVars : [
		'runtime',
		'decompiled'
	],
	#category : #'FogEVM-Decompiler-Unifier-Tests'
}

{ #category : #parsing }
FogEVMDecompileAndUnifyShapingTests >> parse: aString [
	| graph code decompiler unifier |
	code := 'pragma solidity ^0.4.25;
{1}
' format: {aString}.
	graph := (SolidityParser parseStream: aString readStream)
		acceptVisitor: SmGBuilder new.
	runtime := FogConnection new session
		loadPackageForCode: code
		named: #test.
	decompiler := FogEVMIREthereumDecompiler new.
	decompiled := decompiler decompilePackage: runtime.
	(decompiled values flatCollect: #value)
		do: [ :s | 
			unifier := FogEVMAstVariableReadWriteDetector new.
			unifier unify: s ].
	^ graph
]

{ #category : #parsing }
FogEVMDecompileAndUnifyShapingTests >> parseAssemblyExpression: aString [
	^ self parseStatement: aString
]

{ #category : #parsing }
FogEVMDecompileAndUnifyShapingTests >> parseDefinition: aString [
	^ (self parse: ' contract test { ' , aString , '}') query contracts
		first

]

{ #category : #parsing }
FogEVMDecompileAndUnifyShapingTests >> parseExpression: aString [
	^ self parseStatement: aString
]

{ #category : #parsing }
FogEVMDecompileAndUnifyShapingTests >> parseStatement: aString [
	^ (self
		parse:
			' 
contract test { 
	function functionTest () {
	' , aString
				,
					'
}
}') query contracts first methods first
]

{ #category : #'index access' }
FogEVMDecompileAndUnifyShapingTests >> testArrayAccessFunctionApply [
	| method functionCall |
	method := self parseExpression: '
	function()returns(int) [20][3] variable;
	variable[1][2]();'.
	functionCall := method body statements second.
	self assert: functionCall identifier isBind.
	self assert: (functionCall identifier isKindOf: SmGArrayAccess).
	self assert: (functionCall identifier array isKindOf: SmGArrayAccess)
]

{ #category : #'index access' }
FogEVMDecompileAndUnifyShapingTests >> testArrayAccessFunctionApplyArrayAccess [
	| method arrayAccess functionCall |
	method := self parseExpression: '
	function()returns(int[]) [20][3] variable;
	variable[1][2]()[1];'.
	arrayAccess := method body statements second.
	self assert: (arrayAccess isKindOf: SmGArrayAccess).
	functionCall := arrayAccess array.
	self assert: functionCall identifier isBind.
	self assert: (functionCall identifier isKindOf: SmGArrayAccess).
	self assert: (functionCall identifier array isKindOf: SmGArrayAccess)
]

{ #category : #'index access' }
FogEVMDecompileAndUnifyShapingTests >> testArrayAccessFunctionApplyArrayTwoAccess [
	| method arrayAccess functionCall |
	method := self parseExpression: '
	function()returns(int[][]) [20][3] variable;
	variable[1][2]()[3][4];'.
	arrayAccess := method body statements second.
	self assert: (arrayAccess isKindOf: SmGArrayAccess).
	self assert: (arrayAccess array isKindOf: SmGArrayAccess).
	functionCall := arrayAccess array array.
	self assert: functionCall identifier isBind.
	self assert: (functionCall identifier isKindOf: SmGArrayAccess).
	self assert: (functionCall identifier array isKindOf: SmGArrayAccess)
]

{ #category : #'index access' }
FogEVMDecompileAndUnifyShapingTests >> testArrayAccessFunctionApplyArrayTwoAccessApply [
	| method functionCall |
	method := self parseExpression: '
	function()returns(function()returns(int)[][]) [20][3] variable;
	variable[1][2]()[3][4]();'.
	functionCall := method body statements second.
	self assert: (functionCall isKindOf: SmGFunctionCall).
	self assert: functionCall identifier isBind.
	self assert: (functionCall identifier isKindOf: SmGArrayAccess).
	self assert: (functionCall identifier array isKindOf: SmGArrayAccess).
	self
		assert: (functionCall identifier array array isKindOf: SmGFunctionCall).
	self
		assert:
			(functionCall identifier array array identifier array
				isKindOf: SmGArrayAccess)
]

{ #category : #'index access' }
FogEVMDecompileAndUnifyShapingTests >> testArrayAccessFunctionArgumentsApply [
	| method functionCall |
	method := self parseExpression: '
	function(int,int)returns(int) [20][3] variable;
	variable[1][2](1, 2);'.
	functionCall := method body statements second.
	self assert: functionCall identifier isBind.
	self assert: functionCall arguments size equals: 2.
	self assert: (functionCall identifier isKindOf: SmGArrayAccess).
	self assert: (functionCall identifier array isKindOf: SmGArrayAccess)
]

{ #category : #'type naming' }
FogEVMDecompileAndUnifyShapingTests >> testArrayNative [
	| var contract |
	contract := self parseDefinition: ' uint [] variable; '.
	var := contract variables first.
	self assert: var class equals: SmGTypeProperty.
	self assert: var type lookupValue isArrayType.
	self
		assert: var type lookupValue innerType lookupValue typename
		equals: #uint256.
	self assert: var identifier literalValue equals: #variable
]

{ #category : #'type naming' }
FogEVMDecompileAndUnifyShapingTests >> testArrayUserType [
	| var contract |
	contract := self parseDefinition: '
	test [] variable; '.
	var := contract variables first.
	self assert: var class equals: SmGTypeProperty.
	self assert: var type lookupValue isArrayType.
	self
		assert: var type lookupValue innerType identifier literalValue
		equals: #test.
	self assert: var identifier literalValue equals: #variable
]

{ #category : #assembly }
FogEVMDecompileAndUnifyShapingTests >> testAssemblyBlock [
	| block method |
	method := self
		parseAssemblyExpression:
			'
	  	assembly { }'.
	block := method body statements first.
	self assert: (block isKindOf: SmGAsmSequence)
]

{ #category : #assembly }
FogEVMDecompileAndUnifyShapingTests >> testAssemblyFor [
	| block for | 
	
	block := self parseAssemblyExpression: '
	assembly { 
	  let y := 1
	  let x := 2 
	  for { let i := 0 } lt(i, x) { i := add(i, 1) } { y := 2 }
	}'.
	for:= block body statements first statements third. 
	self assert: block body statements first statements size equals: 3.
	self assert: for initializeStatement class equals: SmGAsmSequence .
	self assert: for condition class equals: SmGAsmFunctionCall  .
	self assert: for loopExpressions class equals: SmGAsmSequence.
	self assert: for body class equals: SmGAsmSequence .

]

{ #category : #assembly }
FogEVMDecompileAndUnifyShapingTests >> testAssemblyFunction [
	| block fn |
	block := self
		parseAssemblyExpression:
			'
	assembly { 
	  function power(base, exponent) -> result {
       
    }
	}'.
	self assert: block body statements first statements size equals: 1.
	fn := block body statements first statements first.
	self assert: fn parameters size equals: 2.
	self
		assert:
			(fn parameters
				allSatisfy: [ :p | p type lookupValue typename = #uint256 ]).
	self assert: fn body class equals: SmGAsmSequence.
	self assert: fn identifier class equals: SmGMethodIdentifier
]

{ #category : #assembly }
FogEVMDecompileAndUnifyShapingTests >> testAssemblyIf [
	| block control |
	block := self
		parseAssemblyExpression:
			'
		assembly { 
			let x := 1
			if slt(x, 0) { x := sub(0, x) }
		}
    '.
	self assert: block body statements first statements size equals: 2.
	control :=block body statements first statements second.
	self assert: control condition class equals: SmGAsmFunctionCall .
	self assert: control ifTrue  class equals: SmGAsmSequence .

]

{ #category : #assembly }
FogEVMDecompileAndUnifyShapingTests >> testAssemblySwitch [
	| block control |
	block := self
		parseAssemblyExpression:
			'
	
	assembly { 
		  let exponent := 2
		  let base := 1
		  let result := 0
		
        switch exponent
        case 0 { result := 1 }
        case 1 { result := base }
        default {
            result := base 
            switch exponent
                case 1 { result := 2 }
        }
}
    '.
	self assert: block body statements first statements size equals: 4.
	control := block body statements first statements fourth.
	self assert: control cases size equals: 3.
	control cases allSatisfy: [ :c | c isKindOf: SmGAsmCase ].
	control cases anySatisfy: [ :c | c value = #defaultValue ]
]

{ #category : #'contract properties' }
FogEVMDecompileAndUnifyShapingTests >> testConstantProperty [
	| containingContract constant |
	containingContract := self
		parseDefinition: 'uint constant x = 32**22 + 8;'.
	
	self assert: containingContract constants size equals: 1.
	self assert: containingContract methods isEmpty.
	self assert: containingContract variables isEmpty.
	
	constant := containingContract constants first.
	
	self assert: (constant isKindOf: SmGConstant).
	self assert: (constant value isKindOf: SmGBinaryOperation).
	self assert: (constant value left isKindOf: SmGBinaryOperation).
	self assert: constant value right isSmGLiteral
]

{ #category : #contracts }
FogEVMDecompileAndUnifyShapingTests >> testContractHasOneSuperClass [
	| program contract |
	program := self
		parse:
			'
			contract Superclass { 
			}
			contract Example is Superclass {
    		}'.
	self assert: program query contracts size equals: 2.
	contract := program query contracts second.
	self assert: contract inheritances size equals: 2.
	self assert: (contract inheritances allSatisfy: #isBind).
	self
		assert: contract inheritances first identifier literalValue
		equals: #Superclass.
	self
		assert: contract inheritances second identifier literalValue
		equals: #address.
	self assert: contract inheritances first lookupValue identifier literalValue equals:#Superclass.
	self
		assert: (contract inheritances second lookupValue isKindOf: SmGTypeAddress)
]

{ #category : #contracts }
FogEVMDecompileAndUnifyShapingTests >> testContractHasOneSuperClassWithArgument [
	| program contract |
	program := self
		parse:
			'
			contract Superclass { 
				function Superclass (string arg){}
			}
			contract Example is Superclass("arg") {
    		}'.
	self assert: program query contracts size equals: 2.
	contract := program query contracts second.
	self assert: contract inheritances size equals: 2.
	self assert: contract inheritances first arguments size equals: 1.
	"Superclass is not defined. The lookup should fail."
	self assert: contract inheritances first lookupValue identifier literalValue equals: 'Superclass'.
	self assert: contract inheritances first arguments size equals: 1.
	self assert: contract inheritances first arguments first literalValue equals: '"arg"'.
	self assert: (contract inheritances second lookupValue isKindOf: SmGTypeAddress)
]

{ #category : #contracts }
FogEVMDecompileAndUnifyShapingTests >> testContractWithElements [
	| root contract |
	root := self
		parse:
			'contract Example {
				int a;
				function name (int a) {  }
    		}'.
	self assert: root query contracts size equals: 1.
	contract := root query contracts first.
	self assert: contract methods size equals: 1.
	self assert: contract variables size equals: 1
]

{ #category : #'control flows' }
FogEVMDecompileAndUnifyShapingTests >> testDoWhile [
	| method control |
	method := self
		parseStatement:
			'do {
			  1 ; 
			} while(1 > 2 ); '.
	control := method body statements first.
	self assert: (control condition isKindOf: SmGBinaryOperation).
	self assert: control condition isComparison.
	self assert: (control body isKindOf: SmGSequence ).
	self assert: control body statements size equals: 1
]

{ #category : #'control flows' }
FogEVMDecompileAndUnifyShapingTests >> testDoWhileBlock [
	| control method |
	method := self parseStatement: 'do 1; while(1 > 2); '.
	control := method body statements first.
	self assert: (control condition isKindOf: SmGBinaryOperation).
	self assert: control condition isComparison.
	self assert: (control body isKindOf: SmGSequence ).
	self assert: control body statements size equals: 1
]

{ #category : #'type definition' }
FogEVMDecompileAndUnifyShapingTests >> testEnum [
	| contract enum |
	contract := self
		parseDefinition:
			' enum Example {Val, Val2} 
'.
	self assert: contract typeDefinitions size equals: 1.
	enum := contract typeDefinitions first.
	self assert: (enum isKindOf: SmGEnum).
	self assert: enum values size equals: 2.
	self
		assert: (enum values allSatisfy: [ :d | d isKindOf: SmGIdentifier ])
]

{ #category : #events }
FogEVMDecompileAndUnifyShapingTests >> testEvent [
	| event contract |
	contract := self
		parseDefinition: 'event AnonymousDeposit(address indexed from, uint value);'.
	self assert: contract events size equals: 1.
	event := contract events first.
	self assert: event parameters size equals: 2.
	self assert: event identifier literalValue equals: #AnonymousDeposit.
	self deny: event isAnonymous 
]

{ #category : #events }
FogEVMDecompileAndUnifyShapingTests >> testEventAnonymous [
	| event contract |
	contract := self
		parseDefinition: 'event AnonymousDeposit(address indexed from, uint value) anonymous;'.
	self assert: contract events size equals: 1.
	event := contract events first.
	self assert: event parameters size equals: 2.
	self assert: event identifier literalValue equals: #AnonymousDeposit.
	self assert: event isAnonymous 
]

{ #category : #'type naming' }
FogEVMDecompileAndUnifyShapingTests >> testFixedArrayNative [
	| var contract |
	contract := self parseDefinition: ' uint [4] variable; '.
	self assert: contract variables size equals: 1.
	var := contract variables first.
	self assert: var class equals: SmGTypeProperty.
	self deny: var type lookupValue isFail.
	self assert: var type lookupValue isArrayType.
	self assert: var type length isSmGLiteral.
	self
		assert: var type lookupValue innerType lookupValue class
		equals: SmGUIntType.
	self
		assert: var type lookupValue innerType lookupValue length
		equals: 256.
	self assert: var identifier literalValue equals: #variable
]

{ #category : #'type naming' }
FogEVMDecompileAndUnifyShapingTests >> testFixedArrayUserType [
	| var contract |
	contract := self parseDefinition: ' test [4] variable; '.
	self assert: contract variables size equals: 1.
	var := contract variables first.
	self assert: var class equals: SmGTypeProperty.
	self deny: var type lookupValue isFail.
	self assert: var type lookupValue isArrayType.
	self assert: var type length isSmGLiteral.
	self assert: var type lookupValue innerType lookupValue identifier literalValue equals:#test.
	self assert: var identifier literalValue equals: #variable.

]

{ #category : #'control flows' }
FogEVMDecompileAndUnifyShapingTests >> testFor [
	| control method |
	method := self parseStatement: ' 
	int i = 1;
	for( i; i < 2 ; i++ ) 1; '.
	self assert: method body statements size equals: 2.
	control := method body statements second.
	self assert: control condition isComparison.
	self assert: control initializeStatement isCollection.
	self assert: control initializeStatement size equals: 1.
	self assert: control initializeStatement first isBind.
	self assert: control loopExpressions isCollection.
	self assert: control loopExpressions size equals: 1.
	self assert: (control body isKindOf: SmGSequence)
]

{ #category : #'control flows' }
FogEVMDecompileAndUnifyShapingTests >> testForBlock [
	| control method |
	method := self parseStatement: ' int i; 
	for( i; i < 2 ; i++ ) { i = 1 +1 ; } '.
	self assert: method body statements size equals: 2.
	control := method body statements second.
	self assert: control condition isComparison.
	self assert: control initializeStatement isCollection.
	self assert: control initializeStatement first isBind.
		self assert:( control initializeStatement first lookupValue isKindOf: SmGTypeProperty ).
	self assert: control initializeStatement size equals: 1.
	self assert: control initializeStatement first isBind.
	self assert: control loopExpressions isCollection.
	self assert: control loopExpressions size equals: 1.
	self assert: (control body isKindOf: SmGSequence)
]

{ #category : #'control flows' }
FogEVMDecompileAndUnifyShapingTests >> testForVariableBlock [
	| control method |
	method := self
		parseStatement: ' for( int i = 0; i < 2 ; i++ ) { 1; } '.
	self assert: method body statements size equals: 1.
	control := method body statements first.
	self assert: control condition isComparison.
	self assert: control initializeStatement isCollection.
	self assert: control initializeStatement size equals: 1.
	self
		assert: (control initializeStatement first isKindOf: SmGAssignement).
	self assert: control loopExpressions isCollection.
	self assert: control loopExpressions size equals: 1.
	self assert: (control body isKindOf: SmGSequence)
]

{ #category : #'index access' }
FogEVMDecompileAndUnifyShapingTests >> testFunctionApply [
	| call contract method |
	contract := self parseDefinition: '
	function fn () {  }
	function test () {fn();}'.
	method := contract methods second. 
	call := method body statements first.
	self assert: call class equals: SmGMessageSend.
	self assert: call receiver equals: method body.
	self assert: call arguments isEmpty.
	self assert: call identifier literalValue equals: #fn
]

{ #category : #functions }
FogEVMDecompileAndUnifyShapingTests >> testFunctionFallback [
	| function contract |
	contract := self
		parseDefinition:
			'
		int out; int _in;
	function () public {
        out = _in;
    }'.
	self assert: contract methods size equals: 1.
	function := contract methods first.
	self assert: (function isKindOf: SmGMethod)
]

{ #category : #functions }
FogEVMDecompileAndUnifyShapingTests >> testFunctionManyParameterManyReturn [
	| method contract |
	contract := self
		parseDefinition:
			'function fexmaple(uint i, uint x, uint b, uint r) returns (uint e1, uint e2)  {
			e1 = 1; 
			e2 = 2;
    }'.
	method := contract methods first.
	self assert: method parameters size equals: 4.
	self assert: method returns size equals: 2.
	self assert: method body statements size equals: 2
]

{ #category : #functions }
FogEVMDecompileAndUnifyShapingTests >> testFunctionNoParametersNoReturn [
	| contract method |
	contract := self
		parseDefinition:
			'function f()  {

    }'.
	method := contract methods first.
	self assert: method parameters size equals: 0.
	self assert: method returns size equals: 0.
	self assert: method body statements isEmpty
]

{ #category : #functions }
FogEVMDecompileAndUnifyShapingTests >> testFunctionOneParameterOneReturn [
	| contract method |
	contract := self
		parseDefinition: 'function f(uint i) returns (uint b)  {}'.
	method := contract methods first.
	self assert: method parameters size equals: 1.
	self assert: method returns size equals: 1.
	self assert: method body statements isEmpty
]

{ #category : #functions }
FogEVMDecompileAndUnifyShapingTests >> testFunctionPayable [
	| contract method |
	contract := self
		parseDefinition:
			'function f(uint8 _in) payable returns (uint8 out) {
        out = _in;
    }'.
	method := contract methods first.
	self assert: method modifiers size equals: 1.
	self assert: method modifiers first isPayable.
	self assert: method isPayable.
	self assert: method modifiers first literalValue equals: #payable
]

{ #category : #functions }
FogEVMDecompileAndUnifyShapingTests >> testFunctionPrivate [
	| contract method |
	contract := self
		parseDefinition:
			'function f(uint8 _in) private returns (uint8 out) {
        out = _in;
    }'.
	method := contract methods first.
	self assert: method modifiers size equals: 1.
	self assert: method modifiers first isPrivate.
	self assert: method modifiers first literalValue equals: #private.
	self assert: method isPrivate
]

{ #category : #functions }
FogEVMDecompileAndUnifyShapingTests >> testFunctionPublic [
	| contract method |
	contract := self
		parseDefinition:
			'function f(uint8 _in) public returns (uint8 out) {
        out = _in;
    }'.
	method := contract methods first.
	self assert: method isPublic.
	self assert: method modifiers size equals: 1.
	self assert: method modifiers first isPublic.
	self assert: method modifiers first literalValue equals: #public
]

{ #category : #functions }
FogEVMDecompileAndUnifyShapingTests >> testFunctionPure [
	| contract method |
	contract := self
		parseDefinition:
			'function f(uint8 _in) pure returns (uint8 out) {
        out = _in;
    }'.
	method := contract methods first.
	self assert: method modifiers size equals: 1.
	self assert: method isPure.
	self assert: method modifiers first isPure.
	self assert: method modifiers first literalValue equals: #pure
]

{ #category : #functions }
FogEVMDecompileAndUnifyShapingTests >> testFunctionSignature [
	| contract method |
	contract := self
		parseDefinition: 'function f(uint8 _in) pure returns (uint8 out);'.
	method := contract methods first.
	self assert: method isAbstractMethod.
	self assert: method isPure
]

{ #category : #functions }
FogEVMDecompileAndUnifyShapingTests >> testFunctionUserDefined [
	| contract method |
	contract := self
		parseDefinition:
			'
		modifier owner () { 
		_; }
		function f(uint8 _in) owner returns (uint8 out) {
        out = _in;
    }'.
	method := contract methods first.
	self assert: method modifiers size equals: 1.
	self assert: method modifiers first isUserDefinedModifier.
	self
		assert: method modifiers first identifier literalValue
		equals: #owner
]

{ #category : #functions }
FogEVMDecompileAndUnifyShapingTests >> testFunctionView [
	| contract method |
	contract := self
		parseDefinition:
			'function f(uint8 _in) view returns (uint8 out) {
        out = _in;
    }'.
	method := contract methods first.
	self assert: method modifiers size equals: 1.
	self assert: method modifiers first isView.
	self assert: method isView.
	self assert: method modifiers first literalValue equals: #view
]

{ #category : #'control flows' }
FogEVMDecompileAndUnifyShapingTests >> testIf [
	| control method |
	method := self
		parseStatement:
			'if ( 2 > 3 ) 1;
			'.
	control := method body statements first.
	self assert: control condition isComparison.
	self assert: (control ifTrue isKindOf: SmGSequence).
	self assert: control ifFalse isNil
]

{ #category : #'control flows' }
FogEVMDecompileAndUnifyShapingTests >> testIfBlock [
	| control method |
	method := self
		parseStatement:
			'if ( 2 > 3 ) {
				return;
			}
			'.
	control := method body statements first.
	self assert: control condition isComparison.
	self assert: (control ifTrue isKindOf: SmGSequence).
	self assert: control ifFalse isNil
]

{ #category : #'control flows' }
FogEVMDecompileAndUnifyShapingTests >> testIfElse [
	| control method |
	method := self
		parseStatement:
			'if ( 2 > 3 ) 1;
			else 1;'.
	control := method body statements first.
	self assert: control condition isComparison.
	self assert: (control ifTrue isKindOf: SmGSequence).
	self assert: (control ifFalse isKindOf: SmGSequence)
]

{ #category : #'control flows' }
FogEVMDecompileAndUnifyShapingTests >> testIfElseBlock [
	| control method |
	method := self
		parseStatement:
			'if ( 2 > 3 ) {
				return;
			} else { 
				return;
			}'.
	control := method body statements first.
	self assert: control condition isComparison.
	self assert: (control ifTrue isKindOf: SmGSequence).
	self assert: (control ifFalse isKindOf: SmGSequence)
]

{ #category : #'type naming' }
FogEVMDecompileAndUnifyShapingTests >> testMapNativeArray [
	| contract var |
	contract := self
		parseDefinition: ' mapping(int => test[])  variable; '.
	var := contract variables first.
	self assert: var class equals: SmGTypeProperty.
	self assert: var type lookupValue isMapping.
	self
		assert: var type lookupValue key lookupValue typename
		equals: #int256.
	self assert: var type lookupValue value lookupValue isArrayType.
	self assert: var type lookupValue value lookupValue innerType isBind.
	self
		assert:
			var type lookupValue value lookupValue innerType identifier
				literalValue
		equals: #test
]

{ #category : #'type naming' }
FogEVMDecompileAndUnifyShapingTests >> testMapNativeArrayAndUser [
	| contract var |
	contract := self
		parseDefinition: ' 
		mapping(int => test)  variable3; 
		mapping(int => test[])  variable; 
		mapping(int => test)  variable2; 
		'.
	var := contract variables detect: [: v | v identifier literalValue = #variable ].
	self assert: var class equals: SmGTypeProperty.
	self assert: var type lookupValue isMapping.
	self
		assert: var type lookupValue key lookupValue typename
		equals: #int256.
	self assert: var type lookupValue value lookupValue isArrayType.
	self assert: var type lookupValue value lookupValue innerType isBind.
	self
		assert:
			var type lookupValue value lookupValue innerType identifier
				literalValue
		equals: #test
]

{ #category : #'type naming' }
FogEVMDecompileAndUnifyShapingTests >> testMapNativeNative [
	| var contract |
	contract := self parseDefinition: ' mapping(int => int)  variable; '.
	var := contract variables first.
	self assert: var class equals: SmGTypeProperty.
	self assert: var type lookupValue isMapping.
	self
		assert: var type lookupValue key lookupValue typename
		equals: #int256.
	self
		assert: var type lookupValue value lookupValue typename
		equals: #int256
]

{ #category : #'type naming' }
FogEVMDecompileAndUnifyShapingTests >> testMapNativeUser [
	| var contract |
	contract := self parseDefinition: ' mapping(int => test)  variable; '.
	var := contract variables first.
	self assert: var class equals: SmGTypeProperty.
	self assert: var type lookupValue isMapping.
	self
		assert: var type lookupValue key lookupValue typename
		equals: #int256.
	self
		assert: var type lookupValue value identifier literalValue
		equals: #test
]

{ #category : #contracts }
FogEVMDecompileAndUnifyShapingTests >> testMinimalContractIsContract [
	| program contract |
	program := self
		parse:
			'contract Example {
    		}'.
	contract := program query contracts first. 
	self assert: contract isContract.
	self assert: contract identifier literalValue equals: #Example
]

{ #category : #contracts }
FogEVMDecompileAndUnifyShapingTests >> testMinimalContractIsEmpty [
	| program contract |
	program := self
		parse:
			'contract Example {
    		}'.
	contract := program query contracts first.
	self assert: contract inheritances size equals: 1.
	self assert: contract properties size equals: 2.
	"
		Only two properties are set in an empty contract:
		self 
		this 
	"
	self
		assert: (contract properties values allSatisfy: [ :p | p = contract ])
]

{ #category : #contracts }
FogEVMDecompileAndUnifyShapingTests >> testMinimalInterfaceIsInterface [
	| program contract |
	program := self
		parse:
			'interface Example {
    		}'.
	contract := program query interfaces first. 
	self assert: contract isInterface.
	self assert: contract identifier literalValue equals: #Example
]

{ #category : #contracts }
FogEVMDecompileAndUnifyShapingTests >> testMinimalLibraryIsLibrary [
		| program contract |
	program := self
		parse:
			'library Example {
    		}'.
	contract := program query libraries first. 
	self assert: contract isLibrary .
	self assert: contract identifier literalValue equals: #Example
]

{ #category : #modifiers }
FogEVMDecompileAndUnifyShapingTests >> testModifierNoneParameters [
	| modifier contract |
	contract := self parseDefinition: 'modifier example {     _;     }'.
	modifier := contract modifiers first.
	self assert: modifier isUserDefinedModifier.
	self assert: modifier identifier literalValue equals: #example.
	self assert: modifier parameters isEmpty.
	self assert: modifier body statements size equals: 1
]

{ #category : #modifiers }
FogEVMDecompileAndUnifyShapingTests >> testModifierOneParameter [
	| modifier contract |
	contract := self
		parseDefinition: 'modifier example(int bla) {     _;     }'.
	modifier := contract modifiers first.
	self assert: modifier parameters  size equals: 1.
	self assert: modifier identifier literalValue equals: #example.
	self assert: modifier body statements size equals: 1
]

{ #category : #'type naming' }
FogEVMDecompileAndUnifyShapingTests >> testNativeType [
	| var contract |
	contract := self parseDefinition: ' uint8 variable; '.
	var := contract variables first.
	
	self assert: var class equals: SmGTypeProperty .

	self assert: var identifier literalValue equals: #variable.
	self assert: var type lookupValue typename  equals: #uint8.

]

{ #category : #'index access' }
FogEVMDecompileAndUnifyShapingTests >> testOneIndexAccess [
	| var method |
	method := self parseExpression: '
	int [3] variable;
	variable[1];'.
	var := method body statements second.
	self assert: var class equals: SmGArrayAccess.
	self assert: var index isSmGLiteral.
	self assert: var array identifier literalValue equals: #variable
]

{ #category : #'type definition' }
FogEVMDecompileAndUnifyShapingTests >> testStruct [
	| struct contract |
	contract := self
		parseDefinition:
			'struct bigint {
        uint[] limbs;
    }
'.
	struct := contract typeDefinitions first.
	self assert: (struct isKindOf: SmGStruct).
	self assert: struct variables size equals: 1.
	self
		assert: struct variables first type lookupValue parent
		equals: struct.
	self assert: struct variables first type lookupValue isArrayType
]

{ #category : #'type definition' }
FogEVMDecompileAndUnifyShapingTests >> testStructAccess [
	| struct contract functionProperty |
	contract := self
		parseDefinition:
			'
	
	struct bigint {
        uint[] limbs;
    }

    bigint property;
	
	function tesone() { 
		property.limbs[1];
	}
'.
	struct := contract typeDefinitions first.
	functionProperty := contract methods first body statements first.
	self
		assert: functionProperty array lookupValue type lookupValue isArrayType.
	self
		assert:
			functionProperty array lookupValue parent type lookupValue
				isUserDefinedType
]

{ #category : #'control flows' }
FogEVMDecompileAndUnifyShapingTests >> testTernar [
	| control method |
	method := self parseStatement: '
	int8 a = 1;
	(a>1) ? 1:2; '.
	control := method body statements second.
	self assert: control condition isComparison.
	self assert: (control ifTrue isKindOf: SmGSequence).
	self assert: control ifTrue statements first isSmGLiteral.
	self assert: control ifFalse statements first isSmGLiteral
]

{ #category : #'index access' }
FogEVMDecompileAndUnifyShapingTests >> testThreeIndexAccess [
	| var method |
	method := self parseExpression: '
	int [20][3][5] variable;
	variable[1][2][3];'.
	var := method body statements second.
	
	self assert: var class equals: SmGArrayAccess.
	self assert: var index isSmGLiteral.
	self assert: var array class equals: SmGArrayAccess.
	self assert: var array index isSmGLiteral.
	self assert: var array array class equals: SmGArrayAccess.
	self assert: var array array index isSmGLiteral.
	self assert: var array array array identifier literalValue equals: #variable.
	
]

{ #category : #'index access' }
FogEVMDecompileAndUnifyShapingTests >> testTwoIndexAccess [
	| var method |
	method := self parseExpression: '
	int [20][3] variable;
	variable[1][2];'.
	var := method body statements second.
	self assert: var class equals: SmGArrayAccess.
	self assert: var index isSmGLiteral.
	self assert: var array class equals: SmGArrayAccess.
	self assert: var array index isSmGLiteral.
	self
		assert: var array array identifier literalValue
		equals: #variable
]

{ #category : #'type naming' }
FogEVMDecompileAndUnifyShapingTests >> testUserType [
	| var contract |
	contract := self parseDefinition: ' test variable; '.
	var := contract variables first.
	self assert: var class equals: SmGTypeProperty.
	self assert: var type identifier literalValue equals: #test.
	self assert: var identifier literalValue equals: #variable
]

{ #category : #'control flows' }
FogEVMDecompileAndUnifyShapingTests >> testWhileBlock [
	| method control |
	method := self
		parseStatement:
			' while(1 > 2) { 
				1+1;
			 }   '.
	control := method body statements first.
	self assert: (control condition isKindOf: SmGBinaryOperation).
	self assert: control condition isComparison.
	self assert: (control body isKindOf: SmGSequence).
	self assert: control body statements size equals: 1
]
