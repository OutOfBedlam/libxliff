# libxliff

XLIFF parser for Objective C. This library's objective is building XLIFF processing library that compatible with Xcode, so that it can manipulate XLIFF files that Xcode exports/imports. 


## What is XLIFF

XLIFF is the XML Localization Interchange File Format designed by a group of software providers, 
localization service providers, and localization tools providers. 
It is intended to give any software provider a single interchange file format that can be understood 
by any localization provider. It is loosely based on the OpenTag version 1.2 specification and borrows 
from the TMX 1.2 specification. However, it is different enough from either one to be its own format.

### XLIFF and Xcode

*Export XLIFF from MyProject*

1. Select MyProject from Xcode
2. Menu `Editor` -> `Export For Localization...`


*Import Translated XLIFF to MyProject*

1. Menu `Editor` -> `Import Localiation...`

Please refer to [Apple's Document](https://developer.apple.com/library/ios/documentation/MacOSX/Conceptual/BPInternational/LocalizingYourApp/LocalizingYourApp.html)


## How to add `libxliff` in MyProject?

1. cd into MyProject directory.
2. `git submodule add git@github.com:OutOfBedlam/libxliff.git`
3. add the libxliff.xcodeproj file to my Xcode project through Xcode.
4. Modify MyProject `Build Phase` accordingly
5. Add `libxliff/libxliff` to your header search path


## Quick Start

```
#import "libxliff.h"

NSURL *url = ... URL of XLIFF file ...;
XliffElement *xlf = [XliffParser parseWithURL:url error:nil];
```

## XLIFF Elements

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
