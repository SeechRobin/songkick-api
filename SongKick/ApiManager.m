//
//  ApiManager.m
//  SongKick
//
//  Created by Robin Mukanganise on 2015/07/21.
//  Copyright (c) 2015 Seech. All rights reserved.
//
//  This class is used as a network wrapper, all calls to songkick should be made here

#import "ApiManager.h"
#import <AFNetworking/AFNetworking.h>
#import "Artist.h"
//#define SONGKICK_API_URL   (@"http://api.songkick.com/api/3.0/search/artists.json?query=happy&apikey=jhevSy2yQF6HFzmb")

#define SONGKICK_API_URL (@"http://api.songkick.com/api/3.0/search/")
#define API_KEY          (@"jhevSy2yQF6HFzmb")


@interface ApiManager ()
{
    AFHTTPClient    * _httpClient;
   
}

@end

@implementation ApiManager

static ApiManager *sharedInstance = nil;


///Singleton implementation
+ (ApiManager *)sharedInstance {
    if (nil != sharedInstance) {
        return sharedInstance;
    }
    
    static dispatch_once_t lock;        // Lock
    dispatch_once(&lock, ^{
        sharedInstance = [[ApiManager alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    if ((self = [super init]))
    {
        
  
       
        //Create a client
         NSURL *baseURL = [NSURL URLWithString:SONGKICK_API_URL];
         //NSURL *url = [NSURL URLWithString:SONGKICK_API_URL];
        
        _httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"artists.json" relativeToURL:baseURL]];
        NSLog(@"What is it %@", _httpClient.description);
        _httpClient.parameterEncoding = AFJSONParameterEncoding;
        [_httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
      
    }
    
    return self;
}
//http://stackoverflow.com/questions/5210535/passing-data-between-view-controllers


-(void)searchForArtist:(NSString *)searchString completion: (void (^)(NSArray *))completion
{
    
    NSDictionary *payload =
    @{
      @"query" : searchString,
    };
    
    [self fetchMethod:@"artist" withPayload:payload success:
     ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) { //Successfull callback
         
         NSMutableArray * artists = [[NSMutableArray alloc]init];
         
         //Parse json using mantle
         for (NSDictionary * artistJson in [[JSON objectForKey:@"artists"] objectForKey:@"artist"]) {
             Artist * artists_k = [[Artist alloc]initWithExternalRepresentation:artistJson];
             
             [artists addObject:artists_k];
         }
         
         //Run completion block with array of photos
         completion(artists);
         
         
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) { //Request failed
         
         completion(nil);
     }];
}

- (void)fetchMethod:(NSString *)method
        withPayload:(NSDictionary *)payload
            success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
            failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON))failure
{
    NSMutableDictionary * fullPayload = [[NSMutableDictionary alloc]initWithDictionary:payload];
    [fullPayload setObject:API_KEY forKey:@"apikey"];
   

    NSMutableURLRequest     *urlRequest = [_httpClient requestWithMethod:@"GET" path:@"" parameters:fullPayload];
    AFJSONRequestOperation  *operation;
    
    operation = [AFJSONRequestOperation
                 JSONRequestOperationWithRequest:urlRequest
                 success:^ (NSURLRequest *request, NSHTTPURLResponse *response, id JSONResponse) //Success callback
                 {
                     if (success)
                     {
                         success(request, response, JSONResponse);
                     }
                     
                 }
                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
                 {
                     NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
                     
                     if (failure)
                     {
                         failure(request, response, error, JSON);
                     }
                 }];
    [operation start];
}

@end
