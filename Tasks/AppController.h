//
//  AppController.h
//  Tasks
//
//  Created by Alagu on 12/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	/* Our outlets which allow us to access the interface */
	IBOutlet NSMenu *statusMenu;
	
	/* The other stuff :P */
	NSStatusItem *statusItem;
	NSImage *statusImage;
	NSImage *statusHighlightImage;
	NSMenuItem *menuItem;
	
	NSMutableDictionary * _userPrefs;
}

- (NSString *) pathForDataFile;
- (void) saveDataToDisk;
- (void) loadDataFromDisk;
- (void) setUserPref:(NSMutableDictionary *)newUserPref;
- (IBAction)toggleTaskState:(id)sender;
- (IBAction)clearCompleted:(id)sender;
- (IBAction)setPreferences:(id)sender;


@end
