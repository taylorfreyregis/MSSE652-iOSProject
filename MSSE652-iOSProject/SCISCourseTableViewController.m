//
//  SCISCourseTableViewController.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 3/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "SCISCourseTableViewController.h"
#import "ScisCourse.h"
#import "Constants.h"
#import "CourseDetailViewController.h"

@implementation SCISCourseTableViewController

NSMutableArray *courses;

NSXMLParser *xmlParser;

NSString *currentElement;
int currentIdent;
NSString *currentName;

ScisCourse *currentCourse;
ScisProgram *currentProgram;

ScisCourse *selectedCourse;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (courses == nil) {
        courses = [[NSMutableArray alloc] init];
    }
    
    [self getScisCourses];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return courses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScisCourseCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = ((ScisCourse *)[courses objectAtIndex:indexPath.row]).name;
    cell.detailTextLabel.text = ((ScisProgram *)((ScisCourse *)[courses objectAtIndex:indexPath.row]).program).name;
    
    return cell;
}

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

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if ([segue.identifier isEqualToString:@"CourseDetailSegue"]){
         CourseDetailViewController *destination = segue.destinationViewController;
         NSIndexPath *path = [self.tableView indexPathForSelectedRow];
         destination.course = [courses objectAtIndex:path.row];
     }
 }

#pragma mark - Web Service

-(void) getScisCourses {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", WebServiceDomain, WebServicePath, @"regis2.course"]];
        
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
        
        [xmlParser parse];
    });
}

#pragma mark - NSXMLParserDelegate

-(void) parserDidStartDocument:(NSXMLParser *)parser {
    [courses removeAllObjects];
    currentCourse = nil;
    currentProgram = nil;
}

-(void) parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"something %@", courses);
    [self.tableView reloadData];
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:COURSE]) {
        currentCourse = [[ScisCourse alloc] init];
    } else if ([elementName isEqualToString:PROGRAM_IDENT]) {
        currentProgram = [[ScisProgram alloc] init];
    }
    
    currentElement = [[NSString alloc] initWithString:elementName];
}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:COURSE]) {
        
        [courses addObject:currentCourse];
        currentCourse = nil;
        
    } else if ([elementName isEqualToString:IDENT]){
        
        if (currentProgram != nil) {
            currentProgram.ident = currentIdent;
        } else {
            currentCourse.ident = currentIdent;
        }
        
    } else if ([elementName isEqualToString:NAME]){
        
        if (currentProgram != nil) {
            currentProgram.name = [[NSString alloc] initWithString:currentName];
        } else {
            currentCourse.name = [[NSString alloc] initWithString:currentName];
        }
        
    } else if ([elementName isEqualToString:PROGRAM_IDENT]) {
        currentCourse.program = currentProgram;
        currentProgram = nil;
    }
    
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // Store the found characters if only we're interested in the current element.
    if ([currentElement isEqualToString:IDENT]) {
        currentIdent = [string intValue];
    } else if ([currentElement isEqualToString:NAME]) {
        currentName = string;
    }
}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"XML Parsing Error: %@", parseError);
}

@end
