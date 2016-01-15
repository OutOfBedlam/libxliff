//
//  XliffObject.m
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import "XliffParser.h"
#import "XliffObject.h"
#import "XliffTextObject.h"

@interface XliffObjectAttribute : NSObject
@property NSString *key;
@property NSString *value;
- (void)xmlize:(NSMutableString *)stringBuff;
@end

@implementation XliffObjectAttribute

- (void)xmlize:(NSMutableString *)stringBuff
{
    NSString *escapedValue = [XliffObject xmlSimpleEscape:_value];
    [stringBuff appendFormat:@" %@=\"%@\"", _key, escapedValue];
}

@end


@interface XliffObject()
{
	NSString *_name;
	NSMutableArray<XliffObjectAttribute *> *_attributes;
	NSMutableArray<XliffObject *> *_subObjects;

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

- (NSArray<XliffObject *> *) subObjects
{
	return _subObjects;
}

- (void) insertSubObject:(XliffObject *)sub after:(XliffObject *)object
{
    NSUInteger index = NSNotFound;
    if (object)
        index = [_subObjects indexOfObject:object];

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
    NSUInteger index = NSNotFound;
    if (object)
        index = [_subObjects indexOfObject:object];

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
        [attr xmlize:stringBuff];
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
	else if ([self isKindOfClass:XliffTextObject.class])
	{
        NSString *escapedText = [XliffObject xmlSimpleEscape:((XliffTextObject *)self).text];

		[stringBuff appendString:@">"];
		if (escapedText)
        {
			[stringBuff appendString:escapedText];
        }
		[stringBuff appendFormat:@"</%@>", _name];
	}
	else
	{
		[stringBuff appendString:@"/>"];
	}
}

@end

@implementation XliffObject(XML)

+ (NSString*) xmlSimpleEscape:(NSString*)unescapedStr
{
    if (unescapedStr == nil || [unescapedStr length] == 0) {
        return unescapedStr;
    }

    NSUInteger len = [unescapedStr length];
    NSUInteger longer = ((int) (len * 0.10));
    if (longer < 5) {
        longer = 5;
    }
    longer = len + longer;
    NSMutableString *mStr = [NSMutableString stringWithCapacity:longer];

    NSRange subrange;
    subrange.location = 0;
    subrange.length = 0;

    for (int i = 0; i < len; i++)
    {
        char c = [unescapedStr characterAtIndex:i];
        NSString *replaceWithStr = nil;

        if (c == '\"')
        {
            replaceWithStr = @"&quot;";
        }
        else if (c == '\'')
        {
            replaceWithStr = @"&#x27;";
        }
        else if (c == '<')
        {
            replaceWithStr = @"&lt;";
        }
        else if (c == '>')
        {
            replaceWithStr = @"&gt;";
        }
        else if (c == '&')
        {
            replaceWithStr = @"&amp;";
        }

        if (replaceWithStr == nil) {
            // The current character is not an XML escape character, increase subrange length

            subrange.length += 1;
        } else {
            // The current character will be replaced, but append any pending substring first

            if (subrange.length > 0) {
                NSString *substring = [unescapedStr substringWithRange:subrange];
                [mStr appendString:substring];
            }

            [mStr appendString:replaceWithStr];

            subrange.location = i + 1;
            subrange.length = 0;
        }
    }

    // Got to end of unescapedStr so append any pending substring, in the
    // case of no escape characters this will append the whole string.

    if (subrange.length > 0)
    {
        if (subrange.location == 0) {
            [mStr appendString:unescapedStr];
        } else {
            NSString *substring = [unescapedStr substringWithRange:subrange];
            [mStr appendString:substring];
        }
    }
    
    return [NSString stringWithString:mStr];
}

@end

