//
//  TheXXScrollDetailView.h
//  TheXXPicturesAndTextDetail
//
//  Created by Logan.Fan on 16/9/9.
//  Copyright © 2016年 Logan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TheXXDetailViewPart) {

    TheXXDetailViewPartTop= 1,
    TheXXDetailViewPartBottom,
};

@interface TheXXDetailContentView : UIView

@end

@interface TheXXScrollDetailView : UIView

@property (nonatomic, strong) TheXXDetailContentView *topView;
@property (nonatomic, strong) TheXXDetailContentView *bottomView;

@property (nonatomic, assign) CGFloat                   topViewHeight;
@property (nonatomic, assign) CGFloat                   bottomViewHeight;

@property (nonatomic, assign) TheXXDetailViewPart       part;

@end
