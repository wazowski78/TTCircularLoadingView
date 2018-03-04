//
//  TTLoadingView.m
//  coboelafs
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 徐世勋. All rights reserved.
//

#import "TTLoadingView.h"

@interface TTLoadingView ()
@property (nonatomic, strong) CAShapeLayer *bottomShapeLayer;
@property (nonatomic, strong) CAShapeLayer *contentShapeLayer;
@property (nonatomic, strong) UIBezierPath *ovalPath;
@end

@implementation TTLoadingView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutLoadingView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self layoutLoadingView];
    }
    return self;
}

- (void)layoutLoadingView{
    CGFloat side = 0;
    CGRect frame;
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    if (selfWidth > selfHeight) {
        side = selfHeight;
        frame = CGRectMake((selfWidth-side)/2, 0, side, side);
    } else {
        side = selfWidth;
        frame = CGRectMake(0, (selfHeight-side)/2, side, side);
    }
    
    _ovalPath = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:side/2];
    
    if (!_ovalWidth) _ovalWidth = 7;
    
    // 底部的灰色layer
    _bottomShapeLayer = [CAShapeLayer layer];
    _bottomShapeLayer.strokeColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:0.5].CGColor;
    _bottomShapeLayer.fillColor = [UIColor clearColor].CGColor;
    _bottomShapeLayer.lineWidth = _ovalWidth;
    _bottomShapeLayer.path = _ovalPath.CGPath;
    [self.layer addSublayer:_bottomShapeLayer];
}

- (void)startLoading {
    if (!_contentShapeLayer) _contentShapeLayer = [CAShapeLayer layer];
    if (!_loadingColor) _loadingColor = [UIColor yellowColor];
    if (!_duration) _duration = 2.5;
    if (!_ovalWidth) _ovalWidth = 7;
    
    _bottomShapeLayer.strokeColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:0.5].CGColor;
    
    // 添加橘黄色的layer
    _contentShapeLayer.strokeColor = _loadingColor.CGColor;
    _contentShapeLayer.fillColor = [UIColor clearColor].CGColor;
    _contentShapeLayer.lineWidth = _ovalWidth;
    _contentShapeLayer.path = _ovalPath.CGPath;
    [self.layer addSublayer:_contentShapeLayer];
    
    [_contentShapeLayer removeAllAnimations];
    
    // 起点动画
    CABasicAnimation * strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1.0);
    
    // 终点动画
    CABasicAnimation * strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.0);
    strokeEndAnimation.toValue = @(1.0);
    
    // 组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
    animationGroup.duration = _duration;
    animationGroup.repeatCount = CGFLOAT_MAX;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_contentShapeLayer addAnimation:animationGroup forKey:nil];
}

- (void)stopLoading {
    [_contentShapeLayer removeAllAnimations];
    [_contentShapeLayer removeFromSuperlayer];
}

- (void)loadSuccess {
    [self stopLoading];
    _bottomShapeLayer.strokeColor = self.successColor.CGColor;
}

- (void)loadFail {
    [self stopLoading];
    _bottomShapeLayer.strokeColor = self.failColor.CGColor;
}

- (UIColor *)successColor {
    if (!_successColor) {
        _successColor = [UIColor greenColor];
    }
    return _successColor;
}
- (UIColor *)failColor {
    if (!_failColor) {
        _failColor = [UIColor redColor];
    }
    return _failColor;
}

@end
