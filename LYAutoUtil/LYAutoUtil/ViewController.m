//
//  ViewController.m
//  LYAutoUtil
//
//  Created by xianing on 2017/4/21.
//  Copyright © 2017年 lyning. All rights reserved.
//

#import "ViewController.h"
#import "LYAutoSwitchAlertView.h"
#import "LYAutoSwitchSheetView.h"
#import "LYPopMessages.h"
#import "LYAutoDatePickerController.h"
#import "LYAutoLoading.h"
#import "LYCutoverView.h"
#import "LYAutoUtil_Consts.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    LYCutoverView *cutoverView = [[LYCutoverView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 40)];
    cutoverView.mainColor = [UIColor orangeColor];
    cutoverView.titles = @[@"1", @"2", @"3"];
    cutoverView.currentIndex = 0;
    cutoverView.clickBlock = ^(NSInteger index){
        NSLog(@"%ld", index);
    };
    [self.view addSubview:cutoverView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert:(id)sender {
    [[LYAutoSwitchAlertView shareAutoSwitchAlertView] showAlertView:@"提示"
                                                            subText:@"测试弹框"
                                                         isJudgment:YES
                                                     viewController:self
                                                          sureClick:^(NSString *title) {
                                                              NSLog(@"%@", title);
                                                          }
                                                        cancelBlock:^(NSString *title) {
                                                            NSLog(@"%@", title);
                                                        }];
}

- (IBAction)showSheet:(id)sender {
    NSArray *btns = @[@{@"title": @"按钮1"}, @{@"title": @"按钮2"}, @{@"title": @"按钮3"}];
    [[LYAutoSwitchSheetView shareAutoSwitchSheetView] showSheetView:@"提示"
                                                             btns:btns
                                                   viewController:self
                                                         btnClick:^(NSString *title) {
                                                             NSLog(@"%@", title);
                                                         }];
}

- (IBAction)showPop:(id)sender {
    LYPopMessagesNotificationType type = LYPopMessagesNotificationTypeSuccess;
//    LYPopMessagesNotificationType type = LYPopMessagesNotificationTypeError;

    [LYPopMessages showNotificationInViewController:@"这是一个测试" type:type duration:3.0];
}

- (IBAction)showDatePicker:(id)sender {
    LYAutoDatePickerController *adpc =
    [LYAutoDatePickerController createPicker: 1492750341000
                                         max: 1493481600000
                                         min: 1491753600000
                                   sureBlock:^(NSTimeInterval times) {
                                       NSLog(@"%lf", times);
                                   }];
    
    adpc.view.backgroundColor = [UIColor clearColor];
    adpc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    adpc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.definesPresentationContext = YES;
    [self presentViewController:adpc animated:YES completion:nil];
}

- (IBAction)showLoading:(id)sender {
    [LYAutoLoading showLoading:[UIColor blueColor] animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LYAutoLoading hideLoading:YES];
    });
    
}

@end
