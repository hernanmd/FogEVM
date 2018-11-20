"
This subclass shows the methods of the 'class' side of the contract, allowing to generate the input required for a typical deploy 
"
Class {
	#name : #FogEVMInputGenerationForDeploy,
	#superclass : #FogEVMBytecodeLoadingWidget,
	#instVars : [
		'constructor',
		'contract'
	],
	#category : #'FogEVM-UIDebugger-OpenWizard'
}

{ #category : #specs }
FogEVMInputGenerationForDeploy class >> defaultSpec [
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
						newRow: #constructor;
						add: #empty height: 25 ];
				newColumn: #empty width: 10 ]
]

{ #category : #accessing }
FogEVMInputGenerationForDeploy >> constructor [
	^ constructor
]

{ #category : #initialization }
FogEVMInputGenerationForDeploy >> initializeWidgets [
	super initializeWidgets.
	constructor := self instantiate: FogEVMMethodAsInputDialog.
	
]

{ #category : #initialization }
FogEVMInputGenerationForDeploy >> isDone [
	^ constructor isDone
]

{ #category : #initialization }
FogEVMInputGenerationForDeploy >> manageSelectedContract: anObject [
	contract := anObject.
	anObject ifNotNil: [ constructor constructor: anObject mirror constructor ]
]

{ #category : #initialization }
FogEVMInputGenerationForDeploy >> setUp: aFogEVMInterpreterBuilder [
	aFogEVMInterpreterBuilder
		input: (constructor generateInput: model session and: contract)
		returningType: nil.
	aFogEVMInterpreterBuilder sourceCode: sourceCode
]
