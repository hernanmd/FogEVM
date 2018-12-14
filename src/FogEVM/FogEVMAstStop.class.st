Class {
	#name : #FogEVMAstStop,
	#superclass : #FogEVMAstNode,
	#instVars : [
		'address'
	],
	#category : #'FogEVM-DecompilerAST'
}

{ #category : #'as yet unclassified' }
FogEVMAstStop >> accept: aFogEVMAstVariableWiperVisitor [ 
	aFogEVMAstVariableWiperVisitor visitStop: self 
]

{ #category : #'as yet unclassified' }
FogEVMAstStop >> address: aFogEVMMnemonicExecutableMemoryEntry [
	address := aFogEVMMnemonicExecutableMemoryEntry
]

{ #category : #printing }
FogEVMAstStop >> isEndingState [
	^ true
]

{ #category : #printing }
FogEVMAstStop >> printOn: aStream [
	aStream
		nextPutAll: String crlf;
		nextPutAll: 'STOP ';
		nextPutAll: (address byteNumber write0xHexadecimal: 8);
		nextPutAll: String crlf
]
