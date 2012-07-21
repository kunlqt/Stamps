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

- (void)updateViews;

@end


@implementation QTStampView
@synthesize stamp = _stamp;
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
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    self = [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
    if (self) {
        self.stamp = stamp;
    }
    return self;
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
