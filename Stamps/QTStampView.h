//
//  QTStampView.h
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stamp.h"


@protocol QTStampViewDelegate;


@interface QTStampView : UIView

@property (nonatomic, strong) Stamp *stamp;
@property (nonatomic, weak) id <QTStampViewDelegate> delegate;

- (id)initWithStamp:(Stamp *)stamp;

@end


@protocol QTStampViewDelegate <NSObject>
@required
- (void)stampViewDidReceiveTap:(QTStampView *)stampView;

@optional
- (void)stampViewDidReceiveLongPress:(QTStampView *)stampView;

@end
