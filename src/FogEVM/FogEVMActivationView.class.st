Class {
	#name : #FogEVMActivationView,
	#superclass : #ComposablePresenter,
	#instVars : [
		'activation',
		'from',
		'to',
		'contract',
		'context',
		'input',
		'value',
		'empty'
	],
	#category : #'FogEVM-VisualDebugger'
}

{ #category : #specs }
FogEVMActivationView class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :col | 
			col
				add: #from height:50;
				add: #to height:50;
				add: #contract height:50;
				add: #context height:50;
				add: #input height:50;
				add: #value height:50;
				add: #empty ]
]

{ #category : #accessing }
FogEVMActivationView >> activation [
	^ activation
]

{ #category : #accessing }
FogEVMActivationView >> activation: anObject [
	activation := anObject.
	from text: activation call callerAddress.
	to text: activation call contractAddress.
	contract text: activation contract.
	input text: activation call contractInput.
	value text: activation call callValue.
	context text: activation contextualAccount printString
]

{ #category : #accessing }
FogEVMActivationView >> context [
	^ context
]

{ #category : #accessing }
FogEVMActivationView >> context: anObject [
	context := anObject
]

{ #category : #accessing }
FogEVMActivationView >> contract [
	^ contract
]

{ #category : #accessing }
FogEVMActivationView >> contract: anObject [
	contract := anObject
]

{ #category : #accessing }
FogEVMActivationView >> empty [ 
	^ empty
]

{ #category : #accessing }
FogEVMActivationView >> from [
	^ from
]

{ #category : #accessing }
FogEVMActivationView >> from: anObject [
	from := anObject
]

{ #category : #initialization }
FogEVMActivationView >> initializeWidgets [
	from := self instantiate: LabelledTextInput .
	from label: 'From:'.
	to := self instantiate: LabelledTextInput.
	to label: 'To:'.
	contract := self instantiate: LabelledTextInput.
	contract label: 'Contract:'.
	context := self instantiate: LabelledTextInput.
	context label: 'Context:'.
	input := self instantiate: LabelledTextInput.
	input label: 'Input:'.
	value := self instantiate: LabelledTextInput.
	value label: 'Value:'.
	empty := FogEVMEmpty new .
]

{ #category : #accessing }
FogEVMActivationView >> input [
	^ input
]

{ #category : #accessing }
FogEVMActivationView >> input: anObject [
	input := anObject
]

{ #category : #accessing }
FogEVMActivationView >> to [
	^ to
]

{ #category : #accessing }
FogEVMActivationView >> to: anObject [
	to := anObject
]

{ #category : #accessing }
FogEVMActivationView >> value [
	^ value
]

{ #category : #accessing }
FogEVMActivationView >> value: anObject [
	value := anObject
]
