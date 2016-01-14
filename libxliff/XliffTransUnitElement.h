//
//  XliffTransUnitElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

@class XliffSourceElement;
@class XliffTargetElement;

#ifndef XliffTransUnitElement_h
#define XliffTransUnitElement_h

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


#endif /* XliffTransUnitElement_h */
