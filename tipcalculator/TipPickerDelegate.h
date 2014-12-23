//
//  DefaultTipPickerDelegate.h
//  tipcalculator
//
//  Created by Miles Spielberg on 12/22/14.
//  Copyright (c) 2014 OrionNet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIPickerView.h>


@protocol TipPicked

-(void) onTipPicked:(NSInteger)tipRatio;

@end

@interface TipPickerDelegate : NSObject<UIPickerViewDataSource,UIPickerViewDelegate>

@property IBOutlet id<TipPicked> delegate;

@end
