//
//  QTStampbookViewController.h
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTStampbookViewController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

// User will provide a list of stamps
@property (nonatomic, strong) NSArray *stamps;

@end
