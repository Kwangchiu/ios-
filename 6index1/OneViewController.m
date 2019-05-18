//
//  OneViewController.m
//  6index1
//
//  Created by Kwangchiu on 2019/5/16.
//  Copyright © 2019年 Kwangchiu. All rights reserved.
//

#import "OneViewController.h"
#import "Province.h"


@interface OneViewController ()<UITableViewDataSource>
{
    NSMutableArray *_allCities;
}

@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UITableView *tableView;


//返回按钮
#define backX   5
#define backY   5
#define backH   5
#define backW   5


@end


NSArray *notes;

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //*************************返回按钮*********************************
    
    //分配初始化登陆按钮
    _backBtn=[[UIButton alloc]initWithFrame:CGRectMake(backX, backY, backW, backH)];
    
    
    //为登陆按钮设置监听事件
    [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //将登陆按钮添加到视图
    [self.view addSubview:_backBtn];
    
    
    
    NSURL *url = [NSURL URLWithString:@"https://t1.tempo.fan/ledger/493c6b4ca883ed33b693e6811d66b3feecdb4bdb/SEN:FJU:CMZ0-99QQ"];
    //首先我们得创建一个URL，因为我们得找到服务器相应的位置和资源。
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];//创建请求对象
    //接着我们这里创建了一个请求对象，请求对象其实就是想服务器发出请求的对象，让服务器响应。
    NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];//数据请求
    // 我们利用一个NSData的变量data接受服务器向客户端返回的数据。然后保存在data里面。
    NSDictionary *dir = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //把网页的原始数据解析出来并保存在字典里面，这里说的是json数据解析
    NSString *zhuanma = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //把字典里面的数据转化为我们能看得懂的中文或者英文。
    NSLog(@"%@",zhuanma);//打印测试数据是否成功获取

    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //字符串转字典输出
    NSDictionary *dic=[self dictionaryWithJsonString:string];
    //NSObject *value = [dic objectForKey:@"userName"];
    notes = [dic objectForKey:@"notes"];
    //NSObject *amount = [dic objectForKey:]
    NSLog(@"%@",string);
    _allCities=[[NSMutableArray alloc] initWithCapacity:notes.count];           //判断账号和密码是否为空
    for (int i = 0; i < notes.count; i++)
    {
        // NSLog(@"%@\n", notes[i]);
        NSLog(@"%@ : %@ \n",[notes[i] objectForKey:@"action"],[notes[i] objectForKey:@"amount"]);
        [_allCities addObject:[Province provinceWithHeader:@" " Footer:@" " Cities:@[[notes[i] objectForKey:@"action"],[notes[i] objectForKey:@"amount"]]]];
         //Province *first  = [Province :@"第i" Footer:@"第i组说明" Cities:@[@"%@ : %@ \n",[notes[i] objectForKey:@"action"],[notes[i] objectForKey:@"amount"]]];
    }
    NSLog(@"%@",_allCities);
    _tableView.dataSource=self;
    
   /* NSURL *url = [NSURL URLWithString:@"https://t1.tempo.fan/ledger/493c6b4ca883ed33b693e6811d66b3feecdb4bdb/SEN:FJU:CMZ0-99QQ"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    // request.HTTPBody = [[NSString stringWithFormat:@"userName=%@&pwd=%@",@"cc",@"123456"] dataUsingEncoding:NSUTF8StringEncoding];
    
   

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError==nil)
        {
                        // NSLog(@"chenggong");
            NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            //字符串转字典输出
            NSDictionary *dic=[self dictionaryWithJsonString:string];
            //NSObject *value = [dic objectForKey:@"userName"];
            notes = [dic objectForKey:@"notes"];
            //NSObject *amount = [dic objectForKey:]
            NSLog(@"%@",string);
            _allCities=[[NSMutableArray alloc] initWithCapacity:notes.count];           //判断账号和密码是否为空
            for (int i = 0; i < notes.count; i++)
            {
               // NSLog(@"%@\n", notes[i]);
                NSLog(@"%@ : %@ \n",[notes[i] objectForKey:@"action"],[notes[i] objectForKey:@"amount"]);
                [_allCities addObject:[Province provinceWithHeader:@"第二条" Footer:@"第二组说明" Cities:@[@"2",@"22"]]];                //Province *first  = [Province provinceWithHeader:@"第i" Footer:@"第i组说明" Cities:@[@"%@ : %@ \n",[notes[i] objectForKey:@"action"],[notes[i] objectForKey:@"amount"]]];
               
            }
            NSLog(@"%@",_allCities);            /*Province *second = [Province provinceWithHeader:@"第二条" Footer:@"第二组说明" Cities:@[@"2",@"22"]];
            //初始化数据
            _allCities=@[second];
            _tableView.dataSource=self;*/
            /*for (int i = 1; i <= notes.count; i++)
            {
                //if notes[i]
                    Province *first  = [Province provinceWithHeader:@"第一条" Footer:@"第一组说明" Cities:@[,]];
            }
            
            //封装了头部标题，尾部说明，填充数据的类
            
           
            
        }
        else
        {
            NSLog(@"shibai");
            NSLog(@"%@",connectionError);
        }
    }];
 */
    /*Province *second2 = [Province provinceWithHeader:@"第二条" Footer:@"第二组说明" Cities:@[@"2",@"22"]];
    Province *second = [Province provinceWithHeader:@"第二条" Footer:@"第二组说明" Cities:@[@"2",@"22"]];
    Province *third  = [Province provinceWithHeader:@"第三条" Footer:@"第三组说明" Cities:@[@"3",@"33"]];
    
    //初始化数据
    _allCities=@[second2,second,third];*/
    
    
    
}

#pragma mark 一共有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _allCities.count;
}

#pragma mark 第section组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //第几组的总行数
    return [[_allCities[section] cities] count];
}

#pragma mark 每一行的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil ];
    //indexPath.section第几组  indexPath.row第几行
    cell.textLabel.text=[_allCities[indexPath.section] cities][indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.textColor = [UIColor lightGrayColor];
    
    return cell;
}

#pragma mark 每一组的头部标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_allCities[section] header];
}

#pragma mark 每一组的尾部说明
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return [_allCities[section] footer];
    
    
    
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
