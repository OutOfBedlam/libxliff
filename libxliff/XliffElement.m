//
//  XliffElement.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XliffParser.h"

@interface XliffElement()
{
	NSMutableArray *_fileArray;
}
@end

@implementation XliffElement

- (instancetype) init
{
	self = [super initWithName:@"xliff"];
	if (self)
	{
		_fileArray = [NSMutableArray array];
	}
	return self;
}

- (void)dealloc
{
	[_fileArray removeAllObjects];
}

- (void)addSubObject:(XliffObject *)sub
{
	[super addSubObject:sub];

	if ([sub isKindOfClass:XliffFileElement.class])
	{
		[_fileArray addObject:sub];
	}
}

- (void)removeSubObject:(XliffObject *)sub
{
	if ([sub isKindOfClass:XliffFileElement.class])
	{
		[_fileArray removeObject:sub];
	}

	[super removeSubObject:sub];
}

- (NSArray *) fileArray
{
	return _fileArray;
}

@end
