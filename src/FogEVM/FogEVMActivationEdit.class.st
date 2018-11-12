Class {
	#name : #FogEVMActivationEdit,
	#superclass : #FogEVMActivationView,
	#instVars : [
		'generateMethodActivation',
		'generateContractDeploy'
	],
	#category : #'FogEVM-UIDebugger-Open'
}

{ #category : #specs }
FogEVMActivationEdit class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :c | 
			c
				newRow: [ :r | 
					r
						newColumn: #empty width: 10;
						newColumn: [ :col | 
							col
								add: #empty height: 25;
								add: #from height: 25;
								add: #to height: 25;
								add: #contract height: 25;
								add: #context height: 25;
								add: #input height: 25;
								add: #value height: 25;
								add: #gas height: 25;
								add: #gasPrice height: 25;
								add: #empty height: 25 ];
						newColumn: #empty width: 10 ];
				newRow: [ :buttons | 
					buttons
						add: #generateMethodActivation;
						add: #generateContractDeploy ]
					height: 50;
				newRow: #empty height: 1 ]
]

{ #category : #initialization }
FogEVMActivationEdit >> createByteArrayFor: aString [
	| parsedInput |

	(aString trim beginsWith: '0x')
		ifTrue: [ ^ (FogEVMRegistry fromPrintString: aString length: 32) byteArray ].
	parsedInput := RBParser parseExpression: aString.
	parsedInput isLiteralNode
		ifFalse: [ ^ self error: 'Byte array expected!' ].
	^ parsedInput value class == ByteArray
		ifTrue: [ parsedInput value ]
		ifFalse: [ self error: 'Byte array expected!' ]
]

{ #category : #initialization }
FogEVMActivationEdit >> createRegistryFor: aString length: anInteger [
	^ aString isEmpty
		ifTrue: [ FogEVMRegistry forValue: 0 bytesLength: anInteger ]
		ifFalse: [ FogEVMRegistry fromPrintString: aString length: anInteger ]
]

{ #category : #initialization }
FogEVMActivationEdit >> generateContractDeploy [
	^ generateContractDeploy
]

{ #category : #initialization }
FogEVMActivationEdit >> generateMethodActivation [
	^ generateMethodActivation
]

{ #category : #generating }
FogEVMActivationEdit >> generateRandomContractDeploy [
	self generateRandomMethodActivation.
	to text: ''.
	value text: '0'
]

{ #category : #generating }
FogEVMActivationEdit >> generateRandomMethodActivation [
	| now random contractAddress |
	now := DateAndTime now.
	random := Random seed: now asUnixTime.
	contractAddress := '0x' , ((Keccak hashEncode: random next asString) asString copyFrom: 1 to: 40) asUppercase.
	from text: '0xB4EBF466889C4A0239379125A7D0F9C4E8BF2A14'.
	to text: contractAddress.
	contract text: contractAddress.
	input text: '#[ "This field has to be a byte array or an hexa field" ]'.
	value text: (random nextInt: 1000000) asString.
	context text: contractAddress.
	gas text: (3000 + (random nextInt: 1000000)) asString.
	gasPrice text: (1 + (random nextInt: 1000)) asString
]

{ #category : #initialization }
FogEVMActivationEdit >> initializeWidgets [
	super initializeWidgets.
	generateMethodActivation := self newButton.
	generateMethodActivation label: 'Message send'.
	generateMethodActivation action: [ self generateRandomMethodActivation ].
	generateContractDeploy := self newButton.
	generateContractDeploy label: 'Contract deploy'.
	generateContractDeploy action: [ self generateRandomContractDeploy ].
	from autoAccept.
	to autoAccept.
	contract autoAccept.
	context autoAccept.
	input autoAccept.
	value autoAccept.
	gas autoAccept.
	gasPrice autoAccept
]

{ #category : #initialization }
FogEVMActivationEdit >> setUp: aFogEVMInterpreterBuilder [
	| fromRegistry toRegistry contractAddress inputByteArray valueRegistry contextAddress gasRegistry gasPriceRegistry |
	fromRegistry := self createRegistryFor: from text asString length: 20.
	toRegistry := self createRegistryFor: to text asString length: 20.
	contractAddress := self createRegistryFor: (contract text asString ifEmpty: [ toRegistry asString ]) length: 20.
	valueRegistry := self createRegistryFor: value text asString length: 8.
	contextAddress := self createRegistryFor: context text asString length: 20.
	inputByteArray := self createByteArrayFor: input text asString.
	gasRegistry := self createRegistryFor: gas text asString length: 8.
	gasPriceRegistry := self createRegistryFor: gasPrice text asString length: 8.
	^ aFogEVMInterpreterBuilder
		from: fromRegistry
		to: toRegistry
		contract: contractAddress
		context: contextAddress
		input: inputByteArray
		value: valueRegistry
		gas: gasRegistry
		gasPrice: gasPriceRegistry
]
