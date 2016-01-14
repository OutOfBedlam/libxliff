//
//  XliffCountElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//


/**
 Count - The <count> element contains information about counts.
 For each <count> element the required count-type attribute indicates what kind of count the element represents,
 the optional unit attribute indicates the unit of the count (by default: word).
 A list of values for count-type and unit is provided.
 The optional phase-name attribute references the <phase> in which the count was produced.

 Required attributes:
	count-type.

 Optional attributes:
	phase-name, unit.

 Contents:
	Number (the count value).
 */
@interface XliffCountElement : XliffObject

@property NSString *countType;

@property NSString *phaseName;
@property NSString *unit;
@end
