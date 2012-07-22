//
//  QTMainViewController.m
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import "QTMainViewController.h"

@interface QTMainViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation QTMainViewController
@synthesize imageView;


#pragma mark - QTStampbookDelegate
- (void)stampbook:(QTStampbookViewController *)stampbook didChooseImage:(UIImage *)image {
    [self.navigationController popToViewController:self animated:YES];
    
    self.imageView.image = image;
}

- (void)stampbookDidCancel:(QTStampbookViewController *)stampbook {
    [self.navigationController popToViewController:self animated:YES];
}


#pragma mark - UIViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *identifier = [segue identifier];
    if ([identifier isEqualToString:kChooseStampSegue]) {
        QTStampbookViewController *controller = [segue destinationViewController];
        controller.delegate = self;
        
        // Create the stamps
        NSMutableArray *stamps = [NSMutableArray arrayWithCapacity:6];
        for (int i = 0; i < 24; i++) {
            [stamps addObject:[[Stamp alloc] initWithType:QTStampTypeHappy imageFilename:@"" isCustom:NO]];
        }
        controller.stamps = stamps;
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
