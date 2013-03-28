//
//  RockProperties.m
//  RockPropertiesSlider
//
//  Created by Jon Mullen on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RockProperties.h"

@implementation RockProperties

@synthesize logMatrix,estAcousticSlowness,densityPorosity,neutronPorosity,gammaRay,resistivity,DTC,DTS,porePressureGrad,overburdenGrad,techtonicGrad,fluidDensity,dtcEst,dtsEst,
poissonsRatioSonic,poissonsRatioEst,youngsModulusSonic,youngsModulusEst,closureStressGradSonic,closureStressGradEst,brittlenessIndexSonic,brittlenessIndexEst,params;

-(void)clear{
    [self setDensityPorosity:[NSNumber numberWithFloat:0.0]];
    [self setNeutronPorosity:[NSNumber numberWithFloat:0.0]];
    [self setGammaRay:[NSNumber numberWithFloat:0.0]];
    [self setResistivity:[NSNumber numberWithFloat:0.2]];
    [self setPorePressureGrad:[NSNumber numberWithFloat:0.433]];
    [self setOverburdenGrad:[NSNumber numberWithFloat:1.05]];
    [self setTechtonicGrad:[NSNumber numberWithFloat:0.0]];
    [self setFluidDensity:[NSNumber numberWithFloat:1.0]];
    [self setDTC:[NSNumber numberWithFloat:40.0]];
    [self setDTS:[NSNumber numberWithFloat:40.0]];
    
   
}
-(void)calculateFromSonic{
    //calc poissons
        float poissons =  (powf([DTS floatValue],2.0)/powf([DTC floatValue],2.0) - 2.0)/(2.0*powf([DTS floatValue],2.0)/powf([DTC floatValue],2.0) - 2.0);
        
        if(poissons<.1){
            [self setPoissonsRatioSonic:[NSNumber numberWithFloat:.1]];
        }
           
        else if(poissons>.45)
           [self setPoissonsRatioSonic:[NSNumber numberWithFloat:.45]]; 
        else
            [self setPoissonsRatioSonic:[NSNumber numberWithFloat:poissons]];

    float apparentPorosity = ([densityPorosity floatValue] + [neutronPorosity floatValue])/2.0;

    //calc YM

         RforYM = (2.0-2.0*[poissonsRatioSonic floatValue])/(1.0-2.0*[poissonsRatioSonic floatValue]);
       //  NSLog(@"RforYM: %@",[NSString stringWithFormat:@"%.02f", RforYM]);    
                 float d5;
        if([logMatrix compare:@"Sand"] == NSOrderedSame)
            d5=2.65-[densityPorosity floatValue]*(2.65-[fluidDensity floatValue]);
        else
             d5=2.71-[densityPorosity floatValue]*(2.71-[fluidDensity floatValue]);
        
        
        float youngs = 13447.0*d5*(3.0*RforYM-4.0)/(powf([DTC floatValue],2.0)*RforYM*(RforYM-1.0))*(params.YMDtoYMS-apparentPorosity);

      // 13447*D5*(3*B27-4)/(B9^2*B27*(B27-1))*(J31-(B5+B6)/2)
        
        if(youngs < .1)
           [self setYoungsModulusSonic: [NSNumber numberWithFloat:.1]];
       else if(youngs>12.0) 
            [self setYoungsModulusSonic: [NSNumber numberWithFloat:12.0]];
       else
        [self setYoungsModulusSonic: [NSNumber numberWithFloat:youngs]];
       //calc closure stress
  
        
        float closure = [poissonsRatioSonic floatValue]/(1.0-[poissonsRatioSonic floatValue])*([overburdenGrad floatValue]-params.BiotsAlpha*[porePressureGrad floatValue]) + [porePressureGrad floatValue]+[techtonicGrad floatValue];
            
        
        if(closure<0.0)
            [self setClosureStressGradSonic:[NSNumber numberWithFloat:0.0]];
       else if(closure>1.5)
            [self setClosureStressGradSonic:[NSNumber numberWithFloat:1.5]];
        else
            [self setClosureStressGradSonic:[NSNumber numberWithFloat:closure]];

     
    //calc brittleness
   
      
        float brittleness =(([youngsModulusSonic floatValue]-1.0)/7.0+(.45-[poissonsRatioSonic floatValue])/.35)/.022;       
        if(brittleness<0.0)
            [self setBrittlenessIndexSonic:[NSNumber numberWithFloat:0.0]];
       else if(brittleness>100.0)
             [self setBrittlenessIndexSonic:[NSNumber numberWithFloat:100.0]];
       else
         [self setBrittlenessIndexSonic:[NSNumber numberWithFloat:brittleness]]; 
        
   
        

}
-(void)calculateEstimate {
    
    float apparentPorosity = ([densityPorosity floatValue] + [neutronPorosity floatValue])/2.0;

    DTC_PHIA = apparentPorosity * params.DTCPHIAMULT + params.DTCPHIAOFFSET;
    DTC_PHIN = [neutronPorosity floatValue]*params.DTCPHINMULT + params.DTCPHINOFFSET;
    DTC_PHID = [densityPorosity floatValue] * params.DTCPHIDMULT + params.DTCPHIDOFFSET;
    DTC_GR = [gammaRay floatValue]*params.DTCGRMULT + params.DTCGROFFFSET;
    DTC_RT = params.DTCRTMULT/[resistivity floatValue] + params.DTCRTOFFSET;
    float dtcest = (DTC_PHIA + DTC_PHIN + DTC_PHID + DTC_RT + DTC_GR)/5.0;
    
    
    float d5;
    if([logMatrix compare:@"Sand"] == NSOrderedSame)
        d5=2.65-[densityPorosity floatValue]*(2.65-[fluidDensity floatValue]);
    else
        d5=2.71-[densityPorosity floatValue]*(2.71-[fluidDensity floatValue]);

    
    RHOmatrix = (d5-(apparentPorosity*[fluidDensity floatValue]))/(1-apparentPorosity);
     NSLog(@"rhomat, %f", RHOmatrix);

    if(RHOmatrix < 2.65)
        RHOmatrix = 2.65;
    else if (RHOmatrix > 2.98)
        RHOmatrix = 2.98;
    
   // VRAT = params.VRAT;// RHOmatrix*params.VRATMULT + params.VRATOFFSET;
    
    DTS_VRAT = params.VRAT * dtcest;
     NSLog(@"DTS_VRAT, %f", DTS_VRAT);
    DTS_PHIN = params.DTSPHINMULT*[neutronPorosity floatValue] + params.DTSPHINOFFSET;
      NSLog(@"DTS_PHIN, %f", DTS_PHIN);
    DTS_RT = params.DTSRTMULT*1000.0/[resistivity floatValue] + params.DTSRTOFFSET;
      NSLog(@"DTS_RT, %f", DTS_RT);
    float dtsest = (DTS_VRAT + DTS_PHIN + DTS_RT)/3.0;
    NSLog(@"dtsest, %f", dtsest);

    // float dtsest = apparentPorosity * (350-params.DTSma) + params.DTSma;
    
    
    //set DTC Est
    [self setDtcEst:[NSNumber numberWithFloat:dtcest]]; 
    
    //set DTS Est
    [self setDtsEst:[NSNumber numberWithFloat:dtsest]];
    
    //calc poissons
  //  if(dtcEst != nil && dtsEst != nil && densityPorosity != nil && resistivity != nil && neutronPorosity != nil)
   // {
        float poissons =  (powf([dtsEst floatValue],2.0)/powf([dtcEst floatValue],2.0) - 2.0)/(2.0*powf([dtsEst floatValue],2.0)/powf([dtcEst floatValue],2.0) - 2.0);
        //NSNumber *temp =[NSNumber numberWithFloat:];
        
        if(poissons<.1){
            [self setPoissonsRatioEst:[NSNumber numberWithFloat:.1]];
        }
        
        else if(poissons>.45)
            [self setPoissonsRatioEst:[NSNumber numberWithFloat:.45]]; 
        else
            [self setPoissonsRatioEst:[NSNumber numberWithFloat:poissons]];
        
        // NSLog(@"calculatingFromSonic, %f", [poissonsRatioSonic floatValue]);
        //[temp release];
        
   // }
    
    
    //calc YM
    if(densityPorosity != nil && dtcEst != nil && neutronPorosity != nil && dtsEst != nil)
    {
        
        RforYM = (2.0-2.0*[poissonsRatioEst floatValue])/(1.0-2.0*[poissonsRatioEst floatValue]);
     float youngs = 13447.0*d5*(3.0*RforYM-4.0)/(powf([dtcEst floatValue],2.0)*RforYM*(RforYM-1.0))*(params.YMDtoYMS-apparentPorosity);
   
        if(youngs < .1)
            [self setYoungsModulusEst:[NSNumber numberWithFloat:.1]];
        else if(youngs>12.0) 
            [self setYoungsModulusEst: [NSNumber numberWithFloat:12.0]];
        else
            [self setYoungsModulusEst: [NSNumber numberWithFloat:youngs]];
      
    }
    //calc closure stress
    if(poissonsRatioEst != nil && porePressureGrad != nil && overburdenGrad != nil && techtonicGrad!= nil)
    {
  
        float closure = [poissonsRatioEst floatValue]/(1.0-[poissonsRatioEst floatValue])*([overburdenGrad floatValue]-params.BiotsAlpha*[porePressureGrad floatValue]) + [porePressureGrad floatValue]+[techtonicGrad floatValue];
        
     
        
        if(closure<0.0)
            [self setClosureStressGradEst:[NSNumber numberWithFloat:0.0]];
        else if(closure>1.5)
            [self setClosureStressGradEst:[NSNumber numberWithFloat:1.5]];
        else
            [self setClosureStressGradEst:[NSNumber numberWithFloat:closure]];
        
        // [temp release];
        
        
    }
    //calc brittleness
    if(youngsModulusEst!= nil && closureStressGradEst!= nil){
        
        float brittleness =(([youngsModulusEst floatValue]-1.0)/7.0+(.45-[poissonsRatioEst floatValue])/.35)/.022;       
        if(brittleness<0.0)
            [self setBrittlenessIndexEst:[NSNumber numberWithFloat:0.0]];
        else if(brittleness>100.0)
            [self setBrittlenessIndexEst:[NSNumber numberWithFloat:100.0]];
        else
            [self setBrittlenessIndexEst:[NSNumber numberWithFloat:brittleness]]; 
        
    }     
        


}

@end
