//
//  InfoViewController.h
//  RockPropertiesSlider
//
//  Created by Jon Mullen on 3/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol InfoViewControllerDelegate <NSObject>



-(void)dismissInfoView;

@end

@interface InfoViewController : UIViewController <UINavigationBarDelegate, UINavigationControllerDelegate>
{
UINavigationBar *navBar;

}
@property(nonatomic,assign) id<InfoViewControllerDelegate> delegate;
@property (nonatomic,retain) UINavigationBar *navBar;
-(void)backButtonPressed:(id)sender;
@end
