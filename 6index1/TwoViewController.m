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
@property(nonatomic,strong)UIButton *clickBtn;

//返回按钮
#define backX   5
#define backY   5
#define backH   5
#define backW   5

//点击按钮
#define cliX    88
#define cliY    236
#define cliW    199
#define cliH    30
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //*************************返回按钮*********************************
    
    //分配初始化返回按钮
    _backBtn=[[UIButton alloc]initWithFrame:CGRectMake(backX, backY, backW, backH)];
    
    
    //为返回按钮设置监听事件
    [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //将返回按钮添加到视图
    [self.view addSubview:_backBtn];
    
    
    //************************查询按钮*************************
    
    //分配初始化查询按钮
    _clickBtn=[[UIButton alloc]initWithFrame:CGRectMake(cliX ,cliY, cliW, cliH)];
    
    // 设置监听
    [_clickBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加视图
    [self.view addSubview:_clickBtn];
    
}

//创建返回界面
-(void)backAction:(UIButton *)backBtn{
    
    // 在storyboard中设置zeroViewController的identifier为zeroViewController
    NextViewController *back = [self.storyboard instantiateViewControllerWithIdentifier:@"NextViewController"];
    // 进行跳转
    [self presentViewController:back animated:YES completion:nil];
    
    
}

-(void)clickAction:(UIButton *)clickBtn{
    
    NSURL *url = [NSURL URLWithString:@"https://t1.tempo.fan/account/balance/493c6b4ca883ed33b693e6811d66b3feecdb4bdb"];
    //首先我们得创建一个URL，因为我们得找到服务器相应的位置和资源。
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];//创建请求对象
    //接着我们这里创建了一个请求对象，请求对象其实就是想服务器发出请求的对象，让服务器响应。
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];//数据请求
    // 我们利用一个NSData的变量data接受服务器向客户端返回的数据。然后保存在data里面。
    NSDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //把网页的原始数据解析出来并保存在字典里面，这里说的是json数据解析
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //把字典里面的数据转化为能看得懂的中文或者英文。
    NSLog(@"%@",string);//打印测试数据是否成功获取
    NSDictionary *dic=[self dictionaryWithJsonString:string];
    NSLog(@"%@", dic);
    NSMutableArray *list=dic;//把字典转成可变数组
    NSLog(@"%@",list[0]);
    NSDictionary *list0 = list[0];
    NSLog(@"%@",list0);
    NSObject *balance = [list0 objectForKey:@"balance"];
    NSLog(@"balance=%@", balance);
    
    
    
    //分配初始化提示控制窗口
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"余额"message:balance preferredStyle:UIAlertControllerStyleAlert];
    
    //将确定按钮添加到提示框内
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    //模态窗口显示提示窗
    [self presentViewController:alert animated:YES completion:nil];
    
 
}

//字符串转字典
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
