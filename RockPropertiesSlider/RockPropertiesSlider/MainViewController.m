//
//  MainViewController.m
//  RockPropertiesSlider
//
//  Created by Jon Mullen on 11/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

#import "InfoViewController.h"

@implementation MainViewController
@synthesize densityPorosity;
@synthesize neutronPorosity;
@synthesize gammaRay;
@synthesize resistivity;
@synthesize porePressureGrad;
@synthesize overburdenGrad;
@synthesize techtonicGrad;
@synthesize fluidDensity;
@synthesize DTC;
@synthesize DTS;
@synthesize dtcEst;
@synthesize dtsEst;
@synthesize poissonsRatioSonic;
@synthesize youngsModulusSonic;
@synthesize closureStressGradSonic;
@synthesize brittlenessIndexSonic;
@synthesize poissonsRatioEst;
@synthesize youngsModulusEst;
@synthesize closureStressGradEst;
@synthesize brittlenessIndexEst;
@synthesize densityPorositySlider;
@synthesize neutronPorositySlider;
@synthesize gammaRaySlider;
@synthesize resistivitySlider;
@synthesize porePressureSlider;
@synthesize overburdenSlider;
@synthesize techtonicGradSlider;
@synthesize fluidDensitySlider;
@synthesize dtcSlider;
@synthesize dtsSlider;
@synthesize ParameterDict;
@synthesize pickerView, rockProperties;
@synthesize tableView,popover;
@synthesize isLogMatrix, isEAS, selectEAS, selectLogMatrix, selectedRowEAS, selectedRowLogMatrix, logMatrixArray,estimatedAcousticSlownessArray;
@synthesize softRock = _softRock;
@synthesize tightSand = _tightSand;
@synthesize carbonates = _carbonates;
@synthesize shale = _shale;
@synthesize infoButton, resultsButton, techGradBorderButton;
@synthesize denBorderButton;
@synthesize neutBorderButton;
@synthesize grBorderButton;
@synthesize poreBorderButton;
@synthesize overBorderButton;
@synthesize resBorderButton;//already have this one
@synthesize fluidBorderButton;
@synthesize matrixBorderButton;
@synthesize dtcBorderButton;
@synthesize dtsBorderButton;
@synthesize estBorderButton;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    float width = 3.0;
    float radius = 10.0;
    
    [self.resultsButton.layer setBorderWidth:width];
    [self.resultsButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.resultsButton.layer setCornerRadius:radius];
    [self.techGradBorderButton.layer setBorderWidth:width];
    [self.techGradBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.techGradBorderButton.layer setCornerRadius:radius];

    
    [self.denBorderButton.layer setBorderWidth:width];
    [self.denBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.denBorderButton.layer setCornerRadius:radius];
    [self.neutBorderButton.layer setBorderWidth:width];
    [self.neutBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.neutBorderButton.layer setCornerRadius:radius];
  
    [self.grBorderButton.layer setBorderWidth:width];
    [self.grBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.grBorderButton.layer setCornerRadius:radius];
    [self.poreBorderButton.layer setBorderWidth:width];
    [self.poreBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.poreBorderButton.layer setCornerRadius:radius];
 
    [self.overBorderButton.layer setBorderWidth:width];
    [self.overBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.overBorderButton.layer setCornerRadius:radius];
    [self.fluidBorderButton.layer setBorderWidth:width];
    [self.fluidBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.fluidBorderButton.layer setCornerRadius:radius];
    
    [self.matrixBorderButton.layer setBorderWidth:width];
    [self.matrixBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.matrixBorderButton.layer setCornerRadius:radius];
    [self.dtcBorderButton.layer setBorderWidth:width];
    [self.dtcBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.dtcBorderButton.layer setCornerRadius:radius];

    [self.dtsBorderButton.layer setBorderWidth:width];
    [self.dtsBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.dtsBorderButton.layer setCornerRadius:radius];
    [self.estBorderButton.layer setBorderWidth:width];
    [self.estBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.estBorderButton.layer setCornerRadius:radius];
    
    [self.resBorderButton.layer setBorderWidth:width];
    [self.resBorderButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.resBorderButton.layer setCornerRadius:radius];
    
    self.rockProperties = [[RockProperties alloc] init];
    [self.rockProperties addObserver:self forKeyPath:@"densityPorosity" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"neutronPorosity" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"gammaRay" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"resistivity" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"DTC" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"DTS" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"porePressureGrad" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"overburdenGrad" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"techtonicGrad" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"fluidDensity" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"dtcEst" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"dtsEst" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"poissonsRatioSonic" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"youngsModulusSonic" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"closureStressGradSonic" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"brittlenessIndexSonic" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"poissonsRatioEst" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"youngsModulusEst" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"closureStressGradEst" options:NSKeyValueObservingOptionNew context:nil];
    [self.rockProperties addObserver:self forKeyPath:@"brittlenessIndexEst" options:NSKeyValueObservingOptionNew context:nil];

	
    //load arrays with parameters. Move this to it's own method to load from a dictionary plist
    
    self.logMatrixArray = [[NSMutableArray alloc] init];
    //[self.logMatrixArray addObject:@""];
     [self.logMatrixArray addObject:@"Sand"];
    [self.logMatrixArray addObject:@"Lime"];
   
    
    
    self.estimatedAcousticSlownessArray = [[NSMutableArray alloc] init];
   // [self.estimatedAcousticSlownessArray addObject:@""];
    [self.estimatedAcousticSlownessArray addObject:@"Soft Rock"];
    [self.estimatedAcousticSlownessArray addObject:@"Tight Sand"];
    [self.estimatedAcousticSlownessArray addObject:@"Carbonates"];
    [self.estimatedAcousticSlownessArray addObject:@"Shale"];
    
     
    [densityPorositySlider setAccessibilityLabel:NSLocalizedString(@"densityPorosity", @"densityPorosity")];
    
    [neutronPorositySlider setAccessibilityLabel:NSLocalizedString(@"neutronPorosity", @"neutronPorosity")];
    [gammaRaySlider setAccessibilityLabel:NSLocalizedString(@"gammaRay", @"gammaRay")];
    
    [resistivitySlider setAccessibilityLabel:NSLocalizedString(@"resistivity", @"resistivity")];
    [porePressureSlider setAccessibilityLabel:NSLocalizedString(@"porePressureGrad", @"porePressureGrad")];
    
    [overburdenSlider setAccessibilityLabel:NSLocalizedString(@"overburdenGrad", @"overburdenGrad")];
    [techtonicGradSlider setAccessibilityLabel:NSLocalizedString(@"techtonicGrad", @"techtonicGrad")];
    
    [fluidDensitySlider setAccessibilityLabel:NSLocalizedString(@"fluidDensity", @"fluidDensity")];
    [dtcSlider setAccessibilityLabel:NSLocalizedString(@"DTC", @"DTC")];
    
    [dtsSlider setAccessibilityLabel:NSLocalizedString(@"DTS", @"DTS")];

    [pickerView reloadAllComponents];
    
 
    
    [self resetUI];
    [self.rockProperties calculateFromSonic];
    [self.rockProperties calculateEstimate];


}


-(IBAction)sliderValueChanged:(id)sender{
    
   
    UISlider *theSlider = sender;
    NSNumber *value = [NSNumber numberWithFloat: theSlider.value];

    if([theSlider.accessibilityLabel compare:@"resistivity"] == NSOrderedSame){
        value = [NSNumber numberWithFloat:powf(10, theSlider.value)];
    }
    
    [self.rockProperties setValue:value forKey:theSlider.accessibilityLabel];
    //NSLog(@"Slider %@ changed. Value: %d", theSlider.accessibilityLabel,FuncRound(theSlider.value,2));
    
    [self.rockProperties calculateFromSonic];
    [self.rockProperties calculateEstimate];

    
   }
-(IBAction)logMatrixButtonPressed:(id)sender{
    UITableViewController *tempVC = [[UITableViewController alloc] init];
    //self.tableView = [[UITableView alloc]init];
    //self.tableView.dataSource = self;
   // self.tableView.delegate = self;
    self.isLogMatrix = YES;
    self.isEAS = NO;
    [tempVC setTableView:self.tableView];
    tempVC.contentSizeForViewInPopover = CGSizeMake(100, self.logMatrixArray.count*44);
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:tempVC];
    self.popover.delegate = self;
    [self.popover presentPopoverFromRect:self.selectLogMatrix.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(IBAction)eASButtonPressed:(id)sender{
    UITableViewController *tempVC = [[UITableViewController alloc] init];
    self.tableView = [[UITableView alloc]init];
   // self.tableView.dataSource = self;
   // self.tableView.delegate = self;
    
    self.isLogMatrix = NO;
    self.isEAS = YES;
    tempVC.view = self.tableView;
    
    tempVC.contentSizeForViewInPopover = CGSizeMake(200, self.estimatedAcousticSlownessArray.count*44);
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:tempVC];
    self.popover.delegate = self;
    [self.popover presentPopoverFromRect:self.selectEAS.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

  }


-(void)infoButtonPressed:(id)sender{
    InfoViewController *info = [[InfoViewController alloc]initWithNibName:@"InfoViewController" bundle:nil];
 info.delegate = self;
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backButtonPressed:)];
    info.navigationItem.title = @"About";
    info.navigationItem.rightBarButtonItem = button;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:info];
    
    navController.modalInPopover = YES;
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
   
   
    
    
    [self presentModalViewController:navController animated:YES];
    [button release];

    
    
}

-(void)backButtonPressed:(id)sender{
    [self dismissModalViewControllerAnimated:YES];                                           
}
// KVO observation method
- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context {
    
    //  change gives back an NSDictionary of changes
    NSNumber *newValue = [change valueForKey:NSKeyValueChangeNewKey];
       // update the appropriate label
    if (keyPath == @"densityPorosity") {
        self.densityPorosity.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
        NSLog(@"%@",[NSString stringWithFormat:@"%.02f", newValue]);
    }
    else if (keyPath == @"neutronPorosity") {
        self.neutronPorosity.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    else if (keyPath == @"gammaRay") {
        self.gammaRay.text = [NSString stringWithFormat:@"%.f", [newValue floatValue]];
    }
    else if (keyPath == @"resistivity") {
        self.resistivity.text = [NSString stringWithFormat:@"%.01f", [newValue floatValue]];
    }
    else if (keyPath == @"porePressureGrad") {
        self.porePressureGrad.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    else if (keyPath == @"overburdenGrad") {
        self.overburdenGrad.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    else if (keyPath == @"techtonicGrad") {
        self.techtonicGrad.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    else if (keyPath == @"fluidDensity") {
        self.fluidDensity.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    
    else if (keyPath == @"DTC") {
        self.DTC.text = [NSString stringWithFormat:@"%.01f", [newValue floatValue]];
    }
    else if (keyPath == @"DTS") {
        self.DTS.text = [NSString stringWithFormat:@"%.01f", [newValue floatValue]];
    }
    else if (keyPath == @"poissonsRatioSonic") {
        self.poissonsRatioSonic.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    else if (keyPath == @"youngsModulusSonic") {
        self.youngsModulusSonic.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    else if (keyPath == @"dtcEst") {
        self.dtcEst.text = [NSString stringWithFormat:@"%.01f", [newValue floatValue]];
    }
    else if (keyPath == @"dtsEst") {
        self.dtsEst.text = [NSString stringWithFormat:@"%.01f", [newValue floatValue]];
    }
    else if (keyPath == @"poissonsRatioEst") {
        self.poissonsRatioEst.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    else if (keyPath == @"youngsModulusEst") {
        self.youngsModulusEst.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    else if (keyPath == @"closureStressGradSonic") {
        self.closureStressGradSonic.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    else if (keyPath == @"brittlenessIndexSonic") {
        self.brittlenessIndexSonic.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    else if (keyPath == @"closureStressGradEst") {
        self.closureStressGradEst.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }
    else if (keyPath == @"brittlenessIndexEst") {
        self.brittlenessIndexEst.text = [NSString stringWithFormat:@"%.02f", [newValue floatValue]];
    }  
    
}

- (void)viewDidUnload
{
    [self.rockProperties removeObserver:self forKeyPath:@"densityPorosity"];
    [self.rockProperties removeObserver:self forKeyPath:@"neutronPorosity"];
    [self.rockProperties removeObserver:self forKeyPath:@"gammaRay"];
    [self.rockProperties removeObserver:self forKeyPath:@"resistivity"];
    [self.rockProperties removeObserver:self forKeyPath:@"DTC"];
    [self.rockProperties removeObserver:self forKeyPath:@"DTS"];
    [self.rockProperties removeObserver:self forKeyPath:@"porePressureGrad"];
    [self.rockProperties removeObserver:self forKeyPath:@"overburnedGrad"];
    [self.rockProperties removeObserver:self forKeyPath:@"techtonicGrad"];
    [self.rockProperties removeObserver:self forKeyPath:@"fluidDensity"];
    [self.rockProperties removeObserver:self forKeyPath:@"dtcEst"];
    [self.rockProperties removeObserver:self forKeyPath:@"dtsEst"];
    [self.rockProperties removeObserver:self forKeyPath:@"poissonsRatioSonic"];
    [self.rockProperties removeObserver:self forKeyPath:@"youngsModulusSonic"];
    [self.rockProperties removeObserver:self forKeyPath:@"closureStressGradSonic"];
    [self.rockProperties removeObserver:self forKeyPath:@"brittlenessIndexSonic"];
    [self.rockProperties removeObserver:self forKeyPath:@"poissonsRatioEst"];
    [self.rockProperties removeObserver:self forKeyPath:@"youngsModulusEst"];
    [self.rockProperties removeObserver:self forKeyPath:@"closureStressGradEst"];
    [self.rockProperties removeObserver:self forKeyPath:@"brittlenessIndexEst"];
    
    
    [self setDensityPorosity:nil];
    [self setNeutronPorosity:nil];
    [self setDensityPorositySlider:nil];
    [self setNeutronPorositySlider:nil];
    [self setGammaRay:nil];
    [self setResistivity:nil];
    [self setPorePressureGrad:nil];
    [self setOverburdenGrad:nil];
    [self setTechtonicGrad:nil];
    [self setFluidDensity:nil];
    [self setDTC:nil];
    [self setDTS:nil];
    [self setDtcEst:nil];
    [self setDtsEst:nil];
    [self setGammaRaySlider:nil];
    [self setResistivitySlider:nil];
    [self setPorePressureSlider:nil];
    [self setOverburdenSlider:nil];
    [self setTechtonicGradSlider:nil];
    [self setFluidDensitySlider:nil];
    [self setDtcSlider:nil];
    [self setDtsSlider:nil];
    [self setPoissonsRatioSonic:nil];
    [self setYoungsModulusSonic:nil];
    [self setClosureStressGradSonic:nil];
    [self setBrittlenessIndexSonic:nil];
    [self setPoissonsRatioEst:nil];
    [self setYoungsModulusEst:nil];
    [self setClosureStressGradEst:nil];
    [self setBrittlenessIndexEst:nil];
    
    self.softRock = nil;
    self.tightSand = nil;
    self.carbonates = nil;
    self.shale = nil;
    self.infoButton = nil;
    self.resultsButton= nil;
    self.techGradBorderButton= nil;
    self.denBorderButton= nil;
    self.neutBorderButton= nil;
    self.grBorderButton= nil;
    self.poreBorderButton= nil;
    self.overBorderButton= nil;
    self.resBorderButton= nil;
    self.fluidBorderButton= nil;
    self.matrixBorderButton= nil;
    self.dtcBorderButton= nil;
    self.dtsBorderButton= nil;
    self.estBorderButton= nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        //[pickerView selectRow:1 inComponent:0 animated:NO];
    [pickerView selectRow:1 inComponent:1 animated:NO];
    [self resetUI];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if(interfaceOrientation ==  UIInterfaceOrientationPortrait || interfaceOrientation ==UIInterfaceOrientationPortraitUpsideDown)
    return YES;
    else {
        return NO;
    }
}
 
/*
#pragma mark
#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.isEAS)
        return [self.array2 count];
    else if(self.isLogMatrix)
    { 
      return [self.array1 count];
    }
       
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    static NSString *identifier = @"Cell";
    
    int row = indexPath.row;
    
    cell = [atableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        
    }
    
    if(self.isEAS){
        cell.textLabel.text = [array2 objectAtIndex:row];
    }
    else if(self.isLogMatrix){
        cell.textLabel.text = [array1 objectAtIndex:row];

    }
    else
        cell.textLabel.text = @"Row";
    return  cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int row = indexPath.row;
    
    if(self.isEAS){
        self.selectEAS.titleLabel.text = [self.array2 objectAtIndex:row];
         self.selectedRowEAS = [self.array2 objectAtIndex:row];
        [self.popover dismissPopoverAnimated:YES];
    }
    else if(self.isLogMatrix){
        self.selectLogMatrix.titleLabel.text = [self.array1 objectAtIndex:row];
        self.selectedRowLogMatrix = [self.array1 objectAtIndex:row];
          [self.popover dismissPopoverAnimated:YES];
    }
}
*/
-(IBAction)clearButtonPressed:(id)sender{
    [self resetUI];
  }
-(void)resetUI{
    [self.rockProperties clear];
    
    
    Parameters *params = [[Parameters alloc] init];
    [params setDTCPHIAMULT:90];
    [params setDTSPHINOFFSET:56];
    [params setDTCPHINMULT:90];
    [params setDTCPHINOFFSET:56];
    [params setDTCPHIDMULT:140];
    [params setDTCPHIDOFFSET:52];
    [params setDTCGRMULT:.4];
    [params setDTCGROFFFSET:50];
    [params setDTCRTMULT:.11];
    [params setDTCRTOFFSET:75];
    [params setDTSRTMULT:.9];
    [params setDTSRTOFFSET:100];
    [params setDTSPHINMULT:281];
    [params setDTSPHINOFFSET:80];
    [params setVRATMULT:.95];
    [params setVRATOFFSET:-.81];
    [params setPRGREXP:.05];
    [params setPRGRMULT:.2];
    [params setYMDtoYMS:.8];
    [params setBiotsAlpha:1];
    [params setDTCma:55.5];
    [params setDTSma:90];
    [self.rockProperties setParams:params];
    [self.rockProperties setLogMatrix:@"Sand"];
    [params release];

    self.densityPorositySlider.value = 0.0;
    self.neutronPorositySlider.value = 0.0;
    self.gammaRaySlider.value = 0.0;
    self.resistivitySlider.value =  -0.698970004;//[[NSNumber numberWithFloat:logf(1.58489319)] floatValue];
    self.porePressureSlider.value = 0.433;
    self.overburdenSlider.value = 1.05;
    self.techtonicGradSlider.value = 0.0;
    self.fluidDensitySlider.value = 1.0;
    self.dtcSlider.value = 40.0;
    self.dtsSlider.value = 40.0;
    

    [pickerView selectRow:0 inComponent:0 animated:YES];
    [pickerView selectRow:0 inComponent:1 animated:NO];

    
    [self.rockProperties calculateFromSonic];
    [self.rockProperties calculateEstimate];

//    
//    self.dtcEst.text = @"";
//    self.dtsEst.text = @"";
//    self.poissonsRatioEst.text = @"";
//    self.poissonsRatioSonic.text = @"";
//    self.youngsModulusEst.text = @"";
//    self.youngsModulusSonic.text = @"";
//    self.closureStressGradEst.text = @"";
//    self.closureStressGradSonic.text = @"";
//    self.brittlenessIndexEst.text = @"";
//    self.brittlenessIndexSonic.text = @"";
    
}
#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return [logMatrixArray count];
    }
    return [estimatedAcousticSlownessArray  count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (component == 0) {
        return [logMatrixArray objectAtIndex:row];
    }
    return [estimatedAcousticSlownessArray objectAtIndex:row];
} 
#pragma mark -
#pragma mark PickerView Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
     NSLog(@"Attempting to load params...");
    if (component == 0)
    {
        [self.rockProperties setLogMatrix:[logMatrixArray objectAtIndex:row]];
        
        
        
    } else {
        if(row == 0)//soft rock
        {
            Parameters *params = [[Parameters alloc] init];
            [params setDTCPHIAMULT:143.0];
            [params setDTCPHIAOFFSET:45.0];
            [params setDTCPHINMULT:115.0];
            [params setDTCPHINOFFSET:47.0];
            [params setDTCPHIDMULT:100.0];
            [params setDTCPHIDOFFSET:51.0];
            [params setDTCGRMULT:.16];
            [params setDTCGROFFFSET:45.0];
            [params setDTCRTMULT:.046];
            [params setDTCRTOFFSET:58.0];
            [params setDTSRTMULT:.49];
            [params setDTSRTOFFSET:84.0];
            [params setDTSPHINMULT:232.0];
            [params setDTSPHINOFFSET:83.0];
            [params setVRATMULT:.81];
            [params setVRATOFFSET:-.53];
            [params setPRGREXP:.05];
            [params setPRGRMULT:.2];
            [params setYMDtoYMS:.5];
            [params setBiotsAlpha:.6];
            [params setDTCma:57.5];
            [params setDTSma:88.8];
            [params setVRAT:1.6];

            [self.rockProperties setParams:params];
            NSLog(@"Attempting to load params...");
            [params release];
        }
        else if(row==1)//tight sand
        {
            Parameters *params = [[Parameters alloc] init];
            [params setDTCPHIAMULT:106.0];
            [params setDTCPHIAOFFSET:60.0];
            [params setDTCPHINMULT:96.0];
            [params setDTCPHINOFFSET:58.0];
            [params setDTCPHIDMULT:149.0];
            [params setDTCPHIDOFFSET:52.0];
            [params setDTCGRMULT:.4];
            [params setDTCGROFFFSET:55.0];
            [params setDTCRTMULT:.11];
            [params setDTCRTOFFSET:64.0];
            [params setDTSRTMULT:.4];
            [params setDTSRTOFFSET:94.0];
            [params setDTSPHINMULT:281.0];
            [params setDTSPHINOFFSET:80.0];
            [params setVRATMULT:.91];
            [params setVRATOFFSET:-.81];
            [params setPRGREXP:.05];
            [params setPRGRMULT:.2];
            [params setYMDtoYMS:.8];
            [params setBiotsAlpha:.9];
            [params setDTCma:51.5];
            [params setDTSma:88.8];
            [params setVRAT:1.6];
            
            [self.rockProperties setParams:params];
            [params release];
        }
        else if(row==2)//carbonates
        {
            Parameters *params = [[Parameters alloc] init];
            [params setDTCPHIAMULT:154.0];
            [params setDTCPHIAOFFSET:58.0];
            [params setDTCPHINMULT:120.0];
            [params setDTCPHINOFFSET:53.0];
            [params setDTCPHIDMULT:234.0];
            [params setDTCPHIDOFFSET:57.0];
            [params setDTCGRMULT:1.0];
            [params setDTCGROFFFSET:0.0];
            [params setDTCRTMULT:.12];
            [params setDTCRTOFFSET:56.0];
            [params setDTSRTMULT:.37];
            [params setDTSRTOFFSET:94.0];
            [params setDTSPHINMULT:291.0];
            [params setDTSPHINOFFSET:80.0];
            [params setVRATMULT:1.33];
            [params setVRATOFFSET:-1.2];
            [params setPRGREXP:.05];
            [params setPRGRMULT:.2];
            [params setYMDtoYMS:.8];
            [params setBiotsAlpha:1.0];
            [params setDTCma:50];
            [params setDTSma:89.9];
            [params setVRAT:1.9];
            
            [self.rockProperties setParams:params];
            [params release];
        }
        else if(row==3)//shale
        {
            Parameters *params = [[Parameters alloc] init];
            [params setDTCPHIAMULT:155.0];
            [params setDTCPHIAOFFSET:58.0];
            [params setDTCPHINMULT:161.0];
            [params setDTCPHINOFFSET:44.0];
            [params setDTCPHIDMULT:297.0];
            [params setDTCPHIDOFFSET:68.0];
            [params setDTCGRMULT:1.0];
            [params setDTCGROFFFSET:0.0];
            [params setDTCRTMULT:.19];
            [params setDTCRTOFFSET:61.0];
            [params setDTSRTMULT:.37];
            [params setDTSRTOFFSET:109.0];
            [params setDTSPHINMULT:316.0];
            [params setDTSPHINOFFSET:76.0];
            [params setVRATMULT:1.1];
            [params setVRATOFFSET:-1.4];
            [params setPRGREXP:.05];
            [params setPRGRMULT:.2];
            [params setYMDtoYMS:.8];
            [params setBiotsAlpha:1.0];
            [params setDTCma:55.5];
            [params setDTSma:90.0];

             [params setVRAT:1.7];
            [self.rockProperties setParams:params];
            [params release];
        }
    }
    [self.rockProperties calculateFromSonic];
    [self.rockProperties calculateEstimate];
}
- (void)dealloc {
    [densityPorosity release];
    [neutronPorosity release];
    [densityPorositySlider release];
    [neutronPorositySlider release];
    [gammaRay release];
    [resistivity release];
    [porePressureGrad release];
    [overburdenGrad release];
    [techtonicGrad release];
    [fluidDensity release];
    [DTC release];
    [DTS release];
    [dtcEst release];
    [dtsEst release];
    [gammaRaySlider release];
    [resistivitySlider release];
    [porePressureSlider release];
    [overburdenSlider release];
    [techtonicGradSlider release];
    [fluidDensitySlider release];
    [dtcSlider release];
    [dtsSlider release];
    [poissonsRatioSonic release];
    [youngsModulusSonic release];
    [closureStressGradSonic release];
    [brittlenessIndexSonic release];
    [poissonsRatioEst release];
    [youngsModulusEst release];
    [closureStressGradEst release];
    [brittlenessIndexEst release];
    
   [_softRock release];
   [_tightSand release];
   [_carbonates release];
   [_shale release];
   [infoButton release];
   [resultsButton release];
   [techGradBorderButton release];
[denBorderButton release];
   [neutBorderButton release];
   [grBorderButton release];
   [poreBorderButton release];
   [overBorderButton release];
   [resBorderButton release];
   [fluidBorderButton release];
   [matrixBorderButton release];
   [dtcBorderButton release];
   [dtsBorderButton release];
   [estBorderButton release];
    
    [super dealloc];
}
@end