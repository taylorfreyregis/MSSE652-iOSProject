//
//  WebSocketViewController.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 4/26/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "WebSocketViewController.h"

@interface WebSocketViewController ()

@end

@implementation WebSocketViewController

SRWebSocket *_websocket;
BOOL isConnected;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.ConnectionButton setTitle:@"Open" forState:UIControlStateNormal];
    isConnected = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Custom Web Socket Communication

- (void) initializeConnection {
    _websocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://www.regisscis.net:80/WebSocketServer/chat"]]];
    [_websocket setDelegate:self];
    
    [_websocket open];
    [self.ConnectionButton setTitle:@"Close" forState:UIControlStateNormal];
    isConnected = true;
}

-(void) destroyConnection {
    [_websocket close];
    _websocket = nil;
    [self.ConnectionButton setTitle:@"Open" forState:UIControlStateNormal];
    isConnected = false;
}

- (IBAction)ConnectionAction:(id)sender {
    if (isConnected) {
        [self destroyConnection];
    } else {
        [self initializeConnection];
    }
}

- (IBAction)SendMessageAction:(id)sender {
    if (self.WSMessageTextField.text.length > 0){
        [_websocket send:self.WSMessageTextField.text];
    }
    [self.WSMessageTextField setText:@""];
}

#pragma mark - SocketRocket implementation

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"Message received: %@", message);
    self.WSResponseTextView.text = [NSString stringWithFormat:@"%@\n%@", self.WSResponseTextView.text, message];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"Connection successful with socket: %@", webSocket);
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"Connection failed with error: %@", error);
    [self destroyConnection];
}

-(void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"Web Socket closed with code: %d for reason: %@", (int)code, reason);
    [self destroyConnection];
}


@end
