Class {
	#name : #FogEVMBytecodeLoadingWidget,
	#superclass : #ComposablePresenter,
	#traits : 'TComposableWizardWidget',
	#classTraits : 'TComposableWizardWidget classTrait',
	#instVars : [
		'fileSelector',
		'chooseFileButton',
		'empty',
		'description',
		'contractSelector',
		'package',
		'sourceCode'
	],
	#category : #'FogEVM-UIDebugger-Open'
}

{ #category : #specs }
FogEVMBytecodeLoadingWidget class >> defaultSpec [
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
						add: #empty height: 25 ];
				newColumn: #empty width: 10 ]
]

{ #category : #initialization }
FogEVMBytecodeLoadingWidget >> availableInterpreters [
	^ {FogEVMAbstractInterpreter} , FogEVMAbstractInterpreter allSubclasses
]

{ #category : #initialization }
FogEVMBytecodeLoadingWidget >> availableMemory [
	^ {FogEVMMemory} , FogEVMMemory allSubclasses
]

{ #category : #initialization }
FogEVMBytecodeLoadingWidget >> availableStorage [
		^ {FogEVMMemoryStorage} , FogEVMMemoryStorage allSubclasses
]

{ #category : #accessing }
FogEVMBytecodeLoadingWidget >> build [
	self setUp: model.
	^ model
]

{ #category : #initialization }
FogEVMBytecodeLoadingWidget >> chooseFileButton [
	^ chooseFileButton
]

{ #category : #accessing }
FogEVMBytecodeLoadingWidget >> contractSelector [
	^ contractSelector
]

{ #category : #accessing }
FogEVMBytecodeLoadingWidget >> empty [
	^ empty
]

{ #category : #accessing }
FogEVMBytecodeLoadingWidget >> fileSelector [
	^ fileSelector
]

{ #category : #initialization }
FogEVMBytecodeLoadingWidget >> initializeWidgets [
	contractSelector := self instantiate: LabelledDropList.
	contractSelector label: 'Contract'.
	contractSelector
		items: {};
		displayBlock: [ :item | item name ];
		whenSelectedItemChanged: [ :item :old | self manageSelectedContract: item ].
	fileSelector := self instantiate: LabelledTextInput.
	fileSelector label: ' Solidity File '.
	fileSelector enabled: false.
	chooseFileButton := self newButton.
	chooseFileButton
		icon: (self iconNamed: #smallOpen);
		action: [ self openFileDialog ].
	empty := self newLabel.
	empty label: ''
]

{ #category : #initialization }
FogEVMBytecodeLoadingWidget >> manageSelectedContract: anItem [
	self subclassResponsibility 
]

{ #category : #initialization }
FogEVMBytecodeLoadingWidget >> openFileDialog [
	| file |
	file := FDOpenFileDialog new
		extensionFilters:
			{('Solidity' -> #(sol)).
			('All files' -> #())};
		openModal.
	file
		ifNotNil: [ fileSelector text: file asString.
			sourceCode := file readStream upToEnd.
			package := self session loadPackageForFileReference: file.
			contractSelector items: package descriptions asOrderedCollection ]
]

{ #category : #initialization }
FogEVMBytecodeLoadingWidget >> session [
	^ model session
]

{ #category : #building }
FogEVMBytecodeLoadingWidget >> setUp: aFogEVMInterpreterBuilder [
	self halt.
		contractSelector selectedItem 

]
