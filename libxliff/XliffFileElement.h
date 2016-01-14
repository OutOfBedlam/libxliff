//
//  XliffFileElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

#ifndef XliffFileElement_h
#define XliffFileElement_h

@class XliffHeaderElement;
@class XliffBodyElement;

/**
 The <file> element corresponds to a single extracted original document.
 The required original attribute specifies the name of the file from which this
 file content is derived.
 The required datatype attribute specifies the format of the original file; e.g. "html".
 The required source-language attribute specifies the language of the <source> content.
 The optional target-language attribute is used to specify the language of the <target> content.
 The optional tool-id attribute accepts the id of the <tool> used to generate this XLIFF document.
 The optional date attribute is used to specify the creation date of this XLIFF file.
 The optional xml:space attribute is used to specify how white-spaces are to be treated.
 The optional category attribute is used to specify a general category of the content of the file; e.g. "medical".
 The optional product-name attribute is used to specify the name of the product which uses this file.
 The optional product-version and build-num attributes are used to specify the revision of the product from which this file comes.
 The tool and ts attributes have been deprecated in XLIFF 1.1.

 Required attributes:
	original, source-language, datatype.

 Optional attributes:
	tool, tool-id, date, xml:space, ts, category, target-language, product-name, product-version, build-num.

 Contents:
	Zero or one <header> element, followed by
	One <body> element.
 */
@interface XliffFileElement : XliffObject

// required attributes
@property NSString *original;			// original
@property NSString *sourceLanguage;		// source-language
@property NSString *datatype;			// datatype

// optional attributes
@property NSString *tool;				// tool
@property NSString *toolId;				// tool-id
@property NSString *date;				// date
@property NSString *xmlSpace;			// xml:space
@property NSString *ts;					// ts
@property NSString *category;			// category
@property NSString *targetLanguage;		// target-language
@property NSString *productName;		// product-name
@property NSString *productVersion;		// product-version
@property NSString *buildNum;			// build-num

- (XliffHeaderElement *) headerElement;
- (XliffBodyElement *) bodyElement;

@end

#endif /* XliffFileElement_h */
