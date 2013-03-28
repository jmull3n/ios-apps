//
//  LogGenieAppDelegate.h
//  LogGenie
//
//  Created by Jon Mullen on 8/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogGenieViewController;

@interface LogGenieAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet LogGenieViewController *viewController;

@end
