//
//  ScisCourse.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 3/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "ScisCourse.h"

@implementation ScisCourse

-(instancetype) initWithId:(int) ident andName:(NSString *) name {
    self = [super init];
    if (self) {
        _ident = ident;
        _name = name;
    }
    return self;
}

-(instancetype) initWithId:(int) ident andName:(NSString *) name andProgram:(ScisProgram *)program {
    self = [super init];
    if (self) {
        _ident = ident;
        _name = name;
        _program = program;
    }
    return self;
}

@end
