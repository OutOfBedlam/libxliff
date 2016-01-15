//
//  XliffParserTest.m
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "libxliff.h"

@interface XliffParserTest : XCTestCase
{
    XliffElement *_xlf;
}
@end

@implementation XliffParserTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
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
            NSLog(@"\n\tTU-ID : %@\n\tSource: %@\n\tTarget: %@", tu.Id, tu.sourceText, tu.targetText);
        }
    }
    else
    {
        NSLog(@"%@", obj);
    }
}

- (void)testParser
{
    NSError *error = nil;

    NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:@"XliffParserTest" withExtension:@"xliff"];
    XCTAssert(url != nil, @"Test File not found");

    _xlf = [XliffParser parseWithURL:url error:&error];
    XCTAssert(_xlf != nil, @"Parser failure");
    XCTAssert(_xlf.fileElements.count == 14, @"files count: %ld", _xlf.fileElements.count);

    NSLog(@"version=%@, lang=%@", _xlf.version, _xlf.xmlLang);

    NSArray<XliffFileElement *> *files = _xlf.fileElements;
    for (XliffFileElement *f in files)
    {
        NSString *sourceLanguage = f.sourceLanguage;
        NSString *targetLanguage = f.targetLanguage;

        XliffToolElement *tool = f.toolElement;
        if (tool)
        {
            NSLog(@"%@ %@ %@", f.original, tool.toolName, tool.toolVersion);
        }

        XliffBodyElement *body = f.bodyElement;

        [body enumerateTransUnitUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            XliffTransUnitElement *tu = (XliffTransUnitElement *)obj;
            NSLog(@"\n\tTU-ID : %@ %@\n\tSource(%@): %@\n\tTarget(%@): %@",
                  tu.Id, tu.noteElements,
                  sourceLanguage, tu.sourceText, targetLanguage, tu.targetText);
        }];
    }

    NSMutableString *xmlString = [[NSMutableString alloc] init];
    [_xlf xmlize:xmlString];
    NSLog(@"-----------------------\n%@", xmlString);
}

#if 0
- (void)testPerformanceExample
{
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
#endif

@end
