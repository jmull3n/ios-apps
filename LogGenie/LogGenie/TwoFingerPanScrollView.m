//
//  TwoFingerPanScrollView.m
//  LogGenie
//
//  Created by Jon Mullen on 8/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwoFingerPanScrollView.h"


@implementation TwoFingerPanScrollView
- (void)viewDidLoad {
   // [super viewDidLoad];
    NSLog(@"loadingViewScroller!");
    for (UIGestureRecognizer *gr in self.gestureRecognizers)  {    
        
        if ([gr isKindOfClass:[UIPanGestureRecognizer class]]) {
            
            UIPanGestureRecognizer *pgr = (UIPanGestureRecognizer *) gr;
            pgr.minimumNumberOfTouches = 2;                
        }  
    }  
}

@end
