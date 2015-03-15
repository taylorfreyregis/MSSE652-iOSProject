//
//  SCISProgramTableViewController.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 3/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "SCISProgramTableViewController.h"
#import "Constants.h"

@interface SCISProgramTableViewController ()

@end

@implementation SCISProgramTableViewController

NSMutableArray *programs;
NSXMLParser *xmlParser;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getScisPrograms];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Web Service

-(void) getScisPrograms {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", WebServiceDomain, WebServicePath, @"regis2.program"]];
        
        /*
        // Needs a few delegates implemented, but appears to be a way to specific Accept type in JSON 
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        
        [connection start];
        
        if(connection){
            data = [[NSMutableData alloc] init];
        }
        */
       
        // Works, but cannot use for parsing JSON. Returns XML and there appears to be no way to set the HTTPHeaders.
//        NSString *response = [NSString stringWithContentsOfURL:url
//                                                      encoding:NSASCIIStringEncoding
//                                                         error:&error];
        
//        if (!error) {
//            NSLog(@"Response: %@", response);
//        } else {
//            NSLog(@"Error: %@", error);
//        }
        
        xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        [xmlParser setDelegate:self];
        
    });
}


#pragma mark - NSXMLParserDelegate

-(void) parserDidStartDocument:(NSXMLParser *)parser {
    programs = [[NSMutableArray alloc] init];
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
    [self.tableView reloadData];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:<#(NSString *)#>])
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"XML Parsing Error: %@", parseError);
}
@end
