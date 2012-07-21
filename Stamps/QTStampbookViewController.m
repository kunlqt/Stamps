//
//  QTStampbookViewController.m
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import "QTStampbookViewController.h"
#import "QTStampbookPageViewController.h"
#import "Stamp.h"


@interface QTStampbookViewController ()

@property (nonatomic, strong) NSArray *stampPages;

@end


@implementation QTStampbookViewController
@synthesize stamps = _stamps;
@synthesize stampPages = _stampPages;


#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self.stampPages indexOfObject:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    
    return self.stampPages[index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self.stampPages indexOfObject:viewController];
    if (index == [self.stampPages count] - 1 || index == NSNotFound) {
        return nil;
    }
    
    return self.stampPages[index + 1];
}


#pragma mark - UIViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *identifier = [segue identifier];
    if ([identifier isEqualToString:@""]) {
        
    }
}

- (void)awakeFromNib {
    self.dataSource = self;
    self.delegate = self;
    
    [super awakeFromNib];
}

- (void)viewDidLoad {
    // For purposes of demo, ignore self.stamps and create them manually
    NSMutableArray *pages = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; i < 4; i++) {
        // Create the stamps
        NSMutableArray *stamps = [NSMutableArray arrayWithCapacity:6];
        for (int i = 0; i < 6; i++) {
            [stamps addObject:[[Stamp alloc] initWithType:QTStampTypeHappy imageFilename:@"" isCustom:NO]];
        }
        
        QTStampbookPageViewController *page = [[QTStampbookPageViewController alloc] initWithStamps:stamps];
        [pages addObject:page];
    }
    
    self.stampPages = pages;
    
    [self setViewControllers:@[pages[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationIsPortrait(interfaceOrientation);
    } else {
        return YES;
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
