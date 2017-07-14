//
//  CWGraphBasicsViewController.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/14.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "CWGraphBasicsViewController.h"
#import "CWMazeSearchViewController.h"
@interface CWGraphBasicsViewController ()
@property(nonatomic, strong) NSArray *dataSource;

@end

@implementation CWGraphBasicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"迷宫"];
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
        vc = [[CWMazeSearchViewController alloc] init];
    }
    vc.title = self.dataSource[indexPath.row];
    vc.view.backgroundColor = [UIColor whiteColor];

    [self.navigationController pushViewController:vc animated:YES];
    
}




@end
