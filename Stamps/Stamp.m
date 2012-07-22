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
@synthesize hasImage = _hasImage;


#pragma mark - Stamp Types
NSString * const QTStampTypeHappy = @"Happy";


#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder {
    NSString *identifier = [aDecoder decodeObjectForKey:@"identifier"];
    NSString *type = [aDecoder decodeObjectForKey:@"type"];
    NSString *imageFilename = [aDecoder decodeObjectForKey:@"imageFilename"];
    NSNumber *isCustom = [aDecoder decodeObjectForKey:@"isCustom"];
    NSNumber *hasImage = [aDecoder decodeObjectForKey:@"hasImage"];
    self = [self initWithType:type imageFilename:imageFilename isCustom:[isCustom boolValue]];
    self.identifier = identifier;
    self.hasImage = hasImage;
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.imageFilename forKey:@"imageFilename"];
    [aCoder encodeObject:self.isCustom forKey:@"isCustom"];
    [aCoder encodeObject:self.hasImage forKey:@"hasImage"];
}


#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    Stamp *stamp = [[Stamp alloc] initWithType:self.type imageFilename:self.imageFilename isCustom:[self.isCustom boolValue]];
    stamp.identifier = self.identifier;
    stamp.hasImage = self.hasImage;
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
    return [self.identifier isEqualToString:stamp.identifier];
}


@end
