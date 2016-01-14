//
//  XliffExternalFileElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

/**
 External file - The <external-file> element specifies the location of the actual file being referenced.
 The required href attribute provides a URI to the file.
 The crc attribute accepts a value that can be used to precisely identify and assure the authenticity of the file.
 The uid attribute allows a unique ID to be assigned to the file.

 Required attributes:
	href.

 Optional attributes:
	uid, crc.

 Contents:
	The <external-file> is an empty element, including attributes only.
 */
@interface XliffExternalFileElement : XliffObject

@property NSString *href;
@property NSString *uid;
@property NSString *crc;

@end
