//
//  TDBaseVC.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/3.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDBaseVC.h"

@interface TDBaseVC ()

@end

@implementation TDBaseVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
    [self.navigationController setNavigationBarHidden:self.navBarHidden animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)dealloc{
    NSLog(@"dealloc");
}


@end
