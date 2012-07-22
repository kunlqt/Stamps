//
//  QTStampbookPageViewController.h
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "QTStampView.h"


@protocol QTStampbookPageDelegate;


@interface QTStampbookPageViewController : UIViewController <QTStampViewDelegate>

// Designated Initializer
- (id)initWithStamps:(NSArray *)stamps;

@property (nonatomic, strong) NSArray *stamps;
@property (nonatomic, weak) id <QTStampbookPageDelegate> delegate;

@end


@protocol QTStampbookPageDelegate <NSObject>
@required
- (void)stampbookPage:(QTStampbookPageViewController *)stampbookPage didSelectStamp:(Stamp *)stamp;

@end
