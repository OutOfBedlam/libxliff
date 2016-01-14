//
//  XliffPropElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

#ifndef XliffPropElement_h
#define XliffPropElement_h

@interface XliffPropElement : XliffObject

// Required attributes:
@property NSString *propType;		// prop-type

// Optional attributes:
@property NSString *lang;			// xml:lang

- (NSString *)text;

@end

#endif /* XliffPropElement_h */
