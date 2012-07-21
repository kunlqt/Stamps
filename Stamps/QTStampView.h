//
//  QTStampView.h
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stamp.h"


@interface QTStampView : UIView

@property (nonatomic, strong) Stamp *stamp;

- (id)initWithStamp:(Stamp *)stamp;

@end
