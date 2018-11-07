Class {
	#name : #FogEVMInterpreterView,
	#superclass : #ComposablePresenter,
	#instVars : [
		'blockDifficulty',
		'startedTime',
		'timestamp',
		'gasLimit',
		'blockNumber',
		'blockHash',
		'empty',
		'mainLabel'
	],
	#category : #'FogEVM-VisualDebugger'
}

{ #category : #specs }
FogEVMInterpreterView class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :col | 
			col
				add: #mainLabel height: 50;
				add: #blockDifficulty height: 50;
				add: #startedTime height: 50;
				add: #timestamp height: 50;
				add: #gasLimit height: 50;
				add: #blockNumber height: 50;
				add: #blockHash height: 50;
				add: #empty ]
]

{ #category : #accessing }
FogEVMInterpreterView >> blockDifficulty [
	^ blockDifficulty
]

{ #category : #accessing }
FogEVMInterpreterView >> blockHash [
	^ blockHash
]

{ #category : #accessing }
FogEVMInterpreterView >> blockNumber [
	^ blockNumber
]

{ #category : #accessing }
FogEVMInterpreterView >> empty [
	^ empty
]

{ #category : #accessing }
FogEVMInterpreterView >> gasLimit [
	^ gasLimit
]

{ #category : #initialization }
FogEVMInterpreterView >> initializeWidgets [
	mainLabel := self newLabel .
	mainLabel label: '      Current Interpreter General Variables '.
	blockDifficulty := self instantiate: LabelledTextInput.
	blockDifficulty label: 'Block Difficulty'.
	startedTime := self instantiate: LabelledTextInput.
	startedTime label: 'Started time'.
	timestamp := self instantiate: LabelledTextInput.
	timestamp label: 'Time stamp'.
	gasLimit := self instantiate: LabelledTextInput.
	gasLimit label: 'Gas limit '.
	blockNumber := self instantiate: LabelledTextInput.
	blockNumber label: 'Block Number'.
	blockHash := self instantiate: LabelledTextInput.
	blockHash label: 'Block hash'.
	empty := FogEVMEmpty new
]

{ #category : #initialization }
FogEVMInterpreterView >> interpreter: anInterpreter [
	blockDifficulty text: anInterpreter blockDifficulty.
	startedTime text: anInterpreter startedTime.
	timestamp text: (DateAndTime fromUnixTime: anInterpreter timestamp unsignedValue).
	gasLimit text: anInterpreter gasLimit unsignedValue.
	blockNumber text: anInterpreter currentBlockNumber unsignedValue.
	blockHash text: (anInterpreter blockHashRegisty: anInterpreter currentBlockNumber unsignedValue - 10)
]

{ #category : #initialization }
FogEVMInterpreterView >> mainLabel [
	^ mainLabel
]

{ #category : #accessing }
FogEVMInterpreterView >> startedTime [
	^ startedTime
]

{ #category : #accessing }
FogEVMInterpreterView >> timestamp [
	^ timestamp
]
