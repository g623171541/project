//
//  ViewController.m
//  RegisterBeike
//
//  Created by paddygu on 2018/8/24.
//  Copyright © 2018年 paddygu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (weak, nonatomic) IBOutlet UITextField *imageCodeField;
@property (weak, nonatomic) IBOutlet UILabel *msgCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginMsgCodeField;
@property (weak, nonatomic) IBOutlet UILabel *editMsgCodeField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 获取手机号码
- (IBAction)getMobile:(UIButton *)sender {
    NSLog(@"获取手机号码");
    NSDictionary *reqDic = @{@"action":@"getmobile",@"token":TOKEN,@"itemid":@"17789"};
    [AFCustomManager get:@"http://api.fxhyd.cn/UserInterface.aspx" reqDic:reqDic successBlock:^(id responseObject) {
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",dataStr);
        if(dataStr.length > 10){
            NSString *mobile = [dataStr substringFromIndex:8];
            self.mobileLabel.text = mobile;
            if(mobile.length == 11){
                self.imageView1.image = [UIImage imageNamed:@"right"];
            }else{
                self.imageView1.image = [UIImage imageNamed:@"wrong"];
            }
        }else{
            self.imageView1.image = [UIImage imageNamed:@"wrong"];
        }
        
    } failureBlock:^(id error) {
        [self.view makeToast:@"获取手机号码失败"];
        self.imageView1.image = [UIImage imageNamed:@"wrong"];
    }];
}

// 获取图片验证码
- (IBAction)getImageWithCode:(UIButton *)sender {
    NSLog(@"获取图片验证码");
    if(self.mobileLabel.text.length != 11){
        [self.view makeToast:@"请获取手机号码"];
        return;
    }
    NSDictionary *reqDic = @{@"mobile_phone_no":self.mobileLabel.text,@"_t":[self currentTimeStr]};
    [AFCustomManager get:@"https://m.ke.com/capi/invite/getPicVerifyCode" reqDic:reqDic successBlock:^(id responseObject) {
        self.codeImageView.image = [UIImage imageWithData:responseObject];
        self.imageView2.image = [UIImage imageNamed:@"right"];
    } failureBlock:^(id error) {
        [self.view makeToast:@"获取图片验证码失败"];
        self.imageView2.image = [UIImage imageNamed:@"wrong"];
    }];
}

// 发送短信验证码
- (IBAction)sendMsgCode:(UIButton *)sender {
    NSLog(@"发送短信验证码");
    NSString *code = self.imageCodeField.text;
    if(code.length == 0){
        [self.view makeToast:@"请输入图片验证码"];
        return;
    }
    if(self.mobileLabel.text.length != 11){
        [self.view makeToast:@"请获取手机号码"];
        return;
    }
    NSDictionary *reqDic = @{@"mobile_phone_no":self.mobileLabel.text,@"pic_verify_code":code,@"invite_code":Invite_Code};
    
    [AFCustomManager post:@"https://m.ke.com/capi/invite/sendVerifyCodeForRegister" reqDic:reqDic successBlock:^(id responseObject) {
        NSDictionary *jsonStr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",jsonStr);
        if([jsonStr[@"errno"] integerValue] == 0){
            [self.view makeToast:@"发送成功"];
            self.imageView3.image = [UIImage imageNamed:@"right"];
        }else{
            [self.view makeToast:jsonStr[@"error"]];
            self.imageView3.image = [UIImage imageNamed:@"wrong"];
        }
        
    } failureBlock:^(id error) {
        [self.view makeToast:@"发送短信验证码失败"];
        self.imageView3.image = [UIImage imageNamed:@"wrong"];
    }];
}

// 获取短信验证码
- (IBAction)getMsgCode:(UIButton *)sender {
    NSLog(@"获取短信验证码");
    if(self.mobileLabel.text.length != 11){
        [self.view makeToast:@"请获取手机号码"];
        return;
    }
    NSDictionary *reqDic = @{@"action":@"getsms",@"token":TOKEN,@"itemid":@"17789",@"mobile":self.mobileLabel.text};
    [AFCustomManager get:@"http://api.fxhyd.cn/UserInterface.aspx" reqDic:reqDic successBlock:^(id responseObject) {
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",dataStr);
        if(dataStr.length == 4){
            self.imageView4.image = [UIImage imageNamed:@"wrong"];
            if([dataStr isEqualToString:@"3001"]){
                [self.view makeToast:@"尚未收到短信,请稍后..."];
            }else{
                [self.view makeToast:dataStr];
            }
            return;
        }
        NSString *msgCode = [dataStr substringWithRange:NSMakeRange(22, 4)];
        NSLog(@"%@",msgCode);
        self.msgCodeLabel.text = msgCode;
        self.imageView4.image = [UIImage imageNamed:@"right"];
    } failureBlock:^(id error) {
        [self.view makeToast:@"获取短信验证码失败"];
        self.imageView4.image = [UIImage imageNamed:@"wrong"];
    }];
}

// 注册
- (IBAction)registerBeike:(UIButton *)sender {
    NSLog(@"注册");
    if(self.mobileLabel.text.length != 11){
        [self.view makeToast:@"请获取手机号码"];
        return;
    }
    NSString *msgCode = self.msgCodeLabel.text;
    if(msgCode.length == 0){
        [self.view makeToast:@"没有短信验证码，请先获取"];
        return;
    }
    NSDictionary *reqDic = @{@"mobile_phone_no":self.mobileLabel.text,@"verify_code":msgCode,@"invite_code":Invite_Code,@"password":@"",@"source":@"linkqr"};
    
    [AFCustomManager post:@"https://m.ke.com/capi/invite/register" reqDic:reqDic successBlock:^(id responseObject) {
        NSDictionary *jsonStr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",jsonStr);
        if([jsonStr[@"errno"] integerValue] == 0){
            [self.view makeToast:@"注册成功"];
            self.imageView5.image = [UIImage imageNamed:@"right"];
        }else{
            [self.view makeToast:jsonStr[@"error"]];
            self.imageView5.image = [UIImage imageNamed:@"wrong"];
        }
    } failureBlock:^(id error) {
        [self.view makeToast:@"发送短信验证码失败"];
        self.imageView5.image = [UIImage imageNamed:@"wrong"];
    }];
}

// 发送登录验证码
- (IBAction)sendLoginMsgCode:(UIButton *)sender {
    NSLog(@"发送登录验证码");
    if(self.mobileLabel.text.length != 11){
        [self.view makeToast:@"请获取手机号码"];
        return;
    }
    NSDictionary *reqDic = @{@"request_ts":[self currentTimeStr],@"mobile_phone_no":self.mobileLabel.text};
    [AFCustomManager get:@"https://app.api.ke.com/user/account/sendVerifyCodeForQuickLogin" reqDic:reqDic successBlock:^(id responseObject) {
        NSDictionary *jsonStr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",jsonStr);
        if([jsonStr[@"errno"] integerValue] == 0){
            [self.view makeToast:@"发送成功"];
            self.imageView6.image = [UIImage imageNamed:@"right"];
        }else{
            [self.view makeToast:jsonStr[@"error"]];
            self.imageView6.image = [UIImage imageNamed:@"wrong"];
        }
    } failureBlock:^(id error) {
        [self.view makeToast:@"发送登录验证码失败"];
        self.imageView6.image = [UIImage imageNamed:@"wrong"];
    }];
}

// 获取登录验证码
- (IBAction)getLoginMsgCode:(UIButton *)sender {
    NSLog(@"获取登录验证码");
    if(self.mobileLabel.text.length != 11){
        [self.view makeToast:@"请获取手机号码"];
        return;
    }
    NSDictionary *reqDic = @{@"action":@"getsms",@"token":TOKEN,@"itemid":@"17789",@"mobile":self.mobileLabel.text};
    [AFCustomManager get:@"http://api.fxhyd.cn/UserInterface.aspx" reqDic:reqDic successBlock:^(id responseObject) {
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",dataStr);
        if(dataStr.length == 4){
            self.imageView7.image = [UIImage imageNamed:@"wrong"];
            if([dataStr isEqualToString:@"3001"]){
                [self.view makeToast:@"尚未收到短信,请稍后..."];
            }else{
                [self.view makeToast:dataStr];
            }
            return;
        }
        NSString *msgCode = [dataStr substringWithRange:NSMakeRange(18, 4)];
        NSLog(@"%@",msgCode);
        self.loginMsgCodeField.text = msgCode;
        self.imageView7.image = [UIImage imageNamed:@"right"];
    } failureBlock:^(id error) {
        [self.view makeToast:@"获取登录验证码失败"];
        self.imageView7.image = [UIImage imageNamed:@"wrong"];
    }];
}

// 验证码登录
- (IBAction)loginWithMsgCode:(UIButton *)sender {
    NSLog(@"验证码登录");
    if(self.mobileLabel.text.length != 11){
        [self.view makeToast:@"请获取手机号码"];
        return;
    }
    NSString *msgCode = self.loginMsgCodeField.text;
    if(msgCode.length == 0){
        [self.view makeToast:@"没有短信验证码，请先获取"];
        return;
    }
    NSDictionary *reqDic = @{@"mobile_phone_no":self.mobileLabel.text,@"verify_code":msgCode,@"request_ts":[self currentTimeStr]};
    
    [AFCustomManager post:@"https://app.api.ke.com/user/account/quicklogin" reqDic:reqDic successBlock:^(id responseObject) {
        NSDictionary *jsonStr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",jsonStr);
        if([jsonStr[@"errno"] integerValue] == 0){
            [self.view makeToast:@"登录成功"];
            self.imageView8.image = [UIImage imageNamed:@"right"];
        }else{
            [self.view makeToast:jsonStr[@"error"]];
            self.imageView8.image = [UIImage imageNamed:@"wrong"];
        }
    } failureBlock:^(id error) {
        [self.view makeToast:@"验证码登录失败"];
        self.imageView8.image = [UIImage imageNamed:@"wrong"];
    }];
}

// 修改密码-发送验证码
- (IBAction)sendMsgCodeForEditPwd:(UIButton *)sender {
    NSLog(@"修改密码-发送验证码");
    if(self.mobileLabel.text.length != 11){
        [self.view makeToast:@"请获取手机号码"];
        return;
    }
    NSDictionary *reqDic = @{@"mobile_phone_no":self.mobileLabel.text,@"request_ts":[self currentTimeStr]};
    [AFCustomManager get:@"https://app.api.ke.com/user/account/sendVerifyCodeForChangePasswordV2" reqDic:reqDic successBlock:^(id responseObject) {
        NSDictionary *jsonStr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",jsonStr);
        if([jsonStr[@"errno"] integerValue] == 0){
            [self.view makeToast:@"发送成功"];
            self.imageView9.image = [UIImage imageNamed:@"right"];
        }else{
            [self.view makeToast:jsonStr[@"error"]];
            self.imageView9.image = [UIImage imageNamed:@"wrong"];
        }
    } failureBlock:^(id error) {
        [self.view makeToast:@"修改密码-发送验证码失败"];
        self.imageView9.image = [UIImage imageNamed:@"wrong"];
    }];
}

// 修改密码-获取验证码
- (IBAction)getMsgCodeForEditPwd:(UIButton *)sender {
    NSLog(@"修改密码-获取验证码");
    if(self.mobileLabel.text.length != 11){
        [self.view makeToast:@"请获取手机号码"];
        return;
    }
    NSDictionary *reqDic = @{@"action":@"getsms",@"token":TOKEN,@"itemid":@"17789",@"mobile":self.mobileLabel.text};
    [AFCustomManager get:@"http://api.fxhyd.cn/UserInterface.aspx" reqDic:reqDic successBlock:^(id responseObject) {
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",dataStr);
        if(dataStr.length == 4){
            self.imageView10.image = [UIImage imageNamed:@"wrong"];
            if([dataStr isEqualToString:@"3001"]){
                [self.view makeToast:@"尚未收到短信,请稍后..."];
            }else{
                [self.view makeToast:dataStr];
            }
            return;
        }
        NSString *msgCode = [dataStr substringWithRange:NSMakeRange(18, 4)];
        NSLog(@"%@",msgCode);
        self.editMsgCodeField.text = msgCode;
        self.imageView10.image = [UIImage imageNamed:@"right"];
    } failureBlock:^(id error) {
        [self.view makeToast:@"修改密码-获取验证码失败"];
        self.imageView10.image = [UIImage imageNamed:@"wrong"];
    }];
}

// 修改密码
- (IBAction)editPwd:(UIButton *)sender {
    NSLog(@"修改密码");
    if(self.mobileLabel.text.length != 11){
        [self.view makeToast:@"请获取手机号码"];
        return;
    }
    NSString *msgCode = self.editMsgCodeField.text;
    if(msgCode.length == 0){
        [self.view makeToast:@"没有短信验证码，请先获取"];
        return;
    }
    NSDictionary *reqDic = @{@"mobile_phone_no":self.mobileLabel.text,@"verify_code":msgCode,@"request_ts":[self currentTimeStr],@"new_password":PASSWORD};
    
    [AFCustomManager post:@"https://app.api.ke.com/user/account/changePasswordByVerifyCodeV2" reqDic:reqDic successBlock:^(id responseObject) {
        NSDictionary *jsonStr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",jsonStr);
        if([jsonStr[@"errno"] integerValue] == 0){
            [self.view makeToast:@"修改成功"];
            [self addignoreMobile:self.mobileLabel.text];
            self.imageView11.image = [UIImage imageNamed:@"right"];
        }else{
            [self.view makeToast:jsonStr[@"error"]];
            self.imageView11.image = [UIImage imageNamed:@"wrong"];
        }
        
    } failureBlock:^(id error) {
        [self.view makeToast:@"修改密码失败"];
        self.imageView11.image = [UIImage imageNamed:@"wrong"];
    }];
}

// 账号密码登录
- (IBAction)loginWithPwd:(UIButton *)sender {
    
    NSLog(@"账号密码登录");
    if(self.mobileLabel.text.length != 11){
        [self.view makeToast:@"请获取手机号码"];
        return;
    }
    NSDictionary *reqDic = @{@"mobile_phone_no":self.mobileLabel.text,@"request_ts":[self currentTimeStr],@"password":PASSWORD};
    
    [AFCustomManager post:@"https://app.api.ke.com/user/account/loginByPasswordV2" reqDic:reqDic successBlock:^(id responseObject) {
        NSDictionary *jsonStr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",jsonStr);
        if([jsonStr[@"errno"] integerValue] == 0){
            [self.view makeToast:@"登录成功"];
            self.imageView12.image = [UIImage imageNamed:@"right"];
        }else{
            [self.view makeToast:@"账号密码登录失败"];
            self.imageView12.image = [UIImage imageNamed:@"wrong"];
        }
        
    } failureBlock:^(id error) {
        [self.view makeToast:@"账号密码登录失败"];
        self.imageView12.image = [UIImage imageNamed:@"wrong"];
    }];
}

#pragma mark - 公共方法
#pragma mark - 获取当前时间戳
- (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

#pragma mark - 释放手机号码接口
-(void)releaseMobile:(NSString *)mobile{
    NSLog(@"释放手机号码");
    NSDictionary *reqDic = @{@"action":@"release",@"token":TOKEN,@"itemid":@"17789",@"mobile":self.mobileLabel.text};
    [AFCustomManager get:@"http://api.fxhyd.cn/UserInterface.aspx" reqDic:reqDic successBlock:^(id responseObject) {
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",dataStr);
    } failureBlock:^(id error) {
        [self.view makeToast:@"释放手机号码失败"];
    }];
}

#pragma mark - 拉黑手机号码接口
-(void)addignoreMobile:(NSString *)mobile{
    NSLog(@"拉黑手机号码");
    NSDictionary *reqDic = @{@"action":@"addignore",@"token":TOKEN,@"itemid":@"17789",@"mobile":self.mobileLabel.text};
    [AFCustomManager get:@"http://api.fxhyd.cn/UserInterface.aspx" reqDic:reqDic successBlock:^(id responseObject) {
        NSString *dataStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",dataStr);
    } failureBlock:^(id error) {
        [self.view makeToast:@"拉黑手机号码失败"];
    }];
}

#pragma mark - 点击其他位置收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
