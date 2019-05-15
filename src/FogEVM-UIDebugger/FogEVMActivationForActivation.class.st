"
Activation for activation extends the activation view, but in a way that works for preparing an activation for executing a method over an already existing contract
"
Class {
	#name : #FogEVMActivationForActivation,
	#superclass : #FogEVMActivationView,
	#traits : 'TComposableWizardWidget',
	#classTraits : 'TComposableWizardWidget classTrait',
	#category : #'FogEVM-UIDebugger-OpenWizard'
}

{ #category : #specs }
FogEVMActivationForActivation class >> defaultSpec [
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
								add: #input;
								add: #empty height: 25 ];
						newColumn: #empty width: 10 ];
				newRow: #empty height: 1 ]
]

{ #category : #accessing }
FogEVMActivationForActivation >> build [
	self setUp: model.
	^ model
]

{ #category : #accessing }
FogEVMActivationForActivation >> createByteArrayFor: aString [
	| parsedInput |
	self flag: #ShouldNotUseLikethisTheRegistry.
	(aString trim beginsWith: '0x')
		ifTrue: [ ^ (FogEVMRegistry fromPrintString: aString length:( aString size /2) -1 ) byteArray ].
	parsedInput := RBParser parseExpression: aString.
	parsedInput isLiteralNode
		ifFalse: [ ^ self error: 'Byte array expected!' ].
	^ parsedInput value class == ByteArray
		ifTrue: [ parsedInput value ]
		ifFalse: [ self error: 'Byte array expected!' ]
]

{ #category : #accessing }
FogEVMActivationForActivation >> createRegistryFor: aString length: anInteger [
	^ aString isEmpty
		ifTrue: [ FogEVMRegistry forValue: 0 bytesLength: anInteger ]
		ifFalse: [  FogEVMRegistry fromPrintString: aString length: anInteger ]
]

{ #category : #accessing }
FogEVMActivationForActivation >> initializeWidgets [
	super initializeWidgets.
	to := self instantiate: LabelledDropList .
	from autoAccept: true.
	contract autoAccept: true.
	context autoAccept: true.
	input autoAccept: true.
	transferValue autoAccept: true.
	gas autoAccept: true.
	gasPrice autoAccept: true
]

{ #category : #accessing }
FogEVMActivationForActivation >> model: aModel [
	model := aModel.
	to items: model allDeployedContracts
]

{ #category : #accessing }
FogEVMActivationForActivation >> setUp: aFogEVMInterpreterBuilder [
	| fromRegistry toRegistry contractAddress inputByteArray valueRegistry contextAddress gasRegistry gasPriceRegistry |
	fromRegistry := self createRegistryFor: from text asString length: 20.
	toRegistry := to selectedIndex = 0
		ifTrue: [ self
				createRegistryFor:
					(UIManager default
						request: ' Please enter a valid hash for sending the activation ')
				length: 20 ]
		ifFalse: [ to selectedItem ].
	contractAddress := contract text asString ifEmpty: [ toRegistry ].
	valueRegistry := self
		createRegistryFor: transferValue text asString
		length: 8.
	contextAddress := self
		createRegistryFor: context text asString
		length: 20.
	
	inputByteArray := #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) asByteArray .
	
	(self createByteArrayFor: input text asString) doWithIndex: [ :v : i | inputByteArray at: i put: v ].
	
	
	
	self halt .
	
	gasRegistry := self createRegistryFor: gas text asString length: 8.
	gasPriceRegistry := self
		createRegistryFor: gasPrice text asString
		length: 8.
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

{ #category : #accessing }
FogEVMActivationForActivation >> widgetAsNext [
	input text: model input.
	from text
		ifEmpty: [ from text: '0x81bfba8301a073a010e9fb71fab514e53d1cc3f0'.	"(self createRegistryFor: self session coinBase length: 20) printString."
			gasPrice text: 1.
			gas text: '3000000' ].
	^ self
]
