//
//  QTStampbookViewController.h
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTStampbookPageViewController.h"


@protocol QTStampbookDelegate;


@interface QTStampbookViewController : UIViewController <QTStampbookPageDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate>

// Client will provide a list of stamps
@property (nonatomic, strong) NSArray *stamps;
@property (nonatomic, weak) id <QTStampbookDelegate> delegate;

@end


@protocol QTStampbookDelegate <NSObject>
@required
- (void)stampbook:(QTStampbookViewController *)stampbook didChooseImage:(UIImage *)image;
- (void)stampbookDidCancel:(QTStampbookViewController *)stampbook;

@end
