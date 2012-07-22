//
//  NSCache+Shared.m
//  Stamps
//
//  Created by Daniel Byon on 7/22/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import "NSCache+Shared.h"

@implementation NSCache (Shared)

+ (NSCache *)shared {
    static NSCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    return cache;
}

@end
