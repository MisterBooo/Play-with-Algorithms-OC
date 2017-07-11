//
//  SortCompareViewController.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/11.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "SortCompareViewController.h"
#import "SortTestHelper.h"
@interface SortCompareViewController ()
@property(nonatomic, strong) QMUIFillButton *button;

@end

@implementation SortCompareViewController
- (void)initSubviews {
    [super initSubviews];
    
     _button = [[QMUIFillButton alloc] initWithFillType:QMUIFillButtonColorGreen];
    _button.titleLabel.font = UIFontMake(15);
    [_button setTitle:@"点击进行排序" forState:UIControlStateNormal];
    [self.view addSubview:_button];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat contentMinY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGFloat buttonSpacingHeight = 72;
    CGSize buttonSize = CGSizeMake(260, 40);
    CGFloat buttonMinX = CGFloatGetCenter(CGRectGetWidth(self.view.bounds), buttonSize.width);
    CGFloat buttonOffsetY = CGFloatGetCenter(buttonSpacingHeight, buttonSize.height);
    self.button.frame = CGRectFlatMake(buttonMinX, contentMinY + buttonOffsetY, buttonSize.width, buttonSize.height);
 
    
}






@end
