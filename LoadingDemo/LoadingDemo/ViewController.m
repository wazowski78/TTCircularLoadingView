//
//  ViewController.m
//  LoadingDemo
//
//  Created by apple on 2018/3/2.
//  Copyright © 2018年 徐世勋. All rights reserved.
//

#import "ViewController.h"
#import "TTLoadingView.h"

@interface ViewController ()
//@property (weak, nonatomic) IBOutlet TTLoadingView *loadingView;
@property (strong, nonatomic) TTLoadingView *loadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect yourRect;
    TTLoadingView *loadingView = [[TTLoadingView alloc] initWithFrame:yourRect];
    [self.view addSubview:loadingView];
    
    [_loadingView startLoading];
}

- (IBAction)successAction:(id)sender {
    [_loadingView loadSuccess];
}

- (IBAction)failAction:(id)sender {
    [_loadingView loadFail];
}

- (IBAction)loadAction:(id)sender {
    [_loadingView startLoading];
}

@end
