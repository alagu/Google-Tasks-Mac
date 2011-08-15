//
//  AppController.m
//  Tasks
//
//  Created by Alagu on 12/05/11.
//  Copyright 2011. All rights reserved.
//

#import "AppController.h"
#import "SBJson.h"


@implementation AppController

- (void) awakeFromNib{
	
	//Create the NSStatusBar and set its length
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
	
	//Used to detect where our files are
	NSBundle *bundle = [NSBundle mainBundle];
	
	//Allocates and loads the images into the application which will be used for our NSStatusItem
	statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon" ofType:@"png"]];
	statusHighlightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"icon" ofType:@"png"]];
	
	//Sets the images in our NSStatusItem
	[statusItem setImage:statusImage];
	[statusItem setAlternateImage:statusHighlightImage];
	
	//Tells the NSStatusItem what menu to load
	[statusItem setMenu:statusMenu];
	
	//Sets the tooptip for our item
	[statusItem setToolTip:@"Google Tasks for Mac"];
	//Enables highlighting
	[statusItem setHighlightMode:YES];

	NSUInteger index = 10;
	
	NSString *taskURL = @"https://www.googleapis.com/tasks/v1/lists/MTUzNjI2MjQ0OTYzNTc0OTE0Mjk6MDow/tasks?access_token=<configure_from_oauth>";
	
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:taskURL]];
	NSURLResponse *resp = nil;
	NSError *err = nil;
	NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
	NSString * tasksString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]; 
	
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	
	NSDictionary *responseObj = [parser objectWithString:tasksString];
	
	
	NSArray *tasks = [responseObj objectForKey:@"items"];
	
	while (index && FALSE) {
		NSMenuItem *soM = [[NSMenuItem alloc] initWithTitle:@"Hello" action:@selector(helloWorld:) keyEquivalent:@""];
		[statusMenu addItem:soM];
		[soM setTarget:self];
		[soM setEnabled:NO];
		[soM setState:NO];
		index--;
	}
	
	for (NSDictionary *task in tasks)
	{
		NSString *parent = [task objectForKey:@"parent"];
		
		if (parent == NULL)
		{
			NSMenuItem *soM = [[NSMenuItem alloc] initWithTitle:[task objectForKey:@"title"] action:@selector(helloWorld:) keyEquivalent:@""];
			[statusMenu addItem:soM];
			[soM setTarget:self];
			[soM setEnabled:NO];
			[soM setState:NO];
		}
	}
	
}

- (void) dealloc {
	//Releases the 2 images we loaded into memory
	[statusImage release];
	[statusHighlightImage release];
	[super dealloc];
}

-(IBAction)helloWorld:(id)sender{
	NSLog(@"Hello there!");
}
@end
