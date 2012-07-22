//
//  QTBatchArrayCursor.m
//  Quilt
//
//  Created by Daniel Byon on 4/12/12.
//  Copyright (c) 2012 Nerd Swagger Inc. All rights reserved.
//

#import "QTBatchArrayCursor.h"


@interface QTBatchArrayCursor ()

@property (nonatomic, strong) NSArray *array;

@end


@implementation QTBatchArrayCursor {
    
}
@synthesize array = array_;


#pragma mark - Designated Initializer
- (id)initWithArray:(NSArray *)array batchSize:(QTBatchArraySize)batchSize {
    self = [super init];
    if (self) {
        if ([array count] == 0) {
            self = nil;
            return nil;
        }
        
        self.array = array;
        batchSize_ = batchSize;
        currentIndex_ = 0;
        maxIndex_ = [array count] - 1;
    }
    return self;
}


#pragma mark - Public Methods
- (NSArray *)nextBatch {
    NSRange range;
    if (currentIndex_ > maxIndex_) {
        // should never get here, hasNextBatch shouldn't allow it
        return nil;
    } else if ([self.array count] - currentIndex_ <= batchSize_) {
        // number of remaining items in array are smaller than batch size
        int count = [self.array count] - currentIndex_;
        range = NSMakeRange(currentIndex_, count);
        
        // reached the end of the array, set currentIndex_ to invalid value, so hasNextBatch returns NO
        currentIndex_ = -1;
    } else {
        // enough items in array to return a full batch
        range = NSMakeRange(currentIndex_, batchSize_);
        currentIndex_ += batchSize_;
    }
    return [self.array subarrayWithRange:range];
}

- (BOOL)hasNextBatch {
    return currentIndex_ != -1;
}

- (void)reset {
    currentIndex_ = 0;
}


@end
