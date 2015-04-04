//
//  WebServices.m
//  MSSE652-iOSProject
//
//  Created by Taylor Frey on 3/15/15.
//  Copyright (c) 2015 Taylor Frey. All rights reserved.
//

#import "WebServices.h"
#import "Constants.h"
#import "AFNetworking.h"

@implementation WebServices

+(void)getProgramsWithCompletion:(void(^)(NSArray *jsonArray))completionBlock andFailure:(void(^)(NSError *error))failureBlock {
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WebServiceDomain, WebServicePath]];
    
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
//    
//    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
//    [[AFJSONRequestSerializer serializer] setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [[AFJSONRequestSerializer serializer] setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    
//    [manager setResponseSerializer:[AFXMLParserResponseSerializer serializer]];
//    
//    [manager GET:@"regis2.program/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        XmlUtils *xmlUtil = [[XmlUtils alloc] init];
//        
//        if ([responseObject isKindOfClass:[NSXMLParser class]]) {
//            [((NSXMLParser *)responseObject) setDelegate:xmlUtil];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"AFHTTPRequestOperation %@", operation);
//        NSLog(@"Error %@", error);
//    }];
//    

    
    //NO LONGER WORKING BECAUSE OF RESTKIT
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", WebServiceDomain, WebServicePath, @"regis2.program/"]];
////    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
//    [request setHTTPMethod:@"GET"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        if ([responseObject isKindOfClass:[NSArray class]]) {
//            
//            completionBlock((NSArray *)responseObject);
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//    }];
//    
//    [operation start];
    
}

+(void)getCoursesWithCompletion:(void(^)(NSXMLParser *responseXmlParser))completionBlock andFailure:(void(^)(NSError *error))failureBlock {

    
    
    //NO LONGER WORKING BECAUSE OF RESTKIT
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@", WebServiceDomain, WebServicePath, @"regis2.course/"]];
//    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
//    [request setHTTPMethod:@"GET"];
//    [request addValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"application/xml" forHTTPHeaderField:@"Accept"];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        if ([responseObject isKindOfClass:[NSXMLParser class]]) {
//            
//            completionBlock((NSXMLParser *)responseObject);
//        }
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//    }];
//    
//    [operation start];
}


@end
