//
//  ScisProgram.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 3/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "ScisProgram.h"

@implementation ScisProgram

-(instancetype) initWithId:(int) ident andName:(NSString *) name {
    self = [super init];
    if (self) {
        _ident = ident;
        _name = name;
    }
    return self;
}

@end
