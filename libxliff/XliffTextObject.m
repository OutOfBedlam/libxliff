//
//  XliffTextObject.m
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

#import "libxliff.h"

@interface XliffTextObject()
{
    NSString *_text;
}
@end

@implementation XliffTextObject

- (void)setText:(NSString *)text
{
    _text = text;
}

- (NSString *)text
{
    return _text;
}
@end
