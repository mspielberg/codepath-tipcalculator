//
//  DefaultTipPickerDelegate.m
//  tipcalculator
//
//  Created by Miles Spielberg on 12/22/14.
//  Copyright (c) 2014 OrionNet. All rights reserved.
//

#import "TipPickerDelegate.h"

@interface TipPickerDelegate ()

@property NSArray *tipLevels;

@end

@implementation TipPickerDelegate

- (TipPickerDelegate *)init {
    NSMutableArray *levels = [NSMutableArray arrayWithCapacity:26];
    for (int i = 0; i < 26; i++) levels[i] = [NSNumber numberWithInt:i];
    self.tipLevels = levels;
    return [super init];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 26;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d%%", [self.tipLevels[row] intValue]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.delegate onTipPicked:row];
}

@end
