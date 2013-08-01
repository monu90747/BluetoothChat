//
//  ChatView.m
//  Knuz
//
//  Created by Monu Rathor on 18/02/13.
//  Copyright (c) 2013 HWS. All rights reserved.
//

#import "ChatView.h"

@implementation ChatView

@synthesize bubbleScrollView;
@synthesize imageViewTextAndButton;
@synthesize buttonSend;
@synthesize controlView;
@synthesize textViewMessage;
@synthesize lblUserName;

UIImage *myImage;
UIImage *otherUserImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

BTInterface *btObj;

- (void)setBubbleScrollAnimation{
    CGFloat height;
    CGPoint point;
    if(isKyeboardShow == YES){
        height = 140;
        point = CGPointMake(0, bubbleScrollView.contentSize.height - 150);
    }
    else{
        height = 320;
        point = CGPointMake(0, bubbleScrollView.contentSize.height- self.view.frame.size.height+60);
    }
    if(bubbleScrollView.contentSize.height>=height){
        [UIView beginAnimations:@"newViewId" context:self];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        bubbleScrollView.contentOffset = point;
        [UIView commitAnimations];
    }
}

- (void)frameNormalSize{
    CGFloat originY = controlView.frame.origin.y;
    if(textViewMessage.frame.size.height > 30){
        originY = originY + 10;
    }
    controlView.frame = CGRectMake(0, originY, 320, 50);
    textViewMessage.frame = CGRectMake(12, 10, 232, 30);
    imageViewTextAndButton.frame = CGRectMake(10, 10, 230, 35);
    buttonSend.frame = CGRectMake(250, 12, 60, 30);
    bubbleScrollView.frame = CGRectMake(0, 0, 320, controlView.frame.origin.y-1);
}

- (void)frameBigSize{
    controlView.frame = CGRectMake(0, 140, 320, 60);
    textViewMessage.frame = CGRectMake(12, 10, 230, 40);
    imageViewTextAndButton.frame = CGRectMake(10, 3 , 232, 55);
    buttonSend.frame = CGRectMake(250, 22, 60, 30);
    bubbleScrollView.frame = CGRectMake(0, 0, 320, controlView.frame.origin.y-1);
}

- (void)createBubbleMessage:(NSString *)message DisplayImage:(UIImage *)image IsReceive:(BOOL)receive{
    Bubble *textBubble = [[Bubble alloc] initWithTextMessage:message isRecieved:receive UserImage:[[UserProfile sharedUser] userImage]];
    offsetY = bubbleScrollView.contentSize.height;
    CGRect bubbleFrame = textBubble.frame;
    bubbleFrame.origin = CGPointMake(0, offsetY);
    [bubbleScrollView addSubview:textBubble];
    textBubble.frame = bubbleFrame;
    bubbleScrollView.contentSize = CGSizeMake(320, offsetY+bubbleFrame.size.height+10);
    if(UIKeyboardDidShowNotification){
        [self setBubbleScrollAnimation];
    }
    else{
        [self setBubbleScrollAnimation];
    }
    [self frameNormalSize];
    [textBubble release];
}

- (void)clickSend{
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc]init];
    [dataDictionary setObject:textViewMessage.text forKey:@"message"];
    
    [btObj sendData:textViewMessage.text];
    [self createBubbleMessage:textViewMessage.text DisplayImage:myImage IsReceive:NO];
    textViewMessage.text = @"";
    
}

- (void)keyboardWillShow{
    isKyeboardShow = YES;
    controlView.frame = CGRectMake(0, 200 - controlView.frame.size.height, 320, controlView.frame.size.height);
    bubbleScrollView.frame = CGRectMake(0, 0, 320, controlView.frame.origin.y-1);
    [self setBubbleScrollAnimation];
}

- (void)keyboardWillHide{
    isKyeboardShow = NO;
    controlView.frame = CGRectMake(0, 416-controlView.frame.size.height, 320, controlView.frame.size.height);
    bubbleScrollView.frame = CGRectMake(0, 0, 320, controlView.frame.origin.y-1);
    [self setBubbleScrollAnimation];
}

- (void)textViewDidChange:(UITextView *)textView{
    CGSize textViewSize = [textViewMessage.text sizeWithFont:[UIFont fontWithName:@"Times New Roman" size:18]];
    if(textViewMessage.frame.size.height <= 30){
        if(textViewSize.width >= 210){
            [self frameBigSize];
        }
    }
    else if(textViewSize.width > 30){
        if(textViewSize.width < 210){
            [self frameNormalSize];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)receiveMessage:(NSString *)message{
    NSArray *dataArray = [message componentsSeparatedByString:@" "];
    
    if([[dataArray objectAtIndex:0] isEqualToString:@"name"]){
        [self setTitle:[dataArray objectAtIndex:1]];
    }
    else{
        [self createBubbleMessage:message DisplayImage:myImage IsReceive:YES];
    }
}

- (void)clickClear{
    for(UIView *subView in bubbleScrollView.subviews){
        [subView removeFromSuperview];
    }
    bubbleScrollView.frame = CGRectMake(0, 0, 320, 365);
    bubbleScrollView.contentSize = CGSizeMake(320, 0);
    bubbleScrollView.contentOffset = CGPointMake(320, 0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    buttonClear = [[UIBarButtonItem alloc]initWithTitle:@"Clear Chat" style:UIBarButtonItemStyleBordered target:self action:@selector(clickClear)];
    self.navigationItem.rightBarButtonItem = buttonClear;
    
    btObj = [[BTInterface alloc] init];
    [btObj estblishConnection:[[UserProfile sharedUser] userName]];
    btObj.delegate = self;
    
    //Image loading here.
    myImage = [UIImage imageNamed:@"25X25.png"];
    otherUserImage = [UIImage imageNamed:@"25X25.png"];
    
    controlView = [[UIView alloc] initWithFrame:CGRectMake(0,366, 320, 50)];
    controlView.backgroundColor = [UIColor grayColor];
    
    imageViewTextAndButton = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 232, 35)];
    imageViewTextAndButton.backgroundColor = [UIColor grayColor];
    imageViewTextAndButton.image = [[UIImage imageNamed:@"TEXTFRAME.png"] stretchableImageWithLeftCapWidth:50 topCapHeight:15];
    
    textViewMessage = [[UITextView alloc]initWithFrame:CGRectMake(12, 10, 230, 30)];
    textViewMessage.text = @"";
    textViewMessage.editable = YES;
    textViewMessage.backgroundColor = [UIColor clearColor];
    textViewMessage.font = [UIFont fontWithName:@"Times New Roman" size:18];
    textViewMessage.delegate = self;
    
    buttonSend = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonSend.frame = CGRectMake(250, 12, 60, 30);
    [buttonSend setTitle:@"Sturen" forState:UIControlStateNormal];
    [buttonSend addTarget:self action:@selector(clickSend) forControlEvents:UIControlEventTouchUpInside];
    
    bubbleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 365)];
	bubbleScrollView.contentSize = CGSizeMake(320, 10);
    bubbleScrollView.alwaysBounceVertical = YES;
    bubbleScrollView.delegate = self;
    bubbleScrollView.backgroundColor = [UIColor colorWithRed:(140/255.0) green:(204.0/255.0) blue:(255.0/255.0) alpha:0.2];
	
    [self.view addSubview:bubbleScrollView];
    [controlView addSubview:imageViewTextAndButton];
    [controlView addSubview:buttonSend];
    [controlView addSubview:textViewMessage];
    [self.view addSubview:controlView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidUnload
{
    [self setLblUserName:nil];
    [super viewDidUnload];
    [self setBubbleScrollView:nil];
    [self setImageViewTextAndButton:nil];
    [self setControlView:nil];
    [self setTextViewMessage:nil];
}

- (void)dealloc{
    [lblUserName release];
    [super dealloc];
    [imageViewTextAndButton release];
    [textViewMessage release];
    [controlView release];
    [bubbleScrollView release];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
