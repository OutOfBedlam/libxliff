//
//  XliffParserTest.m
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "XliffParser.h"

@interface XliffParserTest : XCTestCase
{
    XliffElement *_xlf;
}
@end

@implementation XliffParserTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)print:(id)obj
{
    if ([obj isKindOfClass:XliffGroupElement.class])
    {
        XliffGroupElement *group = (XliffGroupElement *)obj;
        NSLog(@"=======GROUP (restype=%@): %@", group.restype, group.Id);
        NSArray *children = [group children];
        for (id child in children)
            [self print:child];
    }
    else if ([obj isKindOfClass:XliffTransUnitElement.class])
    {
        XliffTransUnitElement *tu = (XliffTransUnitElement *)obj;

        if (tu.isTranslate)
        {
            NSLog(@"%@\n\t%@\n\t%@", tu.Id, tu.sourceText, tu.targetText);
        }
    }
    else
    {
        NSLog(@"%@", obj);
    }
}

- (void)testExample {
    NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:@"XliffParserTest" withExtension:@"xliff"];
    XCTAssert(url != nil, @"Test File not found");
    _xlf = [XliffParser parseWithURL:url];

    for (id obj in _xlf.fileArray)
    {
        if ([obj isKindOfClass:XliffFileElement.class])
            NSLog(@"%@", ((XliffFileElement*) obj).original);
    }
    XliffFileElement *fileElement = (XliffFileElement *)[_xlf.fileArray firstObject];
    XliffBodyElement *bodyElement = fileElement.bodyElement;

    NSArray *elements = [bodyElement subObjects];
    for (id obj in elements)
    {
        NSLog(@"%@", obj);
        [self print:obj];
    }
    
    //XCTAssert(YES, @"Pass");
}

#if 0
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
#endif

@end
