//
//  XliffInternalFileElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//


/**
 Internal file - The <internal-file> element contains the actual file being referenced.
 It is a child of the <skl>, <glossary>, and <reference> elements.
 The format of the file is specified by the optional form attribute, which accepts mime-type values.
 The crc attribute accepts a value that can be used to precisely identify and assure the authenticity of the file.

 Required attributes:
	None.

 Optional attributes:
	form, crc.

 Contents:
	An embedded file.
 */
@interface XliffInternalFileElement : XliffObject

@property NSString *form;
@property NSString *crc;

@end

