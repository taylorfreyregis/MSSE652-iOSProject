//
//  WebSocketViewController.h
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 4/26/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SRWebSocket.h>

@interface WebSocketViewController : UIViewController <SRWebSocketDelegate>

- (IBAction)ConnectionAction:(id)sender;
- (IBAction)SendMessageAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *ConnectionButton;

@property (weak, nonatomic) IBOutlet UITextField *WSMessageTextField;

@property (weak, nonatomic) IBOutlet UITextView *WSResponseTextView;

@end
