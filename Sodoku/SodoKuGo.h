//
//  SodoKuGo.h
//  Sodoku
//
//  Created by apple on 18/12/2016.
//  Copyright © 2016 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoxView.h"

@interface SodoKuGo : NSObject

/**
 初始化方法

 @param array BoxView 数组
 @return 实例
 */
- (instancetype)initWithBoxViews:(NSArray<BoxView *> *)array;

/**
 起始方法
 */
- (void)goSodoKu;

@end
