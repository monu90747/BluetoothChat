//
//  Bubble.h
//  ChattingBox
//
//  Created by Monu Rathor on 14/02/13.
//  Copyright (c) 2013 HWS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Bubble : UIView
{
    UITextView *chatTextView;
    UIImageView *bubbleImageView,*userImageView;
}

@property (nonatomic, retain) UITextView *chatTextView;
@property (nonatomic, retain) UIImageView *bubbleImageView,*userImageView;
- (id)initWithTextMessage:(NSString *)message isRecieved:(BOOL)recieved UserImage:(UIImage *)image;
- (UIImageView *)initBubbleImageView:(CGRect)frame isRecieved:(BOOL)recieved;
@end
