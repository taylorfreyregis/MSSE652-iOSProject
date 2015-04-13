//
//  iCloudBookmarkTableViewController.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 4/12/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "iCloudBookmarkTableViewController.h"
#import "AddBookmarkViewController.h"

@interface iCloudBookmarkTableViewController ()

@end

@implementation iCloudBookmarkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateKeyValuePairs:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:store];
    
    // Synchronize Store
    [store synchronize];
    
    // Load Bookmarks
    [self loadBookmarks];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.bookmarks) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.bookmarks) {
        return 0;
    } else {
        return self.bookmarks.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"bookmarkCellId";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Fetch Bookmark
    NSDictionary *bookmark = [self.bookmarks objectAtIndex:indexPath.row];
    
    // Configure Cell
    cell.textLabel.text = [bookmark objectForKey:@"name"];
    cell.detailTextLabel.text = [bookmark objectForKey:@"url"];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Update Bookmarks
        [self.bookmarks removeObjectAtIndex:indexPath.row];
        
        // Save Bookmarks
        [self saveBookmarks];
        
        // Update Table View
        [aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)saveBookmark:(NSDictionary *)bookmark {
    // Add Bookmark To Bookmarks
    [self.bookmarks addObject:bookmark];
    
    // Save Bookmarks
    [self saveBookmarks];
    
    // Reload Table View
    [self.tableView reloadData];
}

- (void)loadBookmarks {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if ([ud objectForKey:@"bookmarks"] != nil) {
        // Load Local Copy
        self.bookmarks = [NSMutableArray arrayWithArray:[ud objectForKey:@"bookmarks"]];
        
    } else {
        // Initialize Bookmarks
        self.bookmarks = [[NSMutableArray alloc] init];
        
        // Save Local Copy
        [ud setObject:self.bookmarks forKey:@"bookmarks"];
    }
}

-(void) saveBookmarks {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:self.bookmarks forKey:@"bookmarks"];
    
    // Save To iCloud
    NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
    
    if (store != nil) {
        [store setObject:self.bookmarks forKey:@"bookmarks"];
        [store synchronize];
    }
}

- (void)updateKeyValuePairs:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSNumber *changeReason = [userInfo objectForKey:NSUbiquitousKeyValueStoreChangeReasonKey];
    NSInteger reason = -1;
    
    // Is a Reason Specified?
    if (!changeReason) {
        return;
        
    } else {
        reason = [changeReason integerValue];
    }
    
    // Proceed If Reason Was (1) Changes on Server or (2) Initial Sync
    if ((reason == NSUbiquitousKeyValueStoreServerChange) || (reason == NSUbiquitousKeyValueStoreInitialSyncChange)) {
        NSArray *changedKeys = [userInfo objectForKey:NSUbiquitousKeyValueStoreChangedKeysKey];
        NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
        
        // Search Keys for "bookmarks" Key
        for (NSString *key in changedKeys) {
            if ([key isEqualToString:@"bookmarks"]) {
                // Update Data Source
                self.bookmarks = [NSMutableArray arrayWithArray:[store objectForKey:key]];
                
                // Save Local Copy
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud setObject:self.bookmarks forKey:@"bookmarks"];
                
                // Reload Table View
                [self.tableView reloadData];
            }
        }
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"addBookmarkSegue"]){
        AddBookmarkViewController *destination = segue.destinationViewController;
        destination.iCloudController = self;
    }
    
}


@end
