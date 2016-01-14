//
//  XliffToolElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

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

