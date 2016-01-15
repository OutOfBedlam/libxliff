//
//  XliffParser.h
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XliffElement;

@interface XliffParser : NSObject

+ (XliffElement *) parseWithXMLDocument:(NSXMLDocument *)xml;
+ (XliffElement *) parseWithData:(NSData *)data error:(NSError **)error;
+ (XliffElement *) parseWithURL:(NSURL *)URL error:(NSError **)error;

@end


