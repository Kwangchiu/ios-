#import "ViewController.h"

//图片选择器协议
@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

//**************************设置控件的坐标*********************************

//屏幕宽高
#define screenWidth   self.view.frame.size.width
#define screenHeight   self.view.frame.size.height

//qq头像宽高
#define qqY   80
#define qqW   0.25*screenWidth
#define qqX   (screenWidth - qqW)/2
#define qqH   qqW

//账号
#define accountX   0
#define accountY   qqY+qqH+20
#define accountW   screenWidth
#define accountH   50

//密码
#define passwdX   0
#define passwdY   accountY+accountH+20
#define passwdW   screenWidth
#define passwdH    30

//登陆按钮
#define loginX    35
#define loginY    passwdY+passwdH+20
#define loginW    screenWidth-2*loginX
#define loginH    50

//登陆失败
#define failedX   10
#define failedY   0.95*screenHeight
#define failedW    80
#define failedH    25

//注册用户按钮
#define newX     0.8*screenWidth
#define newY     0.95*screenHeight
#define newW     80
#define newH     25

//************声明头像，密码，登陆失败，注册用户*********************************

@property(nonatomic,strong)UIButton *headBtn ;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *failedBtn ;
@property(nonatomic,strong)UIButton *signBtn;
@property(nonatomic,strong)UITextField *account, *passwd;

@end

NSDictionary *dic;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //*****************************qq头像******************************
    
    //分配初始化qq头像按钮
    self.headBtn =[[UIButton alloc]initWithFrame:CGRectMake(qqX, qqY, qqW, qqH)];
    
    //设置qq头像
    [_headBtn setBackgroundImage:[UIImage imageNamed:@"head.jpg" ] forState:UIControlStateNormal];
    
    //添加图层蒙版，圆角化
    _headBtn.layer.cornerRadius=qqH/2;
    _headBtn.layer.masksToBounds=YES;
    [_headBtn addTarget:self action:@selector(changHeadAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加头像按钮到视图
    [self.view addSubview:_headBtn];
    
    //****************************账户和密码控件*****************************
    
    //分配初始化账户和密码按钮
    _account =[[UITextField alloc]initWithFrame:CGRectMake(accountX, accountY, accountW, accountH)];
    _passwd =[[UITextField alloc]initWithFrame:CGRectMake(passwdX, passwdY, passwdW, passwdH)];
    
    //设置账户的背景图片
    [_account setBackground:[UIImage imageNamed:@"login_textfield.png"]];
    
    //设置账户和密码的属性：居中，数字键盘，提示符
    _account.textAlignment=NSTextAlignmentCenter;
    _account.keyboardType=UIKeyboardTypeNumberPad;
    _account.placeholder=@"手机号/邮箱";
    [_account setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_account setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    _passwd.textAlignment=NSTextAlignmentCenter;
    _passwd.keyboardType=UIKeyboardTypeAlphabet;
    _passwd.placeholder=@"密码";
    [_passwd setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_passwd setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    
    
    
    //设置密码的密文显示
    _passwd.secureTextEntry=YES;
    [self.view addSubview:_account];
    [self.view addSubview:_passwd];
    
    //**************************登陆按钮*********************************
    
    //分配初始化登陆按钮
    _loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(loginX, loginY, loginW, loginH)];
    
    
    //为登陆按钮设置监听事件
    [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //将登陆按钮添加到视图
    [self.view addSubview:_loginBtn];
    
    //**************************登陆失败按钮*********************************
    
    //分配初始化登陆失败按钮
    _failedBtn =[[UIButton alloc]initWithFrame:CGRectMake(failedX, failedY, failedW, 25)];
    
    //设置登陆失败按钮的效果
    [_failedBtn setBackgroundImage:[UIImage imageNamed:@"failed.png"] forState:UIControlStateNormal];
    [_failedBtn setBackgroundImage:[UIImage imageNamed:@"failed.png"] forState:UIControlStateHighlighted];
    
    //为登陆失败按钮设置监听事件
    [_failedBtn addTarget:self action:@selector(failedAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //将登陆失败按钮添加到视图
    [self.view addSubview:_failedBtn];
    
    //***********************新用户注册按钮*********************************
    
    //分配初始化新用户注册按钮
    _signBtn =[[UIButton alloc]initWithFrame:CGRectMake(newX , newY, newW, newH)];
    
    //设置新用户注册按钮的效果
    [_signBtn setBackgroundImage:[UIImage imageNamed:@"new.png"] forState:UIControlStateNormal];
    [_signBtn setBackgroundImage:[UIImage imageNamed:@"new.png"] forState:UIControlStateHighlighted];
    
    //为新用户注册按钮设置监听事件
    [_signBtn addTarget:self action:@selector(signAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //将新用户注册按钮添加到视图
    [self.view addSubview:_signBtn];
    
}

//**************************************改变头像事件***************************************

-(void)changHeadAction:(UIButton *)headBtn{
    
    //分配初始化图片选择器
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    
    //设置图片来源：系统相册
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    //为图片选择器设置委托事件
    picker.delegate=self;
    
    //模态窗口显示图片选择器
    [self presentViewController:picker animated:YES completion:nil];
    
}


//**************************图片选择器委托事件*********************************

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    //选择系统相册里的图片当头像
    [_headBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    //退出模态窗口
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
//**************************登陆按钮事件*********************************

-(void)loginAction:(UIButton *)loginBtn{
    
    //网络URL测试
    NSURL *url = [NSURL URLWithString:@"https://t1.tempo.fan/user/login"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    request.HTTPBody = [[NSString stringWithFormat:@"userName=%@&pwd=%@",_account.text,_passwd.text] dataUsingEncoding:NSUTF8StringEncoding];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError==nil)
        {
            
            // NSLog(@"chenggong");
            NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            //字符串转字典输出
            dic=[self dictionaryWithJsonString:string];
            //NSObject *value = [dic objectForKey:@"userName"];
            //NSObject *key = [dic objectForKey:@"pwd"];
            NSLog(@"%@",string);
            //判断账号和密码是否为空
            if (_account.text.length >0 &&_passwd.text.length >0) {
                
                /*NextViewController *next=[[NextViewController alloc]init];
                 next.modalTransitionStyle=UIModalTransitionStylePartialCurl;
                 [self presentViewController:next animated:YES completion:^{
                 
                 }];*/
                
                //2.判断用户名和密码是否正确
                if ([string isEqual:@"{\"error\":\"Wrong user or password.\"}"]) {
                    NSLog(@"用户名或密码错误，登录失败");
                }
                else{
                
                    // 在storyboard中设置nextViewController的identifier为nextViewController
                    NextViewController *next = [self.storyboard instantiateViewControllerWithIdentifier:@"NextViewController"];
                    // 进行跳转
                    [self presentViewController:next animated:YES completion:nil];
                    NSLog(@"登陆成功");
                    
                }
                
               
            }else{
                
                //分配初始化提示控制窗口
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"用户或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
                
                //将确定按钮添加到提示框内
                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                
                //模态窗口显示提示窗
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        }
        else
        {
            NSLog(@"shibai");
            NSLog(@"%@",connectionError);
        }
    }];
    
    
}

//*************************登陆失败事件**********************************


-(void)failedAction:(UIButton *)failedBtn{
    
    //分配初始化提示控制窗口
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"找回密码" message:@"短信登陆" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //将确定按钮添加到提示框内
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    //模态窗口显示提示窗
    [self presentViewController:alert animated:YES completion:nil];
}

//**************************新用户注册事件*********************************

-(void)signAction:(UIButton *)signBtn{
    
    //分配初始化提示控制窗口
    UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"验证手机号码" message:@"中国 +86 " preferredStyle:UIAlertControllerStyleActionSheet];
    
    //将确定按钮添加到提示框内
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
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

