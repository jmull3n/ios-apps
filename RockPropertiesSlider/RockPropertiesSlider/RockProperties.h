//
//  RockProperties.h
//  RockPropertiesSlider
//
//  Created by Jon Mullen on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parameters.h"

@interface RockProperties :NSObject
{
    
    Parameters *params;
    NSString *logMatrix;
    NSString *estAcousticSlowness;
    NSNumber *densityPorosity;
    NSNumber *neutronPorosity;
    NSNumber *gammaRay;
    NSNumber *resistivity;
    NSNumber *DTC;
    NSNumber *DTS;
    NSNumber *porePressureGrad;
    NSNumber *overburdenGrad;
    NSNumber *techtonicGrad;
    NSNumber *fluidDensity;
    
    NSNumber *dtcEst;
    NSNumber *dtsEst;
    
    NSNumber *poissonsRatioSonic;
    NSNumber *youngsModulusSonic;
    NSNumber *closureStressGradSonic;
    NSNumber *brittlenessIndexSonic;

    NSNumber *poissonsRatioEst;
    NSNumber *youngsModulusEst;
    NSNumber *closureStressGradEst;
    NSNumber *brittlenessIndexEst;
    
    //intermediate properties
    
     float RforYM;
     float RHOmatrix;
     float ApparentPorosity;
     float PHIDls;
     float PHINls;
     float YMSfromDTCIV;
    
     float DTC_PHIA;
     float DTC_PHIN;
     float DTC_PHID;
     float DTC_GR;
     float DTC_RT;
    
     float VRAT;
     float DTS_VRAT;
     float DTS_PHIN;
     float DTS_RT;
    
    float PR_GR;
     float YMD_DT;
     float YMD_DT2;


}
@property (nonatomic,retain) Parameters *params;
@property (nonatomic, retain) NSString *logMatrix;
@property (nonatomic, retain) NSString *estAcousticSlowness;
@property (nonatomic, retain) NSNumber *densityPorosity;
@property (nonatomic, retain) NSNumber *neutronPorosity;
@property (nonatomic, retain) NSNumber *gammaRay;
@property (nonatomic, retain) NSNumber *resistivity;
@property (nonatomic, retain) NSNumber *DTC;
@property (nonatomic, retain) NSNumber *DTS;
@property (nonatomic, retain) NSNumber *porePressureGrad;
@property (nonatomic, retain) NSNumber *overburdenGrad;
@property (nonatomic, retain)NSNumber *techtonicGrad;
@property (nonatomic, retain)NSNumber *fluidDensity;
@property (nonatomic, retain)NSNumber *dtcEst;
@property (nonatomic, retain)NSNumber *dtsEst;
@property (nonatomic, retain)NSNumber *poissonsRatioSonic;
@property (nonatomic, retain)NSNumber *youngsModulusSonic;
@property (nonatomic, retain)NSNumber *closureStressGradSonic;
@property (nonatomic, retain)NSNumber *brittlenessIndexSonic;
@property (nonatomic, retain)NSNumber *poissonsRatioEst;
@property (nonatomic, retain)NSNumber *youngsModulusEst;
@property (nonatomic, retain)NSNumber *closureStressGradEst;
@property (nonatomic, retain)NSNumber *brittlenessIndexEst;

-(void)calculateFromSonic;
-(void)calculateEstimate;
-(void)clear;
@end
