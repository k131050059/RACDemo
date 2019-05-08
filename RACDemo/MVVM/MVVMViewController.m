//
//  MVVMViewController.m
//  RACDemo
//
//  Created by sjl on 2019/5/8.
//  Copyright © 2019 sjl. All rights reserved.
//

#import "MVVMViewController.h"
#import "ReactiveObjC.h"
#import "LoginViewModel.h"
#import "LoginView.h"
@interface MVVMViewController ()
//VC 持有 view 和vm
@property (strong, nonatomic)  UITextField *txtAccount;
@property (strong, nonatomic)  UITextField *txtPwd;
@property (strong, nonatomic)  UIButton *btnSubmit;
@property (strong, nonatomic)  UILabel *lblResult;

@property (strong,nonatomic) LoginViewModel *viewModel;

@end

@implementation MVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupViews];
    
    // Do any additional setup after loading the view.
}


- (void)setupViews {
    LoginView *lgview = [[LoginView alloc]initWithFrame:self.view.bounds];
    
    [[lgview rac_signalForSelector:@selector(pushToMainController)]subscribeNext:^(RACTuple * _Nullable x) {
        sleep(3);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.view addSubview:lgview];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
