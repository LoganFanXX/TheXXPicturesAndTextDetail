//
//  UIView+TheXXCategory.m
//  TheXXCategory
//
//  Created by Logan.Fan on 16/8/23.
//  Copyright © 2016年 Logan. All rights reserved.
//

#import "UIView+TheXXCategory.h"
//#import <MBProgressHUD.h>

CGFloat TheXXMsgYLocRelyOn                         = CGFLOAT_MAX;  //靠上位置（类加载再进行屏幕适配赋值）
static CGFloat const TheXXMsgToScreenMinEdge        = 12.f;             //弹框到屏幕边缘最小距离（左，右）
static CGFloat const TheXXMsgEdge           = 15.f;             //文字到弹框距离
static CGFloat const TheXXMsgMinWidth       = 80.f;             //弹框的最小宽度
static CGFloat const TheXXMsgShowDuration   = .15f;             //弹框渐显示时间
static CGFloat const TheXXMsgHiddDuration   = .35f;             //弹框渐隐藏时间
static CGFloat const TheXXMsgDuration       = 1.6f;             //弹框显示时长

#pragma mark - TheXXView

@interface TheXXView : UIView

- (void)showMsgWith: (NSString *)msg rect: (CGRect)rect;

@end

@interface TheXXView ()

@property (nonatomic, strong) UILabel           *msgLabel;

@end

@implementation TheXXView

- (UILabel *)msgLabel{
    
    if (!_msgLabel) {
        _msgLabel= [[UILabel alloc]init];
        [self addSubview:_msgLabel];
        _msgLabel.numberOfLines= 0;
        _msgLabel.textColor= [UIColor whiteColor];
        _msgLabel.font= [UIFont systemFontOfSize:14.f];
        _msgLabel.textAlignment= NSTextAlignmentCenter;
    }
    return _msgLabel;
}

- (instancetype)init{
    
    if (self = [super init]) {
        self.backgroundColor= [[UIColor blackColor] colorWithAlphaComponent:.5f];
    }
    return self;
}

- (void)showMsgWith:(NSString *)msg rect:(CGRect)rect{
    
    self.msgLabel.text= msg;
    CGSize thatSize= [self.msgLabel sizeThatFits:CGSizeMake(rect.size.width - 2 * (TheXXMsgToScreenMinEdge + TheXXMsgEdge), CGFLOAT_MAX)];
    thatSize.width= thatSize.width < TheXXMsgMinWidth ? TheXXMsgMinWidth : thatSize.width;
    self.msgLabel.frame= CGRectMake(TheXXMsgEdge, TheXXMsgEdge, thatSize.width, thatSize.height);
    self.theXX_width= thatSize.width + 2 * TheXXMsgEdge;
    self.theXX_height= thatSize.height + 2 * TheXXMsgEdge;
}

@end

#pragma mark - UIView (TheXXCategory)

@implementation UIView (TheXXCategory)

#pragma mark - initalize

+ (void)initialize{
    
    CGFloat screenHeight= [UIScreen mainScreen].bounds.size.height;
    if (screenHeight == 568.f) { TheXXMsgYLocRelyOn= 120.f; }
    else if (screenHeight == 667.f) { TheXXMsgYLocRelyOn= 150.f; }
    else if (screenHeight == 736.f) { TheXXMsgYLocRelyOn= 180.f; }
}

#pragma mark - 创建Xib

+ (instancetype)createFromXib{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
+ (instancetype)createFromXibWithFrame: (CGRect)frame{
    
    UIView *view= [self createFromXib];
    view.frame= frame;
    return view;
}

#pragma mark - 弹窗

/**Base_View*/
- (void)theXX_showMsg:(NSString *)msg animated:(BOOL)animated yCenter:(BOOL)yCenter yLocation:(CGFloat)yLocation complete:(void (^)())complete{
    
    if (msg.length == 0) { return; }
    
    [self theXX_hiddenMsg];
    TheXXView *msgView= [[TheXXView alloc]init];
    [msgView showMsgWith:msg rect:self.frame];
    msgView.theXX_x= (self.bounds.size.width- msgView.theXX_width) * .5f;
    msgView.theXX_y= yCenter ? (self.bounds.size.height- msgView.theXX_height) * .5f : yLocation;
    [self addSubview:msgView];
    
    if (animated) {
        [UIView animateWithDuration:TheXXMsgShowDuration animations:^{
            msgView.alpha= 1.f;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:TheXXMsgHiddDuration delay:TheXXMsgDuration options:UIViewAnimationOptionTransitionNone animations:^{
                msgView.alpha = 0.f;
            } completion:^(BOOL finished) {
                [msgView removeFromSuperview];
                !complete ? : complete();
            }];
        }];
    }else {
        msgView.alpha = 1.f;
        [UIView animateWithDuration:TheXXMsgHiddDuration delay:TheXXMsgDuration options:UIViewAnimationOptionTransitionNone animations:^{
            msgView.alpha = 0.f;
        } completion:^(BOOL finished) {
            [msgView removeFromSuperview];
            !complete ? : complete();
        }];
    }
}

/**Base_Http*/
- (void)TheXX_showHttpError:(NSError *)error msg:(NSString *)msg animated:(BOOL)animated yCenter:(BOOL)yCenter yLocation:(CGFloat)yLocation {
    
    if (error.code == -1009) {
        [self theXX_showMsg:@"网络似乎断开，请检查网络" animated:animated yCenter:yCenter yLocation:yLocation complete:nil];
    }else if (error.code == -1001) {
        [self theXX_showMsg:@"网络请求超时" animated:animated yCenter:yCenter yLocation:yLocation complete:nil];
    }else {
        [self theXX_showMsg:msg animated:animated yCenter:yCenter yLocation:yLocation complete:nil];
    }
}

/**普通消息 弹窗*/
- (void)theXXShowMsg: (NSString *)msg animated: (BOOL)animated{
    
    [self theXX_showMsg:msg animated:animated yCenter:YES yLocation:0 complete:nil];
}

/**普通消息 弹窗 结束回调*/
- (void)theXXShowMsg: (NSString *)msg animated: (BOOL)animated complete: (void(^)(void))complete{
    
    [self theXX_showMsg:msg animated:animated yCenter:YES yLocation:0 complete:complete];
}

/**普通消息弹窗 Y轴偏移*/
- (void)theXXShowMsg:(NSString *)msg animated:(BOOL)animated yLocation: (CGFloat)yLocation{
    
    [self theXX_showMsg:msg animated:animated yCenter:NO yLocation:yLocation complete:nil];
}

/**普通消息弹窗 Y轴偏移 结束回调*/
- (void)theXXShowMsg:(NSString *)msg animated:(BOOL)animated yLocation: (CGFloat)yLocation complete: (void(^)(void))complete{
    
    [self theXX_showMsg:msg animated:animated yCenter:NO yLocation:yLocation complete:complete];
}

/**网络错误 消息弹窗*/
- (void)theXXShowHttpError: (NSError *)error msg: (NSString *)msg animated: (BOOL)animated{
    
    [self TheXX_showHttpError:error msg:msg animated:animated yCenter:YES yLocation:0];
}

/**网络错误 消息弹窗 Y轴偏移*/
- (void)theXXShowHttpError: (NSError *)error msg: (NSString *)msg animated: (BOOL)animated yLocation: (CGFloat)yLocation{
    
    [self TheXX_showHttpError:error msg:msg animated:animated yCenter:NO yLocation:yLocation];
}

/**弹窗提示 隐藏*/
- (void)theXX_hiddenMsg{
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[TheXXView class]]) {
            [view removeFromSuperview];
        }
    }
}

//#pragma mark - progressHUD
//
///**菊花*/
//- (void)TheXXShowProgressHUDWithMsg: (NSString *)msg animated: (BOOL)animated complete:(void (^)(void))complete{
//    
//    /*
//    MBProgressHUDModeIndeterminate,
//    MBProgressHUDModeDeterminate,
//    MBProgressHUDModeDeterminateHorizontalBar,
//    MBProgressHUDModeAnnularDeterminate,
//    MBProgressHUDModeCustomView,
//    MBProgressHUDModeText
//     */
//    
//    MBProgressHUD *progressHUD= [[MBProgressHUD alloc]init];
//    progressHUD.mode= MBProgressHUDModeIndeterminate;
//    progressHUD.animationType = MBProgressHUDAnimationZoomIn;
//    progressHUD.removeFromSuperViewOnHide = YES;
//    progressHUD.labelText = msg;
//    progressHUD.completionBlock = complete;
//    [self addSubview:progressHUD];
//    [progressHUD show:animated];
//}
//
///**菊花 隐藏*/
//- (void)TheXXHiddenProgressHUD: (BOOL)animated{
//    
//    for (UIView *view in self.subviews) {
//        if ([view isKindOfClass:[MBProgressHUD class]]) {
//            [MBProgressHUD hideHUDForView:self animated:animated];
//        }
//    }
//}

#pragma mark - getter && setter

- (CGFloat)theXX_x { return self.frame.origin.x; }
- (void)setTheXX_x:(CGFloat)theXX_x {
    CGRect rect= self.frame;
    rect.origin.x= theXX_x;
    self.frame= rect;
}

- (CGFloat)theXX_y { return self.frame.origin.y; }
- (void)setTheXX_y:(CGFloat)theXX_y {
    CGRect rect= self.frame;
    rect.origin.y= theXX_y;
    self.frame= rect;
}

- (CGFloat)theXX_width { return self.frame.size.width; }
- (void)setTheXX_width:(CGFloat)theXX_width {
    CGRect rect= self.frame;
    rect.size.width= theXX_width;
    self.frame= rect;
}

- (CGFloat)theXX_height { return self.frame.size.height; }
- (void)setTheXX_height:(CGFloat)theXX_height{
    CGRect rect= self.frame;
    rect.size.height= theXX_height;
    self.frame= rect;
}

- (CGPoint)theXX_origin { return self.frame.origin; }
- (void)setTheXX_origin:(CGPoint)theXX_origin {
    CGRect rect= self.frame;
    rect.origin= theXX_origin;
    self.frame= rect;
}

- (CGSize)theXX_size { return self.frame.size; }
- (void)setTheXX_size:(CGSize)theXX_size{
    CGRect rect= self.frame;
    rect.size= theXX_size;
    self.frame= rect;
}


@end
