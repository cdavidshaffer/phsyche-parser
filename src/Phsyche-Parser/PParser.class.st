"
Parser for Physche
"
Class {
	#name : #PParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'number',
		'boolean',
		'list',
		'expression',
		'symbol',
		'symbolChar',
		'string'
	],
	#category : #'Phsyche-Parser'
}

{ #category : #accessing }
PParser >> boolean [ 

	^('true' asParser | 'false' asParser) flatten trim ==> [ :str | str = 'true' ]
]

{ #category : #accessing }
PParser >> expression [ 

	^number / boolean / symbol / string / list 
]

{ #category : #accessing }
PParser >> list [
	^ ($( asParser
		, expression trim star
		, $) asParser)  ==> [ :stuff | stuff second]
]

{ #category : #accessing }
PParser >> number [ 

	^($- asParser optional, #digit asParser plus, $. asParser optional, #digit asParser star)
			 flatten trim ==> [ :str | str asNumber ]
]

{ #category : #accessing }
PParser >> start [
	"Answer the production to start this parser with."
	
	^expression trim
]

{ #category : #accessing }
PParser >> string [
	^ ($" asParser , $" asParser negate star , $" asParser) flatten trim 
		==> [ :str | str allButFirst allButLast ]
]

{ #category : #accessing }
PParser >> symbol [
	^ ($# asParser optional , 
			(#digit asParser negate and , symbolChar) ,
			symbolChar star) flatten trim
		==> [ :str | 
			str first = $#
				ifTrue: [ str allButFirst asSymbol ]
				ifFalse: [ str asSymbol ] ]
]

{ #category : #accessing }
PParser >> symbolChar [

	^$( asParser negate and , $) asParser negate and
			, #space asParser negate and , $" asParser negate
]
