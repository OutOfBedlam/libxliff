//
//  XliffElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

@class XliffFileElement;

/**
	XLIFF document - The <xliff> element encloses all the other elements of the document.
	The required version attribute specifies the version of XLIFF.
	The optional xml:lang attribute is used to specify the language of the content of the document.

	Required attributes:
        version.

	Optional attributes:
        xml:lang.

	Contents:
        One or more <file> elements.
 */
@interface XliffElement : XliffObject

// Required attribute
@property NSString *version;

// Optional attribute
@property NSString *xmlLang;

// One or more <file> elements
- (NSArray<XliffFileElement *> *) fileElements;

@end
