//
//  XliffFileElement.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libxliff.h"

@interface XliffFileElement()
{
	XliffHeaderElement *_headerElement;
	XliffBodyElement *_bodyElement;
}
@end

@implementation XliffFileElement

- (instancetype) init
{
	self = [super initWithName:@"file"];
	if (self)
	{
	}
	return self;
}

- (void)addSubObject:(XliffObject *)sub
{
	[super addSubObject:sub];

	if ([@"header" isEqualToString:sub.name])
		_headerElement = (XliffHeaderElement *) sub;
	else if ([@"body" isEqualToString:sub.name])
		_bodyElement = (XliffBodyElement *) sub;
}

- (XliffHeaderElement *) headerElement
{
	return _headerElement;
}

- (XliffBodyElement *) bodyElement
{
	return _bodyElement;
}

@end
