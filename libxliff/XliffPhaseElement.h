//
//  XliffPhaseElement.h
//  libxliff
//
//  Created by Eirny on 1/14/16.
//  Copyright © 2016 Yet Reader Forge. All rights reserved.
//

#ifndef XliffPhaseElement_h
#define XliffPhaseElement_h

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

#endif /* XliffPhaseElement_h */
