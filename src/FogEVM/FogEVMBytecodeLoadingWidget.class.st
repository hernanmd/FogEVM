"
This widget allows to open an existing solidity file, compiling, allowing the generation of a typical input of a transaction. 
It bases the defaults and traking of commonly used configurations in the model.

This behaviours define one of the main dependancies  with the project FogDB (Since it uses the contract description and the compiling utils)
"
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
	#category : #'FogEVM-UIDebugger-OpenWizard'
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
	fileSelector := self instantiate: LabelledDropList.
	fileSelector label: 'Solidity File'.
	fileSelector displayBlock: [ :x | x key ].
	fileSelector whenSelectedItemChanged: [ :item :old | self manageSelectedFile: item. ].
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
FogEVMBytecodeLoadingWidget >> manageSelectedFile: anItem [
	anItem ifNotNil: [
	sourceCode := anItem key readStream upToEnd.
	contractSelector items: anItem value descriptions asOrderedCollection]
]

{ #category : #initialization }
FogEVMBytecodeLoadingWidget >> model: aModel [
	model := aModel.
	fileSelector items: model loadedPackages.
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
		ifNotNil: [ package := model loadPackageForFileReference: file.
			fileSelector items: model loadedPackages.
			fileSelector setSelectedItem: package
			"			contractSelector items: fileSelector selectedItem value descriptions asOrderedCollection " ]
]
