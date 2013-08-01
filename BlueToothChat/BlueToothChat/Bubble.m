//
//  Bubble.m
//  ChattingBox
//
//  Created by Monu Rathor on 14/02/13.
//  Copyright (c) 2013 HWS. All rights reserved.
//

#import "Bubble.h"

#define minBubbleSize 30.0f
#define maxBubbleSize 190.0f
@implementation Bubble
@synthesize chatTextView,bubbleImageView,userImageView;

- (id)initWithTextMessage:(NSString *)message isRecieved:(BOOL)recieved UserImage:(UIImage *)image{
    if (self == [super init]) {
        if([message isEqualToString:@""]){
            message = @" ";
        }
        chatTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, maxBubbleSize, 0)];
        chatTextView.editable = NO;
        chatTextView.scrollEnabled = NO;
        chatTextView.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:15];
        chatTextView.backgroundColor = [UIColor clearColor];
        chatTextView.text = message;   
        
        bubbleImageView = [self initBubbleImageView:CGRectMake(chatTextView.frame.origin.x - 5,chatTextView.frame.origin.y, 0, 0) isRecieved:recieved];
        
        userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2, 0, 40, 40)];
        userImageView.image = image;
        
        [self addSubview:userImageView];
        [self addSubview:bubbleImageView];
        [self addSubview:chatTextView];
        
        CGSize size = [message sizeWithFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:15]];

        if (size.width > chatTextView.frame.size.width) 
            size.width = chatTextView.frame.size.width;
        else if (size.width < minBubbleSize)
            size.width = minBubbleSize;
        
        if(recieved == YES){
            chatTextView.frame = CGRectMake(320-(size.width+18)-55, 0, size.width+18, chatTextView.contentSize.height+12);
            bubbleImageView.frame = CGRectMake(chatTextView.frame.origin.x-15 ,chatTextView.frame.origin.y, chatTextView.frame.size.width + 30,chatTextView.frame.size.height-5);
            userImageView.frame = CGRectMake(280, bubbleImageView.frame.size.height-47, 40, 40);
        }
        else{
            chatTextView.frame = CGRectMake(65, 0, size.width+18, chatTextView.contentSize.height+12);
            bubbleImageView.frame = CGRectMake(chatTextView.frame.origin.x-25 ,chatTextView.frame.origin.y, chatTextView.frame.size.width + 30,chatTextView.frame.size.height-5);
            userImageView.frame = CGRectMake(2, bubbleImageView.frame.size.height-47, 40, 40);
        }
        
        [self setFrame:CGRectMake(0, 0, bubbleImageView.frame.size.width, bubbleImageView.frame.size.height)];
        [chatTextView release];
        [bubbleImageView release];
    }
    return self;
}

- (UIImageView *)initBubbleImageView:(CGRect)frame isRecieved:(BOOL)recieved {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [imageView setBackgroundColor:[UIColor clearColor]];
    UIImage *balloon = nil;
    
    switch (recieved) {
        case NO:{
            balloon = [[UIImage imageNamed:@"chatBubblemageda.png"] stretchableImageWithLeftCapWidth:50 topCapHeight:25];
            imageView.image = balloon;
        }
            break;
        case YES:{
            balloon = [[UIImage imageNamed:@"chatBubbleBlue.png"] stretchableImageWithLeftCapWidth:32 topCapHeight:25];
            imageView.image = balloon;
        }
            break;
        default:
            break;
    }
    return imageView;
}

@end
