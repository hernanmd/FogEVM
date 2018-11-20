"
This subclass shows the methods of the instance side of the contract, allowing to generate the input required for a typical method activation
"
Class {
	#name : #FogEVMInputGenerationForActivation,
	#superclass : #FogEVMBytecodeLoadingWidget,
	#instVars : [
		'methods',
		'contract'
	],
	#category : #'FogEVM-UIDebugger-OpenWizard'
}

{ #category : #specs }
FogEVMInputGenerationForActivation class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newRow: [ :r | 
			r
				newColumn: [ :left | 
					left
						newRow: [ :ff | 
							ff
								add: #fileSelector;
								add: #chooseFileButton width: 25 ]
							height: 25;
						newRow: #contractSelector height: 25;
						newRow: #methods;
						add: #empty height: 25 ];
				newColumn: #empty width: 10 ]
]

{ #category : #initialization }
FogEVMInputGenerationForActivation >> initializeWidgets [
	super initializeWidgets.
	methods := self instantiate: FogEVMMethodAsInputDialog.
	
]

{ #category : #initialization }
FogEVMInputGenerationForActivation >> isDone [
	^ methods isDone
]

{ #category : #initialization }
FogEVMInputGenerationForActivation >> manageSelectedContract: anObject [
	contract := anObject.
	anObject ifNotNil: [ methods methods: anObject mirror instanceMirror methods ]
]

{ #category : #initialization }
FogEVMInputGenerationForActivation >> methods [
	^ methods
]

{ #category : #initialization }
FogEVMInputGenerationForActivation >> setUp: aFogEVMInterpreterBuilder [
	aFogEVMInterpreterBuilder input: (methods generateInput: model session and: contract).
	aFogEVMInterpreterBuilder sourceCode: sourceCode
]
