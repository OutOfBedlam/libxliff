//
//  XliffHeaderElement.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "libxliff.h"

@interface XliffHeaderElement()
{
	NSMutableArray *_propGroupArray;
	NSMutableArray<XliffNoteElement *> *_noteArray;

	XliffSklElement *_skl;
	XliffToolElement *_tool;
}
@end

@implementation XliffHeaderElement

- (instancetype) init
{
	self = [super initWithName:@"header"];
	if (self)
	{
		_propGroupArray = [NSMutableArray array];
		_noteArray = [NSMutableArray array];
	}
	return self;
}

- (void)dealloc
{
	[_propGroupArray removeAllObjects];
	[_noteArray removeAllObjects];
}

- (void)addSubObject:(XliffObject *)sub
{
	[super addSubObject:sub];

	// zero or one <skl> element,
	if ([@"skl" isEqualToString:sub.name])
	{
		_skl = (XliffSklElement *)sub;
		_skl.parent = self;
	}
	// zero or one <phase-group> element
	else if ([@"phase-group" isEqualToString:sub.name])
	{
	}
	// zero, one or more <glossary>, <reference>, <count-group>,
    // <prop-group>, <note>, <tool> elements, in any order
	else if ([@"glossary" isEqualToString:sub.name])
	{

	}
	else if ([@"reference" isEqualToString:sub.name])
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
		[_noteArray addObject:(XliffNoteElement *)sub];
	}
	else if ([@"tool" isEqualToString:sub.name])
	{
		_tool = (XliffToolElement *)sub;
	}
}

- (NSArray *)propGroupArray
{
	return _propGroupArray;
}

- (NSArray<XliffNoteElement *> *)noteElements
{
	return _noteArray;
}

- (XliffToolElement *) toolElement
{
	return _tool;
}

@end
