//
//  MVPViewController.m
//  RACDemo
//
//  Created by sjl on 2019/5/8.
//  Copyright © 2019 sjl. All rights reserved.
//

#import "MVPViewController.h"
#import "MVPresenter.h"
#import "MVProtocal.h"
#import "MVPLoginView.h"
@interface MVPViewController()<MVProtocal,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;

//V 强持有P  P弱持有V  P通过protocal来控制V
@property(nonatomic,strong) MVPresenter *presenter;
@end

@implementation MVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =  [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.presenter = [MVPresenter new];
    [self.presenter attatchView:self];
    [self.presenter getData];
    
    UIButton *refresh =[[UIButton alloc]initWithFrame:CGRectMake(100, 300, 50, 50)];
    refresh.backgroundColor=[UIColor redColor];
    [refresh setTitle:@"刷新" forState:UIControlStateNormal];
    [refresh addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refresh];
    
    MVPLoginView *lv = [[MVPLoginView alloc]initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, self.view.frame.size.height-350)];
    lv.presenter=self.presenter;
    lv.userInteractionEnabled=YES;
    [self.view addSubview:lv];
    // Do any additional setup after loading the view.
}
- (void)refreshData{
    [self.presenter refreshData];
}
-(void)reloadTableView:(NSArray*)data{
    self.dataArr = data;
    [self.tableView reloadData];
}
-(void)changeColor{
    _tableView.backgroundColor=[self randomColor];
    
}
- (void)loginSuccess{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIColor*)randomColor{
    CGFloat hue = (arc4random() %256/256.0);
    CGFloat saturation = (arc4random() %128/256.0) +0.5;
    CGFloat brightness = (arc4random() %128/256.0) +0.5;
    UIColor*color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;

}


//MARK: tableview DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [self.dataArr[indexPath.row] valueForKey:@"title"];
    cell.backgroundColor = [UIColor greenColor];
    cell.textLabel.textColor =[UIColor grayColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;

}
//MARK: tableview Delagete
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


//MARK: tableview 懒加载
-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [UITableView new];
        //初始化背景颜色为白色
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.frame = self.view.bounds;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _tableView.separatorStyle = NO;
        
    }
    return _tableView;
    
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
