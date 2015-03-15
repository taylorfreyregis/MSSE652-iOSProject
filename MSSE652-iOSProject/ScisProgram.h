//
//  ScisProgram.h
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 3/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScisProgram : NSObject

@property (nonatomic) int ident;
@property (nonatomic) NSString *name;

-(instancetype) initWithId:(int) ident andName:(NSString *) name;

@end
