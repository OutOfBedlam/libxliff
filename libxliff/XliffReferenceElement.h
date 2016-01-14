//
//  XliffReferenceElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//


/**
 Reference - The <reference> element points to or contains reference material, which can aid in the localization of the file.

 Required attributes:
	None.

 Optional attributes:
	None.

 Contents:
	A description of the reference material and either exactly one <internal-file> or one <external-file> element.
 */
@interface XliffReferenceElement : XliffObject

@end
