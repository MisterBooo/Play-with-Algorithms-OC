//
//  CWSortNumberView.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/12.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "CWSortNumberView.h"

@implementation CWSortNumberView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 3;
        _contentLabel = [[UILabel alloc] initWithFont:UIFontLightMake(20) textColor:UIColorWhite];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.contentLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.contentLabel.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    

}

@end
