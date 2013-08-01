//
//  UserProfile.m
//  BlueToothChat
//
//  Created by Vijay  Yadav on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile
@synthesize userName;
@synthesize userImage;
static UserProfile* _sharedStoreUser;

- (void)initUser:(NSString *)uname Image:(UIImage *)image{
    userName = [[NSString alloc]initWithString:uname];
    userImage = [[UIImage alloc] init];
    userImage = image;
}

+ (id)alloc {
	@synchronized([UserProfile class]) {
		NSAssert(_sharedStoreUser == nil, @"Attempted to allocate a second instance of singleton class MusicPlayers.");
		_sharedStoreUser = [super alloc];
		return _sharedStoreUser;
	}
	return nil;
}

+ (UserProfile*)sharedUser
{
	@synchronized(self) {
		
        if (_sharedStoreUser == nil) {
            [[self alloc] init];
        }
    }
    return _sharedStoreUser;
}

- (void)dealloc{
    [super dealloc];
    [userImage release];
    [userName release];
}

@end
