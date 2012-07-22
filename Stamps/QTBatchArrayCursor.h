//
//  QTBatchArrayCursor.h
//  Quilt
//
//  Created by Daniel Byon on 4/12/12.
//  Copyright (c) 2012 Nerd Swagger Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    QTBatchArraySizeStamps = 6,
    QTBatchArraySizeSmall = 10,
    QTBatchArraySizeMedium = 25,
    QTBatchArraySizeLarge = 50,
    QTBatchArraySizeExtraLarge = 100
} QTBatchArraySize;


@interface QTBatchArrayCursor : NSObject {
    @private
    __strong NSArray *array_;
    NSUInteger batchSize_;
    NSUInteger currentIndex_;
    NSUInteger maxIndex_;
}

// Designated Initializer
- (id)initWithArray:(NSArray *)array batchSize:(QTBatchArraySize)size;

- (NSArray *)nextBatch;
- (BOOL)hasNextBatch;
- (void)reset;

@end
