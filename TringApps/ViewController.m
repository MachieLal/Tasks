//
//  ViewController.m
//  TringApps
//
//  Created by Swarup_Pattnaik on 31/07/16.
//  Copyright © 2016 Swarup_Pattnaik. All rights reserved.
//

#import "ViewController.h"

#define gridColumns 4
#define viewSpacing 2
#define viewDimensionConstant 100
#define boxCount [[_numberOfBoxes text] intValue]


@interface ViewController () <UIScrollViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self printBoxes];
    
    self.areaScroller.delegate = self;
    [self.areaScroller addGestureRecognizer:self.tapRecognizer];
    
    self.areaScroller.showsHorizontalScrollIndicator = YES;
    self.areaScroller.showsVerticalScrollIndicator = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hideKeyboard];
}


- (IBAction)restoreBoxes:(UIButton *)sender {
    [self hideKeyboard];
    [self cleanUpScrollView];
    [self printBoxes];
}

- (IBAction)changeBoxes:(UIButton *)sender {
    [self hideKeyboard];
    [self cleanUpScrollView];
    
    CGFloat xAxis = viewSpacing;
    CGFloat yAxis = viewSpacing;
    CGFloat viewWidthConstant = viewDimensionConstant/10;
    CGFloat viewWidth = viewWidthConstant;

    CGFloat viewHeight = viewDimensionConstant;
    UIButton * button;
    
    int cols = gridColumns;
    int count = boxCount;
    int x = 0;
    int y = yAxis;
    while (count>0) {
        x = xAxis;
        for (int i = 1; i <= cols && count!= 0; i++, count--) {
            button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, viewWidth, viewHeight)];
            button.backgroundColor = [UIColor blueColor];
            
            [button setTitle:[NSString stringWithFormat:@"%d",boxCount-count+1] forState:UIControlStateNormal];
            button.tag = 420;
            [button addGestureRecognizer:self.tapRecognizer];
            [self.areaScroller addSubview:button];
            x = x + viewWidth + xAxis;
            viewWidth = viewWidthConstant * (boxCount-count+1);
        }
        y = y + viewHeight + yAxis;
    }
    self.areaScroller.contentSize = CGSizeMake((viewWidth + viewSpacing) * cols, y + viewHeight + viewHeight);
}
- (void)hideKeyboard {
    [_numberOfBoxes endEditing:YES];
}


- (void) printBoxes
{
    CGFloat xAxis = viewSpacing;
    CGFloat yAxis = viewSpacing;
    CGFloat viewWidth = viewDimensionConstant;
    CGFloat viewHeight = viewDimensionConstant;
    UIButton * button;
    
    int cols = gridColumns;
    int count = boxCount;
    int x = 0;
    int y = yAxis;
    while (count>0) {
        x = xAxis;
        for (int i = 1; i <= cols && count!= 0; i++, count--) {
            button = [[UIButton alloc] initWithFrame:CGRectMake(x, y, viewWidth, viewHeight)];
            button.backgroundColor = [UIColor blueColor];

            [button setTitle:[NSString stringWithFormat:@"%d",boxCount-count+1] forState:UIControlStateNormal];
            button.tag = 420;
            
            [button addGestureRecognizer:self.tapRecognizer];

            [self.areaScroller addSubview:button];
            x = x + viewWidth + xAxis;
        }
        y = y + viewHeight + yAxis;
    }
    
    self.areaScroller.contentSize = CGSizeMake((viewWidth + viewSpacing) * gridColumns, y + viewHeight + viewHeight);
}

- (void) cleanUpScrollView
{
    NSArray * subviews = [_areaScroller subviews];
    NSUInteger subViewCount = [subviews count];
    
    while (subViewCount > 0) {
        id viewAtIndex = [subviews objectAtIndex:--subViewCount];
        if ( [viewAtIndex isKindOfClass:[UIButton class]] && [viewAtIndex tag] == 420) {
            [viewAtIndex removeFromSuperview];
        }
    }
}

- (UITapGestureRecognizer *) tapRecognizer
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(hideKeyboard)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    
    return tapRecognizer;
}

@end
