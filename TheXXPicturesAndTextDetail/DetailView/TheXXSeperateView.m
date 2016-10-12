//
//  TheXXSeperateView.m
//  TheXXPicturesAndTextDetail
//
//  Created by Logan.Fan on 16/9/7.
//  Copyright © 2016年 Logan. All rights reserved.
//

#import "TheXXSeperateView.h"

@interface TheXXSeperateView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation TheXXSeperateView

- (void)setTitleString:(NSString *)titleString {
    if (titleString == nil) {
        return;
    }
    self.titleLabel.text= titleString;
}

@end
