//
//  UserPrefs.h
//  Tasks
//
//  Created by Alagu on 18/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface UserPrefs : NSObject <NSCoding> {
    NSMutableDictionary * properties;
}

- (NSMutableDictionary *) properties;
- (void) setProperties: (NSDictionary *)newProperties;

@end
