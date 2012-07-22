//
//  QTStampbookViewController.m
//  Stamps
//
//  Created by Daniel Byon on 7/21/12.
//  Copyright (c) 2012 Quilt. All rights reserved.
//

#import "QTStampbookViewController.h"
#import "QTNewStampOverlayView.h"
#import "Stamp.h"
#import "QTBatchArrayCursor.h"
#import "UIImage+Resize.h"


@interface QTStampbookViewController ()

@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) NSArray *stampPages;

- (IBAction)cancelButtonTapped:(id)sender;

- (void)addNewStampForType:(NSString *)type;

- (void)confirmImage:(UIImage *)image;

@end


@implementation QTStampbookViewController {
    Stamp *_currentlyEditingStamp;
    NSString *_pendingFilename;
}
@synthesize stamps = _stamps;
@synthesize delegate = _delegate;
@synthesize pageController = _pageController;
@synthesize imagePickerController = _imagePickerController;
@synthesize stampPages = _stampPages;


#pragma mark - Actions
- (IBAction)cancelButtonTapped:(id)sender {
    [self.delegate stampbookDidCancel:self];
}


#pragma mark - New Stamps
- (void)addNewStampForType:(NSString *)type {
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    QTNewStampOverlayView *overlay = [[QTNewStampOverlayView alloc] initWithFrame:self.imagePickerController.view.frame];
    overlay.type = type;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        self.imagePickerController.allowsEditing = NO;
        self.imagePickerController.showsCameraControls = NO;
        self.imagePickerController.cameraOverlayView = overlay;
        self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        self.imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
    } else {
        return;
    }
    
    [self presentViewController:self.imagePickerController animated:YES completion:^{
        int64_t delayInSeconds = 0.1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NewStampStartPictureCountdown" object:nil];
        });
    }];
}

- (void)confirmImage:(UIImage *)image {
    ConfirmImageViewController *controller = [[ConfirmImageViewController alloc] init];
    controller.image = image;
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - QTConfirmImageDelegate
- (void)confirmImage:(ConfirmImageViewController *)controller didConfirmImage:(UIImage *)image {
    [self.navigationController popToViewController:self animated:YES];
    
    NSString *filename = [@(arc4random()) stringValue];
    [[NSCache shared] setObject:image forKey:filename];
    
    _currentlyEditingStamp.type = @"Modified";
    _currentlyEditingStamp.imageFilename = [filename copy];
    _currentlyEditingStamp.hasImage = @YES;
    
    NSInteger stampIndex = [self.stamps indexOfObject:_currentlyEditingStamp];
    NSInteger currentPageIndex = stampIndex / 6;
    
    QTStampbookPageViewController *currentPage = [self.stampPages objectAtIndex:currentPageIndex];
    NSMutableArray *pageStamps = [currentPage.stamps mutableCopy];
    NSInteger pageStampIndex = stampIndex % 6;
    [pageStamps replaceObjectAtIndex:pageStampIndex withObject:[_currentlyEditingStamp copy]];
    currentPage.stamps = pageStamps;
    
    _currentlyEditingStamp = nil;
    _pendingFilename = nil;
}

- (void)confirmImageDidCancel:(ConfirmImageViewController *)controller {
    [self.navigationController popToViewController:self animated:YES];
    _pendingFilename = nil;
}


#pragma mark - QTStampbookPageDelegate
- (void)stampbookPage:(QTStampbookPageViewController *)stampbookPage didSelectStamp:(Stamp *)stamp {
    NSLog(@"stamp %d selected", [self.stamps indexOfObject:stamp] + 1);
    
    if ([stamp.hasImage boolValue]) {
        NSMutableArray *stamps = [NSMutableArray arrayWithCapacity:[self.stamps count]];
        for (QTStampbookPageViewController *page in self.stampPages) {
            [stamps addObjectsFromArray:page.stamps];
        }
        [[NSCache shared] setObject:stamps forKey:@"stamps"];
        
        [self.delegate stampbook:self didChooseImage:[[NSCache shared] objectForKey:stamp.imageFilename]];
    } else {
        _currentlyEditingStamp = [stamp copy];
        [self addNewStampForType:stamp.type];
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (image.imageOrientation != UIImageOrientationUp) {
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        [image drawInRect:(CGRect){0, 0, image.size}];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    image = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(320.0f, 480.0f) interpolationQuality:kCGInterpolationDefault];
    image = [image croppedImage:CGRectMake(0.0f, 80.0f, 320.0f, 278.0f)];
    
    [self confirmImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:NO completion:nil];
    self.imagePickerController = nil;
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

- (void)awakeFromNib {
    __weak QTStampbookViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"UserCancelledNewStampPicture" object:nil queue:nil usingBlock:^(NSNotification *note) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"NewStampTakePicture" object:nil queue:nil usingBlock:^(NSNotification *note) {
        [weakSelf.imagePickerController takePicture];
    }];
    
    self.stamps = [[NSCache shared] objectForKey:@"stamps"];
    
    [super awakeFromNib];
}

- (void)viewDidLoad {
    NSMutableArray *pages = [NSMutableArray arrayWithCapacity:ceil([self.stamps count] / 6.0f)];
    QTBatchArrayCursor *cursor = [[QTBatchArrayCursor alloc] initWithArray:self.stamps batchSize:QTBatchArraySizeStamps];
    while ([cursor hasNextBatch]) {
        QTStampbookPageViewController *page = [[QTStampbookPageViewController alloc] initWithStamps:[cursor nextBatch]];
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
