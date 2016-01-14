//
//  XliffParser.h
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

@class XliffElement;

@interface XliffParser : NSObject

+ (XliffElement *) parseWithXMLDocument:(NSXMLDocument *)xml;
+ (XliffElement *) parseWithData:(NSData *)data;
+ (XliffElement *) parseWithURL:(NSURL *)URL;

@end


