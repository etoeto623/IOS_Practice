//
//  ViewController.m
//  ColorMaster
//
//  Created by long on 15-6-8.
//  Copyright (c) 2015年 long. All rights reserved.
//

#import "ViewController.h"
#import "CellBlock.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property int screenWidth;
@property int screenHeight;
@property int currentLevel;
@property int padding;
@property int cellPadding;
@property float cellSize;
@property int tapTimes;
@property BOOL isGameEnd;
@property NSMutableArray *nma;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.screenWidth = self.view.bounds.size.width;
    self.screenHeight = self.view.bounds.size.height;
    self.currentLevel = 2;
    self.padding = 10;
    self.cellPadding = 3;
    self.tapTimes = 0;
    self.cellSize = [self getCellSize];
    self.isGameEnd = NO;
    self.nma = [[NSMutableArray alloc]init];
    
    [self drawBgBlock];
    [self drawCells:self.currentLevel];
    
    UITapGestureRecognizer *ut = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:ut];
}

-(void) tapView{
    if (self.isGameEnd) {
        [self levelUp];
    }
}

// 绘制背景色块
- (void)drawBgBlock{
    float size = self.screenWidth- 2*self.padding;
    float x = self.padding;
    float y = (self.screenHeight - size)/2;
    
    UIView *uv = [[UIView alloc]initWithFrame:(CGRectMake(x, y, size, size))];
    uv.layer.cornerRadius = 4;
    uv.backgroundColor = [UIColor grayColor];
    [self.view addSubview:uv];
}

// 获取cell的大小
- (float) getCellSize{
    return (self.screenWidth- 2*self.padding - (self.currentLevel+1)*self.cellPadding)/self.currentLevel;
}

// 获取指定位置的cell的坐标
- (CGPoint) getCellOrigin:(int)indexX indexY:(int)indexY{
    float x = self.padding + (self.cellSize + self.cellPadding)*indexX + self.cellPadding;
    float y = (self.screenHeight - self.screenWidth + 2*self.padding)/2 + (self.cellSize + self.cellPadding)*indexY + self.cellPadding;
    return CGPointMake(x, y);
}

// 获取cell的大小
- (CGSize) getCelSize{
    return CGSizeMake(self.cellSize, self.cellSize);
}

//绘制cell
- (void) drawCells:(int)level{
    for (int i = 0; i < level; i++) {
        NSMutableArray *nm = [[NSMutableArray alloc]init];
        for (int j = 0; j < level; j++) {
            CGPoint cp = [self getCellOrigin:i indexY:j];
            CGSize cs = [self getCelSize];
            
            [nm addObject:[[CellBlock alloc]initWithInfo:CGRectMake(cp.x, cp.y, cs.width, cs.height) indexX:j indexY:i delegate:self]];
        }
        [self.nma addObject:nm];
    }
}

- (void)tapDelegate:(int)x y:(int)y{
    for (int i = 0; i < self.currentLevel; i++) {
        for (int j = 0; j < self.currentLevel; j++) {
            CellBlock *cb = [[self.nma objectAtIndex:i] objectAtIndex:j];
            if ((abs(i - y) <= 1 && j == x) || (abs(j - x) <= 1 && i == y)) {
                [cb setCurrentColor:cb.currentColor*-1];
                [cb updateBgColor];
            }
        }
    }
    self.tapTimes += 1;
    [self showScore];
    
    self.isGameEnd = [self isWin];
    if (self.isGameEnd) {
        UIAlertView *ua = [[UIAlertView alloc]initWithTitle:@"Congratulations" message:[NSString stringWithFormat:@"Mission Completed,点击了%d次",self.tapTimes] delegate:self cancelButtonTitle:@"我碉堡了" otherButtonTitles:@"下一关", nil];
        [ua show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1 ) {
        [self levelUp];
    }
}

-(void)showScore{
    self.scoreLabel.text = [NSString stringWithFormat:@"点击次数:%d",self.tapTimes];
}

- (void)levelUp{
    [self cleanMess];
    self.isGameEnd = NO;
    self.currentLevel += 1;
    self.cellSize = [self getCellSize];
    [self drawCells:self.currentLevel];
}

- (void)cleanMess{
    for (int i = 0; i < self.currentLevel; i++) {
        for (int j = 0; j < self.currentLevel; j++) {
            CellBlock *cb = [[self.nma objectAtIndex:i] objectAtIndex:j];
            [cb removeFromSuperview];
        }
    }
    self.tapTimes = 0;
    [self showScore];
    self.nma = [[NSMutableArray alloc]init];
}

- (BOOL)isWin{
    for (int i = 0; i < self.currentLevel; i++) {
        for (int j = 0; j < self.currentLevel; j++) {
            CellBlock *cb = [[self.nma objectAtIndex:i] objectAtIndex:j];
            if (cb.currentColor == 1) {
                return NO;
            }
        }
    }
    return YES;
}

@end
