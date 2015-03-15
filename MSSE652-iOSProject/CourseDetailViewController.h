//
//  CourseDetailViewController.h
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 3/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScisCourse.h"

@interface CourseDetailViewController : UIViewController

@property (nonatomic) ScisCourse *course;

@property (weak, nonatomic) IBOutlet UILabel *courseName;

@property (weak, nonatomic) IBOutlet UILabel *courseId;

@property (weak, nonatomic) IBOutlet UILabel *programName;

@property (weak, nonatomic) IBOutlet UILabel *programId;

@end
