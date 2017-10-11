//
//  WXLPlaceholderView.m
//  WXLPlaceholderView
//
//  Created by 李蒙 on 15/6/29.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "WXLPlaceholderView.h"
#import "UIColor+WXL.h"

@interface WXLPlaceholderView ()

@property (strong, nonatomic) UITextView *descriptionTextView;

@end

@implementation WXLPlaceholderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self commonInit];
}

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeCenter;
    _imageView.alpha = 0.0f;
    
    [self addSubview:_imageView];
    
    _descriptionTextView = [[UITextView alloc] init];
    [_descriptionTextView setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [_descriptionTextView setUserInteractionEnabled:NO];
    [_descriptionTextView setBackgroundColor:[UIColor clearColor]];
    [_descriptionTextView setTextAlignment:NSTextAlignmentCenter];
    [_descriptionTextView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [self addSubview:_descriptionTextView];
    
    [_descriptionTextView layoutIfNeeded];
}

- (void)wxl_showViewWithImageName:(NSString *)imageName andTitle:(NSString *)title
{
    _imageView.image = [UIImage imageNamed:imageName];
    _imageView.frame = CGRectMake(0, 0, 100, 100);
    _imageView.center = self.center;
    
    _descriptionTextView.text = title;
    _descriptionTextView.frame = CGRectMake(20, _imageView.frame.size.height + _imageView.frame.origin.y + 25, self.frame.size.width - 40, 10);
    _descriptionTextView.textColor = [UIColor wxl_colorWithHexString:@"d4d4d4"];
    CGFloat fixedWidth = _descriptionTextView.frame.size.width;
    CGSize newSize = [_descriptionTextView sizeThatFits:CGSizeMake(fixedWidth, 20)];
    CGRect newFrame = _descriptionTextView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    _descriptionTextView.frame = newFrame;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 1.0f;
        
        _descriptionTextView.alpha = 1.0f;
        _imageView.alpha = 1.0f;
        
    } completion:nil];
}

- (void)wxl_hide
{
    self.alpha = 0.0f;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _descriptionTextView.frame = CGRectMake(20, _imageView.frame.size.height + _imageView.frame.origin.y + 25, self.frame.size.width - 40, 10);
    _descriptionTextView.textColor = [UIColor wxl_colorWithHexString:@"d4d4d4"];
    CGFloat fixedWidth = _descriptionTextView.frame.size.width;
    CGSize newSize = [_descriptionTextView sizeThatFits:CGSizeMake(fixedWidth, 20)];
    CGRect newFrame = _descriptionTextView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    _descriptionTextView.frame = newFrame;
}

@end
