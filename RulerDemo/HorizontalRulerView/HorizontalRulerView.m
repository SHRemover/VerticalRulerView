//
//  HorizontalRulerView.m
//  RulerDemo
//
//  Created by gs_sh on 2017/12/26.
//  Copyright © 2017年 Remover. All rights reserved.
//

#import "HorizontalRulerView.h"

#import "Masonry.h"
#import "HorizontalRuler.h"

@interface HorizontalRulerView ()
{
    NSString *titleStr;
    NSString *unitStr;
    CGFloat initValue;
    CGFloat minValue;
    CGFloat maxValue;
    CGFloat margin;
}
@property (retain, nonatomic) UILabel *titleLab;
@property (retain, nonatomic) UILabel *valueLab;
@property (retain, nonatomic) UILabel *valueUnitLab;
@property (retain, nonatomic) UILabel *minLab;
@property (retain, nonatomic) UILabel *maxLab;
@property (retain, nonatomic) UIView *horRulerBacView;
@property (retain, nonatomic) HorizontalRuler *horRuler;

@end

@implementation HorizontalRulerView

- (void)defaultValue {
    titleStr = @"水平尺";
    unitStr = @"";
    minValue = 50;
    maxValue = 100;
    initValue = 0.5*(maxValue-minValue)+minValue;
    margin = 20;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultValue];
        [self configView];
    }
    return self;
}

- (void)configView {
    
    self.titleLab = [[UILabel alloc] init];
    _titleLab.text = titleStr;
    _titleLab.font = [UIFont boldSystemFontOfSize:18.0];
    self.valueLab = [[UILabel alloc] init];
    self.valueUnitLab = [[UILabel alloc] init];
    _valueLab.font = _valueUnitLab.font = [UIFont systemFontOfSize:18.0];
    _valueLab.textColor = _valueUnitLab.textColor = [UIColor orangeColor];
    self.horRulerBacView = [[UIView alloc] init];
    self.minLab = [[UILabel alloc] init];
    self.maxLab = [[UILabel alloc] init];
    _minLab.font = _maxLab.font = [UIFont systemFontOfSize:14.0];
    _minLab.textColor = _maxLab.textColor = [UIColor lightGrayColor];
    
    [self addSubview:_titleLab];
    [self addSubview:_valueLab];
    [self addSubview:_valueUnitLab];
    [self addSubview:_horRulerBacView];
    [self addSubview:_minLab];
    [self addSubview:_maxLab];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(margin);
    }];
    [_valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLab);
        make.left.equalTo(_titleLab.mas_right).offset(10);
    }];
    [_valueUnitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_valueLab);
        make.left.equalTo(_valueLab.mas_right);
    }];
    [_horRulerBacView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(margin);
        make.left.equalTo(_titleLab);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(10);
    }];
    [_minLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_horRulerBacView.mas_bottom).offset(5);
        make.left.equalTo(_titleLab);
    }];
    [_maxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_minLab);
        make.right.mas_equalTo(-margin);
    }];
    
    [_horRulerBacView layoutIfNeeded];
    
    self.horRuler = [[HorizontalRuler alloc] initWithFrame:(CGRectMake(0, 0, _horRulerBacView.frame.size.width, _horRulerBacView.frame.size.height))];
    _horRuler.rulerInitValue = initValue;
    _horRuler.rulerMinValue = minValue;
    _horRuler.rulerMaxValue = maxValue;
    
    __weak __typeof(self) weakSelf = self;
    _horRuler.valueChanged = ^(CGFloat value, CGFloat persentageValue) {
       weakSelf.valueLab.text = [NSString stringWithFormat:@"%.1f", value];
    };
    
    _horRuler.touchUpInside = ^(CGFloat value, CGFloat persentageValue) {
        if (weakSelf.touchUpInside) {
            weakSelf.touchUpInside(value, persentageValue);
        }
    };
    
    [_horRulerBacView addSubview:_horRuler];
}

- (void)setRulerMinValue:(CGFloat)rulerMinValue {
    minValue = rulerMinValue;
    _horRuler.rulerMinValue = minValue;
    _minLab.text = [NSString stringWithFormat:@"%.1f", minValue];
}

- (void)setRulerMaxValue:(CGFloat)rulerMaxValue {
    maxValue = rulerMaxValue;
    _horRuler.rulerMaxValue = maxValue;
    _maxLab.text = [NSString stringWithFormat:@"%.1f", maxValue];
}

- (void)setRulerInitValue:(CGFloat)rulerInitValue {
    initValue = rulerInitValue;
    _horRuler.rulerInitValue = initValue;
    _valueLab.text = [NSString stringWithFormat:@"%.1f", initValue];
}

- (void)setRulerTitleStr:(NSString *)rulerTitleStr {
    titleStr = rulerTitleStr;
    _titleLab.text = titleStr;
}

- (void)setRulerUnitStr:(NSString *)rulerUnitStr {
    unitStr = rulerUnitStr;
    _valueUnitLab.text = unitStr;
}


@end
