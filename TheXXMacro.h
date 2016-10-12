//
//  TheXXMacro.h
//  TheXXTableViewZoomHeader
//
//  Created by Logan.Fan on 16/9/7.
//  Copyright © 2016年 Logan. All rights reserved.
//

#ifndef TheXXMacro_h
#define TheXXMacro_h

#define COLOR_RGB(r,g,b)            [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define COLOR_RANDOM                COLOR_RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))                                // 自定义色

#define WEAK_SELF                   __weak __typeof(self) weakSelf = self
#define STRONG_SELF                 __unused __strong __typeof(weakSelf) self = weakSelf

#define H_STATUSBAR                 20.f                            // 状态栏高
#define H_NAVBAR                    64.f                            // 导航栏高
#define H_TABBAR                    49.f                            // 标签栏高
#define W_SCREEN        [UIScreen mainScreen].bounds.size.width     // 屏幕宽
#define H_SCREEN        [UIScreen mainScreen].bounds.size.height    // 屏幕高
#define IS_320_W                    (W_SCREEN == 320.f ? YES : NO)  // 是否是 320 宽的手机 5s
#define IS_375_W                    (W_SCREEN == 375.f ? YES : NO)  // 是否是 375 宽的手机 6s
#define IS_414_W                    (W_SCREEN == 414.f ? YES : NO)  // 是否是 414 宽的手机 6sP

#define IS_480_H                    (H_SCREEN == 480.f ? YES : NO)  // 是否是 480 高的手机 4s
#define IS_568_H                    (H_SCREEN == 568.f ? YES : NO)  // 是否是 568 高的手机 5s
#define IS_667_H                    (H_SCREEN == 667.f ? YES : NO)  // 是否是 667 高的手机 6s
#define IS_736_H                    (H_SCREEN == 736.f ? YES : NO)  // 是否是 736 高的手机 6sP


#endif /* TheXXMacro_h */
