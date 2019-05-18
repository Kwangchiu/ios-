//
//  ZeroViewController.m
//  6index1
//
//  Created by Kwangchiu on 2019/5/16.
//  Copyright © 2019年 Kwangchiu. All rights reserved.
//

#import "ZeroViewController.h"


@interface ZeroViewController ()

@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIButton *addBtn;
//地址输出
@property(nonatomic,strong)UITextView *output;
//click响应按钮
@property (weak, nonatomic) IBOutlet UITextView *textView;

//返回值
#define backX   5
#define backY   5
#define backH   5
#define backW   5

//输出值
#define outX    0
#define outY    230
#define outW    85
#define outH    370

//输出值
#define addX    100
#define addY    230
#define addW    100
#define addH    370




@end

@implementation ZeroViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //*************************返回按钮*********************************
    
    //分配初始化登陆按钮
    _backBtn=[[UIButton alloc]initWithFrame:CGRectMake(backX, backY, backW, backH)];
    
    
    //为登陆按钮设置监听事件
    [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //将登陆按钮添加到视图
    [self.view addSubview:_backBtn];
    
    //***********输出框初始化*************
    
    //分配初始化输出
    _output =[[UITextField alloc]initWithFrame:CGRectMake(outX, outY, outH, outW)];
    
    //输出框属性设置
    _output.textAlignment=NSTextAlignmentLeft;
    [_output setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_output setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    //设置边框宽度
    _output.layer.borderWidth = 0.5;
    //设置边框颜色
    _output.layer.borderColor = [UIColor whiteColor].CGColor;
    //设置圆角
    _output.layer.cornerRadius = 4;
    //滑动
    //_output.scrollEnabled = YES;
    
    //将输出按钮添加到视图
    [self.view addSubview:_output];
    
    
    //分配初始化登陆按钮
    _addBtn=[[UIButton alloc]initWithFrame:CGRectMake(addX, addY, addW, addH)];
    
    
    //为登陆按钮设置监听事件
    [_addBtn addTarget:self action:@selector(outputAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //将登陆按钮添加到视图
    [self.view addSubview:_addBtn];
    
    
    
    
    
    
    
   
}

//************************网络请求*************************

-(void)outputAction:(UIButton *)outputBtn
{

    
    extern NSDictionary *dic;
    NSObject *address = [dic objectForKey:@"address"];
    NSLog(@"address=%@", address);
    
    [_output setText:[NSString stringWithFormat:@" %@ ",address ]];
    
    
    
}

//创建返回界面
-(void)backAction:(UIButton *)backBtn{
    
    // 在storyboard中设置zeroViewController的identifier为zeroViewController
    NextViewController *back = [self.storyboard instantiateViewControllerWithIdentifier:@"NextViewController"];
    // 进行跳转
    [self presentViewController:back animated:YES completion:nil];
    
    
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
