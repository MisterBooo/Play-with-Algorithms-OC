//
//  UIColor+CWRandom.m
//  Play-with-Algorithms-OC
//
//  Created by wuzhibo on 2017/7/15.
//  Copyright © 2017年 CoderWoo. All rights reserved.
//

#import "UIColor+CWRandom.h"

@implementation UIColor (CWRandom)

+ (UIColor *)cw_randomColor{
   return  [UIColor colorWithRed:(arc4random()%256)/256.f
                    green:(arc4random()%256)/256.f
                     blue:(arc4random()%256)/256.f
                    alpha:1.0f];
}


@end
