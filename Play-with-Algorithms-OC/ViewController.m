//
//  ViewController.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/11.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "ViewController.h"
#import "SortViewController.h"
#import "CWGraphBasicsViewController.h"
@interface ViewController ()
@property(nonatomic, strong) NSArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"排序基础",@"高级排序算法",@"堆和堆排序",@"二分搜索树",@"并查集",@"图的基础",@"最小生成树",@"最短路径"];
    [self.tableView reloadData];
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
        vc = [[SortViewController alloc] init];
    }else if(indexPath.row == 5){
        vc = [[CWGraphBasicsViewController alloc] init];
    }
    vc.title = self.dataSource[indexPath.row];
    vc.view.backgroundColor = [UIColor whiteColor];

    [self.navigationController pushViewController:vc animated:YES];

}



@end
