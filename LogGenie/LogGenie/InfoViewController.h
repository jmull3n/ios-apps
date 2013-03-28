//
//  InfoViewController.h
//  LogGenie
//
//  Created by Jon Mullen on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InfoViewControllerDelegate;


@interface InfoViewController : UIViewController <UIScrollViewDelegate,UIGestureRecognizerDelegate> {
 
   UIImageView *aboutView;
    
    
    UIScrollView *imageScrollView;
	UIImageView *imageView;  
}
@property (nonatomic, assign) id <InfoViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIImageView *aboutView;

@property (nonatomic, retain) IBOutlet UIScrollView *imageScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

- (IBAction)onDone:(id)sender;
- (IBAction)onAbout:(id)sender;
- (IBAction)onBack:(id)sender;
@end


@protocol InfoViewControllerDelegate
- (void)infoViewControllerDidFinish:(InfoViewController *)controller;
@end
