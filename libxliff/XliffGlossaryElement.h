//
//  XliffGlossaryElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//


/**
 Glossary - The <glossary> element points to or contains a glossary, which can be used in the localization of the file.

 Required attributes:
	None.

 Optional attributes:
	None.

 Contents:
	The glossary description and either exactly one <internal-file> or one <external-file> element.
 */
@interface XliffGlossaryElement : XliffObject

@end

