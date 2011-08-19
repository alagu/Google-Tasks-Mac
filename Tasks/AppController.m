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
	
	if (self = [super init])
    {
        _userPrefs = [[NSMutableDictionary alloc] init];
    }
	
	[self loadDataFromDisk];
	[_userPrefs setObject:@"<dummy_access_token>" forKey:@"access_token"];
	[self saveDataToDisk];
	
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

	
	NSString *taskURL = @"https://www.googleapis.com/tasks/v1/lists/MTUzNjI2MjQ0OTYzNTc0OTE0Mjk6MDow/tasks?access_token=<configure_from_oauth>";
	
	NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:taskURL]];
	NSURLResponse *resp = nil;
	NSError *err = nil;
	NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
	NSString * tasksString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]; 
	
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	
	NSDictionary *responseObj = [parser objectWithString:tasksString];
	
	
	NSArray *tasks = [responseObj objectForKey:@"items"];

	
	NSUInteger index = 1;

	for (NSDictionary *task in tasks)
	{
		NSString *parent = [task objectForKey:@"parent"];
		
		if (parent == NULL)
		{
			NSMenuItem *soM = [[NSMenuItem alloc] initWithTitle:[task objectForKey:@"title"] action:@selector(helloWorld:) keyEquivalent:@""];
			[statusMenu addItem:soM];
			index++;
		}
	}
	
}


- (NSMutableDictionary *) userPrefs
{
    return _userPrefs;
}


- (NSString *) pathForDataFile
{
    NSFileManager *fileManager= [NSFileManager defaultManager];
	
    NSString *folder = @"~/Library/Application Support/Google Tasks Mac/";
    folder = [folder stringByExpandingTildeInPath];
    
	if ([fileManager fileExistsAtPath: folder] == NO)
    {
        [fileManager createDirectoryAtPath:folder attributes:nil];
    }
    
    NSString *fileName = @"Google_Tasks_Mac.plist";
    return [folder stringByAppendingPathComponent: fileName];
}


- (void) dealloc {
	//Releases the 2 images we loaded into memory
	[statusImage release];
	[statusHighlightImage release];
	[super dealloc];
}

- (void) saveDataToDisk
{
    NSString * path = [self pathForDataFile];
	
    NSMutableDictionary * rootObject;
    rootObject = [NSMutableDictionary dictionary];
    
    [rootObject setValue:_userPrefs forKey:@"userprefs"];
    [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}

- (void) loadDataFromDisk
{
    NSString     * path         = [self pathForDataFile];
    NSDictionary * rootObject;
    
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    [self setUserPref:[rootObject valueForKey:@"userprefs"]];
}


- (void) setUserPref: (NSMutableDictionary *)newUserPref
{
    if (_userPrefs != newUserPref)
    {
        [_userPrefs autorelease];
        _userPrefs	= [[NSMutableDictionary alloc] initWithDictionary:newUserPref];
    }
}

- (IBAction) helloWorld
{
	NSLog(@"Hello world");
}
@end
