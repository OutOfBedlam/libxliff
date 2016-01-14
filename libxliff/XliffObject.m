//
//  XliffObject.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XliffParser.h"

@interface XliffObjectAttribute : NSObject
@property NSString *key;
@property NSString *value;
@end

@implementation XliffObjectAttribute
@end


@interface XliffObject()
{
	NSString *_name;
	NSMutableArray *_attributes;
	NSMutableArray *_subObjects;

	NSArray *_namespaces;
}
@end

@implementation XliffObject

- (instancetype) initWithName:(NSString *)name
{
	self = [super init];
	if (self)
	{
		_name = name;
		_subObjects = [NSMutableArray array];
		_attributes = [NSMutableArray array];
	}
	return self;
}

- (void)dealloc
{
	[_attributes removeAllObjects];
	[_subObjects removeAllObjects];
}

- (NSString *)name
{
	return _name;
}

- (void) setNamespaces:(NSArray *)ns
{
	_namespaces = [NSArray arrayWithArray:ns];
}

- (NSArray *)namespaces
{
	return _namespaces;
}

- (void) removeSubObject:(XliffObject *)sub
{
	[_subObjects removeObject:sub];
}

- (void) addSubObject:(XliffObject *)sub
{
	[_subObjects addObject:sub];
}

- (NSArray *) subObjects
{
	return _subObjects;
}

- (void) insertSubObject:(XliffObject *)sub after:(XliffObject *)object
{
	NSUInteger index = [_subObjects indexOfObject:object];
	if (index == NSNotFound)
	{
		[_subObjects addObject:sub];
	}
	else
	{
		[_subObjects insertObject:sub atIndex:index + 1];
	}
}

- (void) insertSubObject:(XliffObject *)sub before:(XliffObject *)object
{
	NSUInteger index = [_subObjects indexOfObject:object];
	if (index == NSNotFound)
	{
		[_subObjects addObject:sub];
	}
	else
	{
		[_subObjects insertObject:sub atIndex:index];
	}
}

- (void) setAttribute:(NSString *)attrValue forName:(NSString *)attrName
{
	NSString *v = [attrValue copy];
	NSString *n = [attrName copy];

	XliffObjectAttribute *attr = [[XliffObjectAttribute alloc] init];
	attr.key = n;
	attr.value = v;

	[_attributes addObject:attr];

	[self setValue:v forKey:n];
}

- (NSString *)attributeForName:(NSString *)attrName;
{
	for (XliffObjectAttribute *attr in _attributes)
	{
		if ([attr.key isEqualToString:attrName])
			return attr.value;
	}
	return nil;
}

- (BOOL)expectText
{
	return NO;
}

- (void)setText:(NSString *)text
{

}

- (NSString *)text
{
	return nil;
}

- (id)ancestorOfClass:(Class)class
{
	XliffObject *parent = self.parent;
	while(parent != nil)
	{
		if ([parent isKindOfClass:class])
			return parent;
		parent = parent.parent;
	}
	return nil;
}

+ (NSString *) normalizePropertyName:(NSString *)xmlPropertyName
{
	NSString *nkey = xmlPropertyName;

	// remove namespace speparator eg) xml:space ==> xml-space ==> xmlSpace
	nkey = [nkey stringByReplacingOccurrencesOfString:@":" withString:@"-"];

	// convert "page-progression-direction" ==> "pageProgressionDirection"
	NSRange range = [nkey rangeOfString:@"-"];
	while(range.location != NSNotFound)
	{
		nkey = [[nkey substringToIndex:range.location]
				stringByAppendingString:[[nkey substringFromIndex:range.location+1] capitalizedString]];
		range = [nkey rangeOfString:@"-"];
	}while(range.length);

	return nkey;
}

- (id)valueForUndefinedKey:(NSString *)key
{
	NSString *normalizedKey = [XliffObject normalizePropertyName:key];

	if ([super respondsToSelector:NSSelectorFromString(normalizedKey)])
	{
		return [super valueForKey:normalizedKey];
	}
	else
	{
		for (XliffObjectAttribute *attr in _attributes)
		{
			if ([attr.key isEqualToString:key])
				return attr.value;
		}

		NSLog(@"*** Undefined-Key %s %@ \"%@\"", __func__, NSStringFromClass([self class]), key);
	}
	return nil;
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key
{
	NSString *normalizedKey = [XliffObject normalizePropertyName:key];

	// guess selector of setter "setPageProgressionDirection"
	NSString *capitalized = [NSString stringWithFormat:@"%@%@", [[normalizedKey substringToIndex:1] capitalizedString],
							 [normalizedKey substringFromIndex:1]];


	if ([super respondsToSelector:NSSelectorFromString([NSString stringWithFormat:@"set%@:", capitalized])])
	{
		[super setValue:value forKey:normalizedKey];
	}
}

- (void)xmlize:(NSMutableString *)stringBuff
{
	for (int i = 0; i < _level; i++)
		[stringBuff appendString:@"  "];

	[stringBuff appendFormat:@"<%@", _name];

	NSArray *ns = [self namespaces];
	for (NSString *n in ns)
	{
		[stringBuff appendFormat:@" %@", n];
	}

	for (XliffObjectAttribute *attr in _attributes)
	{
		[stringBuff appendFormat:@" %@=\"%@\"", attr.key, attr.value];
	}

	if (_subObjects.count)
	{
		[stringBuff appendString:@">"];

		for (XliffObject *sub in _subObjects)
		{
			[stringBuff appendString:@"\n"];
			[sub xmlize:stringBuff];
		}

		[stringBuff appendString:@"\n"];

		for (int i = 0; i < _level; i++)
			[stringBuff appendString:@"  "];

		[stringBuff appendFormat:@"</%@>", _name];
	}
	else if ([self expectText])
	{
		[stringBuff appendString:@">"];
		if (self.text)
			[stringBuff appendString:self.text];
		[stringBuff appendFormat:@"</%@>", _name];
	}
	else
	{
		[stringBuff appendString:@"/>"];
	}
}

@end

