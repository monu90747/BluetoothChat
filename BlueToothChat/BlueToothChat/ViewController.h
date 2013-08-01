//
//  ViewController.h
//  BlueToothChat
//
//  Created by Vijay  Yadav on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatView.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImagePickerController *picker;
}
- (IBAction)buttonChat:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *txtUserName;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)clickSetImage:(id)sender;

@end
