//
//  XliffTransUnitElement.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libxliff.h"


@interface XliffTransUnitElement()
{
	XliffSourceElement *_source;
	XliffTargetElement *_target;

	NSMutableArray<XliffNoteElement *> *_noteArray;
	NSMutableArray *_propGroupArray;
}
@end

@implementation XliffTransUnitElement

- (instancetype) init
{
	self = [super initWithName:@"trans-unit"];
	if (self)
	{
		_noteArray = [NSMutableArray array];
		_propGroupArray = [NSMutableArray array];
	}
	return self;
}

- (void)dealloc
{
	[_noteArray removeAllObjects];
	[_propGroupArray removeAllObjects];
}

- (void)addSubObject:(XliffObject *)sub
{
	[super addSubObject:sub];

	//		One <source> element, followed by
	//		Zero or one <target> element, followed by
	//		Zero, one or more <context-group>, <count-group>, <prop-group>, <note>, <alt-trans> elements, in any order, followed by
	//		Zero, one or more non-XLIFF elements.

	if ([@"source" isEqualToString:sub.name])
	{
		_source = (XliffSourceElement *)sub;
	}
	else if ([@"target" isEqualToString:sub.name])
	{
		_target = (XliffTargetElement *)sub;
	}
	else if ([@"note" isEqualToString:sub.name])
	{
		[_noteArray addObject:(XliffNoteElement *)sub];
	}
	else if ([@"prop-group" isEqualToString:sub.name])
	{
		[_propGroupArray addObject:sub];
	}
}

- (NSString *)sourceText
{
	return _source.text;
}

- (XliffSourceElement *)source
{
	return _source;
}

- (NSString *)targetText
{
	return _target.text;
}

- (void)setTargetText:(NSString *)text
{
	if (!_target)
	{
		_target = [[XliffTargetElement alloc] init];
		_target.level = _source.level;
		[super insertSubObject:_target after:_source];
	}
	_target.text = [text copy];
}

- (XliffTargetElement *)target
{
	return _target;
}

- (void)setTarget:(XliffTargetElement *)target
{
	_target = target;
}

- (NSArray<XliffNoteElement *> *)noteElements
{
	return _noteArray;
}

- (BOOL)isTranslate
{
	return self.translate ? [self.translate boolValue] : NO;
}

- (NSArray *)propGroupArray
{
	return _propGroupArray;
}
@end
