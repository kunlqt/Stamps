//
//  ConfirmImageViewController.m
//  Quilt
//
//  Created by Daniel Byon on 12/22/11.
//  Copyright (c) 2012 Nerd Swagger Inc. All rights reserved.
//

#import "QTConfirmImageViewController.h"
#import "AFPhotoEditorController.h"


@interface QTConfirmImageViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

- (IBAction)confirm:(id)sender;
- (IBAction)reject:(id)sender;
- (IBAction)edit:(id)sender;

@end


@implementation QTConfirmImageViewController
@synthesize image = image_;
@synthesize delegate = delegate_;
@synthesize imageView = imageView_;


#pragma mark - Overridden Setters
- (void)setImage:(UIImage *)image {
    if (image_ != image) {
        image_ = image;
        self.imageView.image = image;
    }
}


#pragma mark - Actions
- (IBAction)confirm:(id)sender {
    [self.delegate confirmImage:self didConfirmImage:self.image];
}

- (IBAction)reject:(id)sender {
    [self.delegate confirmImageDidCancel:self];
}

- (IBAction)edit:(id)sender {
    NSArray *tools = [NSArray arrayWithObjects:kAFEffects, kAFText, kAFDraw, kAFCrop, kAFOrientation, nil];
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:self.image options:[NSDictionary dictionaryWithObject:tools forKey:kAFPhotoEditorControllerToolsKey]];
    [editorController setDelegate:self];
    
    [self presentModalViewController:editorController animated:YES];
}

#pragma mark - AFPhotoEditorControllerDelegate
- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)editedImage
{
    self.image = editedImage;
    [self dismissModalViewControllerAnimated:NO];
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    [self dismissModalViewControllerAnimated:NO];
}

#pragma mark - UIViewController
- (void)viewDidLoad {
    self.imageView.image = self.image;
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload {
    self.imageView = nil;
    [super viewDidUnload];
}


@end
