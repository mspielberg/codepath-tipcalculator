//
//  DefaultsController.m
//  tipcalculator
//
//  Created by Miles Spielberg on 12/22/14.
//  Copyright (c) 2014 OrionNet. All rights reserved.
//

#import "DefaultsController.h"

@implementation DefaultsController

+ (void)setDefaultTipTo:(NSInteger)amount {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:amount forKey:@"defaultTip"];
    [defaults synchronize];
}

+ (NSInteger)defaultTipRatio {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL defaultTipExists = [defaults objectForKey:@"defaultTip"];
    NSInteger defaultTip = [defaults integerForKey:@"defaultTip"];
    
    if (defaultTipExists && defaultTip <= 25) {
        return defaultTip;
    } else {
        return 15;
    }
}

+ (void)setPreviousBillOf:(NSNumber*)amount {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *previousBill = @{
        @"timestamp":[NSDate date],
        @"amount":amount,
    };
    [defaults setObject:previousBill forKey:@"previousBill"];
}

+ (NSNumber *)previousBill {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *previousBill = [defaults dictionaryForKey:@"previousBill"];
    
    NSDate *timestamp = [previousBill valueForKey:@"timestamp"];
    NSNumber *amount = [previousBill valueForKey:@"amount"];
    
    if (timestamp && amount && [amount doubleValue] >= 0.0 && [timestamp timeIntervalSinceNow] > -60) {
        return amount;
    } else {
        return nil;
    }
}

@end
