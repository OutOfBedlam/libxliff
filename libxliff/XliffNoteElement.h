//
//  XliffNoteElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

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
@interface XliffNoteElement : XliffTextObject

// optional attributes
@property NSString *lang;	// xml:lang
@property NSString *from;	// from
@property NSString *priority; // priority
@property NSString *annotates; // annotates

@end
