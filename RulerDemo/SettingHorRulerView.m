//
//  SettingHorRulerView.m
//  RulerDemo
//
//  Created by gs_sh on 2017/12/27.
//  Copyright © 2017年 Remover. All rights reserved.
//

#import "SettingHorRulerView.h"

#import "Masonry.h"

#import "HorizontalRulerView.h"

@interface SettingHorRulerView ()
{
    CGFloat contentW;
    CGFloat rulerBacH;
    CGFloat margin;
    CGFloat topSubValue;
    CGFloat bottomSubValue;
}
@property (retain, nonatomic) UIView *contentView;
@property (retain, nonatomic) UILabel *titleLab;
@property (retain, nonatomic) UIView *topHorRulerBacView;
@property (retain, nonatomic) HorizontalRulerView *topHorRulerView;
@property (retain, nonatomic) UIView *bottomHorRulerBacView;
@property (retain, nonatomic) HorizontalRulerView *bottomHorRulerView;
@property (retain, nonatomic) UIButton *cancelBtn;
@property (retain, nonatomic) UIButton *sureBtn;

@end

@implementation SettingHorRulerView

- (void)defaultValue {
    contentW = 280;
    rulerBacH = 100;
    margin = 20;
    topSubValue = 0;
    bottomSubValue = 0;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self defaultValue];
        [self configView];
        [self showViewAnimation];
    }
    return self;
}

- (void)configView {
    
    self.contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 5;
    _contentView.layer.masksToBounds = YES;
    self.titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:16.0];
    _titleLab.textColor = [UIColor lightGrayColor];
    self.topHorRulerBacView = [[UIView alloc] init];
    self.bottomHorRulerBacView = [[UIView alloc] init];
    self.cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancelBtn"] forState:(UIControlStateNormal)];
    [_cancelBtn addTarget:self action:@selector(clickCancelBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_sureBtn setBackgroundImage:[UIImage imageNamed:@"sureBtn"] forState:(UIControlStateNormal)];
    [_sureBtn addTarget:self action:@selector(clickSureBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_contentView addSubview:_titleLab];
    [_contentView addSubview:_topHorRulerBacView];
    [_contentView addSubview:_bottomHorRulerBacView];
    [_contentView addSubview:_cancelBtn];
    [_contentView addSubview:_sureBtn];
    [self addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(contentW);
        make.height.mas_equalTo(220);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(margin);
    }];
    [_topHorRulerBacView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(5);
        make.left.equalTo(_contentView);
        make.width.mas_equalTo(contentW);
        make.height.mas_equalTo(rulerBacH);
    }];
    [_bottomHorRulerBacView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topHorRulerBacView.mas_bottom).offset(5);
        make.left.equalTo(_contentView);
        make.width.mas_equalTo(contentW);
        make.height.mas_equalTo(0);
    }];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.bottom.mas_equalTo(-margin);
    }];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(-margin);
    }];
    
    [_contentView layoutIfNeeded];
    
    self.topHorRulerView = [[HorizontalRulerView alloc] initWithFrame:(CGRectMake(0, 0, _topHorRulerBacView.frame.size.width, _topHorRulerBacView.frame.size.height))];
    _topHorRulerView.touchUpInside = ^(CGFloat value, CGFloat persentageValue) {
        topSubValue = value;
    };
    [_topHorRulerBacView addSubview:_topHorRulerView];
    
    self.bottomHorRulerView = [[HorizontalRulerView alloc] initWithFrame:(CGRectMake(0, 0, _bottomHorRulerBacView.frame.size.width, _bottomHorRulerBacView.frame.size.height))];
    _bottomHorRulerView.touchUpInside = ^(CGFloat value, CGFloat persentageValue) {
        bottomSubValue = value;
    };
    _bottomHorRulerBacView.hidden = YES;
    [_bottomHorRulerBacView addSubview:_bottomHorRulerView];
}

#pragma mark - 数据赋值

- (void)setHasBottomSubView:(BOOL)hasBottomSubView {
    if (hasBottomSubView) {
        [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(320);
        }];
        [_bottomHorRulerBacView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rulerBacH);
        }];
        _bottomHorRulerBacView.hidden = NO;
    } else {
        [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(220);
        }];
        [_bottomHorRulerBacView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        _bottomHorRulerBacView.hidden = YES;
    }
    [_contentView layoutIfNeeded];
    [_bottomHorRulerBacView layoutIfNeeded];
    _bottomHorRulerView.frame = CGRectMake(0, 0, _bottomHorRulerBacView.frame.size.width, _bottomHorRulerBacView.frame.size.height);
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleLab.text = titleStr;
}

- (void)setRulerUnitStr:(NSString *)rulerUnitStr {
    _topHorRulerView.rulerUnitStr = _bottomHorRulerView.rulerUnitStr = rulerUnitStr;
}

- (void)setRulerMinValue:(CGFloat)rulerMinValue {
    _topHorRulerView.rulerMinValue = _bottomHorRulerView.rulerMinValue = rulerMinValue;
}

- (void)setRulerMaxValue:(CGFloat)rulerMaxValue {
    _topHorRulerView.rulerMaxValue = _bottomHorRulerView.rulerMaxValue = rulerMaxValue;
}

- (void)setRulerSubTopTitleStr:(NSString *)rulerSubTopTitleStr {
    _topHorRulerView.rulerTitleStr = rulerSubTopTitleStr;
}

- (void)setRulerSubTopInitValue:(CGFloat)rulerSubTopInitValue {
    _topHorRulerView.rulerInitValue = rulerSubTopInitValue;
    topSubValue = rulerSubTopInitValue;
}

- (void)setRulerSubBottomTitleStr:(NSString *)rulerSubBottomTitleStr {
    _bottomHorRulerView.rulerTitleStr = rulerSubBottomTitleStr;
}

- (void)setRulerSubBottomInitValue:(CGFloat)rulerSubBottomInitValue {
    _bottomHorRulerView.rulerInitValue = rulerSubBottomInitValue;
    bottomSubValue = rulerSubBottomInitValue;
}

#pragma mark - 交互事件

- (void)clickCancelBtnAction:(UIButton *)sender {
    [self hiddenView];
}

- (void)clickSureBtnAction:(UIButton *)sender {
    if (bottomSubValue > topSubValue) {
        [self showErrAlertController];
        return;
    }
    
    [self hiddenView];
    if (self.touchUpInsideTopValue) {
        self.touchUpInsideTopValue(topSubValue);
    }
    if (self.touchUpInsideBottomValue) {
        self.touchUpInsideBottomValue(bottomSubValue);
    }
}

- (void)showErrAlertController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"设置错误" message:@"最小值不可大于最大值，请重新设置。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
//    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)showViewAnimation {
    self.contentView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
    }];
}

- (void)hiddenView {
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
