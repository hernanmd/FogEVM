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
		'empty'
	],
	#category : #'FogEVM-UIDebugger-Tools'
}

{ #category : #specs }
FogEVMInterpreterView class >> defaultSpec [
	<spec>
	^ SpecLayout composed  
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
		yourself
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

{ #category : #accessing }
FogEVMInterpreterView >> startedTime [
	^ startedTime
]

{ #category : #accessing }
FogEVMInterpreterView >> timestamp [
	^ timestamp
]
