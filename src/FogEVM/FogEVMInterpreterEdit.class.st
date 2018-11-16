Class {
	#name : #FogEVMInterpreterEdit,
	#superclass : #FogEVMInterpreterView,
	#traits : 'TComposableWizardWidget',
	#classTraits : 'TComposableWizardWidget classTrait',
	#instVars : [
		'mockedRandomValues',
		'nodeDelegate',
		'useFogValues'
	],
	#category : #'FogEVM-UIDebugger-Open'
}

{ #category : #specs }
FogEVMInterpreterEdit class >> defaultSpec [
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
								add: #blockDifficulty height: 25;
								add: #startedTime height: 25;
								add: #timestamp height: 25;
								add: #gasLimit height: 25;
								add: #blockNumber height: 25;
								add: #blockHash height: 25;
								add: #empty height: 25 ];
						newColumn: #empty width: 10 ];
				newRow: [ :b | b add: #mockGeneratedValues ] height: 50;
				newRow: #empty height:1  ];
		yourself
]

{ #category : #accessing }
FogEVMInterpreterEdit >> build [
	^ self setUp: model
]

{ #category : #generating }
FogEVMInterpreterEdit >> generateValues [
	| now random |
	now := DateAndTime now.
	random := Random new seed: now asUnixTime.
	blockDifficulty text: (random nextInt: 9999999999) asString.
	startedTime text: now.
	timestamp text: now.
	gasLimit text: (300000 + (random nextInt: 999999)) asString.
	blockNumber text: (random nextInt: 9999999999).
	blockHash text: (Keccak hashEncode: (random nextInt: 9999999999) asString)
]

{ #category : #initialization }
FogEVMInterpreterEdit >> initializeWidgets [
	super initializeWidgets.
	useFogValues := self newCheckBox.
	useFogValues label: 'Use node information'.
	useFogValues
		whenActivatedDo: [ self switchState: true ];
		whenDeactivatedDo: [ self switchState: false ].
	useFogValues state: true.
	blockDifficulty autoAccept.
	startedTime autoAccept.
	timestamp autoAccept.
	gasLimit autoAccept.
	blockNumber autoAccept.
	blockHash autoAccept
]

{ #category : #initialization }
FogEVMInterpreterEdit >> mockGeneratedValues [
	^ useFogValues
]

{ #category : #initialization }
FogEVMInterpreterEdit >> setUp: aFogEVMInterpreterBuilder [
	aFogEVMInterpreterBuilder useFogValues: useFogValues state.
	useFogValues state
		ifFalse: [ aFogEVMInterpreterBuilder
				blockDifficulty: (FogEVMRegistry fromPrintString: blockDifficulty text asString length: 8)
				startedAt: startedTime text asString asDateAndTime
				timestamp: timestamp text asString asDateAndTime
				gasLimit: (FogEVMRegistry fromPrintString: gasLimit text asString length: 8)
				blockNumber: (FogEVMRegistry fromPrintString: blockNumber text asString length: 8)
				blockHash: (FogEVMRegistry fromPrintString: blockHash text asString length: 32) ]
]

{ #category : #initialization }
FogEVMInterpreterEdit >> switchState: aBoolean [
	aBoolean
		ifTrue: [ blockDifficulty text: ''.
			startedTime text: ''.
			timestamp text: ''.
			gasLimit text: ''.
			blockNumber text: ''.
			blockHash text: '' ]
		ifFalse: [ self generateValues ]
]
