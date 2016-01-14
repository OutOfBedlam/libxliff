//
//  XliffGroupElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

#ifndef XliffGroupElement_h
#define XliffGroupElement_h

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


#endif /* XliffGroupElement_h */
