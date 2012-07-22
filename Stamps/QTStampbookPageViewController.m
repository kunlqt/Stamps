//
//  QTStampbookPageViewController.m
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import "QTStampbookPageViewController.h"
#import "Stamp.h"


@interface QTStampbookPageViewController ()

- (void)layoutStampViews;

@end


@implementation QTStampbookPageViewController
@synthesize stamps = _stamps;
@synthesize delegate = _delegate;


#pragma mark - Overridden Setters
- (void)setStamps:(NSArray *)stamps {
    if (_stamps != stamps) {
        _stamps = stamps;
        
        [self layoutStampViews];
    }
}


#pragma mark - QTStampViewDelegate
- (void)stampViewDidReceiveTap:(QTStampView *)stampView {
    [self.delegate stampbookPage:self didSelectStamp:stampView.stamp];
}

- (void)stampViewDidReceiveLongPress:(QTStampView *)stampView {
    NSLog(@"stamp %d received long press", [self.stamps indexOfObject:stampView.stamp]);
}


#pragma mark - View Handling
- (void)layoutStampViews {
    // Clean up old stamp views
    for (UIView *view in [self.view subviews]) {
        [view removeFromSuperview];
    }
    
    if ([self.stamps count] == 0) {
        return;
    }
    
    for (int i = 0; i < [self.stamps count]; i++) {
        Stamp *stamp = self.stamps[i];
        QTStampView *stampView = [[QTStampView alloc] initWithStamp:stamp];
        stampView.delegate = self;
        
        CGRect frame;
        switch (i) {
            case 0: frame = CGRectMake(  0.0f,   0.0f, 160.0f, 139.0f); break;
            case 1: frame = CGRectMake(160.0f,   0.0f, 160.0f, 139.0f); break;
            case 2: frame = CGRectMake(  0.0f, 139.0f, 160.0f, 139.0f); break;
            case 3: frame = CGRectMake(160.0f, 139.0f, 160.0f, 139.0f); break;
            case 4: frame = CGRectMake(  0.0f, 278.0f, 160.0f, 139.0f); break;
            case 5: frame = CGRectMake(160.0f, 278.0f, 160.0f, 139.0f); break;
        }
        stampView.frame = frame;
        
        [self.view addSubview:stampView];
    }
}


#pragma mark - Initialization
- (id)initWithStamps:(NSArray *)stamps {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.stamps = stamps;
    }
    return self;
}

- (id)init {
    return [self initWithStamps:nil];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self init];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self init];
}


#pragma mark - UIViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *identifier = [segue identifier];
    if ([identifier isEqualToString:@""]) {
        
    }
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)viewDidLoad {
    
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
