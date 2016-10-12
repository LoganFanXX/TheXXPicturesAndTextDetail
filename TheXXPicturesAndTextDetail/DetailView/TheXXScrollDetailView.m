//
//  TheXXScrollDetailView.m
//  TheXXPicturesAndTextDetail
//
//  Created by Logan.Fan on 16/9/9.
//  Copyright © 2016年 Logan. All rights reserved.
//

#import "TheXXScrollDetailView.h"
#import "TheXXSeperateView.h"

#import "TheXXMacro.h"

#define H_SELF self.frame.size.height
#define W_SELF self.frame.size.width

static const CGFloat DetailViewTopViewHeight= 49.f;        //xib上半部分高度
static const CGFloat DetailViewBottomViewHeight= 64.f;     //xib下半部分高度
static const CGFloat MinOffSetYToSwitch= 60.f;             //上下切换的最小偏移值


@implementation TheXXDetailContentView

@end

@interface TheXXScrollDetailView ()
<
UIScrollViewDelegate
>

@property (nonatomic, strong) UIScrollView              *scrollView;
@property (nonatomic, strong) UIScrollView              *secondScrollView;
@property (nonatomic, strong) TheXXSeperateView         *seperateView;

@end

@implementation TheXXScrollDetailView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self= [super initWithFrame:frame]) {
        
        _scrollView= [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.backgroundColor= [UIColor cyanColor];
        _scrollView.delegate= self;
        _scrollView.scrollEnabled= YES;
        _scrollView.bounces= YES;
        [self addSubview:_scrollView];
        
        _seperateView= [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TheXXSeperateView class]) owner:nil options:nil] lastObject];
        _seperateView.frame= CGRectMake(0, self.scrollView.frame.size.height, W_SCREEN, DetailViewTopViewHeight+ DetailViewBottomViewHeight);
        [self.scrollView addSubview:_seperateView];
        
        _secondScrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0 , self.scrollView.frame.size.height + DetailViewTopViewHeight + DetailViewBottomViewHeight, W_SCREEN, H_SCREEN- DetailViewBottomViewHeight)];
        _secondScrollView.backgroundColor= [UIColor brownColor];
        _secondScrollView.delegate= self;
        _secondScrollView.bounces= YES;
        [self.scrollView addSubview:_secondScrollView];
        
        _topView= [[TheXXDetailContentView alloc]init];
        _topView.clipsToBounds= YES;
        [self.scrollView addSubview:_topView];
        
        _bottomView= [[TheXXDetailContentView alloc]init];
        _topView.clipsToBounds= YES;
        [self.secondScrollView addSubview:_bottomView];
        
        self.topViewHeight= self.frame.size.height- DetailViewTopViewHeight;
        self.bottomViewHeight= self.frame.size.height- DetailViewBottomViewHeight;
        
        self.part= TheXXDetailViewPartTop;
    }
    return self;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY= scrollView.contentOffset.y;
    
    if (scrollView == self.scrollView) {
        NSLog(@"scrollView_______%f", offsetY);
        
        if (offsetY >= DetailViewTopViewHeight + DetailViewBottomViewHeight + MinOffSetYToSwitch && self.part == TheXXDetailViewPartTop) {
            self.scrollView.contentSize= CGSizeMake(W_SCREEN, self.topViewHeight +  DetailViewTopViewHeight + DetailViewBottomViewHeight + self.secondScrollView.frame.size.height);
            [UIView animateWithDuration:.25f animations:^{
                self.scrollView.contentOffset= CGPointMake(0, self.topViewHeight+ DetailViewTopViewHeight);
                self.secondScrollView.scrollsToTop= YES;
            } completion:^(BOOL finished) {
                self.part= TheXXDetailViewPartBottom;
                self.scrollView.scrollEnabled= NO;
            }];
            
        }
    }
    if (scrollView == self.secondScrollView) {
        NSLog(@"secondScrollView_______%f", offsetY);
        
        if (offsetY <= -(MinOffSetYToSwitch + DetailViewBottomViewHeight) && self.part == TheXXDetailViewPartBottom) {
            [UIView animateWithDuration:.25f animations:^{
                self.scrollView.contentOffset= CGPointMake(0, self.topViewHeight - H_SELF);
            } completion:^(BOOL finished) {
                self.scrollView.scrollEnabled= YES;
                self.scrollView.contentSize= CGSizeMake(W_SCREEN, self.topViewHeight +  DetailViewTopViewHeight);
                self.scrollView.contentOffset= CGPointMake(0, self.topViewHeight- H_SELF+ DetailViewTopViewHeight);
                self.part= TheXXDetailViewPartTop;
            }];
        }
    }
}

#pragma mark - setter

- (void)setTopViewHeight:(CGFloat)topViewHeight{

    CGFloat minTopViewH= H_SELF- DetailViewTopViewHeight;
    _topViewHeight= minTopViewH> H_SELF ? minTopViewH : H_SELF;
    self.topView.frame= CGRectMake(0, 0, W_SCREEN, _topViewHeight);
    self.scrollView.contentSize= CGSizeMake(W_SCREEN, self.topViewHeight +  DetailViewTopViewHeight);
}

- (void)setBottomViewHeight:(CGFloat)bottomViewHeight {

    CGFloat minBottonH= H_SELF- DetailViewBottomViewHeight;
    _bottomViewHeight= minBottonH > H_SELF ? minBottonH : H_SELF;
    self.topView.frame= CGRectMake(0, 0, W_SCREEN, _bottomViewHeight);
    self.secondScrollView.contentSize= CGSizeMake(W_SCREEN, _bottomViewHeight + 0.001);
}
@end
