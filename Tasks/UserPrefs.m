//
//  UserPrefs.m
//  Tasks
//
//  Created by Alagu on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserPrefs.h"


@implementation UserPrefs


- (id) init
{
    if (self = [super init])
    {
        properties = [[NSMutableDictionary alloc] initWithDictionary:NULL];
    }
    return self;
}


- (void) dealloc
{
    [properties release];
    [super dealloc];
}

- (void) setProperties: (NSDictionary *)newProperties
{
    if (properties != newProperties)
    {
        [properties autorelease];
        properties = [[NSMutableDictionary alloc] initWithDictionary: newProperties];
    }
}


- (NSMutableDictionary *) properties
{
    return properties;
}

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        [self setProperties: [coder decodeObjectForKey:@"properties"]];
    }
    return self;
}


- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: properties forKey:@"properties"];
}
@end
