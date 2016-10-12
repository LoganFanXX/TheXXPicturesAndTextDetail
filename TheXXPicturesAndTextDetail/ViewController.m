//
//  ViewController.m
//  TheXXPicturesAndTextDetail
//
//  Created by Logan.Fan on 16/9/7.
//  Copyright © 2016年 Logan. All rights reserved.
//

#import "ViewController.h"
#import "TheXXScrollDetailView.h"

#import "TheXXMacro.h"

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) TheXXScrollDetailView         *detailView;
@property (nonatomic, strong) UITableView                   *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.detailView= [[TheXXScrollDetailView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.detailView];
    
    
    self.tableView= [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //    self.tableView.separatorStyle= UITableViewCellSelectionStyleNone;
    self.tableView.rowHeight= 80.f;
    self.tableView.delegate= self;
    self.tableView.dataSource= self;
    [self.detailView.topView addSubview: self.tableView];
    
    UIView *bottomView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, W_SCREEN, H_SCREEN)];
    bottomView.backgroundColor= [UIColor redColor];
    [self.detailView.bottomView addSubview:bottomView];
    UIView *lineView= [[UIView alloc]initWithFrame:CGRectMake(0, 250, W_SCREEN, 50)];
    lineView.backgroundColor= [UIColor whiteColor];
    [bottomView addSubview:lineView];
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text= [NSString stringWithFormat:@"测试数据————%ld", indexPath.row];
        cell.textLabel.textColor= COLOR_RANDOM;
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
    }
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
