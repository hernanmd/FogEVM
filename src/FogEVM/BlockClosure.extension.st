Extension { #name : #BlockClosure }

{ #category : #'*FogEVM' }
BlockClosure >> asStep [
	^ ComposableWizardStep new
		widget: self;
		yourself
]
