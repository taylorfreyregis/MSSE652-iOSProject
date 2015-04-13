//
//  iCloudBookmarkTableViewController.h
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 4/12/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iCloudBookmarkTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *bookmarks;

-(void) saveBookmark:(NSDictionary *) bookmark;

@end
