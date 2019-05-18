//
//  TwoViewController.m
//  6index1
//
//  Created by Kwangchiu on 2019/5/16.
//  Copyright © 2019年 Kwangchiu. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@property(nonatomic,strong)UIButton *backBtn;

#define backX   5
#define backY   5
#define backH   5
#define backW   5
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //*************************返回按钮*********************************
    
    //分配初始化登陆按钮
    _backBtn=[[UIButton alloc]initWithFrame:CGRectMake(backX, backY, backW, backH)];
    
    
    //为登陆按钮设置监听事件
    [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //将登陆按钮添加到视图
    [self.view addSubview:_backBtn];
    
}

//创建返回界面
-(void)backAction:(UIButton *)backBtn{
    
    // 在storyboard中设置zeroViewController的identifier为zeroViewController
    NextViewController *back = [self.storyboard instantiateViewControllerWithIdentifier:@"NextViewController"];
    // 进行跳转
    [self presentViewController:back animated:YES completion:nil];
    
    
}

@end
