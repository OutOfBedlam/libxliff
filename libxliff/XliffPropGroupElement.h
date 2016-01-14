//
//  XliffPropGroupElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//


@interface XliffPropGroupElement : XliffObject

// Optional attributes:
@property NSString *name;	// name

//! child elements which are prop, prop-group
- (NSArray *) propArray;

@end

