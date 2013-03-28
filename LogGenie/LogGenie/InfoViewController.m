//
//  InfoViewController.m
//  LogGenie
//
//  Created by Jon Mullen on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"
#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 1.5


@interface InfoViewController (UtilityMethods)
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
@end


@implementation InfoViewController

@synthesize delegate=_delegate;
@synthesize aboutView, imageScrollView, imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



// adds a set of gesture recognizers to one of our piece subviews
- (void)addGestureRecognizersToPiece:(UIView *)piece
{
//         UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc]                                                    
//           initWithTarget:self action:@selector(handleSingleTap:)];
//        singleFingerTap.numberOfTouchesRequired = 2;
//        [singleFingerTap setDelegate:self];
//        [self.view addGestureRecognizer:singleFingerTap];        
//        [singleFingerTap release];
//        
//    UITapGestureRecognizer *singleFingerDTap = [[UITapGestureRecognizer alloc]                                                    
//        initWithTarget:self action:@selector(handleDoubleTap:)];
//    singleFingerDTap.numberOfTapsRequired = 2;
//    [singleFingerDTap setDelegate:self];
//    [self.view addGestureRecognizer:singleFingerDTap];        
//    [singleFingerDTap release];
//    

    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc]                                                    
                                               initWithTarget:self action:@selector(handleTwoFingerTap:)];
    
    singleFingerTap.numberOfTouchesRequired = 2;
    [singleFingerTap setDelegate:self];
    [self.view addGestureRecognizer:singleFingerTap];        
    [singleFingerTap release];
    
    UITapGestureRecognizer *singleFingerDTap = [[UITapGestureRecognizer alloc]                                                    
                                                initWithTarget:self action:@selector(handleDoubleTap:)];
    singleFingerDTap.numberOfTapsRequired = 2;
    [singleFingerDTap setDelegate:self];
    [self.view addGestureRecognizer:singleFingerDTap];        
    [singleFingerDTap release];
}



- (IBAction) onDone:(id) sender
{
    // Tell the parent window to close this window
    [self.delegate infoViewControllerDidFinish:self];

    //    [self.parentViewController dismissModalViewControllerAnimated: YES ];
}

- (IBAction) onAbout:(id) sender
{
    // Tell the parent window to close this window
    aboutView.alpha = 1.0;
   
    //    [self.parentViewController dismissModalViewControllerAnimated: YES ];
}



- (IBAction) onBack:(id) sender
{
    // Tell the parent window to close this window

    aboutView.alpha = 0.0;    
    //    [self.parentViewController dismissModalViewControllerAnimated: YES ];
}


-(void)resetDisplay
{

}

- (void)dealloc
{
    self.aboutView = nil;
    self.imageScrollView = nil;
    self.imageView = nil;
        [aboutView release];
    [imageScrollView release];
	[imageView release];
       [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
   
    // set the tag for the image view
    [imageView setTag:ZOOM_VIEW_TAG];
    
    [self addGestureRecognizersToPiece:imageScrollView];

    for (UIGestureRecognizer *gr in imageScrollView.gestureRecognizers)  {    
        NSLog(@"changins geustesr");
        if ([gr isKindOfClass:[UIPanGestureRecognizer class]]) {
            
            UIPanGestureRecognizer *pgr = (UIPanGestureRecognizer *) gr;
            pgr.maximumNumberOfTouches = 2; 
            
        }  
    }
    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = [imageScrollView frame].size.width  / [imageView frame].size.width;
    [imageScrollView setMinimumZoomScale:minimumScale];
    [imageScrollView setZoomScale:minimumScale];
    
    aboutView.alpha = 0.0;
    [self.view addSubview:aboutView];
     [super viewDidLoad];
    
   
//    
//    // add gesture recognizers to the image view
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
//    
//    [doubleTap setNumberOfTapsRequired:2];
//    [doubleTap setDelegate:self];
//    [twoFingerTap setDelegate:self];
//    [twoFingerTap setNumberOfTouchesRequired:2];
//    
//    [imageView addGestureRecognizer:singleTap];
//    [imageView addGestureRecognizer:doubleTap];
//    [imageView addGestureRecognizer:twoFingerTap];
//    
//    [singleTap release];
//    [doubleTap release];
//    [twoFingerTap release];
    


    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
 //   [aboutView release];
    self.aboutView = nil;
    //[self setAboutView:nil];
    self.imageScrollView = nil;
	self.imageView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [imageScrollView viewWithTag:ZOOM_VIEW_TAG];
}

/************************************** NOTE **************************************/
/* The following delegate method works around a known bug in zoomToRect:animated: */
/* In the next release after 3.0 this workaround will no longer be necessary      */
/**********************************************************************************/
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
    [scrollView setZoomScale:scale+0.01 animated:NO];
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // single tap does nothing for now
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // double tap zooms in
    NSLog(@"tapping!!!!");
    float newScale = [imageScrollView zoomScale] * ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [imageScrollView zoomToRect:zoomRect animated:YES];
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {
    // two-finger tap zooms out
    NSLog(@"tapping out!!!!");
    float newScale = [imageScrollView zoomScale] / 20;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [imageScrollView zoomToRect:zoomRect animated:YES];
}

#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [imageScrollView frame].size.height / scale;
    zoomRect.size.width  = [imageScrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

@end
