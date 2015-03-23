//
//  SCISProgramTableViewController.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 3/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "SCISProgramTableViewController.h"
#import "Constants.h"
#import "ScisProgram.h"
#import "WebServices.h"

@implementation SCISProgramTableViewController

NSMutableData *responseData;


NSMutableArray *programs;

NSXMLParser *xmlParser;

NSString *currentElement;
int currentIdent;
NSString *currentName;

ScisProgram *currentProgram;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (programs == nil) {
        programs = [[NSMutableArray alloc] init];
    }
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return programs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScisProgramCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    
    cell.textLabel.text = ((ScisProgram *)[programs objectAtIndex:indexPath.row]).name;
    
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
    
    [WebServices getProgramsWithCompletion:^(NSArray *jsonArray) {
        
        [programs removeAllObjects];
        
        for (int i = 0; i <jsonArray.count; i++) {
//            NSString *item = jsonArray[i];
//            NSLog(@"item: %@", item);
            
            NSDictionary *programDict = jsonArray[i];
            ScisProgram *program = [[ScisProgram alloc]init];
            for (id key in programDict) {
                id value = [programDict objectForKey:key];
//                NSLog(@"key: %@, value: %@", key, value);
                if ([key isEqualToString:IDENT]) {
                    program.ident = [value intValue];
                } else if ([key isEqualToString:NAME]) {
                    program.name = value;
                }
            }
            [programs addObject:program];
        }
        
        [self.tableView reloadData];
        
    } andFailure:^(NSError *error) {
        NSLog(@"There was an error getting programs: %@", error);
    }];
    
//
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", WebServiceDomain, WebServicePath, @"regis2.program"]];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    
//    [request setHTTPMethod:@"GET"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
//    [[NSURLConnection alloc] initWithRequest:request delegate:self];
     
}

//XML Version
//-(void) getScisPrograms {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSError *error = nil;
//        
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", WebServiceDomain, WebServicePath, @"regis2.program"]];
//        
//        /*
//        // Needs a few delegates implemented, but appears to be a way to specific Accept type in JSON 
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
//        [request setHTTPMethod:@"GET"];
//        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        
//        NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
//        
//        [connection start];
//        
//        if(connection){
//            data = [[NSMutableData alloc] init];
//        }
//        */
//       
//        // Works, but cannot use for parsing JSON. Returns XML and there appears to be no way to set the HTTPHeaders.
////        NSString *response = [NSString stringWithContentsOfURL:url
////                                                      encoding:NSASCIIStringEncoding
////                                                         error:&error];
//        
////        if (!error) {
////            NSLog(@"Response: %@", response);
////        } else {
////            NSLog(@"Error: %@", error);
////        }
//        
//        xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
//        [xmlParser setDelegate:self];
//        
//        [xmlParser parse];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [self.tableView reloadData];
//        });
//    });
//}

#pragma mark - NSURLConnectionDelegate / NSURLConnectionDataDelegate
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    responseData = [[NSMutableData alloc] init];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection {
//    NSString *response = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
//    NSLog(@"JSON Response: %@", response); // only for loggingr
    
    [programs removeAllObjects];
    
    NSError *error = nil;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:responseData
                                                     options:kNilOptions
                                                       error:&error];
    
    for (int i = 0; i <array.count; i++) {
//        NSString *item = array[i];
//        NSLog(@"item: %@", item);
        
        NSDictionary *programDict = array[i];
        ScisProgram *program = [[ScisProgram alloc]init];
        for (id key in programDict) {
            id value = [programDict objectForKey:key];
//            NSLog(@"key: %@, value: %@", key, value);
            if ([key isEqualToString:IDENT]) {
                program.ident = [value intValue];
            } else if ([key isEqualToString:NAME]) {
                program.name = value;
            }
        }
        [programs addObject:program];
    }
    
    [self.tableView reloadData];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"NSURLConnection Error: %@", error);
}


//#pragma mark - NSXMLParserDelegate
//
//-(void) parserDidStartDocument:(NSXMLParser *)parser {
//    [programs removeAllObjects];
//}
//
//-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
//    if ([elementName isEqualToString:PROGRAM]) {
//        currentProgram = [[ScisProgram alloc] init];
//    }
//    
//    currentElement = [[NSString alloc] initWithString:elementName];
//}
//
//-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
//    if ([elementName isEqualToString:PROGRAM]) {
//        
//        [programs addObject:currentProgram];
//    }
//    else if ([elementName isEqualToString:IDENT]){
//        
//        currentProgram.ident = currentIdent;
//    }
//    else if ([elementName isEqualToString:NAME]){
//        
//        currentProgram.name = [[NSString alloc] initWithString:currentName];
//    }
//}
//
//-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
//    // Store the found characters if only we're interested in the current element.
//    if ([currentElement isEqualToString:IDENT]) {
//        currentIdent = [string intValue];
//    } else if ([currentElement isEqualToString:NAME]) {
//        currentName = string;
//    }
//}
//
//-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
//    NSLog(@"XML Parsing Error: %@", parseError);
//}
@end
