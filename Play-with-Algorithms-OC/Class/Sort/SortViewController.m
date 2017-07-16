//
//  SortViewController.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/11.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "SortViewController.h"
#import "SortCompareViewController.h"
#import "CWSortAnimationViewController.h"
@interface SortViewController ()
@property(nonatomic, strong) NSArray *dataSource;

@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@"排序性能比较",@"选择排序法动画",@"插入排序法动画",@"冒泡排序法动画"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QMUICommonViewController *vc = [[QMUICommonViewController alloc] init];
    if (indexPath.row == 0) {
         vc = [[SortCompareViewController alloc] init];
    }else if (indexPath.row == 1){
        vc = [[CWSortAnimationViewController alloc] initWithType:SortTypeSelection];
    }else if (indexPath.row == 2){
        vc = [[CWSortAnimationViewController alloc] initWithType:SortTypeInsertion];
    }else if (indexPath.row == 3){
        vc = [[CWSortAnimationViewController alloc] initWithType:SortTypeBubble];
    }
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
