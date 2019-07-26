"
Parser for Physche
"
Class {
	#name : #PParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'positiveNumber',
		'negativeNumber',
		'number',
		'boolean',
		'list',
		'expression',
		'symbol',
		'whitespace',
		'symbolChar'
	],
	#category : #'Phsyche-Parser'
}

{ #category : #accessing }
PParser >> boolean [ 

	^('true' asParser | 'false' asParser) flatten trim ==> [ :str | str = 'true' ]
]

{ #category : #accessing }
PParser >> expression [ 

	^number / boolean / symbol / list 
]

{ #category : #accessing }
PParser >> list [
	^ ($( asParser
		, expression trim star
		, $) asParser)  ==> [ :stuff | stuff second]
]

{ #category : #accessing }
PParser >> negativeNumber [ 

	^($- asParser , positiveNumber) flatten trim ==> [ :str | str asNumber ]
]

{ #category : #accessing }
PParser >> number [ 

	^positiveNumber / negativeNumber 
]

{ #category : #accessing }
PParser >> positiveNumber [ 

	^(#digit asParser plus, $. asParser optional, #digit asParser star)
			 flatten trim ==> [ :str | str asNumber ]
]

{ #category : #accessing }
PParser >> start [
	"Answer the production to start this parser with."
	
	^expression trim
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
			, whitespace negate
]

{ #category : #accessing }
PParser >> whitespace [

	^#blank asParser / #newline asParser
]
