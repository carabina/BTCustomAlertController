//
//  ViewController.m
//  BTCustomAlertController
//
//  Created by Rechael on 2017/12/6.
//  Copyright © 2017年 Flyada. All rights reserved.
//

#import "ViewController.h"
#import "BTCustomAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnAction:(id)sender {
    BTCustomAlertController *alert = [[BTCustomAlertController alloc] initWithTitle:@"提示" message:@"测试信息测试信息测试信息"];
    alert.isShowCancel = YES;
    [alert addAction:[BTAction actionWithTitle:@"确定" action:^{
        
    }]];
    [alert addAction:[BTAction actionWithTitle:@"取消" action:^{
        
    }]];
    [alert show];
}


@end
