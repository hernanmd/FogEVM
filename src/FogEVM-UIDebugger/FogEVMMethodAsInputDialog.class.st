"
This component allows to choose a method, and configure it for execution. 
In order to give a the needed binary information (used as input in a tipical transaction ), it defines the message: 
#generateInput: aSession and: aContractDescription.
"
Class {
	#name : #FogEVMMethodAsInputDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'parameters',
		'push',
		'pop',
		'input',
		'type',
		'selectedMethod',
		'parametersToGo',
		'resolvedParameters',
		'methodsList',
		'noConstructor'
	],
	#category : #'FogEVM-UIDebugger-Tools'
}

{ #category : #specs }
FogEVMMethodAsInputDialog class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :m | 
			m
				newRow: #methodsList;
				newRow: [ :r | 
					r
						add: #type width: 100;
						add: #input;
						add: #push width: 100;
						add: #pop width: 100 ]
					height: 30;
				newRow: #parameters ];
		yourself
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> constructor: aFogConstructorMirror [
	
	aFogConstructorMirror ifNil: [ noConstructor := true. ]
		ifNotNil: [
		   methodsList items: {aFogConstructorMirror}.
			methodsList setSelectedItem: aFogConstructorMirror.
			self setLabels ]
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> generateInput: aSession and: aContractDescription [
	^ noConstructor
		ifTrue: [ aContractDescription binary ]
		ifFalse: [ methodsList selectedItem
				encodeUsing: aSession
				for: aContractDescription
				with: (resolvedParameters reverse collect: #value) ]
]

{ #category : #initialization }
FogEVMMethodAsInputDialog >> initializeWidgets [
	noConstructor := false.
	methodsList := self newList.
	methodsList
		items: {};
		displayBlock: [ :item | item name ];
		whenSelectedItemChanged: [ :item :old | self manageSelectedMethod: item ].
	parameters := self newList.
	input := self instantiate: LabelledTextInput.
	input label: ''.
	input autoAccept: true.
	type := self newLabel.
	push := self newButton.
	resolvedParameters := {}.
	push label: 'Push'.
	push action: [ self pushParameter ].
	pop := self newButton.
	pop action: [ self popParameter ].
	pop label: 'Pop'
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> input [
	^ input
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> isDone [
	^ parametersToGo ifNil: [ noConstructor ] ifNotNil: [ parametersToGo isEmpty ]
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> manageSelectedMethod: aSelected [
	aSelected
		ifNotNil: [ resolvedParameters := OrderedCollection new.
			parametersToGo := aSelected parameters associations copy.
			self setLabels.
			parameters items: resolvedParameters ]
		ifNil: [ resolvedParameters := OrderedCollection new.
			parametersToGo := nil.
			type label: 'Select a valid method'.
			input label: ''.
			parameters items: resolvedParameters ]
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> methods: aCollection [
	methodsList items: aCollection.
	aCollection ifNotEmpty: [ methodsList setSelectedItem: aCollection anyOne ]
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> methodsList [
	^ methodsList
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> parameters [
	^ parameters
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> pop [
	^ pop
]

{ #category : #initialization }
FogEVMMethodAsInputDialog >> popParameter [
	| param |
	self assert: methodsList selectedItem isNotNil.
	param := resolvedParameters removeFirst.
	parameters items: resolvedParameters.
	parametersToGo addFirst: param key.
	self setLabels
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> push [
	^ push
]

{ #category : #pushing }
FogEVMMethodAsInputDialog >> pushParameter [
	self assert: methodsList selectedItem isNotNil.
	
	resolvedParameters addFirst: (parametersToGo first -> input text).
	parameters items: resolvedParameters.
	parametersToGo removeFirst.
	
	self setLabels.
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> returningType [
	^ methodsList selectedItem returnType
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> setLabels [
	input text: ''.
	parametersToGo
		ifEmpty: [ type label: 'Accept'.
			input label: '' ]
		ifNotEmpty: [ type label: parametersToGo first value name.
			input label: parametersToGo first key ]
]

{ #category : #accessing }
FogEVMMethodAsInputDialog >> type [
	^ type
]
