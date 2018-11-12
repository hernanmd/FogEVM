Class {
	#name : #FogEVMDebuggerSessionEdit,
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
FogEVMDebuggerSessionEdit class >> defaultSpec [
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
FogEVMDebuggerSessionEdit >> accept [
 whenConfirmed cull: self buildInterpreter cull: builder.
	[ whenConfirmed cull: self buildInterpreter cull: builder.
	self delete ]
		on: Error
		do: [ :e | UIManager default alert: e messageText ]
]

{ #category : #building }
FogEVMDebuggerSessionEdit >> buildInterpreter [

	builder := FogEVMInterpreterBuilder new.
	settings setUp: builder.
	callView setUp: builder.
	interpreterView setUp: builder.
	^ interpreter := builder build
]

{ #category : #initialization }
FogEVMDebuggerSessionEdit >> buildTabManager [
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
FogEVMDebuggerSessionEdit >> callView [
	^ callView
]

{ #category : #initialization }
FogEVMDebuggerSessionEdit >> cancel [
	^ cancel
]

{ #category : #initialization }
FogEVMDebuggerSessionEdit >> columnsToShow [
	^ settings columnsToShow
]

{ #category : #initialization }
FogEVMDebuggerSessionEdit >> defaultActivationConfiguration [
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
FogEVMDebuggerSessionEdit >> defaultInterpreterConfiguration [
	^ FogEVMTestInterpreter new 
]

{ #category : #initialization }
FogEVMDebuggerSessionEdit >> initializeWidgets [
	interpreterView := self instantiate: FogEVMInterpreterEdit.
	callView := self instantiate: FogEVMActivationEdit.
	settings := self instantiate: FogEVMBuildingSettings.
	callView activation: self defaultActivationConfiguration.
	interpreterView interpreter: self defaultInterpreterConfiguration.
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
FogEVMDebuggerSessionEdit >> interpreter [
	^ interpreter
]

{ #category : #accessing }
FogEVMDebuggerSessionEdit >> interpreterView [
	^ interpreterView
]

{ #category : #initialization }
FogEVMDebuggerSessionEdit >> ok [
	^ ok
]

{ #category : #initialization }
FogEVMDebuggerSessionEdit >> reject [
	^ self delete
]

{ #category : #initialization }
FogEVMDebuggerSessionEdit >> tabManager [
	^ tabManager
]

{ #category : #accessing }
FogEVMDebuggerSessionEdit >> whenConfirmed: aBlock [
	whenConfirmed:= aBlock
]
