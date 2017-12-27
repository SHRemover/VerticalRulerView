//
//  ViewController.m
//  RulerDemo
//
//  Created by gs_sh on 2017/12/18.
//  Copyright © 2017年 Remover. All rights reserved.
//

#import "ViewController.h"

#import "VerticalRuler.h"

#import "HorizontalRuler.h"
#import "HorizontalRulerView.h"
#import "SettingHorRulerView.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    VerticalRuler *ruler = [[VerticalRuler alloc] initWithFrame:(CGRectMake(50, 100, 20, 300))];
//
//    ruler.valueChanged = ^(CGFloat value, CGFloat persentageValue) {
//        NSLog(@"value:%f == persentageValue:%f", value, persentageValue);
//    };
//    [self.view addSubview:ruler];
    
    
//    HorizontalRuler *horRuler = [[HorizontalRuler alloc] initWithFrame:(CGRectMake(50, 450, 300, 10))];
//    horRuler.valueChanged = ^(CGFloat value, CGFloat persentageValue) {
//        NSLog(@"value:%f == persentageValue:%f", value, persentageValue);
//    };
//    [self.view addSubview:horRuler];
    
//    HorizontalRulerView *horRulerView = [[HorizontalRulerView alloc] initWithFrame:(CGRectMake(20, 100, 240, 120))];
//    horRulerView.backgroundColor = [UIColor cyanColor];
//    horRulerView.rulerTitleStr = @"Max-Load";
//    horRulerView.rulerUnitStr = @"kg";
//    horRulerView.rulerMinValue = 70;
//    horRulerView.rulerMaxValue = 120;
//    horRulerView.rulerInitValue = 100;
//
//    horRulerView.touchUpInside = ^(CGFloat value, CGFloat persentageValue) {
//        NSLog(@"value:%f -- persentageValue:%f", value, persentageValue);
//    };
//
//    [self.view addSubview:horRulerView];
    
    UIButton *add = [UIButton buttonWithType:(UIButtonTypeSystem)];
    add.frame = CGRectMake(100, 200, 100, 50);
    [add setTitle:@"add" forState:(UIControlStateNormal)];
    [add addTarget:self action:@selector(addView:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:add];
    
}

- (void)addView:(UIButton *)sender {
    
    SettingHorRulerView *view = [[SettingHorRulerView alloc] initWithFrame:self.view.bounds];
    view.titleStr = @"Stroke Setting";
    view.rulerMinValue = 60;
    view.rulerMaxValue = 125;
//    view.rulerUnitStr = @"kg";
    view.hasBottomSubView = YES;
    view.rulerSubTopInitValue = 85.2;
    view.rulerSubTopTitleStr = @"Max-Height";
    view.rulerSubBottomInitValue = 71.3;
    view.rulerSubBottomTitleStr = @"Min-Height";
    [self.view addSubview:view];
    
    view.touchUpInsideTopValue = ^(CGFloat value) {
        NSLog(@"touchUpInsideTopValue == value:%f", value);
    };
    view.touchUpInsideBottomValue = ^(CGFloat value) {
        NSLog(@"touchUpInsideBottomValue == value:%f", value);
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
