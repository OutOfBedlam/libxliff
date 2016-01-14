//
//  XliffSourceElement.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libxliff.h"

@interface XliffSourceElement()
@end

@implementation XliffSourceElement

@synthesize text = _text;

- (instancetype)init
{
	self = [super initWithName:@"source"];
	if (self)
	{

	}
	return self;
}

@end
