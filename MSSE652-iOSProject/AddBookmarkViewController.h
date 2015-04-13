//
//  AddBookmarkViewController.h
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 4/12/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCloudBookmarkTableViewController.h"

@interface AddBookmarkViewController : UIViewController

@property (weak, nonatomic) iCloudBookmarkTableViewController *iCloudController;
@property (weak, nonatomic) IBOutlet UITextField *NameTextField;
@property (weak, nonatomic) IBOutlet UITextField *UrlTextField;

- (IBAction)SaveBookmark:(id)sender;

@end
