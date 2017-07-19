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
//有序度
@property(nonatomic, strong) QMUIButton *orderedButton;


@property(nonatomic, assign) int number;
@property(nonatomic, assign) int orderedNumber;

@property(nonatomic, strong) QMUITextField *textField;

@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) NSMutableArray *dataSoruce;



@end

@implementation SortCompareViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.dataSoruce = [NSMutableArray array];
}

- (void)initSubviews {
    [super initSubviews];
    
     _button = [[QMUIFillButton alloc] initWithFillType:QMUIFillButtonColorGreen];
    _button.titleLabel.font = UIFontMake(15);
    [_button setTitle:@"点击选取对比的排序算法" forState:UIControlStateNormal];
    [self.view addSubview:_button];
    
   
   
    
    
    QMUIButton *button = [[QMUIButton alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(200, 40))];
    button.titleLabel.font = UIFontBoldMake(14);
    [button setTitleColor:UIColorBlue forState:UIControlStateNormal];
    button.backgroundColor = UIColorMake(235, 249, 255);
    button.highlightedBackgroundColor = UIColorMake(211, 239, 252);// 高亮时的背景色
    button.layer.borderColor = UIColorMake(142, 219, 249).CGColor;
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 4;
    button.highlightedBorderColor = UIColorMake(0, 168, 225);// 高亮时的边框颜色
    
    _orderedButton = button;
    [_orderedButton setTitle:@"点击设置数组无序程度" forState:UIControlStateNormal];
    [self.view addSubview:_orderedButton];

    
    _textField = [[QMUITextField alloc] init];
    self.textField.delegate = self;
    self.textField.maximumTextLength = 6;
    self.textField.placeholder = @"请输入排序数组的长度";
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.font = UIFontMake(16);
    self.textField.layer.cornerRadius = 2;
    self.textField.layer.borderColor = UIColorSeparator.CGColor;
    self.textField.layer.borderWidth = PixelOne;
    self.textField.textInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.textField];
    
   
    _label = [UILabel new];
    _label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.label];
    self.label.backgroundColor = UIColorBlue;
    self.label.textColor = UIColorWhite;
    self.label.numberOfLines = 0;
    self.label.text = @" ";
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
   
    
    UIEdgeInsets padding = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController.navigationBar.frame) + 16, 16, 16, 16);
    CGFloat contentWidth = CGRectGetWidth(self.view.bounds) - UIEdgeInsetsGetHorizontalValue(padding);
    self.textField.frame = CGRectMake(padding.left, padding.top, contentWidth, 40);
    
    CGSize buttonSize = CGSizeMake(contentWidth, 40);
    CGFloat buttonMinX = CGFloatGetCenter(CGRectGetWidth(self.view.bounds), buttonSize.width);
  
    self.orderedButton.frame = CGRectFlatMake(buttonMinX,CGRectGetMaxY(self.textField.frame) + 18, buttonSize.width, buttonSize.height);
    
    [self.orderedButton addTarget:self action:@selector(orderedButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.button.frame = CGRectFlatMake(buttonMinX,CGRectGetMaxY(self.orderedButton.frame) + 18, buttonSize.width, buttonSize.height);
    
    [self.button addTarget:self action:@selector(sortTestButtonClickdEvent) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.label.frame = CGRectMake(padding.left, CGRectGetMaxY(self.button.frame) + 18, buttonSize.width,400);
    
    
}

#pragma mark - Private
- (void)compareSort{
    QMUIDialogSelectionViewController *dialogViewController = [[QMUIDialogSelectionViewController alloc] init];
    dialogViewController.titleView.style = QMUINavigationTitleViewStyleSubTitleVertical;
    dialogViewController.title = @"选择对比的算法";
    dialogViewController.titleView.subtitle = @"可多选";
    dialogViewController.allowsMultipleSelection = YES;// 打开多选
    dialogViewController.items = @[@"选择排序", @"插入排序", @"冒泡排序", @"归并排序",@"优化后的归并排序",@"自底向上的归并排序",@"快速排序",@"双路快速排序",@"三路快速排序"];
    [dialogViewController addCancelButtonWithText:@"取消" block:nil];
    __weak __typeof(self)weakSelf = self;
    [dialogViewController addSubmitButtonWithText:@"确定" block:^(QMUIDialogViewController *aDialogViewController) {
        QMUIDialogSelectionViewController *d = (QMUIDialogSelectionViewController *)aDialogViewController;
        [d hide];
        
        if (weakSelf.orderedNumber > 0) {
            if (weakSelf.orderedNumber > weakSelf.dataSoruce.count) {
                weakSelf.orderedNumber = (int )weakSelf.dataSoruce.count;
            }
            int count = (int )weakSelf.dataSoruce.count;
            [weakSelf.dataSoruce removeAllObjects];
            weakSelf.dataSoruce = [[SortTestHelper shareInstance] generateNearlyOrderedArray:count swapTimes:weakSelf.orderedNumber];
        }
        for (NSNumber *selectedItemIndex in d.selectedItemIndexes) {
            NSString *string = [[SortTestHelper shareInstance] testSort:selectedItemIndex.intValue array:weakSelf.dataSoruce.mutableCopy];
            NSString *text = [weakSelf.label.text stringByAppendingString:@"\n "];
            text = [text stringByAppendingString:string];
            weakSelf.label.text = text;
        }

       
        
    }];
    [dialogViewController show];
}

#pragma mark - 按钮点击事件
- (void)orderedButtonClicked{
    QMUIDialogSelectionViewController *dialogViewController = [[QMUIDialogSelectionViewController alloc] init];
    dialogViewController.title = @"数组的无序程度";
    //有序数组交换的次数
    dialogViewController.items = @[@"0",@"10", @"50", @"100", @"1000"];
    dialogViewController.cellForItemBlock = ^(QMUIDialogSelectionViewController *aDialogViewController, QMUITableViewCell *cell, NSUInteger itemIndex) {
        cell.accessoryType = UITableViewCellAccessoryNone;// 移除点击时默认加上右边的checkbox
    };
    dialogViewController.heightForItemBlock = ^CGFloat (QMUIDialogSelectionViewController *aDialogViewController, NSUInteger itemIndex) {
        return 54;// 修改默认的行高，默认为 TableViewCellNormalHeight
    };
    __unsafe_unretained __block typeof(self) weakSelf = self;
    dialogViewController.didSelectItemBlock = ^(QMUIDialogSelectionViewController *aDialogViewController, NSUInteger itemIndex) {
        NSString *title = [NSString stringWithFormat:@"无序程度为:%@",aDialogViewController.items[itemIndex]];
        weakSelf.orderedNumber = [aDialogViewController.items[itemIndex] intValue];
        [weakSelf.orderedButton setTitle:title forState:UIControlStateNormal];
        
        [aDialogViewController hide];
    };
    [dialogViewController show];

}

- (void)sortTestButtonClickdEvent{
    [self.textField endEditing:YES];
    [self.dataSoruce removeAllObjects];
    if (self.number == 0) {
        [QMUITips showWithText:@"请输入排序数组的长度" inView:self.view hideAfterDelay:2.0];
    }else{
        self.dataSoruce = [[SortTestHelper shareInstance] generateRandomArrayNumber:self.number rangeL:0 rangeR:self.number];
        [self compareSort];
    }
}
#pragma mark - <QMUITextFieldDelegate>

- (void)textField:(QMUITextField *)textField didPreventTextChangeInRange:(NSRange)range replacementString:(NSString *)replacementString {
    [QMUITips showWithText:@"数字不能大于 99999 " inView:self.view hideAfterDelay:2.0];
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason{
    self.number = textField.text.intValue;
    NSLog(@"self.number:%d",self.number);
}



@end
