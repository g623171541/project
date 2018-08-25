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
    
}

// 获取图片验证码
- (IBAction)getImageWithCode:(UIButton *)sender {
}

// 发送短信验证码
- (IBAction)sendMsgCode:(UIButton *)sender {
}

// 获取短信验证码
- (IBAction)getMsgCode:(UIButton *)sender {
}

// 注册
- (IBAction)registerBeike:(UIButton *)sender {
}

// 发送登录验证码
- (IBAction)sendLoginMsgCode:(UIButton *)sender {
}

// 获取登录验证码
- (IBAction)getLoginMsgCode:(UIButton *)sender {
}

// 验证码登录
- (IBAction)loginWithMsgCode:(UIButton *)sender {
}

// 修改密码-获取登录验证码
- (IBAction)getMsgCodeForEditPwd:(UIButton *)sender {
}

// 修改密码
- (IBAction)editPwd:(UIButton *)sender {
}

// 账号密码登录
- (IBAction)loginWithPwd:(UIButton *)sender {
}

@end
