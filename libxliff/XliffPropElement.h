//
//  XliffPropElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

@interface XliffPropElement : XliffTextObject

// Required attributes:
@property NSString *propType;		// prop-type

// Optional attributes:
@property NSString *lang;			// xml:lang

@end
