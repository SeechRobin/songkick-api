//
//  Artist.m
//  SongKick
//
//  Created by Robin Mukanganise on 2015/07/21.
//  Copyright (c) 2015 Seech. All rights reserved.
//

#import "Artist.h"

@implementation Artist

+ (NSDictionary *)externalRepresentationKeyPathsByPropertyKey
{
    //Mapping used by mantle
    NSDictionary * dict =  @{
                             @"uri"             : @"uri",
                             @"displayName"     : @"displayName",
                             @"artistId"              : @"id",
                             @"onTourUntil"     : @"onTourUntil",
                             };
    
    return dict;
}
@end
