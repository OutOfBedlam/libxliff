# libxliff

XLIFF parser for Objective C

## What is XLIFF

XLIFF is the XML Localization Interchange File Format designed by a group of software providers, 
localization service providers, and localization tools providers. 
It is intended to give any software provider a single interchange file format that can be understood 
by any localization provider. It is loosely based on the OpenTag version 1.2 specification and borrows 
from the TMX 1.2 specification. However, it is different enough from either one to be its own format.

### XLIFF Elements

* Top Level and Header elements 

	```
	<xliff>, <file>, <header>, <skl>, <external-file>, <internal-file>,
	<glossary>, <reference> , <phase-group>, <phase>, <tool>, <note>
	```
	
* Named Group Elements

	```
	<context-group>, <context>, <count-group> , <count>, <prop-group> , <prop>
	```

* Structural elements

	```
	<body>, <group>, <trans-unit>, <source>, <target>, <bin-unit>, <bin-source>, 
	<bin-target> , <alt-trans>
	```

* Inline elements

	```
	<g>, <x/>, <bx/>, <ex/>, <bpt>, <ept>, <sub>, <it>, <ph>
	```

* Delimiter element

	```
	<mrk>
	```


## License

GNU GENERAL PUBLIC LICENSE V2
