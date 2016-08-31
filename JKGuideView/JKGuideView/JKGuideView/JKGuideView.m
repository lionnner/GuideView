//
//  JKGuideView.m
//  JKGuideView
//
//  Created by lvjialin on 16/8/31.
//  Copyright © 2016年 lionnner. All rights reserved.
//

#import "JKGuideView.h"

#define WINDOWSIZE [UIScreen mainScreen].bounds.size
#define WINDOWSIZEWIDTH [UIScreen mainScreen].bounds.size.width
#define WINDOWSIZEHEIGHT [UIScreen mainScreen].bounds.size.height

#define arrowsImageViewW 60
#define arrowsImageViewH 46

#define titleLabW WINDOWSIZEWIDTH/2

@interface JKGuideView ()
{
    UIButton *_checkBtn;
    UIImageView *_arrowsImageView;
    UILabel *_titleLab;
    
    UIView *_topView;
    UIView *_leftView;
    UIView *_bottomView;
    UIView *_rightView;
    
    CGFloat _titleLabH;
    NSMutableArray *_framesArr;
    NSMutableArray *_titlesArr;
}

@end

@implementation JKGuideView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles frames:(NSArray *)frames
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.translatesAutoresizingMaskIntoConstraints = NO;
        _framesArr = [frames mutableCopy];
        _titlesArr = [titles mutableCopy];
        [self createViews];
        [self setCheckBtn];
    }
    return self;
}

- (void)createViews
{
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    [self addSubview:_topView];
    
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    [self addSubview:_bottomView];
    
    _leftView = [[UIView alloc] init];
    _leftView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    [self addSubview:_leftView];
    
    _rightView = [[UIView alloc] init];
    _rightView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
    [self addSubview:_rightView];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.textColor = [UIColor whiteColor];
    _titleLab.numberOfLines = 0;
    _titleLab.font = [UIFont fontWithName:@"Wawati SC" size:24];
    
    _arrowsImageView = [[UIImageView alloc]init];

}

- (void)setCheckBtn
{
    _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _checkBtn.backgroundColor = [UIColor clearColor];
    _checkBtn.layer.opacity = 0.75;
    [_checkBtn setBackgroundImage:[UIImage imageNamed:@"userGuideBtnBG_unClear"] forState:UIControlStateNormal];
    [_checkBtn addTarget:self action:@selector(resetBtnFrame) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_checkBtn];
    [self resetBtnFrame];
}

- (void)resetBtnFrame
{
    if (_framesArr.count > 0 && _titlesArr.count > 0) {
        _titleLab.text = [_titlesArr firstObject];
        [self resetSubViewsFrameWithBtnFrame:CGRectFromString([_framesArr firstObject])];
        [_framesArr removeObjectAtIndex:0];
        [_titlesArr removeObjectAtIndex:0];
    } else {
        [self removeFromSuperview];
    }
}

- (void)resetSubViewsFrameWithBtnFrame:(CGRect)rect
{
    [self updateViewsFrame:rect];
    
    CGFloat centerX = WINDOWSIZEWIDTH/2;
    CGFloat centerY = WINDOWSIZEHEIGHT/2;
    
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat btnW = rect.size.width;
    CGFloat btnH = rect.size.height;
    
    CGFloat btnCenterX = x + btnW/2;
    CGFloat btnCenterY = y + btnH/2;
    
    CGFloat arrowsX;
    CGFloat arrowsY;
    CGFloat titleLabX;
    CGFloat titleLabY;
    _titleLabH = [self labelHeightFromeString:_titleLab.text with:titleLabW];
    
    CGFloat angle;
    if (btnCenterX<centerX && btnCenterY<centerY) {
        //左上
        //箭头旋转180‘
        angle = M_PI;
        arrowsX = x+btnW/2;
        arrowsY = y+btnH;
        titleLabX = arrowsX+arrowsImageViewW;
        titleLabY = arrowsY;
        
    }else if(btnCenterX>=centerX && btnCenterY<=centerY){
        //右上
        //箭头旋转-90‘
        angle = -M_PI_2;
        arrowsX = x-arrowsImageViewW/2;
        arrowsY = y+btnH;
        titleLabX = arrowsX-titleLabW/2;
        titleLabY = arrowsY+arrowsImageViewH;
        
        
    }else if(btnCenterX>=centerX && btnCenterY>=centerY){
        //右下
        //箭头不旋转
        angle = 0;
        arrowsX = x;
        arrowsY = y-arrowsImageViewH;
        titleLabX = arrowsX-titleLabW+20;
        titleLabY = arrowsY-_titleLabH+20;
        
        
    }else if(btnCenterX<centerX && btnCenterY>centerY){
        //左下
        angle = M_PI_2;
        arrowsX = x+arrowsImageViewW/2;
        arrowsY = y - arrowsImageViewH;
        titleLabX = arrowsX;
        titleLabY = arrowsY-_titleLabH;
        
    }

    _arrowsImageView.transform = CGAffineTransformMakeRotation(angle);
    _arrowsImageView.frame = CGRectMake(arrowsX, arrowsY, arrowsImageViewW, arrowsImageViewH);
    _titleLab.frame = CGRectMake(titleLabX, titleLabY, titleLabW, _titleLabH);
    [self addSubview:_arrowsImageView];
    [self startArrowsAnimation];
    [self addSubview:_titleLab];
    [self layoutSubviews];
}
- (void)updateViewsFrame:(CGRect)frame
{
    _checkBtn.frame = frame;
    
    _topView.frame = CGRectMake(0, 0, WINDOWSIZEWIDTH, frame.origin.y);
    
    _bottomView.frame = CGRectMake(0, frame.origin.y + frame.size.height, WINDOWSIZEWIDTH, WINDOWSIZEHEIGHT - (frame.origin.y + frame.size.height));
    
    _leftView.frame = CGRectMake(0, _topView.frame.size.height, frame.origin.x, frame.size.height);
    
    _rightView.frame = CGRectMake((frame.origin.x + frame.size.width), frame.origin.y,WINDOWSIZEWIDTH - (frame.origin.x + frame.size.width) , frame.size.height);
}


- (CGFloat)labelHeightFromeString:(NSString *)string with:(CGFloat)with
{
    CGRect tmpsize = [string boundingRectWithSize:CGSizeMake(with, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Wawati SC" size:24]} context:nil];
    return tmpsize.size.height;
}
- (void)startArrowsAnimation
{
    if (_arrowsImageView.animationImages == nil) {
        NSMutableArray *images = [[NSMutableArray alloc]init];
        for (int i = 1; i<=8; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat: @"userGuide_arrors%d",i]];
            [images addObject:image];
        }
        _arrowsImageView.animationImages = images;
        _arrowsImageView.animationDuration = 0.6;
        _arrowsImageView.animationRepeatCount = 0;
    }
    
    [_arrowsImageView startAnimating];
}

- (void)stopArrowsAnimation
{
    if ([_arrowsImageView isAnimating]) [_arrowsImageView stopAnimating];
}

-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab =[[UILabel alloc]init];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.numberOfLines = 0;
        _titleLab.font = [UIFont fontWithName:@"Wawati SC" size:24];
        _titleLab.text = @"这是一个新功能，这个功能很牛逼啊很牛B";
    }
    return _titleLab;
}

-(UIImageView *)arrowsImageView
{
    if (!_arrowsImageView) {
        _arrowsImageView = [[UIImageView alloc]init];
    }
    return _arrowsImageView;
    
}

- (void)dealloc
{
    NSLog(@"%@ 释放了",[super class]);
}
@end
