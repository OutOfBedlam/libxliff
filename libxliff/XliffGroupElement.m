//
//  XliffGroupElement.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XliffParser.h"


@interface XliffGroupElement()
{
	NSMutableArray *_children;
	NSMutableArray *_propGroupArray;
	NSMutableArray *_noteArray;
}
@end

@implementation XliffGroupElement

- (instancetype) init
{
	self = [super initWithName:@"group"];
	if (self)
	{
		_children = [NSMutableArray array];
		_propGroupArray = [NSMutableArray array];
		_noteArray = [NSMutableArray array];
	}
	return self;
}

- (void)dealloc
{
	[_children removeAllObjects];
	[_propGroupArray removeAllObjects];
	[_noteArray removeAllObjects];
}

- (void)addSubObject:(XliffObject *)sub
{
	[super addSubObject:sub];

	//		Zero, one or more <context-group> elements, followed by
	//		Zero, one or more <count-group> elements, followed by
	//		Zero, one or more <prop-group> elements, followed by
	//		Zero, one or more <note> elements, followed by
	//		Zero, one or more non-XLIFF elements, followed by
	//		One or more <group>, <trans-unit>, <bin-unit> elements, in any order.
	//
	//		All <context-group>, <count-group>, <prop-group>, <note> and non-XLIFF elements pertain to the subsequent elements in the tree but can be overridden within a child element.

	if ([@"context-group" isEqualToString:sub.name])
	{

	}
	else if ([@"count-group" isEqualToString:sub.name])
	{

	}
	else if ([@"prop-group" isEqualToString:sub.name])
	{
		[_propGroupArray addObject:sub];
	}
	else if ([@"note" isEqualToString:sub.name])
	{
		[_noteArray addObject:sub];
	}
	else if ([@"group" isEqualToString:sub.name])
	{
		[_children addObject:sub];
	}
	else if ([@"trans-unit" isEqualToString:sub.name])
	{
		[_children addObject:sub];
	}
	else if ([@"bin-unit" isEqualToString:sub.name])
	{

	}
}

- (NSArray *)children
{
	return _children;
}

- (NSArray *)propGroupArray
{
	return _propGroupArray;
}

- (NSArray *)noteArray
{
	return _noteArray;
}
@end