//
//  XliffParser.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import "XliffParser.h"

static NSDictionary *xliffElements;

@implementation XliffParser

+ (void)initialize
{
	xliffElements = @{
					@"xliff": NSStringFromClass(XliffElement.class),
					@"file": NSStringFromClass(XliffFileElement.class),
					@"header": NSStringFromClass(XliffHeaderElement.class),
					@"skl": NSStringFromClass(XliffSklElement.class),
					@"internal-file" : NSStringFromClass(XliffInternalFileElement.class),
					@"external-file" : NSStringFromClass(XliffExternalFileElement.class),
					@"glossary" : NSStringFromClass(XliffGlossaryElement.class),
					@"reference" : NSStringFromClass(XliffReferenceElement.class),
					@"note" : NSStringFromClass(XliffNoteElement.class),
					@"phase-group" : NSStringFromClass(XliffPhaseGroupElement.class),
					@"tool" : NSStringFromClass(XliffToolElement.class),
					@"count-group" : NSStringFromClass(XliffCountGroupElement.class),
					@"count" : NSStringFromClass(XliffCountElement.class),
					@"body" : NSStringFromClass(XliffBodyElement.class),
					@"group" : NSStringFromClass(XliffGroupElement.class),
					@"prop" : NSStringFromClass(XliffPropElement.class),
					@"prop-group" : NSStringFromClass(XliffPropGroupElement.class),
					@"trans-unit" : NSStringFromClass(XliffTransUnitElement.class),
					@"source" : NSStringFromClass(XliffSourceElement.class),
					@"target" : NSStringFromClass(XliffTargetElement.class),
					};
}

+ (XliffElement *) parseWithXMLDocument:(NSXMLDocument *)xml
{
	XliffElement *xliff = nil;

	for (NSXMLElement *element in [xml children])
	{
		NSString *tagName = element.localName;
		if ([@"xliff" isEqualToString:tagName])
		{
			xliff = (XliffElement *)[self.class parseWithXMLElement:element];
			return xliff;
		}
	}

	return xliff;
}

+ (XliffObject *) parseWithXMLElement:(NSXMLElement *)element
{
	NSString *tagName = element.name;
	NSString *className = [xliffElements valueForKey:tagName];

	XliffObject *xlfObject = [[NSClassFromString(className) alloc] init];
	xlfObject.level = MAX(0, element.level - 1);

	NSArray *ns = [element namespaces];
	if (ns) [xlfObject setNamespaces:ns];

	for (NSXMLNode *attr in [element attributes])
	{
		[xlfObject setAttribute:attr.stringValue forName:attr.name];
	}

	for (NSXMLNode *child in [element children])
	{
		switch (child.kind)
		{
			case NSXMLElementKind:
			{
				XliffObject *subObject = [self.class parseWithXMLElement:(NSXMLElement *) child];
				subObject.parent = xlfObject;
				[xlfObject addSubObject:subObject];
				break;
			}
			case NSXMLTextKind:
			{
				if ([xlfObject expectText])
					[xlfObject setText:[child stringValue]];
				break;
			}
			default:
				break;
		}
	}

	return xlfObject;
}

+ (XliffElement *) parseWithData:(NSData *)data
{
	NSError *error = nil;
	NSXMLDocument *xml = [[NSXMLDocument alloc] initWithData:data options:NSXMLNodeOptionsNone error:&error];

	if (error)
	{
		NSLog(@"%s %@", __func__, error);
		return NO;
	}

	return [XliffParser parseWithXMLDocument:xml];
}

+ (XliffElement *) parseWithURL:(NSURL *)URL
{
	NSError *error = nil;
	NSXMLDocument *xml = [[NSXMLDocument alloc] initWithContentsOfURL:URL options:NSXMLNodeOptionsNone error:&error];

	if (error)
	{
		NSLog(@"%s %@", __func__, error);
		return NO;
	}

	return [XliffParser parseWithXMLDocument:xml];
}

@end
