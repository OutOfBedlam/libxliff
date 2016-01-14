//
//  XliffBodyElement.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libxliff.h"

@interface XliffBodyElement()
{
	NSMutableArray *_transUnitArray;
}
@end

@implementation XliffBodyElement

- (instancetype) init
{
	self = [super initWithName:@"body"];
	if (self)
	{
		_transUnitArray = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc
{
	[_transUnitArray removeAllObjects];
}

- (void)addSubObject:(XliffObject *)sub
{
	[super addSubObject:sub];

	if ([@"trans-unit" isEqualToString:sub.name])
		[_transUnitArray addObject: sub];
}

- (NSUInteger)countTransUnit
{
	return _transUnitArray.count;
}

- (XliffTransUnitElement *) transUnitAtIndex:(NSUInteger)index
{
	return (XliffTransUnitElement *) [_transUnitArray objectAtIndex:index];
}

- (void)enumerateTransUnitUsingBlock:(void(^)(id obj, NSUInteger idx, BOOL *stop))block
{
	[_transUnitArray enumerateObjectsUsingBlock:block];
}
@end
