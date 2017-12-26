//
//  HorizontalRuler.m
//  RulerDemo
//
//  Created by gs_sh on 2017/12/26.
//  Copyright © 2017年 Remover. All rights reserved.
//

#import "HorizontalRuler.h"

#import "HorizontalProgressView.h"

@interface HorizontalRuler ()
{
    CGFloat initValue;
    CGFloat minValue;
    CGFloat maxValue;
}
@property (retain, nonatomic) HorizontalProgressView *horProgressView;
@property (retain, nonatomic) UISlider *slider;

@end

@implementation HorizontalRuler

- (void)defaultValue {
    minValue = 50;
    maxValue = 100;
    initValue = 0.5*(maxValue-minValue)+minValue;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor cyanColor];
        [self defaultValue];
        [self configWithFrame:frame];
    }
    return self;
}

- (void)configWithFrame:(CGRect)frame
{
    CGRect screenFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.horProgressView = [[HorizontalProgressView alloc] initWithFrame:screenFrame];
    [self addSubview:_horProgressView];
    
    UIImageView *rulerBacImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HRulerBac"]];
    rulerBacImage.frame = screenFrame;
    [self addSubview:rulerBacImage];
    
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    
    //设置滑块图标图片
    [_slider setThumbImage:[UIImage imageNamed:@"HRulerBtn"] forState:UIControlStateNormal];
    //设置点击滑块状态图标
    [_slider setThumbImage:[UIImage imageNamed:@"HRulerBtn"] forState:UIControlStateHighlighted];
    
    //设置背景颜色
    [_slider setMinimumTrackTintColor:[UIColor clearColor]];
    [_slider setMaximumTrackTintColor:[UIColor clearColor]];
    
    //设置旋转
//    CGAffineTransform rotation = CGAffineTransformMakeRotation(degressToRadian(-90));
//    _slider.transform = rotation;
    
    //设置最小数
    _slider.minimumValue = minValue;
    //设置最大数
    _slider.maximumValue = maxValue;
    //设置起始位置
    _slider.value = initValue;
    
    
    //设置委托事件
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(sliderTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加到VIEW
    [self addSubview:_slider];
}

- (void)setRulerMinValue:(CGFloat)rulerMinValue {
    _slider.minimumValue = rulerMinValue;
}

- (void)setRulerMaxValue:(CGFloat)rulerMaxValue {
    _slider.maximumValue = rulerMaxValue;
}

- (void)setRulerInitValue:(CGFloat)rulerInitValue {
    _slider.value = rulerInitValue;
    
    CGFloat persentageValue = (_slider.value - _slider.minimumValue)/(_slider.maximumValue - _slider.minimumValue);
    _horProgressView.persentage = persentageValue;
}


- (void)sliderValueChanged:(UISlider *)slider {
    CGFloat persentageValue = (slider.value - slider.minimumValue)/(slider.maximumValue - slider.minimumValue);
    _horProgressView.persentage = persentageValue;
    if (self.valueChanged) {
        self.valueChanged(slider.value, persentageValue);
    }
}

- (void)sliderTouchUpInside:(UISlider *)slider {
    CGFloat persentageValue = (slider.value - slider.minimumValue)/(slider.maximumValue - slider.minimumValue);
    if (self.touchUpInside) {
        self.touchUpInside(slider.value, persentageValue);
    }
}


@end
