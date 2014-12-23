//
//  TipViewController.m
//  tipcalculator
//
//  Created by Miles Spielberg on 12/22/14.
//  Copyright (c) 2014 OrionNet. All rights reserved.
//

#import "DefaultsController.h"
#import "TipViewController.h"
#import "TipPickerDelegate.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *tipRatioButton;
@property (weak, nonatomic) IBOutlet UIPickerView *tipPicker;
@property (strong, nonatomic) IBOutlet TipPickerDelegate *tipPickerDelegate;


@property NSInteger tipRatio;
@property NSInteger pickerYShown;
@property NSInteger pickerYHidden;

@end

@implementation TipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Tip Calculator";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    NSNumber *previousBill = [DefaultsController previousBill];
    if (previousBill) {
        self.billTextField.text = [NSString stringWithFormat:@"%.2f", [previousBill floatValue]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    self.tipRatio = [DefaultsController defaultTipRatio];
    [self updateValues];
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

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self hideTipRatioPicker];
    [self updateValues];
}

- (IBAction)onBillTextFieldChanged:(id)sender {
    [DefaultsController setPreviousBillOf:[NSNumber numberWithFloat:[self.billTextField.text floatValue]]];
    [self updateValues];
}

- (void)updateValues {
    [self.tipRatioButton setTitle:[NSString stringWithFormat:@"%ld%%", (long)self.tipRatio] forState:UIControlStateNormal];
    [self.tipPicker selectRow:self.tipRatio inComponent:0 animated:NO];
    float billAmount = [self.billTextField.text floatValue];
    float tipAmount = billAmount * self.tipRatio / 100;
    float totalAmount = billAmount + tipAmount;
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (IBAction)onTipAmountButton:(id)sender {
    [self.view endEditing:YES];
    if (self.tipPicker.hidden) {
        [self showTipRatioPicker];
    } else {
        [self hideTipRatioPicker];
    }
}

- (void)onTipPicked:(NSInteger)amount {
    self.tipRatio = amount;
    [self updateValues];
}

- (void)hideTipRatioPicker {
    [self setupPickerCoordinates];
    [self slewPickerTo:self.pickerYShown];
    [UIView animateWithDuration:0.2 animations:^{
        [self slewPickerTo:self.pickerYHidden];
    } completion:^(BOOL finished){
        self.tipPicker.hidden = YES;
    }];
}

- (void)showTipRatioPicker {
    [self setupPickerCoordinates];
    [self slewPickerTo:self.pickerYHidden];
    self.tipPicker.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        [self slewPickerTo:self.pickerYShown];
    }];
}

- (void)slewPickerTo:(NSInteger)y {
    self.tipPicker.center = (CGPoint){self.tipPicker.center.x, y};
}

- (void)setupPickerCoordinates {
    if (!self.pickerYShown) {
        self.pickerYShown = self.tipPicker.center.y;
        self.pickerYHidden = self.tipPicker.bounds.size.height + self.pickerYShown;
    }
}

@end
