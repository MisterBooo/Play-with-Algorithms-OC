//
//  SortCompareViewController.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/11.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "SortCompareViewController.h"
#import "SortTestHelper.h"
@interface SortCompareViewController ()<QMUITextFieldDelegate>
@property(nonatomic, strong) QMUIFillButton *button;
@property(nonatomic, assign) int number;
@property(nonatomic, strong) QMUITextField *textField;
@end

@implementation SortCompareViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    
}

- (void)initSubviews {
    [super initSubviews];
    
     _button = [[QMUIFillButton alloc] initWithFillType:QMUIFillButtonColorGreen];
    _button.titleLabel.font = UIFontMake(15);
    [_button setTitle:@"点击进行排序" forState:UIControlStateNormal];
    [self.view addSubview:_button];
    
    
    
    _textField = [[QMUITextField alloc] init];
    self.textField.delegate = self;
    self.textField.maximumTextLength = 6;
    self.textField.placeholder = @"请输入数字";
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.font = UIFontMake(16);
    self.textField.layer.cornerRadius = 2;
    self.textField.layer.borderColor = UIColorSeparator.CGColor;
    self.textField.layer.borderWidth = PixelOne;
    self.textField.textInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.textField];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
   
    
    UIEdgeInsets padding = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController.navigationBar.frame) + 16, 16, 16, 16);
    CGFloat contentWidth = CGRectGetWidth(self.view.bounds) - UIEdgeInsetsGetHorizontalValue(padding);
    self.textField.frame = CGRectMake(padding.left, padding.top, contentWidth, 40);
    
    CGSize buttonSize = CGSizeMake(contentWidth, 40);
    CGFloat buttonMinX = CGFloatGetCenter(CGRectGetWidth(self.view.bounds), buttonSize.width);
  
    self.button.frame = CGRectFlatMake(buttonMinX,CGRectGetMaxY(self.textField.frame) + 18, buttonSize.width, buttonSize.height);
    
    [self.button addTarget:self action:@selector(sortTest) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark - Private
- (void)sortTest{
    [self.textField endEditing:YES];
    
   NSMutableArray *array = [[SortTestHelper shareInstance] generateRandomArrayNumber:self.number rangeL:0 rangeR:self.number];
   
  [[SortTestHelper shareInstance] testSort:SortTypeSelection array:array];
  [[SortTestHelper shareInstance] testSort:SortTypeBubble array:array];
  [[SortTestHelper shareInstance] testSort:SortTypeInsertion array:array];
   
 
  
}
#pragma mark - <QMUITextFieldDelegate>

- (void)textField:(QMUITextField *)textField didPreventTextChangeInRange:(NSRange)range replacementString:(NSString *)replacementString {
    [QMUITips showWithText:@"数字不能大于 999999 " inView:self.view hideAfterDelay:2.0];
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason{
    self.number = textField.text.intValue;
    NSLog(@"self.number:%d",self.number);
}



@end
