//
//  ViewController.m
//  LFPasswordDemo
//
//  Created by admin on 2018/1/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "LFPasswordField.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenheight  [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<LFPasswordFieldDelegate>

@property (nonatomic, strong)  LFPasswordField *numberField;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)configUI {
    self.numberField = [[LFPasswordField alloc] initWithFrame:CGRectMake(30,120,kScreenWidth - 60, 45)];
    _numberField.delegate = self;
    _numberField.borderRaduis = 0;
    _numberField.borderColor = [UIColor orangeColor];
    _numberField.font = [UIFont boldSystemFontOfSize:20];
    _numberField.textColor = [UIColor orangeColor];
    [self.view addSubview:_numberField];
    UIButton *isSecure = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, kScreenWidth - 60, 45)];
    [isSecure setTitle:@"关闭密文输入" forState:UIControlStateNormal];
    [isSecure setTitle:@"开启密文输入" forState:UIControlStateSelected];
    [isSecure addTarget:self action:@selector(handleSecure:) forControlEvents:UIControlEventTouchUpInside];
    [isSecure setBackgroundColor:[UIColor orangeColor]];
    [isSecure.layer setCornerRadius:5];
    [isSecure.layer setMasksToBounds:YES];
    [self.view addSubview:isSecure];
}
- (void)handleSecure:(UIButton *)sender {
    sender.selected = !sender.selected;
    _numberField.secureTextEntry = !sender.selected;
}
- (void)passwordFieldDidChange:(LFPasswordField *)passwordField {
    NSLog(@"%s, text=%@",__FUNCTION__, passwordField.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
