//
//  DefaultsController.h
//  tipcalculator
//
//  Created by Miles Spielberg on 12/22/14.
//  Copyright (c) 2014 OrionNet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefaultsController : NSObject
+ (NSInteger)defaultTipRatio;
+ (void)setDefaultTipTo:(NSInteger)amount;
+ (void)setPreviousBillOf:(NSNumber*)amount;
+ (NSNumber *)previousBill;
@end
