//
//  XliffObject.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XliffObject : NSObject

- (instancetype) initWithName:(NSString *)name;

@property (weak) XliffObject *parent;
@property (assign) NSUInteger level;

- (NSString *)name;

- (void)addSubObject:(XliffObject *)sub;
- (NSArray<XliffObject *> *)subObjects;
- (void) removeSubObject:(XliffObject *)sub;

- (void) insertSubObject:(XliffObject *)sub after:(XliffObject *)obbject;
- (void) insertSubObject:(XliffObject *)sub before:(XliffObject *)object;

- (void)setAttribute:(NSString *)attrValue forName:(NSString *)attrName;
- (NSString *)attributeForName:(NSString *)attrName;

- (void) setNamespaces:(NSArray *)ns;
- (NSArray *)namespaces;

- (id)ancestorOfClass:(Class)class;

- (void)xmlize:(NSMutableString *)stringBuff;

@end


@interface XliffObject(XML)
+ (NSString*) xmlSimpleEscape:(NSString*)unescapedStr;
@end
