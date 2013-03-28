//
//  LogGenieViewController.h
//  LogGenie
//
//  Created by Jon Mullen on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
//#import "TwoFingerPanScrollView.h"

@interface LogGenieViewController : UIViewController <UIScrollViewDelegate,UIGestureRecognizerDelegate,InfoViewControllerDelegate> {
 UIImageView *firstPieceView; 
 UIImageView *secondPieceView; 
    UIView *mainView;
 UIImageView *thirdPieceView; 
    UIImageView *fourthPieceView;   
    
    UIScrollView *imageScrollView;
    
    UIView *tempView;

    
 CGPoint startTouchPosition;    
}
@property (nonatomic, retain) IBOutlet UIImageView *firstPieceView;
@property (nonatomic, retain) IBOutlet UIImageView *secondPieceView;
@property (nonatomic, retain) IBOutlet UIView *mainView;
@property (nonatomic, retain) IBOutlet UIImageView *thirdPieceView;
@property (nonatomic, retain) IBOutlet UIImageView *fourthPieceView;
@property (nonatomic, retain) IBOutlet UIScrollView *imageScrollView;

- (IBAction) onInfo:(id) sender;
@end
