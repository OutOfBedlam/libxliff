//
//  XliffHeaderElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

@class XliffToolElement;
@class XliffNoteElement;

/**
 File header - The <header> element contains metadata relating to the <file> element.

 Required attributes:
	None.

 Optional attributes:
	None.

 Contents:
	zero or one <skl> element, followed by
	zero or one <phase-group> element, followed by
	zero, one or more <glossary>, <reference>, <count-group>, <prop-group>, <note>, <tool> elements, in any order, followed by
	Zero, one or more non-XLIFF elements.

 While for backward compatibility reasons no order is enforced for the elements before the non-XLIFF elements,
 the recommended order is the one in which they are listed here.
 */
@interface XliffHeaderElement : XliffObject

- (NSArray *)propGroupArray;
- (NSArray<XliffNoteElement *> *)noteElements;

- (XliffToolElement *) toolElement;

@end
