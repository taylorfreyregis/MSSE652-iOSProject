//
//  AddBookmarkViewController.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 4/12/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "AddBookmarkViewController.h"

@interface AddBookmarkViewController ()

@end

@implementation AddBookmarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)SaveBookmark:(id)sender {
    NSString *name = self.NameTextField.text;
    NSString *url = self.UrlTextField.text;
    
    NSDictionary *bookmark = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"name", url, @"url", nil];
    
    [self.iCloudController saveBookmark:bookmark];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
