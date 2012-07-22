//
//  QTStampView.m
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import "QTStampView.h"


static inline UIImage * RandomColorImage(void) {
    CGRect frame = CGRectMake(0.0f, 0.0f, 3.0f, 3.0f);
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat red = (arc4random() % 256) / 255.0f;
    CGFloat green = (arc4random() % 256) / 255.0f;
    CGFloat blue = (arc4random() % 256) / 255.0f;
    [[UIColor colorWithRed:red green:green blue:blue alpha:1.0f] set];
    
    CGContextFillRect(context, frame);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(1.0f, 1.0f, 1.0f, 1.0f)];
}


@interface QTStampView ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer;
- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer;

- (void)updateViews;

@end


@implementation QTStampView
@synthesize stamp = _stamp;
@synthesize delegate = _delegate;
@synthesize imageView = _imageView;
@synthesize priceLabel = _priceLabel;


#pragma mark - Overridden Setters
- (void)setStamp:(Stamp *)stamp {
    if (_stamp != stamp) {
        _stamp = stamp;
        
        [self updateViews];
    }
}


#pragma mark - Object Lifecycle
- (id)initWithStamp:(Stamp *)stamp {
    self = [self init];
    if (self) {
        self.stamp = stamp;
    }
    return self;
}

- (id)init {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    self = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    return [self init];
}


#pragma mark - Gesture Recognizers
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    [self.delegate stampViewDidReceiveTap:self];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(stampViewDidReceiveLongPress:)]) {
        [self.delegate performSelector:@selector(stampViewDidReceiveLongPress:) withObject:self];
    }
}


#pragma mark - View Handling
- (void)updateViews {
    UIImage *image = [UIImage imageNamed:self.stamp.imageFilename];
    if (!image) {
        image = RandomColorImage();
    }
    self.imageView.image = image;
    
    self.priceLabel.text = @""; // blank for now
}


@end
