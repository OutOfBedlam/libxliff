//
//  XliffTargetElement.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libxliff.h"

@interface XliffTargetElement()
{
	NSString *_text;
}
@end

@implementation XliffTargetElement

@synthesize text = _text;

- (instancetype)init
{
	self = [super initWithName:@"target"];
	if (self)
	{

	}
	return self;
}

- (BOOL) expectText{ return YES; }
- (void) setText:(NSString *)text { _text = [text copy]; }
- (NSString *) text { return _text; }

@end
