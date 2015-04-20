//
//  ChatSocketViewController.h
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 4/19/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatSocketViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *socketConnectionButton;
- (IBAction)socketConnectionAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *sendMessageTextField;

@property (weak, nonatomic) IBOutlet UITextView *receiveMessageTextView;

- (IBAction)sendMessageAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *socketStatusLabel;

@end
