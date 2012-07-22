//
//  QTNewStampOverlayView.m
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import "QTNewStampOverlayView.h"


@interface QTNewStampOverlayView ()

@property (nonatomic, weak) IBOutlet UILabel *promptLabel;
@property (nonatomic, weak) IBOutlet UILabel *countdownLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger secondsLeft;

- (IBAction)cancel:(id)sender;

- (void)startCountdown;
- (void)stopCountdown;
- (void)timerFired:(NSTimer *)timer;

@end


@implementation QTNewStampOverlayView
@synthesize type;
@synthesize promptLabel;
@synthesize countdownLabel;
@synthesize timer;
@synthesize secondsLeft;


#pragma mark - Actions
- (IBAction)cancel:(id)sender {
    [self stopCountdown];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserCancelledNewStampPicture" object:nil];
}


#pragma mark - Countdown
- (void)startCountdown {
    self.secondsLeft = 3;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFired:) userInfo:nil repeats:NO];
}

- (void)stopCountdown {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerFired:(NSTimer *)timer {
    if (self.secondsLeft < 0) {
        [self stopCountdown];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NewStampTakePicture" object:nil];
    } else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFired:) userInfo:nil repeats:NO];
    }
    
    self.countdownLabel.text = [NSString stringWithFormat:@"%d", self.secondsLeft];
    self.secondsLeft--;
}


#pragma mark - Object Lifecycle
- (id)init {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    self = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    if (self) {
        id weakSelf = self;
        [[NSNotificationCenter defaultCenter] addObserverForName:@"NewStampStartPictureCountdown" object:nil queue:nil usingBlock:^(NSNotification *note) {
            [self startCountdown];
            [[NSNotificationCenter defaultCenter] removeObserver:weakSelf name:@"NewStampStartPictureCountdown" object:nil];
        }];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    return [self init];
}

- (void)dealloc {
    [self stopCountdown];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
