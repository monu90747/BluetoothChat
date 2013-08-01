//
//  BTInterface.h
//  BlueToothChat
//
//  Created by Vijay  Yadav on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "ChatView.h"

@interface BTInterface : NSObject<GKSessionDelegate,GKPeerPickerControllerDelegate>{
    GKSession *connectionSession;
    GKPeerPickerController *connectionPicker;
    id delegate;
    NSString *userName;
}
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, assign) id delegate;
@property(nonatomic,retain) GKPeerPickerController *connectionPicker;
@property(retain) GKSession *connectionSession;
-(void)estblishConnection:(NSString *)name;
- (void) sendData:(NSString *)msgData;


@end
