//
//  UIView+TheXXCategory.h
//  TheXXCategory
//
//  Created by Logan.Fan on 16/8/23.
//  Copyright © 2016年 Logan. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat TheXXMsgYLocRelyOn;       //靠上位置

@interface UIView (TheXXCategory)

//设置或者取得View的坐标
@property (nonatomic, assign) CGFloat           theXX_x;
@property (nonatomic, assign) CGFloat           theXX_y;
@property (nonatomic, assign) CGFloat           theXX_width;
@property (nonatomic, assign) CGFloat           theXX_height;
@property (nonatomic, assign) CGPoint           theXX_origin;
@property (nonatomic, assign) CGSize            theXX_size;

/** xib 创建View*/
+ (instancetype)createFromXib;

/**xib 创建View frame*/
+ (instancetype)createFromXibWithFrame: (CGRect)frame;

#pragma mark - 弹窗

/**普通消息 弹窗*/
- (void)theXXShowMsg: (NSString *)msg animated: (BOOL)animated;

/**普通消息 弹窗 结束回调*/
- (void)theXXShowMsg: (NSString *)msg animated: (BOOL)animated complete: (void(^)(void))complete;

/**网络错误 消息弹窗*/
- (void)theXXShowHttpError: (NSError *)error msg: (NSString *)msg animated: (BOOL)animated;

/**网络错误 消息弹窗 Y轴偏移*/
- (void)theXXShowHttpError: (NSError *)error msg: (NSString *)msg animated: (BOOL)animated yLocation: (CGFloat)yLocation;

/**普通消息弹窗 Y轴偏移*/
- (void)theXXShowMsg:(NSString *)msg animated:(BOOL)animated yLocation: (CGFloat)yLocation;

/**普通消息弹窗 Y轴偏移 结束回调*/
- (void)theXXShowMsg:(NSString *)msg animated:(BOOL)animated yLocation: (CGFloat)yLocation complete: (void(^)(void))complete;

/**弹窗提示 隐藏*/
- (void)theXX_hiddenMsg;

//#pragma mark - progressHUD
//
///**菊花*/
//- (void)TheXXShowProgressHUDWithMsg: (NSString *)msg animated: (BOOL)animated complete: (void(^)(void))complete;
//
///**菊花 隐藏*/
//- (void)TheXXHiddenProgressHUD: (BOOL)animated;

@end
