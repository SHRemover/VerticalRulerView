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

@end
