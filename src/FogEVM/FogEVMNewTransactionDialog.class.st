Class {
	#name : #FogEVMNewTransactionDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'interpreter',
		'interpreterView',
		'callView',
		'tabManager',
		'settings',
		'whenConfirmed',
		'ok',
		'cancel',
		'builder'
	],
	#category : #'FogEVM-UIDebugger-Open'
}

{ #category : #specs }
FogEVMNewTransactionDialog class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :general | 
			general
				newRow: [ :up | up newRow: #tabManager ];
				newRow: [ :r | 
					r
						add: #ok width: 100;
						add: #cancel width: 100 ]
					height: 50 ]
]

{ #category : #initialization }
FogEVMNewTransactionDialog >> accept [
 whenConfirmed cull: self buildInterpreter cull: builder.
	[ whenConfirmed cull: self buildInterpreter cull: builder.
	self delete ]
		on: Error
		do: [ :e | UIManager default alert: e messageText ]
]

{ #category : #building }
FogEVMNewTransactionDialog >> buildInterpreter [

	builder := FogEVMInterpreterBuilder new.
	settings setUp: builder.
	callView setUp: builder.
	interpreterView setUp: builder.
	^ interpreter := builder build
]

{ #category : #initialization }
FogEVMNewTransactionDialog >> buildTabManager [
	| tab |
	tabManager := self newTabManager.
	tab := self newTab.
	tab closeable: false.
	tab
		label: 'Running Settings';
		presenter: settings.
	tabManager addTab: tab.
	tab := self newTab.
	tab closeable: false.
	tab
		label: 'Interpreter parameters';
		presenter: interpreterView.
	tabManager addTab: tab.
	tab := self newTab.
	tab closeable: false.
	tab
		label: 'Call parameters';
		presenter: callView.
	tabManager addTab: tab
]

{ #category : #accessing }
FogEVMNewTransactionDialog >> callView [
	^ callView
]

{ #category : #initialization }
FogEVMNewTransactionDialog >> cancel [
	^ cancel
]

{ #category : #initialization }
FogEVMNewTransactionDialog >> columnsToShow [
	^ settings columnsToShow
]

{ #category : #initialization }
FogEVMNewTransactionDialog >> defaultActivationConfiguration [
	| call activation |
	call := FogEVMCall new.
	call contractInput: #(0 0 0 0) asByteArray.
	call callerAddress: (FogEVMRegistry forValue: 16rb4ebf466889c4a0239379125a7d0f9c4e8bf2a14 bytesLength: 20).
	call contractAddress: (FogEVMRegistry forValue: 16r81bfba8301a073a010e9fb71fab514e53d1cc3f0 bytesLength: 20).
	call callValue: (FogEVMRegistry forValue: 0 bytesLength: 32).
	call gas: (FogEVMRegistry forValue: 3000000 bytesLength: 32).
	call gasPrice: (FogEVMRegistry forValue: 1 bytesLength: 32).
	activation := FogEVMActivation new.
	activation contextualAccount: (FogEVMRegistry forValue: 16r81bfba8301a073a010e9fb71fab514e53d1cc3f0 bytesLength: 20).
	activation call: call.
	^ activation
]

{ #category : #initialization }
FogEVMNewTransactionDialog >> defaultInterpreterConfiguration [
	^ FogEVMTestInterpreter new 
]

{ #category : #initialization }
FogEVMNewTransactionDialog >> initializeWidgets [
	interpreterView := self instantiate: FogEVMInterpreterEdit.
	callView := self instantiate: FogEVMActivationForDeploy.
	settings := self instantiate: FogEVMBytecodeLoadingWidget.
	ok := self newButton.
	ok
		label: 'Ok';
		action: [ self accept ].
	cancel := self newButton.
	cancel
		label: 'Cancel';
		action: [ self reject ].
	self buildTabManager
]

{ #category : #accessing }
FogEVMNewTransactionDialog >> interpreter [
	^ interpreter
]

{ #category : #accessing }
FogEVMNewTransactionDialog >> interpreterView [
	^ interpreterView
]

{ #category : #initialization }
FogEVMNewTransactionDialog >> ok [
	^ ok
]

{ #category : #initialization }
FogEVMNewTransactionDialog >> reject [
	^ self delete
]

{ #category : #initialization }
FogEVMNewTransactionDialog >> tabManager [
	^ tabManager
]

{ #category : #accessing }
FogEVMNewTransactionDialog >> whenConfirmed: aBlock [
	whenConfirmed:= aBlock
]
