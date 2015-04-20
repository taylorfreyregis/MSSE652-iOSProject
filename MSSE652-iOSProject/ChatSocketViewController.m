//
//  ChatSocketViewController.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 4/19/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "ChatSocketViewController.h"
#import "SocketSvc.h"
#import "Constants.h"

@interface ChatSocketViewController () <SocketProtocol>

@end

@implementation ChatSocketViewController

SocketSvc *service;
bool connection;
NSMutableArray *messages;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    service = [[SocketSvc alloc ]initWithHost:SocketHost andPort:SocketPort];
    [self.socketConnectionButton setTitle:@"Connect" forState:UIControlStateNormal];
    [self.socketStatusLabel setText:@"Connection Currently Closed"];
    connection = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) messageReceived:(NSString *)message {
    [messages addObject:message];
    NSString *string = [messages componentsJoinedByString:@"\n"];
    [self.receiveMessageTextView setText:string];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)socketConnectionAction:(id)sender {
    if (!connection) {
        [service openConnection];
        connection = true;
        [self.socketConnectionButton setTitle:@"Disconnect" forState:UIControlStateNormal];
        [self.socketStatusLabel setText:@"Connection Currently Open"];
    } else {
        [service closeConnection];
        connection = false;
        [self.socketConnectionButton setTitle:@"Connect" forState:UIControlStateNormal];
        [self.socketStatusLabel setText:@"Connection Currently Closed"];
    }
}

- (IBAction)sendMessageAction:(id)sender {
    if (self.sendMessageTextField.text.length > 0) {
        [service sendMessage:self.sendMessageTextField.text];
        self.sendMessageTextField.text = @"";
    }
}


@end
