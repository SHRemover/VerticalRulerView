//
//  SettingHorRulerView.h
//  RulerDemo
//
//  Created by gs_sh on 2017/12/27.
//  Copyright © 2017年 Remover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingHorRulerView : UIView

/** 设置标题 **/
@property (copy, nonatomic) NSString *titleStr;

/** 是否有双层ruler **/
@property (assign, nonatomic) BOOL hasBottomSubView;
/** 数值单位 **/
@property (copy, nonatomic) NSString *rulerUnitStr;
/** 最小值 **/
@property (assign, nonatomic) CGFloat rulerMinValue;
/** 最大值 **/
@property (assign, nonatomic) CGFloat rulerMaxValue;

/** top标题 **/
@property (copy, nonatomic) NSString *rulerSubTopTitleStr;
/** top初始值/当前值 **/
@property (assign, nonatomic) CGFloat rulerSubTopInitValue;

/** bottom标题 **/
@property (copy, nonatomic) NSString *rulerSubBottomTitleStr;
/** bottom初始值/当前值 **/
@property (assign, nonatomic) CGFloat rulerSubBottomInitValue;

@property (nonatomic, copy) void (^touchUpInsideTopValue)(CGFloat value);
@property (nonatomic, copy) void (^touchUpInsideBottomValue)(CGFloat value);

@end
