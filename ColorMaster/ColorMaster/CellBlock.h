//
//  CellBlock.h
//  ColorMaster
//
//  Created by long on 15-6-8.
//  Copyright (c) 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface CellBlock : UIView

@property CGRect cellRect;
@property int indexX;
@property int indexY;
@property int currentColor;
@property ViewController *delegate;

- (id)initWithInfo:(CGRect)frame indexX:(int)indexX indexY:(int)indexY delegate:(ViewController*)delegate;
- (void)updateBgColor;
@end
