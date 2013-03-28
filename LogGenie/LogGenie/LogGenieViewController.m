//
//  LogGenieViewController.m
//  LogGenie
//
//  Created by Jon Mullen on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "LogGenieViewController.h"

#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 1.5


@interface LogGenieViewController (UtilityMethods)
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;
@end


@implementation LogGenieViewController
@synthesize firstPieceView;
@synthesize secondPieceView;
@synthesize mainView;
@synthesize thirdPieceView;
@synthesize imageScrollView;
@synthesize fourthPieceView;



// adds a set of gesture recognizers to one of our piece subviews
- (void)addGestureRecognizersToPiece:(UIView *)piece
{
//    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotatePiece:)];
//    [piece addGestureRecognizer:rotationGesture];
//    [rotationGesture release];
// 
//    if(piece == self.view){
//    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scalePiece:)];
//    [pinchGesture setDelegate:self];
//    [piece addGestureRecognizer:pinchGesture];
//    [pinchGesture release];
//        
//        
//    UIPanGestureRecognizer *panGestureMainView = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
//        [panGestureMainView setMinimumNumberOfTouches:2];
//        [panGestureMainView setDelegate:self];
//        [piece addGestureRecognizer:panGestureMainView];
//        [panGestureMainView release];
////    
////        UITapGestureRecognizer *singleFingerDTap = [[UITapGestureRecognizer alloc]                                                    
////           initWithTarget:self action:@selector(handleSingleDoubleTap:)];
////        singleFingerDTap.numberOfTapsRequired = 2;
////        [singleFingerDTap setDelegate:self];
////        [self.view addGestureRecognizer:singleFingerDTap];        
////        [singleFingerDTap release];
//    
//    }
if(piece == mainView)
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPiece:)];
    
    [panGesture setMaximumNumberOfTouches:1];
    
    [panGesture setDelegate:self];
    //[panGesture delaysTouchesBegan];
    [piece addGestureRecognizer:panGesture];
    [panGesture release];
}
    if(piece == imageScrollView)
    {
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
}


//- (void)awakeFromNib
//{
//    [self addGestureRecognizersToPiece:firstPieceView];
//   
//}

- (void)dealloc
{
    [firstPieceView release];
    [mainView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark === Utility methods  ===
#pragma mark

// scale and rotation transforms are applied relative to the layer's anchor point
// this method moves a gesture recognizer's view's anchor point between the user's fingers
- (void)adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"Attempting to get anchor point");
    NSLog(@"Gesture state: %u",gestureRecognizer.state);
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //UIView *piece = gestureRecognizer.view;
        
        
        UIView* view = gestureRecognizer.view;
        CGPoint loc = [gestureRecognizer locationInView:view];
        tempView = [view hitTest:loc withEvent:nil];
         NSLog(@"anchor point for piece: %i",tempView.tag); 
        
         NSLog(@"anchor point %f, %f",tempView.center.x, tempView.center.y); 
        CGPoint locationInView = [gestureRecognizer locationInView:tempView];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:tempView.superview];
        //tempView.tag = 500;
         //tempView = [piece hitTest:locationInSuperview withEvent:nil];
        tempView.layer.anchorPoint = CGPointMake(locationInView.x / tempView.bounds.size.width, locationInView.y / tempView.bounds.size.height);
        tempView.center = locationInSuperview;
        
       


      NSLog(@"anchor point %f, %f",tempView.center.x, tempView.center.y);
         NSLog(@"anchor point for piece: %i",tempView.tag); 
    }
}

#pragma mark -
#pragma mark === Touch handling  ===
#pragma mark

// shift the piece's center by the pan amount
// reset the gesture recognizer's translation to {0, 0} after applying so the next callback is a delta from the current position
- (void)panPiece:(UIPanGestureRecognizer *)gestureRecognizer
{
      

    
   // UIView *piece =  tempView;// firstPieceView;// [gestureRecognizer view];
     NSLog(@"Attempting to pan %i",tempView.tag);
    
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    if(tempView == firstPieceView || tempView ==secondPieceView || tempView == thirdPieceView || tempView == fourthPieceView )
    {
        if ([gestureRecognizer state] == UIGestureRecognizerStateBegan 
            || [gestureRecognizer state] == UIGestureRecognizerStateChanged
            ) 
        {
            CGPoint translation = [gestureRecognizer translationInView:[tempView superview]];
            CGFloat newX =[tempView center].x + translation.x;
            if(UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {  
                
                if(newX < -960)
                {
                    newX = -950; 
                }
                if(newX > 1920)
                {
                    newX = 1910;
                }
            }
            NSLog(@"newX: %f",newX);
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.1];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
       
       //     [tempView setCenter:CGPointMake(newX,[tempView center].y)];
            
            [tempView setCenter:CGPointMake(newX,[tempView center].y)];
            [UIView commitAnimations];
            [gestureRecognizer setTranslation:CGPointZero inView:[tempView superview]];
            NSLog(@"Panned piece!! %i", tempView.tag);
        }
    }
}

// rotate the piece by the current rotation
// reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current rotation
- (void)rotatePiece:(UIRotationGestureRecognizer *)gestureRecognizer
{
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformRotate([[gestureRecognizer view] transform], [gestureRecognizer rotation]);
        [gestureRecognizer setRotation:0];
    }
}

// scale the piece by the current scale
// reset the gesture recognizer's rotation to 0 after applying so the next callback is a delta from the current scale
- (void)scalePiece:(UIPinchGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Attempting to Scale");
    [self adjustAnchorPointForGestureRecognizer:gestureRecognizer];
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan || [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], [gestureRecognizer scale], [gestureRecognizer scale]);
        [gestureRecognizer setScale:1];
         NSLog(@"Scaled!!!");
    }
}


//
//- (void)handleSingleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
//    NSLog(@"attempting to reset scale");
//    [UIView animateWithDuration:0.2 animations:^(void) {
//        
//        self.view.transform = CGAffineTransformIdentity;
//        self.firstPieceView.transform = CGAffineTransformIdentity;
//        self.secondPieceView.transform = CGAffineTransformIdentity;
//         self.thirdPieceView.transform = CGAffineTransformIdentity;
//        self.fourthPieceView.transform = CGAffineTransformIdentity;
//        
//        [self.firstPieceView setCenter:CGPointMake(480,
//         [self.firstPieceView center].y)];
//         [self.secondPieceView setCenter:CGPointMake(480,[self.secondPieceView center].y)];
//         [self.thirdPieceView setCenter:CGPointMake(480,[self.thirdPieceView center].y)];
//         [self.fourthPieceView setCenter:CGPointMake(-[self.firstPieceView center].x*2,[self.fourthPieceView center].y)];
//    }];
//    [UIView commitAnimations];
//    NSLog(@"ScaleReset!");
//
//    
//}

// ensure that the pinch, pan and rotate gesture recognizers on a particular view can all recognize simultaneously
// prevent other gesture recognizers from recognizing simultaneously
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // if the gesture recognizers's view isn't one of our pieces, don't allow simultaneous recognition
    if (gestureRecognizer.view != firstPieceView && gestureRecognizer.view != secondPieceView && gestureRecognizer.view != thirdPieceView && gestureRecognizer.view != fourthPieceView)
        return NO;
    NSLog(@"multiple gestures recognized");
    


    return YES;
    
   
}
 
- (void)infoViewControllerDidFinish:(InfoViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}




- (IBAction) onInfo:(id) sender
{ 
    InfoViewController *controller = [[InfoViewController alloc] initWithNibName:@"InfoViewController" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];


}


#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
      [mainView setTag:ZOOM_VIEW_TAG];
   
    [self addGestureRecognizersToPiece:mainView];
    
    [self addGestureRecognizersToPiece:imageScrollView];
    for (UIGestureRecognizer *gr in imageScrollView.gestureRecognizers)  {    
        NSLog(@"changins geustesr");
        if ([gr isKindOfClass:[UIPanGestureRecognizer class]]) {
            
            UIPanGestureRecognizer *pgr = (UIPanGestureRecognizer *) gr;
            pgr.minimumNumberOfTouches = 2; 
                      
        }  
    }  

    
    // calculate minimum scale to perfectly fit image width, and begin at that scale
    float minimumScale = [imageScrollView frame].size.width  / [mainView frame].size.width;
    NSLog(@"minscale: %f",minimumScale);
    
    [imageScrollView setMinimumZoomScale:minimumScale];
    [imageScrollView setZoomScale:minimumScale];
    
    [super viewDidLoad];
  
}


- (void)viewDidUnload
{
    [self setMainView:nil];
    self.view = nil;
    self.firstPieceView = nil;
    self.secondPieceView = nil;
    self.thirdPieceView = nil;
    self.fourthPieceView = nil;
    self.imageScrollView = nil;
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
    NSLog(@"attempting to scroll");
    return [imageScrollView viewWithTag:ZOOM_VIEW_TAG];
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
    float newScale =   [imageScrollView zoomScale] / 20;//[mainView frame].size.width/[imageScrollView frame].size.width ;//
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [imageScrollView zoomToRect:zoomRect animated:YES];
    
//    [UIView animateWithDuration:0.2 animations:^(void) {
//        NSLog(@"center: %f, %f",firstPieceView.layer.anchorPoint.x, firstPieceView.layer.anchorPoint.y );
//        NSLog(@"center: %f, %f",[self.imageScrollView center].x, [self.imageScrollView center].y );
//
//        self.firstPieceView.transform = CGAffineTransformIdentity;
//        self.secondPieceView.transform = CGAffineTransformIdentity;
//         self.thirdPieceView.transform = CGAffineTransformIdentity;
//        self.fourthPieceView.transform = CGAffineTransformIdentity;

//        [firstPieceView setCenter:CGPointMake(960,[firstPieceView center].y)];
//        [secondPieceView setCenter:CGPointMake(960,[secondPieceView center].y)];
//        [thirdPieceView setCenter:CGPointMake(960,[thirdPieceView center].y)];
//       [fourthPieceView setCenter:CGPointMake(960,[fourthPieceView center].y)];
//        NSLog(@"center: %f, %f",[firstPieceView center].x, [firstPieceView center].y );

//    }];
//    [UIView commitAnimations];
    NSLog(@"ScaleReset!");

}


#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    NSLog(@"getting zoom rect");
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
