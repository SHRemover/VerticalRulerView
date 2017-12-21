//
//  VerticalRuler.h
//  RulerDemo
//
//  Created by gs_sh on 2017/12/18.
//  Copyright © 2017年 Remover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalRuler : UIView

@property (nonatomic, copy) void (^valueChanged)(CGFloat value, CGFloat persentageValue);
@property (nonatomic, copy) void (^touchUpInside)(CGFloat value, CGFloat persentageValue);

/** 最小值 **/
@property (assign, nonatomic) CGFloat rulerMinValue;
/** 最大值 **/
@property (assign, nonatomic) CGFloat rulerMaxValue;
/** 初始值/当前值 **/
@property (assign, nonatomic) CGFloat rulerInitValue;

@end
