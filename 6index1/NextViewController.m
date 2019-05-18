//
//  NextViewController.m
//  6index1
//
//  Created by Kwangchiu on 2019/5/15.
//  Copyright © 2019年 Kwangchiu. All rights reserved.
//


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define IS_IPHONE_X (HEIGHT == 812.0f) ? YES : NO

#import "NextViewController.h"


@interface NextViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * titleArray;

//创建钱包、钱包列表、查询余额、查询代币余额按钮
#define zeroX    35
#define zeroY    20
#define zeroW    40
#define zeroH    50


//*********声明创建钱包，钱包列表，查询余额，查询代币余额的按钮******************
@property(nonatomic,strong)UIButton *zeroBtn ;
@property(nonatomic,strong)UIButton *oneBtn;
@property(nonatomic,strong)UIButton *twoBtn ;
@property(nonatomic,strong)UIButton *threeBtn;


@end




@implementation NextViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //************************1234各个按钮***********************
    
    //分配创建钱包按钮
    _zeroBtn=[[UIButton alloc]initWithFrame:CGRectMake(zeroX, zeroY, zeroW, zeroH)];
    
    //分配钱包列表按钮
    _oneBtn=[[UIButton alloc]initWithFrame:CGRectMake(zeroX, zeroY, zeroW, zeroH)];
    
    //分配查询余额按钮
    _twoBtn=[[UIButton alloc]initWithFrame:CGRectMake(zeroX, zeroY, zeroW, zeroH)];
    
    //分配查询代币余额
    _threeBtn=[[UIButton alloc]initWithFrame:CGRectMake(zeroX, zeroY, zeroW, zeroH)];
    
    
    //******************为各个按钮设置监听事件********************
    
    //为创建钱包按钮设置监听事件
    [_zeroBtn addTarget:self action:@selector(zeroAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //为钱包列表按钮设置监听事件
    [_oneBtn addTarget:self action:@selector(oneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //为查询余额按钮设置监听事件
    [_twoBtn addTarget:self action:@selector(twoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //为查询代币余额按钮设置监听事件
    [_threeBtn addTarget:self action:@selector(threeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //**********************添加按钮视图**********************
    
    //将登陆按钮添加到视图
    [self.view addSubview:_zeroBtn];
    
    [self.view addSubview:_oneBtn];
    
    [self.view addSubview:_twoBtn];
    
    [self.view addSubview:_threeBtn];
    
}





//**************************各个按钮事件*********************************

//创建钱包界面
-(void)zeroAction:(UIButton *)zeroBtn{
    
    NSLog(@"进入创建钱包界面成功");
    // 在storyboard中设置zeroViewController的identifier为zeroViewController
    ZeroViewController *zero = [self.storyboard instantiateViewControllerWithIdentifier:@"ZeroViewController"];
    // 进行跳转
    [self presentViewController:zero animated:YES completion:nil];
    
    
}

//分配钱包界面
-(void)oneAction:(UIButton *)oneBtn{
    
    NSLog(@"进入分配钱包界面成功");
    // 在storyboard中设置zeroViewController的identifier为zeroViewController
    OneViewController *one = [self.storyboard instantiateViewControllerWithIdentifier:@"OneViewController"];
    // 进行跳转
    [self presentViewController:one animated:YES completion:nil];
    
}
    
//查看余额界面
-(void)twoAction:(UIButton *)twoBtn{
    
    NSLog(@"进入查看余额界面成功");
    // 在storyboard中设置zeroViewController的identifier为zeroViewController
    TwoViewController *two = [self.storyboard instantiateViewControllerWithIdentifier:@"TwoViewController"];
    // 进行跳转
    [self presentViewController:two animated:YES completion:nil];
    
}

//查看代币余额界面
-(void)threeAction:(UIButton *)threeBtn{
    
    NSLog(@"进入代币余额界面成功");
    // 在storyboard中设置zeroViewController的identifier为zeroViewController
    ThreeViewController *three = [self.storyboard instantiateViewControllerWithIdentifier:@"ThreeViewController"];
    // 进行跳转
    [self presentViewController:three animated:YES completion:nil];
    
    
}


 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textColor = [UIColor lightGrayColor];
    return cell;
}


//选中时 调用的方法 避免点击button时出现失控
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        ZeroViewController *TokenInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ZeroViewController"];
        [self.navigationController pushViewController:TokenInfoVC animated:YES];
        
    }else if (indexPath.row == 1)
    {
        OneViewController *TokenInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OneViewController"];
        [self.navigationController pushViewController:TokenInfoVC animated:YES];
        
    }else if (indexPath.row == 2)
    {
        TwoViewController *TokenInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TwoViewController"];
        [self.navigationController pushViewController:TokenInfoVC animated:YES];
        
    }else if (indexPath.row == 3)
    {
        ThreeViewController *TokenInfoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ThreeViewController"];
        [self.navigationController pushViewController:TokenInfoVC animated:YES];
        
    }
}


@end
