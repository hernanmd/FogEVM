Class {
	#name : #FogEVMActivationForDeploy,
	#superclass : #FogEVMActivationView,
	#traits : 'TComposableWizardWidget',
	#classTraits : 'TComposableWizardWidget classTrait',
	#category : #'FogEVM-UIDebugger-Open'
}

{ #category : #specs }
FogEVMActivationForDeploy class >> activationSpec [
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
								add: #transferValue height: 25;
								add: #gas height: 25;
								add: #gasPrice height: 25;
								add: #input ;
								add: #empty height: 25 ];
						newColumn: #empty width: 10 ];
				newRow: #empty height: 1 ]
]

{ #category : #specs }
FogEVMActivationForDeploy class >> defaultSpec [
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
								add: #gas height: 25;
								add: #gasPrice height: 25;
								add: #input ;
								add: #empty height: 25 ];
						newColumn: #empty width: 10 ];
				newRow: #empty height: 1 ]
]

{ #category : #accessing }
FogEVMActivationForDeploy >> build [
	self setUp: model.
	^ model
]

{ #category : #initialization }
FogEVMActivationForDeploy >> createByteArrayFor: aString [
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
FogEVMActivationForDeploy >> createRegistryFor: aString length: anInteger [
	^ aString isEmpty
		ifTrue: [ FogEVMRegistry forValue: 0 bytesLength: anInteger ]
		ifFalse: [  FogEVMRegistry forValue: aString asNumber  bytesLength: anInteger ]
]

{ #category : #initialization }
FogEVMActivationForDeploy >> initializeWidgets [
	super initializeWidgets.
	from autoAccept.
	to autoAccept.
	contract autoAccept.
	context autoAccept.
	input autoAccept.
	transferValue autoAccept.
	gas autoAccept.
	gasPrice autoAccept
]

{ #category : #accessing }
FogEVMActivationForDeploy >> session [
	^ model session
]

{ #category : #initialization }
FogEVMActivationForDeploy >> setUp: aFogEVMInterpreterBuilder [
	| fromRegistry   inputByteArray valueRegistry  gasRegistry gasPriceRegistry |
	fromRegistry := self createRegistryFor: from text asString length: 20.
	valueRegistry :=  FogEVMRegistry zero.
	inputByteArray :=  input text asString.
	gasRegistry := self createRegistryFor: gas text asString length: 8.
	gasPriceRegistry := self createRegistryFor: gasPrice text asString length: 8.
	^ aFogEVMInterpreterBuilder
		from: fromRegistry
		to: nil
		contract: nil
		context: nil
		input: inputByteArray
		value: valueRegistry
		gas: gasRegistry
		gasPrice: gasPriceRegistry
]

{ #category : #accessing }
FogEVMActivationForDeploy >> widgetAsNext [
	input text: model input.
	from text: '0x81bfba8301a073a010e9fb71fab514e53d1cc3f0'.	"(self createRegistryFor: self session coinBase length: 20) printString."
	gasPrice text: 1.
	gas text: '3000000'.
	^ self
]
