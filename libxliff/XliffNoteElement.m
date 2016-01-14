//
//  XliffNoteElement.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XliffParser.h"

@interface XliffNoteElement()
{
	NSString *_text;
}
@end

@implementation XliffNoteElement

- (instancetype) init
{
	self = [super initWithName:@"note"];
	if (self)
	{
	}
	return self;
}

- (BOOL) expectText{ return YES; }
- (void) setText:(NSString *)text { _text = [text copy]; }
- (NSString *) text { return _text; }

@end