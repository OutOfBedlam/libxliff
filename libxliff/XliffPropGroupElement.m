//
//  XliffPropGroupElement.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XliffParser.h"


@interface XliffPropGroupElement()
{
	NSMutableArray *_propArray;
}
@end

@implementation XliffPropGroupElement

- (instancetype) init
{
	self = [super initWithName:@"prop-group"];
	if (self)
	{
		_propArray = [NSMutableArray array];
	}
	return self;
}

- (void)dealloc
{
	[_propArray removeAllObjects];
}

- (void)addSubObject:(XliffObject *)sub
{
	[super addSubObject:sub];

	//	One or more <prop> elements.

	if ([@"prop" isEqualToString:sub.name])
	{
		[_propArray addObject:sub];
	}
	else if ([@"prop-group" isEqualToString:sub.name])
	{
		[_propArray addObject:sub];
	}
}

- (NSArray *) propArray
{
	return _propArray;
}

@end
