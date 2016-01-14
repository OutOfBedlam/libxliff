//
//  XliffParser.h
//  XLIFF Editor
//
//  Created by Eirny on 6/15/15.
//  Copyright (c) 2015 Yet Reader Forge. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XliffObject;
@class XliffElement;
@class XliffFileElement;
@class XliffHeaderElement;
@class XliffBodyElement;
@class XliffSklElement;
@class XliffInternalFileElement;
@class XliffExternalFileElement;
@class XliffGlossaryElement;
@class XliffReferenceElement;
@class XliffNoteElement;
@class XliffPhaseGroupElement;
@class XliffPhaseElement;
@class XliffToolElement;
@class XliffCountGroupElement;
@class XliffCountElement;
@class XliffGroupElement;
@class XliffPropElement;
@class XliffPropGroupElement;
@class XliffTransUnitElement;
@class XliffSourceElement;
@class XliffTargetElement;



#pragma mark - XliffParser

@interface XliffParser : NSObject

+ (XliffElement *) parseWithXMLDocument:(NSXMLDocument *)xml;
+ (XliffElement *) parseWithData:(NSData *)data;
+ (XliffElement *) parseWithURL:(NSURL *)URL;

@end

#pragma mark - XliffObject
@interface XliffObject : NSObject

- (instancetype) initWithName:(NSString *)name;

@property (weak) XliffObject *parent;
@property (assign) NSUInteger level;

- (NSString *)name;

- (void)addSubObject:(XliffObject *)sub;
- (NSArray *)subObjects;
- (void) removeSubObject:(XliffObject *)sub;

- (void) insertSubObject:(XliffObject *)sub after:(XliffObject *)obbject;
- (void) insertSubObject:(XliffObject *)sub before:(XliffObject *)object;

- (void)setAttribute:(NSString *)attrValue forName:(NSString *)attrName;
- (NSString *)attributeForName:(NSString *)attrName;

- (BOOL)expectText;
- (void)setText:(NSString *)text;
- (NSString *)text;

- (void) setNamespaces:(NSArray *)ns;
- (NSArray *)namespaces;

- (id)ancestorOfClass:(Class)class;

- (void)xmlize:(NSMutableString *)stringBuff;

@end


#pragma mark - XliffElement

/**
	XLIFF document - The <xliff> element encloses all the other elements of the document.
	The required version attribute specifies the version of XLIFF.
	The optional xml:lang attribute is used to specify the language of the content of the document.

	Required attributes:
		version.

	Optional attributes:
		xml:lang.

	Contents:
		One or more <file> elements.
 */
@interface XliffElement : XliffObject

// required attributes
@property NSString *version;

// Optional attributes:
@property NSString *xmlLang;

// child element
- (NSArray *) fileArray;

@end


#pragma mark - XliffFileElement

/**
 The <file> element corresponds to a single extracted original document.
 The required original attribute specifies the name of the file from which this
 file content is derived.
 The required datatype attribute specifies the format of the original file; e.g. "html".
 The required source-language attribute specifies the language of the <source> content.
 The optional target-language attribute is used to specify the language of the <target> content.
 The optional tool-id attribute accepts the id of the <tool> used to generate this XLIFF document.
 The optional date attribute is used to specify the creation date of this XLIFF file.
 The optional xml:space attribute is used to specify how white-spaces are to be treated.
 The optional category attribute is used to specify a general category of the content of the file; e.g. "medical".
 The optional product-name attribute is used to specify the name of the product which uses this file.
 The optional product-version and build-num attributes are used to specify the revision of the product from which this file comes.
 The tool and ts attributes have been deprecated in XLIFF 1.1.

 Required attributes:
	original, source-language, datatype.

 Optional attributes:
	tool, tool-id, date, xml:space, ts, category, target-language, product-name, product-version, build-num.

 Contents:
	Zero or one <header> element, followed by
	One <body> element.
 */
@interface XliffFileElement : XliffObject

// required attributes
@property NSString *original;			// original
@property NSString *sourceLanguage;		// source-language
@property NSString *datatype;			// datatype

// optional attributes
@property NSString *tool;				// tool
@property NSString *toolId;				// tool-id
@property NSString *date;				// date
@property NSString *xmlSpace;			// xml:space
@property NSString *ts;					// ts
@property NSString *category;			// category
@property NSString *targetLanguage;		// target-language
@property NSString *productName;		// product-name
@property NSString *productVersion;		// product-version
@property NSString *buildNum;			// build-num

- (XliffHeaderElement *) headerElement;
- (XliffBodyElement *) bodyElement;

@end

#pragma mark - XliffHeaderElement

/**
 File header - The <header> element contains metadata relating to the <file> element.

 Required attributes:
	None.

 Optional attributes:
	None.

 Contents:
	zero or one <skl> element, followed by
	zero or one <phase-group> element, followed by
	zero, one or more <glossary>, <reference>, <count-group>, <prop-group>, <note>, <tool> elements, in any order, followed by
	Zero, one or more non-XLIFF elements.

 While for backward compatibility reasons no order is enforced for the elements before the non-XLIFF elements,
 the recommended order is the one in which they are listed here.
 */
@interface XliffHeaderElement : XliffObject

- (NSArray *)propGroupArray;
- (NSArray *)noteArray;

- (XliffToolElement *) toolElement;

@end


#pragma mark - XliffSklElement

/**
 Skeleton file - The <skl> element contains the skeleton file or the location of the skeleton file.
 The skeleton file is a template that can be used in recreating the original file,
 from the <source> content, or the translated file, from the <target> content.

 Required attributes:
	None.

 Optional attributes:
	None

 Contents:
	Either exactly one <internal-file> or one <external-file> element.
 */
@interface XliffSklElement : XliffObject

@end



#pragma mark - XliffInternalFileElement

/**
 Internal file - The <internal-file> element contains the actual file being referenced.
 It is a child of the <skl>, <glossary>, and <reference> elements.
 The format of the file is specified by the optional form attribute, which accepts mime-type values.
 The crc attribute accepts a value that can be used to precisely identify and assure the authenticity of the file.

 Required attributes:
	None.

 Optional attributes:
	form, crc.

 Contents:
	An embedded file.
 */
@interface XliffInternalFileElement : XliffObject

@property NSString *form;
@property NSString *crc;

@end


#pragma mark - XliffExternalFileElement

/**
 External file - The <external-file> element specifies the location of the actual file being referenced.
 The required href attribute provides a URI to the file.
 The crc attribute accepts a value that can be used to precisely identify and assure the authenticity of the file.
 The uid attribute allows a unique ID to be assigned to the file.

 Required attributes:
	href.

 Optional attributes:
	uid, crc.

 Contents:
	The <external-file> is an empty element, including attributes only.
 */
@interface XliffExternalFileElement : XliffObject

@property NSString *href;
@property NSString *uid;
@property NSString *crc;

@end


#pragma mark - XliffGlossaryElement

/**
 Glossary - The <glossary> element points to or contains a glossary, which can be used in the localization of the file.

 Required attributes:
	None.

 Optional attributes:
	None.

 Contents:
	The glossary description and either exactly one <internal-file> or one <external-file> element.
 */
@interface XliffGlossaryElement : XliffObject

@end


#pragma mark -XliffReferenceElement

/**
 Reference - The <reference> element points to or contains reference material, which can aid in the localization of the file.

 Required attributes:
	None.

 Optional attributes:
	None.

 Contents:
	A description of the reference material and either exactly one <internal-file> or one <external-file> element.
 */
@interface XliffReferenceElement : XliffObject

@end


#pragma mark - XliffNoteElement

/**
 Note - The <note> element is used to add localization-related comments to the XLIFF document.
 The content of <note> may be instructions from developers about how to handle the <source>,
 comments from the translator about the translation,
 or any comment from anyone involved in processing the XLIFF file.

 The optional xml:lang attribute specifies the language of the note content.
 The optional from attribute indicates who entered the note.
 The optional priority attribute allows a priority from 1 (high) to 10 (low) to be assigned to the note.
 The optional annotates attribute indicates if the note is a general note or, in the case of a <trans-unit>,
 pertains specifically to the to the <source> or the <target> element.

 Required attributes:
	None.

 Optional attributes:
	xml:lang, from, priority, annotates.

 Contents:
	Text, no standard elements.
 */
@interface XliffNoteElement : XliffObject

// optional attributes
@property NSString *lang;	// xml:lang
@property NSString *from;	// from
@property NSString *priority; // priority
@property NSString *annotates; // annotates

- (NSString *) text;

@end


#pragma mark - XliffPhaseGroupElement

/**
 Phase group - The <phase-group> element contains information about the task that has been performed on the file.
 This phase information is specific to the tools and workflow used in processing the file.

 Required attributes:
	None.

 Optional attributes:
	None.

 Contents:
	One or more <phase> elements.
 */
@interface XliffPhaseGroupElement : XliffObject

@end


#pragma mark - XliffPhaseElement
/**
 Phase information - The <phase> contains metadata about the tasks performed in a particular process.

 The required phase-name attribute uniquely identifies the phase for reference within the file.
 The required process-name attribute identifies the kind of process the phase corresponds to; e.g. "proofreading".

 The optional company-name attribute identifies the company performing the task.
 The optional tool-id attribute references the <tool> used in performing the task.
 The optional date attribute provides a timestamp indicating when the task was performed.
 The optional job-id attribute allows an ID to be assigned to the job.
 The optional contact-name, contact-email, and contact-phone attributes all refer to the person performing the task.

 Required attributes:
	phase-name, process-name.

 Optional attributes:
	company-name, tool, tool-id, date, job-id, contact-name, contact-email, contact-phone.

 Contents:
	Zero, one or more <note> elements.
 */
@interface XliffPhaseElement : XliffObject

@property NSString *phaseName;
@property NSString *processName;

@property NSString *companyName;
@property NSString *tool;
@property NSString *toolId;
@property NSString *date;
@property NSString *jobId;
@property NSString *contactName;
@property NSString *contactEmail;
@property NSString *contactPhone;
@end


#pragma mark - XliffToolElement

/**
 Tool - The <tool> element describes the tool that has been used to execute a given task in the document.
 The required tool-id attribute uniquely identifies the tool for reference within the file.
 The required tool-name attribute specifies the actual tool name.
 The optional tool-version attribute provides the version of the tool.
 The optional tool-company attribute provides the name of the company that produced the tool.

 Required attributes:
	tool-id, tool-name.

 Optional attributes:
	tool-version, tool-company.

 Contents:
	Zero, one or more non-XLIFF elements.
 */
@interface XliffToolElement : XliffObject

@property NSString *toolId;
@property NSString *toolName;

@property NSString *toolVersion;
@property NSString *toolCompany;
@end


#pragma mark - XliffCountGroupElement

/**
 Count group - The <count-group> element holds count elements relating to the level in the tree in which it occurs.
 Each group for <count> elements must be named, allowing different uses for each group.
 The required name attribute uniquely identifies the <count-group> within the file.

 Required attributes:
	name.

 Optional attributes:
	None.

 Contents:
	One or more <count> elements.
 */
@interface XliffCountGroupElement : XliffObject

@property NSString *name;

@end


#pragma mark - XliffCountElement

/**
 Count - The <count> element contains information about counts.
 For each <count> element the required count-type attribute indicates what kind of count the element represents,
 the optional unit attribute indicates the unit of the count (by default: word).
 A list of values for count-type and unit is provided.
 The optional phase-name attribute references the <phase> in which the count was produced.

 Required attributes:
	count-type.

 Optional attributes:
	phase-name, unit.

 Contents:
	Number (the count value).
 */
@interface XliffCountElement : XliffObject

@property NSString *countType;

@property NSString *phaseName;
@property NSString *unit;
@end


#pragma mark - XliffBodyElement

/**
 File body - The <body> element contains the content from the file. 
 
 Required attributes:
	None.
 Optional attributes:
	None.
 Contents:
	Zero, one or more <group>, <trans-unit>, <bin-unit> elements, in any order.
 */
@interface XliffBodyElement : XliffObject
- (NSUInteger)countTransUnit;
- (XliffTransUnitElement *) transUnitAtIndex:(NSUInteger)index;
- (void)enumerateTransUnitUsingBlock:(void(^)(id obj, NSUInteger idx, BOOL *stop))block;

@end


#pragma mark - XliffGroupElement

@interface XliffGroupElement : XliffObject
// Optional attributes:
@property NSString *Id;			// id
@property NSString *datatype;	// datatype
@property NSString *space;		// xml:space
@property NSString *ts;			// ts
@property NSString *restype;	// restype
@property NSString *resname;	// resname
@property NSString *extradata;	// extradata
@property NSString *helpId;		// help-id
@property NSString *menu;		// menu
@property NSString *menuOption;	// menu-option
@property NSString *menuName;	// menu-name
@property NSString *coord;		// coord
@property NSString *font;		// font
@property NSString *cssStyle;	// css-style
@property NSString *style;		// style
@property NSString *exstyle;	// exstyle
@property NSString *extype;		// extype
@property NSString *translate;	// translate
@property NSString *reformat;	// reformat
@property NSString *maxbytes;	// maxbytes
@property NSString *minbytes;	// minbytes
@property NSString *sizeUnit;	// size-unit
@property NSString *maxheight;	// maxheight
@property NSString *minheight;	// minheight
@property NSString *maxwidth;	// maxwidth
@property NSString *minwidth;	// minwidth
@property NSString *charclass;	// charclass.

- (NSArray *)children;
- (NSArray *)propGroupArray;
- (NSArray *)noteArray;

@end



#pragma mark - XliffPropElement

@interface XliffPropElement : XliffObject

// Required attributes:
@property NSString *propType;		// prop-type

// Optional attributes:
@property NSString *lang;			// xml:lang

- (NSString *)text;

@end


#pragma mark - XliffPropGroupElement

@interface XliffPropGroupElement : XliffObject

// Optional attributes:
@property NSString *name;	// name

//! child elements which are prop, prop-group
- (NSArray *) propArray;

@end


#pragma mark - XliffTransUnitElement

@interface XliffTransUnitElement : XliffObject

// Required attributes:
@property NSString *Id;	// id

// Optional attributes:
@property NSString *approved;	// approved
@property NSString *translate;	// translate
@property NSString *reformat;	// reformat
@property NSString *xmlSpace;	// xml:space
@property NSString *datatype;	// datatype
@property NSString *ts;			// ts
@property NSString *phaseName;	// phase-name
@property NSString *restype;	// restype
@property NSString *resname;	// resname
@property NSString *extradata;	// extradata
@property NSString *helpId;		// help-id
@property NSString *menu;		// menu
@property NSString *menuOption;	// menu-option
@property NSString *menuName;	// menu-name
@property NSString *coord;		// coord
@property NSString *font;		// font
@property NSString *cssStyle;	// css-style
@property NSString *style;		// style
@property NSString *exstyle;	// exstyle
@property NSString *extype;		// extype
@property NSString *maxbytes;	// maxbytes
@property NSString *minbytes;	// minbytes
@property NSString *sizeUnit;	// size-unit
@property NSString *maxheight;	// maxheight
@property NSString *minheight;	// minheight
@property NSString *maxwidth;	// maxwidth
@property NSString *minwidth;	// minwidth
@property NSString *charclass;	// charclass

- (NSString *)sourceText;
- (XliffSourceElement *)source;

- (NSString *)targetText;
- (void)setTargetText:(NSString *)text;
- (XliffTargetElement *)target;
- (void)setTarget:(XliffTargetElement *)target;

- (NSArray *)noteArray;
- (BOOL)isTranslate;

//! array of XLFPropGroupElement
- (NSArray *)propGroupArray;

@end


#pragma mark - XliffSourceElement
@interface XliffSourceElement : XliffObject
@property (copy) NSString *text;
@end


#pragma mark - XliffTargetElement
@interface XliffTargetElement : XliffObject
@property (copy) NSString *text;
@end

