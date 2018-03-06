//
//  TTLoadingView.h
//  coboelafs
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 徐世勋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTLoadingView : UIView
/** 圆弧宽度 default:7 */
@property (nonatomic, assign) CGFloat ovalWidth;
/** loading一圈需要的时间 default:2.5 */
@property (nonatomic, assign) CGFloat duration;

@property (nonatomic, strong) UIColor *loadingColor;
@property (nonatomic, strong) UIColor *successColor;
@property (nonatomic, strong) UIColor *failColor;

- (void)startLoading;
- (void)stopLoading;
- (void)loadSuccess;
- (void)loadFail;

@end
