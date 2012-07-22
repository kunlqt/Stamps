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
@property (nonatomic, strong) NSMutableArray *stamps;

@end

@implementation QTMainViewController
@synthesize imageView;
@synthesize stamps;


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
        
        if (!controller.stamps) {
            controller.stamps = self.stamps;
        }
    }
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)viewDidLoad {
    self.stamps = [NSMutableArray arrayWithCapacity:12];
    for (int i = 0; i < 12; i++) {
        switch (i) {
            case 0:
                [self.stamps addObject:[[Stamp alloc] initWithType:QTStampTypeSmile imageFilename:@"" isCustom:NO]];
                break;
            case 1:
                [self.stamps addObject:[[Stamp alloc] initWithType:QTStampTypeFrown imageFilename:@"" isCustom:NO]];
                break;
            case 2:
                [self.stamps addObject:[[Stamp alloc] initWithType:QTStampTypeMeh imageFilename:@"" isCustom:NO]];
                break;
            case 3:
                [self.stamps addObject:[[Stamp alloc] initWithType:QTStampTypeShocked imageFilename:@"" isCustom:NO]];
                break;
            case 4:
                [self.stamps addObject:[[Stamp alloc] initWithType:QTStampTypeFlirt imageFilename:@"" isCustom:NO]];
                break;
            case 5:
                [self.stamps addObject:[[Stamp alloc] initWithType:QTStampTypeCustom imageFilename:@"" isCustom:NO]];
                break;
            default:
                [self.stamps addObject:[[Stamp alloc] initWithType:QTStampTypeCustom imageFilename:@"" isCustom:NO]];
        }
        
        
    }
    self.stamps = stamps;
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
