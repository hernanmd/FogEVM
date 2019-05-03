"
A Call is the representation of the call, or activation, in Ethereum way. 

callValue represnets the money transferred with the execution. 
callerAddress is the address of the caller
contractAddress is the addrress of the contract 
contractInput is the submitted executioninput. In the case of a method activation is the signature plus the parameters encoded.
"
Class {
	#name : #FogEVMCall,
	#superclass : #Object,
	#instVars : [
		'callValue',
		'contractInput',
		'contractAddress',
		'callerAddress',
		'gas',
		'gasPrice'
	],
	#category : #'FogEVM-ByteCode-Interpreter'
}

{ #category : #creation }
FogEVMCall class >> loadDefinition: aFogCallDefinition [
	| newCall |
	newCall := self new.
	newCall
		contractInput:(Hexadecimal new readHexadecimalByteArray:  aFogCallDefinition data).
	newCall callerAddress: (FogEVMRegistry fromPrintString: aFogCallDefinition from length: 20).
	newCall
		contractAddress:
			(aFogCallDefinition to ifNil: [ nil ] ifNotNil: [ :to | FogEVMRegistry fromPrintString: to length: 20 ]).
	newCall callValue: (FogEVMRegistry forValue: aFogCallDefinition value bytesLength: 8).
	newCall gas: (FogEVMRegistry forValue: aFogCallDefinition gas bytesLength: 8).
	newCall gasPrice: (FogEVMRegistry forValue: aFogCallDefinition gasPrice bytesLength: 8).
	^ newCall
]

{ #category : #accessing }
FogEVMCall >> callValue [
	^ callValue
]

{ #category : #accessing }
FogEVMCall >> callValue: aCallValue [
	callValue := aCallValue 
]

{ #category : #accessing }
FogEVMCall >> callerAddress [
	^ callerAddress
]

{ #category : #accessing }
FogEVMCall >> callerAddress: anObject [
	callerAddress := anObject
]

{ #category : #accessing }
FogEVMCall >> contractAddress [
	^ contractAddress
]

{ #category : #accessing }
FogEVMCall >> contractAddress: anObject [
	contractAddress := anObject
]

{ #category : #accessing }
FogEVMCall >> contractInput [
	^ contractInput
]

{ #category : #accessing }
FogEVMCall >> contractInput: anObject [
	contractInput := anObject
]

{ #category : #'as yet unclassified' }
FogEVMCall >> gas [
	^ gas
]

{ #category : #accessing }
FogEVMCall >> gas: aFogEVMRegistry [ 
	gas := aFogEVMRegistry 
]

{ #category : #accessing }
FogEVMCall >> gasPrice [
	^ gasPrice
]

{ #category : #accessing }
FogEVMCall >> gasPrice: aFogEVMRegistry [
	gasPrice := aFogEVMRegistry
]

{ #category : #accessing }
FogEVMCall >> printOn: aStream [
	aStream
		nextPutAll: 'Call(';
		nextPutAll: callerAddress;
		nextPut: $,;
		nextPutAll: contractInput;
		nextPut: $,;
		nextPutAll: gas;
		nextPut: $)
]
