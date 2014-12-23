//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Miles Spielberg on 12/22/14.
//  Copyright (c) 2014 OrionNet. All rights reserved.
//

#import "SettingsViewController.h"
#import "DefaultsController.h"
#import "TipPickerDelegate.h"

@interface SettingsViewController ()
@property (strong, nonatomic) IBOutlet NSObject *defaultTipPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *tipPicker;
@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Settings";
    
    [self.tipPicker selectRow:[DefaultsController defaultTipRatio] inComponent:0 animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)onTipPicked:(NSInteger)tipRatio {
    [DefaultsController setDefaultTipTo:tipRatio];
}

@end
