//
//  XliffPhaseGroupElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

#ifndef XliffPhaseGroupElement_h
#define XliffPhaseGroupElement_h

/**
 Phase group - The <phase-group> element contains information about the task that has been performed on the file.
 This phase information is specific to the tools and workflow used in processing the file.

 Required attributes:
	None.

 Optional attributes:
	None.

 Contents:
	One or more <phase> elements.
 */
@interface XliffPhaseGroupElement : XliffObject

@end

#endif /* XliffPhaseGroupElement_h */
