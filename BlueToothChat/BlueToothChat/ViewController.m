//
//  ViewController.m
//  BlueToothChat
//
//  Created by Vijay  Yadav on 19/02/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize txtUserName;
@synthesize imageView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setTxtUserName:nil];
    [self setImageView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonChat:(id)sender {
    [[UserProfile sharedUser] initUser:txtUserName.text Image:[UIImage imageNamed:@"25X25.png"]];
    ChatView *chat = [[ChatView alloc]init];
    [self.navigationController pushViewController:chat animated:YES];
    [chat release];
    
}
- (void)dealloc {
    [txtUserName release];
    [imageView release];
    [super dealloc];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"image picked");
    [[UserProfile sharedUser] setUserImage:imageView.image];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)clickSetImage:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
    }
    else{
        NSLog(@"Photo Library not present");
    }
}
@end
