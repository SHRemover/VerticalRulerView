//
//  HorizontalProgressView.m
//  RulerDemo
//
//  Created by gs_sh on 2017/12/26.
//  Copyright © 2017年 Remover. All rights reserved.
//

#import "HorizontalProgressView.h"

#define SELF_WIDTH CGRectGetWidth(self.bounds)
#define SELF_HEIGHT CGRectGetHeight(self.bounds)

@interface HorizontalProgressView ()
{
    UIColor *startColor;
    UIColor *endColor;
    CGFloat initPersentage;
    CGFloat lineHeight;
}
@property (strong, nonatomic) CAShapeLayer *colorMaskLayer; // 渐变色遮罩
@property (strong, nonatomic) CAShapeLayer *colorLayer; // 渐变色
@property (strong, nonatomic) CAShapeLayer *blueMaskLayer; // 蓝色背景遮罩

@end

@implementation HorizontalProgressView


- (void)defaultValue {
//    self.backgroundColor = [UIColor darkGrayColor];
    startColor = [UIColor orangeColor];
    endColor = [UIColor redColor];
    initPersentage = 0.5;
    lineHeight = 30;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self defaultValue];
        [self setupBlueMaskLayer];
        [self setupColorLayer];
        [self setupColorMaskLayer];
    }
    return self;
}


/**
 *  设置整个蓝色view的遮罩
 */
- (void)setupBlueMaskLayer {
    
    CAShapeLayer *layer = [self generateMaskLayer];
    self.layer.mask = layer;
    self.blueMaskLayer = layer;
}

/**
 *  设置渐变色
 */
- (void)setupColorLayer {
    
    self.colorLayer = [CAShapeLayer layer];
    self.colorLayer.frame = self.bounds;
    [self.layer addSublayer:self.colorLayer];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, SELF_WIDTH, SELF_HEIGHT);
    // 分段设置渐变色
    layer.locations = @[@0.0, @1.0];
    layer.colors = @[(id)endColor.CGColor, (id)startColor.CGColor];
    [self.colorLayer addSublayer:layer];
}

/**
 *  设置渐变色的遮罩
 */
- (void)setupColorMaskLayer {
    
    CAShapeLayer *layer = [self generateMaskLayer];
    layer.lineWidth = lineHeight + 0.5; // 渐变遮罩线宽较大，防止蓝色遮罩有边露出来
    self.colorLayer.mask = layer;
    self.colorMaskLayer = layer;
    self.colorMaskLayer.strokeEnd = initPersentage;
}

/**
 *  生成一个遮罩层
 *  因为蓝色遮罩与渐变遮罩的配置都相同，所以封装出来
 */
- (CAShapeLayer *)generateMaskLayer {
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:CGPointMake(0, self.frame.size.height/2)];
    // 其他点
    [linePath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
    
    layer.lineWidth = lineHeight;
    layer.path = linePath.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor; // 填充色为透明（不设置为黑色）
    layer.strokeColor = [UIColor blackColor].CGColor; // 随便设置一个边框颜色
    
    return layer;
}

/**
 *  在修改百分比的时候，修改彩色遮罩的大小
 *
 *  @param persentage 百分比
 */
- (void)setPersentage:(CGFloat)persentage {
    self.colorMaskLayer.strokeEnd = persentage;
    [self.colorMaskLayer removeAllAnimations];
}



@end
