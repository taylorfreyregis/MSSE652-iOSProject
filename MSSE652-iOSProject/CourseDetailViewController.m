//
//  CourseDetailViewController.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 3/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "CourseDetailViewController.h"

@implementation CourseDetailViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.courseName.text = self.course.name;
    self.courseId.text = [NSString stringWithFormat:@"%d", self.course.ident];
    self.programName.text = self.course.program.name;
    self.programId.text = [NSString stringWithFormat:@"%d", self.course.program.ident];
}

@end
