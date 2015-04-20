//
//  SocketSvc.h
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 4/19/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SocketSvc : NSObject <NSStreamDelegate>

@property (nonatomic, strong) NSString *host;
@property (nonatomic) int port;

- (id) initWithHost:(NSString *)host andPort:(int)port;

- (void) openConnection;

- (void) sendMessage:(NSString *) message;

- (void) closeConnection;

@end

@protocol SocketProtocol <NSObject>

- (void) messageReceived:(NSString *)message;

@end