//
//  Stamp.m
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import "Stamp.h"

@implementation Stamp
@synthesize identifier = _identifier;
@synthesize type = _type;
@synthesize imageFilename = _imageFilename;
@synthesize isCustom = _isCustom;


#pragma mark - Stamp Types
NSString * const QTStampTypeHappy = @"Happy";


#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    Stamp *stamp = [[Stamp alloc] initWithType:self.type imageFilename:self.imageFilename isCustom:[self.isCustom boolValue]];
    return stamp;
}


#pragma mark - Object Lifecycle
- (id)initWithType:(NSString *)type imageFilename:(NSString *)imageFilename isCustom:(BOOL)isCustom {
    self = [self init];
    if (self) {
        self.type = type;
        self.imageFilename = imageFilename;
        self.isCustom = [NSNumber numberWithBool:isCustom];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        self.identifier = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
        CFRelease(uuid);
    }
    return self;
}


#pragma mark - Object Equality
- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    Stamp *stamp = (Stamp *)object;
    return [self.identifier isEqual:stamp.identifier];
}


@end
