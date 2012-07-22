//
//  ConfirmImageViewController.h
//  Quilt
//
//  Created by Daniel Byon on 12/22/11.
//  Copyright (c) 2012 Nerd Swagger Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFPhotoEditorController.h"


@protocol QTConfirmImageDelegate;


@interface ConfirmImageViewController : UIViewController <AFPhotoEditorControllerDelegate> {
    @private
    UIImage *image_;
    __weak id <QTConfirmImageDelegate> delegate_;
    
    __weak UIImageView *imageView_;
}

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id <QTConfirmImageDelegate> delegate;

@end


@protocol QTConfirmImageDelegate <NSObject>
@required
- (void)confirmImage:(ConfirmImageViewController *)controller didConfirmImage:(UIImage *)image;
- (void)confirmImageDidCancel:(ConfirmImageViewController *)controller;

@end
