//
//  BoxView.h
//  Sodoku
//
//  Created by apple on 18/12/2016.
//  Copyright © 2016 apple. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Grid.h"

/**
 boxView 数据样式

 - BoxViewNumbersTypeHor: 横向
 - BoxViewNumbersTypeVer: 纵向
 */
typedef NS_ENUM(NSInteger, BoxViewNumbersType) {
    BoxViewNumbersTypeHor,
    BoxViewNumbersTypeVer
};

@interface BoxView : NSView

/**
 用于标记第几个boxview
 */
@property (nonatomic, assign) NSInteger index;

/**
 数据源
 */
@property (nonatomic, strong) NSArray<Grid *> *gridArray;

/**
 初始化数据源
 */
- (void)updateOriginalGridArray;

/**
 跟新 answer
 */
- (void)updateAnswer;

/**
 返回 某行 或 某列 数字

 @param type 行还是列
 @param index 第几行或列（从0开始，0，1，2）
 @return 数字数组（空为 0）
 */
- (NSArray<Grid *> *)boxViewNumbersWithType:(BoxViewNumbersType)type index:(NSInteger)index;

/**
 清空 无用临时数据
 */
- (void)clearBoxTempNumbers;

/**
 获取 9 格数字
 */
- (NSArray<Grid *> *)boxViewAllNubers;

@end
