//
//  TTLoadingView.h
//  coboelafs
//
//  Created by apple on 2018/2/22.
//  Copyright © 2018年 liubei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTLoadingView : UIView

@property (nonatomic, assign) CGFloat ovalWidth;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, strong) UIColor *loadingColor;

- (void)startLoading;
- (void)stopLoading;
- (void)loadSuccess;
- (void)loadFail;

@end
