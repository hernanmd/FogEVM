Class {
	#name : #FogEVMProxyMemoryStorage,
	#superclass : #FogEVMMemoryStorage,
	#instVars : [
		'fogSession'
	],
	#category : #'FogEVM-Environment-Storage'
}

{ #category : #accessing }
FogEVMProxyMemoryStorage >> createStorageFor: aContractAddress at: aStateHash [
	| remote bucket |
	remote := self fogSession
		findAccountByHash: aContractAddress blockTag: aStateHash.
	remote session: self fogSession.
	bucket := FogEVMBucketStorage new address: aContractAddress.
	remote
		ifNil: [ bucket beLocal ]
		ifNotNil: [ bucket beProxified: remote ].
	^ bucket
]

{ #category : #accessing }
FogEVMProxyMemoryStorage >> fogSession [
	^ fogSession
		ifNil: [ fogSession := FogConnection createDefaultConnection session ]
]
