//
//  QTMainViewController.m
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import "QTMainViewController.h"
#import "MGTileMenuController.h"


#define kNumberOfTiles 9


@interface QTMainViewController ()

@property (nonatomic, strong) MGTileMenuController *tileMenu;

- (void)setupGestureRecognizers;

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer;
- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer;

@end

@implementation QTMainViewController
@synthesize tileMenu;


#pragma mark - Gesture Recognizer Handlers
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (tileMenu.isVisible && !CGRectContainsPoint(tileMenu.view.frame, [gestureRecognizer locationInView:self.view])) {
            [tileMenu dismissMenu];
        }
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (!tileMenu.isVisible) {
            if (!tileMenu) {
                tileMenu = [[MGTileMenuController alloc] initWithDelegate:self];
                tileMenu.dismissAfterTileActivated = NO;
            }
            [tileMenu displayMenuCenteredOnPoint:[gestureRecognizer locationInView:self.view] inView:self.view];
        }
    }
}


#pragma mark - MGTileMenuDelegate
- (NSInteger)numberOfTilesInMenu:(MGTileMenuController *)tileMenu {
    return kNumberOfTiles;
}

- (UIImage *)imageForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu {
	return [UIImage imageNamed:@"QuiltIcon"];
}

- (NSString *)labelForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu {
    return nil;
}

- (NSString *)descriptionForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu {
    return nil;
}

- (UIImage *)backgroundImageForTile:(NSInteger)tileNumber inMenu:(MGTileMenuController *)tileMenu {
    return [UIImage imageNamed:@"grey_gradient"];
}

- (void)tileMenu:(MGTileMenuController *)tileMenu didActivateTile:(NSInteger)tileNumber {
    NSLog(@"Tile %d activated", tileNumber);
}


#pragma mark - Setup
- (void)setupGestureRecognizers {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
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
    [self setupGestureRecognizers];
    
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
