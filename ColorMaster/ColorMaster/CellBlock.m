//
//  CellBlock.m
//  ColorMaster
//
//  Created by long on 15-6-8.
//  Copyright (c) 2015年 long. All rights reserved.
//

#import "CellBlock.h"
#import "ViewController.h"

@implementation CellBlock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithInfo:(CGRect)frame indexX:(int)indexX indexY:(int)indexY delegate:(ViewController *)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.indexX = indexX;
        self.indexY = indexY;
        self.delegate = delegate;
        self.layer.cornerRadius = 3;
        self.currentColor = 1;
        [self updateBgColor];
    }
    [delegate.view addSubview:self];
    
    UITapGestureRecognizer *utap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    [self addGestureRecognizer:utap];
    
    return self;
}

- (void) tapped{
    [self.delegate tapDelegate:self.indexX y:self.indexY];
}

- (void)updateBgColor{
    if (self.currentColor == 1) {
        self.backgroundColor = [[UIColor alloc]initWithRed:0.574 green:0.766 blue:0.383 alpha:0.8];
    } else {
        self.backgroundColor = [[UIColor alloc]initWithRed:0.37 green:0.543 blue:0.824 alpha:0.8];
    }
}

@end
