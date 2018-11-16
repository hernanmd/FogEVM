Class {
	#name : #FogEVMMethodAsInputView,
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
		'methodsList'
	],
	#category : #'FogEVM-UIDebugger-Open'
}

{ #category : #specs }
FogEVMMethodAsInputView class >> defaultSpec [
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
FogEVMMethodAsInputView >> constructor: aFogConstructorMirror [
	methodsList items: {aFogConstructorMirror }.
	methodsList setSelectedItem: aFogConstructorMirror.
	self setLabels.
]

{ #category : #accessing }
FogEVMMethodAsInputView >> generateInput: aSession and: aContractDescription [
	^ methodsList selectedItem encodeUsing: aSession for: aContractDescription with: (resolvedParameters reverse collect: #value)
]

{ #category : #initialization }
FogEVMMethodAsInputView >> initializeWidgets [
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
	resolvedParameters := {  }.
	push label: 'Push'.
	push action: [ self pushParameter ].
	pop := self newButton.
	pop action: [ self popParameter ].
	pop label: 'Pop'
]

{ #category : #accessing }
FogEVMMethodAsInputView >> input [
	^ input
]

{ #category : #accessing }
FogEVMMethodAsInputView >> isDone [
	^ parametersToGo ifNil: [ false ] ifNotNil: [ parametersToGo isEmpty ]
]

{ #category : #accessing }
FogEVMMethodAsInputView >> manageSelectedMethod: aSelected [
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
FogEVMMethodAsInputView >> methods: aCollection [
	methodsList items: aCollection.
	aCollection ifNotEmpty: [ methodsList setSelectedItem: aCollection anyOne ]
]

{ #category : #accessing }
FogEVMMethodAsInputView >> methodsList [
	^ methodsList
]

{ #category : #accessing }
FogEVMMethodAsInputView >> parameters [
	^ parameters
]

{ #category : #accessing }
FogEVMMethodAsInputView >> pop [
	^ pop
]

{ #category : #initialization }
FogEVMMethodAsInputView >> popParameter [
	| param |
	self assert: methodsList selectedItem isNotNil.
	param := resolvedParameters removeFirst.
	parameters items: resolvedParameters.
	parametersToGo addFirst: param key.
	self setLabels
]

{ #category : #accessing }
FogEVMMethodAsInputView >> push [
	^ push
]

{ #category : #pushing }
FogEVMMethodAsInputView >> pushParameter [
	self assert: methodsList selectedItem isNotNil.
	
	resolvedParameters addFirst: (parametersToGo first -> input text).
	parameters items: resolvedParameters.
	parametersToGo removeFirst.
	
	self setLabels.
]

{ #category : #accessing }
FogEVMMethodAsInputView >> setLabels [
	input text: ''.
	parametersToGo
		ifEmpty: [ type label: 'Accept'.
			input label: '' ]
		ifNotEmpty: [ type label: parametersToGo first value name.
			input label: parametersToGo first key ]
]

{ #category : #accessing }
FogEVMMethodAsInputView >> type [
	^ type
]
