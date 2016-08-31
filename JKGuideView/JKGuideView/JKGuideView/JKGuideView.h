//
//  JKGuideView.h
//  JKGuideView
//
//  Created by lvjialin on 16/8/31.
//  Copyright © 2016年 lionnner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKGuideView : UIView
/**
 *  初始化函数
 *
 *  @param frame  <#frame description#>
 *  @param titles 所提示信息s
 *  @param frames 所提示信息位置s
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles frames:(NSArray *)frames;

@end
