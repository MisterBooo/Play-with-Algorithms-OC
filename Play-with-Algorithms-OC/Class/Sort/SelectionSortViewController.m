//
//  SelectionSortViewController.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/11.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "SelectionSortViewController.h"
@interface SelectionSortViewController ()


@end

@implementation SelectionSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.index = 0;
}

- (void)setupStateMachine{
    for(int i = 0 ; i < self.models.count ; i ++){
        int minIndex = i;
        for( int j = i + 1 ; j < self.models.count ; j ++ ){
            //添加一个存储状态的数组
            //状态机
            NSMutableArray *array = [NSMutableArray array];
            for (int k = 0; k < self.models.count; k++) {
                CWSortModel *model_k = [[CWSortModel alloc] init];
                CWSortModel *model = self.models[k];
                if (k == j) {
                    model_k.backgroundColor = UIColorGreen;
                }else if (k == minIndex){
                    model_k.backgroundColor = UIColorRed;
                }else{
                    model_k.backgroundColor = UIColorBlue;
                }
                if (k < i) {
                    model_k.backgroundColor = UIColorYellow;
                }
                model_k.numberText = model.numberText;
                [array addObject:model_k];
            }
            
            CWSortModel *model_j = self.models[j];
            CWSortModel *model_minIndex = self.models[minIndex];
            
            if( model_j.numberText.intValue < model_minIndex.numberText.intValue ){
                minIndex = j;
            }
            [self.stateArray addObject:array];
            
        }
        [self.models exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    
    //打印出所有状态
    for (int i = 0; i< self.stateArray.count; i++) {
        NSMutableArray *array = self.stateArray[i];
        for (int j = 0; j < array.count; j++) {
            CWSortModel *model = array[j];
            NSLog(@"%@",model.numberText);
        }
        NSLog(@"***********");
    }
}


@end
