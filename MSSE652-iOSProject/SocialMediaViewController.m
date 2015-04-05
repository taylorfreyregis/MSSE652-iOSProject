//
//  SocialMediaViewController.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 4/4/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "SocialMediaViewController.h"

@interface SocialMediaViewController ()

@end

@implementation SocialMediaViewController

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
//
- (IBAction)TwitterAction:(id)sender {
    
    // Is Twitter service available?
    if ([SLComposeViewController isAvailableForServiceType: SLServiceTypeTwitter]) {
        
        SLComposeViewController *twitterPostViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [self presentViewController:twitterPostViewController animated:YES completion:nil];
        
    } else {
        // If not, display alert
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Twitter Unavailable"
                                                            message:@"Integrated Twitter Service is unavailable. Please verify the service is enabled and the proper credentials have been used."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (IBAction)FacebookAction:(id)sender {
    
    // Is Facebook service available?
    if ([SLComposeViewController isAvailableForServiceType: SLServiceTypeFacebook]) {
        
        SLComposeViewController *facebookPostViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [self presentViewController:facebookPostViewController animated:YES completion:nil];
        
    } else {
        // If not, display alert
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Facebook Unavailable"
                                                            message:@"Integrated Facebook Service is unavailable. Please verify the service is enabled and the proper credentials have been used."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        
    }
}


@end
