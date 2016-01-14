//
//  XliffCountGroupElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

/**
 Count group - The <count-group> element holds count elements relating to the level in the tree in which it occurs.
 Each group for <count> elements must be named, allowing different uses for each group.
 The required name attribute uniquely identifies the <count-group> within the file.

 Required attributes:
	name.

 Optional attributes:
	None.

 Contents:
	One or more <count> elements.
 */
@interface XliffCountGroupElement : XliffObject

@property NSString *name;

@end
