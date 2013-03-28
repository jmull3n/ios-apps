//
//  MainViewController.h
//  RockPropertiesSlider
//
//  Created by Jon Mullen on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


#include "RockProperties.h"
#include "InfoViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface MainViewController : UIViewController <UIPopoverControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource,InfoViewControllerDelegate>
{
    RockProperties  *rockProperties;
    UIPickerView *pickerView;
    
    UITableView *tableView;
    UIPopoverController *popover;
    //data for the picker wheels
    NSMutableArray *logMatrixArray;
    NSMutableArray *estimatedAcousticSlownessArray;
    
    NSMutableDictionary  *ParameterDict;
    //labels for all the slider values
    BOOL isLogMatrix;
    BOOL isEAS;
    
    IBOutlet UIButton *selectLogMatrix;
    IBOutlet UIButton *selectEAS;
    
    NSString *selectedRowLogMatrix;
    NSString *selectedRowEAS;
    
    IBOutlet UIButton *infoButton;
   
    //fake out borders!
    
    IBOutlet UIButton *resultsButton;
    IBOutlet UIButton *techGradBorderButton;
    IBOutlet UIButton *denBorderButton;
    IBOutlet UIButton *neutBorderButton;
    IBOutlet UIButton *grBorderButton;
    IBOutlet UIButton *poreBorderButton;
    IBOutlet UIButton *overBorderButton;
    IBOutlet UIButton *resBorderButton;
    IBOutlet UIButton *fluidBorderButton;
    IBOutlet UIButton *matrixBorderButton;
    IBOutlet UIButton *dtcBorderButton;
    IBOutlet UIButton *dtsBorderButton;
    IBOutlet UIButton *estBorderButton;
   
}

@property (nonatomic,retain) RockProperties *rockProperties;
@property (nonatomic,retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic,retain) NSMutableDictionary *ParameterDict;
@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property (nonatomic,retain) UIPopoverController *popover;
@property (retain, nonatomic) IBOutlet UILabel *densityPorosity;
@property (retain, nonatomic) IBOutlet UILabel *neutronPorosity;
@property (retain, nonatomic) IBOutlet UILabel *gammaRay;
@property (retain, nonatomic) IBOutlet UILabel *resistivity;
@property (retain, nonatomic) IBOutlet UILabel *porePressureGrad;
@property (retain, nonatomic) IBOutlet UILabel *overburdenGrad;
@property (retain, nonatomic) IBOutlet UILabel *techtonicGrad;
@property (retain, nonatomic) IBOutlet UILabel *fluidDensity;
@property (retain, nonatomic) IBOutlet UILabel *DTC;
@property (retain, nonatomic) IBOutlet UILabel *DTS;
@property (retain, nonatomic) IBOutlet UILabel *dtcEst;
@property (retain, nonatomic) IBOutlet UILabel *dtsEst;
@property (retain, nonatomic) IBOutlet UILabel *poissonsRatioSonic;
@property (retain, nonatomic) IBOutlet UILabel *youngsModulusSonic;
@property (retain, nonatomic) IBOutlet UILabel *closureStressGradSonic;
@property (retain, nonatomic) IBOutlet UILabel *brittlenessIndexSonic;
@property (retain, nonatomic) IBOutlet UILabel *poissonsRatioEst;
@property (retain, nonatomic) IBOutlet UILabel *youngsModulusEst;
@property (retain, nonatomic) IBOutlet UILabel *closureStressGradEst;
@property (retain, nonatomic) IBOutlet UILabel *brittlenessIndexEst;

@property (nonatomic,retain) NSString *selectedRowLogMatrix;
@property (nonatomic,retain) NSString *selectedRowEAS;


@property (retain, nonatomic) IBOutlet UISlider *densityPorositySlider;

@property (retain, nonatomic) IBOutlet UISlider *neutronPorositySlider;
@property (retain, nonatomic) IBOutlet UISlider *gammaRaySlider;
@property (retain, nonatomic) IBOutlet UISlider *resistivitySlider;
@property (retain, nonatomic) IBOutlet UISlider *porePressureSlider;
@property (retain, nonatomic) IBOutlet UISlider *overburdenSlider;
@property (retain, nonatomic) IBOutlet UISlider *techtonicGradSlider;
@property (retain, nonatomic) IBOutlet UISlider *fluidDensitySlider;
@property (retain, nonatomic) IBOutlet UISlider *dtcSlider;
@property (retain, nonatomic) IBOutlet UISlider *dtsSlider;

@property (nonatomic) BOOL isLogMatrix;
@property (nonatomic) BOOL isEAS;

@property (nonatomic,retain) IBOutlet UIButton *selectLogMatrix;
@property (nonatomic,retain) IBOutlet UIButton *selectEAS;
@property (nonatomic,retain) IBOutlet UIButton *infoButton;
@property (nonatomic,retain) IBOutlet UIButton *resultsButton;
@property (nonatomic,retain) IBOutlet UIButton *techGradBorderButton;

@property (nonatomic,retain) IBOutlet UIButton *denBorderButton;
@property (nonatomic,retain) IBOutlet UIButton *neutBorderButton;
@property (nonatomic,retain) IBOutlet UIButton *grBorderButton;
@property (nonatomic,retain) IBOutlet UIButton *poreBorderButton;
@property (nonatomic,retain) IBOutlet UIButton *overBorderButton;
@property (nonatomic,retain) IBOutlet UIButton *resBorderButton;
@property (nonatomic,retain) IBOutlet UIButton *fluidBorderButton;
@property (nonatomic,retain) IBOutlet UIButton *matrixBorderButton;
@property (nonatomic,retain) IBOutlet UIButton *dtcBorderButton;
@property (nonatomic,retain) IBOutlet UIButton *dtsBorderButton;
@property (nonatomic,retain) IBOutlet UIButton *estBorderButton;


@property (nonatomic, retain) NSMutableArray *logMatrixArray;
@property (nonatomic, retain) NSMutableArray *estimatedAcousticSlownessArray;

@property (nonatomic,strong) NSArray *softRock;
@property (nonatomic,strong) NSArray *tightSand;
@property (nonatomic,strong) NSArray *carbonates;
@property (nonatomic,strong) NSArray *shale;

-(IBAction)sliderValueChanged:(id)sender;
-(IBAction)logMatrixButtonPressed:(id)sender;
-(IBAction)eASButtonPressed:(id)sender;
-(IBAction)clearButtonPressed:(id)sender;
-(void)infoButtonPressed:(id)sender;
-(void)backButtonPressed:(id)sender;
-(void)resetUI;
//-(void)calculateFromSonic;
@end
