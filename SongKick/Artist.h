//
//  Artist.h
//  SongKick
//
//  Created by Robin Mukanganise on 2015/07/21.
//  Copyright (c) 2015 Seech. All rights reserved.
//

#import "MTLModel.h"

@interface Artist : MTLModel

@property (strong, nonatomic) NSString * uri;
@property (strong, nonatomic) NSString * displayName;
@property (strong, nonatomic) NSString * artistId;
@property (strong, nonatomic) NSString * onTourUntil;

@end

