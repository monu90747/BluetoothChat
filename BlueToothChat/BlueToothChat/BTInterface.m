//
//  BTInterface.m
//  BlueToothChat
//
//  Created by Vijay  Yadav on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BTInterface.h"

@implementation BTInterface

@synthesize connectionPicker,connectionSession;
@synthesize delegate,userName;

-(id)init
{
    if (!self) {
        self=[super init];
    }
    return self;
}
-(void)estblishConnection:(NSString *)name{
    self.userName = [[NSString alloc]init];
    self.userName = name;
    connectionPicker=[[GKPeerPickerController alloc] init];
    connectionPicker.delegate=self;
    connectionPicker.connectionTypesMask=GKPeerPickerConnectionTypeNearby;
    [connectionPicker show];
}

- (void)peerPickerController:(GKPeerPickerController *)picker
              didConnectPeer:(NSString *)peerID
                   toSession:(GKSession *) session {
    self.connectionSession = session;
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
    connectionPicker.delegate = nil;
    
    [connectionPicker dismiss];
    [connectionPicker autorelease];
}
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    connectionPicker.delegate = nil;
    [connectionPicker autorelease];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Cancel" message:@"Connection cancelled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release]; 
    
    
}
- (void)session:(GKSession *)session
           peer:(NSString *)peerID
 didChangeState:(GKPeerConnectionState)state {
    switch (state)
    {
        case GKPeerStateConnected:
            NSLog(@"connected self:%@",userName);          
            [self sendData:[NSString stringWithFormat:@"name %@",userName]];
            break;
        case GKPeerStateDisconnected:
            NSLog(@"disconnected");
            [self sendData:@"discunnected"];
            [self.connectionPicker release];
            connectionPicker = nil;
            
            break;
        case GKPeerStateAvailable:
        case GKPeerStateConnecting:
        case GKPeerStateUnavailable:
            break;
    }
}
-(void)sendData:(NSString *)msgData{
    
    NSLog(@"Sending message:%@",msgData);
    
    NSData *data = [msgData dataUsingEncoding:NSASCIIStringEncoding];
    
    if (connectionSession)
        [self.connectionSession sendDataToAllPeers:data
                                      withDataMode:GKSendDataReliable
                                             error:nil];
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context {
    
    //---convert the NSData to NSString---
    NSString* str;
    
    str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    if([delegate isKindOfClass:[ChatView class]])
        [delegate receiveMessage:str];
}

- (void)dealloc
{
    [connectionSession release];
    [connectionPicker release];
    [super dealloc];
}


@end
