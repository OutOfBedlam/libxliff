//
//  XliffBodyElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

@class XliffTransUnitElement;

/**
 File body - The <body> element contains the content from the file.

 Required attributes:
	None.
 Optional attributes:
	None.
 Contents:
	Zero, one or more <group>, <trans-unit>, <bin-unit> elements, in any order.
 */
@interface XliffBodyElement : XliffObject
- (NSUInteger)countTransUnit;
- (XliffTransUnitElement *) transUnitAtIndex:(NSUInteger)index;
- (void)enumerateTransUnitUsingBlock:(void(^)(id obj, NSUInteger idx, BOOL *stop))block;

@end

