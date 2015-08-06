//
//  ApiManager.h
//  SongKick
//
//  Created by Robin Mukanganise on 2015/07/21.
//  Copyright (c) 2015 Seech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiManager : NSObject

+ (id)sharedInstance;
-(void)searchForArtist:(NSString *)searchString completion: (void (^)(NSArray *))completion;


@end
