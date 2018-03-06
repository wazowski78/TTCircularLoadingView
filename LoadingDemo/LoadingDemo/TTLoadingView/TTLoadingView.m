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
@property (nonatomic, strong) CAAnimationGroup *animationGroup;
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
    
    // 底部的灰色layer
    _bottomShapeLayer = [CAShapeLayer layer];
    _bottomShapeLayer.strokeColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:0.5].CGColor;
    _bottomShapeLayer.path = _ovalPath.CGPath;
    _bottomShapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_bottomShapeLayer];
    
    // 添加橘黄色的layer
    [self.layer addSublayer:self.contentShapeLayer];
    
    // 起点动画
    CABasicAnimation * strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-1);
    strokeStartAnimation.toValue = @(1.0);
    
    // 终点动画
    CABasicAnimation * strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.0);
    strokeEndAnimation.toValue = @(1.0);
    
    // 组合动画
    self.animationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
}

#pragma mark  ===============||-->  Public  <--||===============

- (void)startLoading {
    if (!_loadingColor) _loadingColor = [UIColor yellowColor];
    if (!_duration) _duration = 2.5;
    if (!_ovalWidth) _ovalWidth = 7;
    
    _bottomShapeLayer.strokeColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:0.5].CGColor;
    _bottomShapeLayer.lineWidth = _ovalWidth;
    self.contentShapeLayer.strokeColor = _loadingColor.CGColor;
    self.contentShapeLayer.lineWidth = _ovalWidth;
    [self.layer addSublayer:self.contentShapeLayer];
    self.animationGroup.duration = _duration;
    
    [self.contentShapeLayer addAnimation:_animationGroup forKey:nil];
}

- (void)stopLoading {
    [self.contentShapeLayer removeAllAnimations];
    [self.contentShapeLayer removeFromSuperlayer];
    self.contentShapeLayer = nil;
}

- (void)loadSuccess {
    [self stopLoading];
    _bottomShapeLayer.strokeColor = self.successColor.CGColor;
}

- (void)loadFail {
    [self stopLoading];
    _bottomShapeLayer.strokeColor = self.failColor.CGColor;
}

- (void)setOvalWidth:(CGFloat)ovalWidth {
    _bottomShapeLayer.lineWidth = _ovalWidth;
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

#pragma mark  ===============||-->  Lazy loading  <--||===============

- (CAShapeLayer *)contentShapeLayer {
    if (!_contentShapeLayer) {
        _contentShapeLayer = [CAShapeLayer layer];
        _contentShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _contentShapeLayer.path = _ovalPath.CGPath;
    }
    return _contentShapeLayer;
}
- (CAAnimationGroup *)animationGroup {
    if (!_animationGroup) {
        _animationGroup = [CAAnimationGroup animation];
        _animationGroup.repeatCount = CGFLOAT_MAX;
        _animationGroup.fillMode = kCAFillModeForwards;
        _animationGroup.removedOnCompletion = NO;
        _animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    return _animationGroup;
}

@end
