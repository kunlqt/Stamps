//
//  QTStampbookViewController.m
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import "QTStampbookViewController.h"
#import "Stamp.h"
#import "QTBatchArrayCursor.h"


@interface QTStampbookViewController ()

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) NSArray *stampPages;

- (IBAction)cancelButtonTapped:(id)sender;

@end


@implementation QTStampbookViewController
@synthesize stamps = _stamps;
@synthesize stampPages = _stampPages;


#pragma mark - Actions
- (IBAction)cancelButtonTapped:(id)sender {
    [self.delegate stampbookDidCancel:self];
}


#pragma mark - QTStampbookPageDelegate
- (void)stampbookPage:(QTStampbookPageViewController *)stampbookPage didSelectStamp:(Stamp *)stamp {
    NSLog(@"stamp %d selected", [self.stamps indexOfObject:stamp] + 1);
    
    if ([stamp.hasImage boolValue]) {
        [self.delegate stampbook:self didChooseImage:[UIImage imageNamed:stamp.imageFilename]];
    } else {
        // Show camera flow
    }
}


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

- (void)viewDidLoad {
    NSMutableArray *pages = [NSMutableArray arrayWithCapacity:ceil([self.stamps count] / 6.0f)];
    QTBatchArrayCursor *cursor = [[QTBatchArrayCursor alloc] initWithArray:self.stamps batchSize:QTBatchArraySizeStamps];
    while ([cursor hasNextBatch]) {
        NSArray *batch = [cursor nextBatch];
        
        QTStampbookPageViewController *page = [[QTStampbookPageViewController alloc] initWithStamps:batch];
        page.delegate = self;
        [pages addObject:page];
    }
    
    self.stampPages = pages;
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.view.frame = self.view.bounds;
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    [self.pageController setViewControllers:@[self.stampPages[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:self.pageController.view];
    [self.pageController didMoveToParentViewController:self];
    
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
