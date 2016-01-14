//
//  XliffInternalFileElement.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XliffParser.h"

@implementation XliffInternalFileElement

- (instancetype) initWithXMLElement:(NSXMLElement *)element
{
	self = [super initWithName:@"internal-file"];
	if (self)
	{
	}
	return self;
}

@end
