//
//  UserProfile.h
//  BlueToothChat
//
//  Created by Vijay  Yadav on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfile : NSObject
{
    NSString *userName;
    UIImage *userImage;
}
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) UIImage *userImage;
+ (UserProfile*)sharedUser;
- (void)initUser:(NSString *)uname Image:(UIImage *)image;

@end
