//
//  Grid.h
//  Sodoku
//
//  Created by apple on 13/12/2016.
//  Copyright © 2016 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Grid : NSObject

/**
 定位 左上角 为原点 向右 x轴
 */
@property (nonatomic, assign) NSInteger x;

/**
 定位 左上角 为原点 向下 y轴
 */
@property (nonatomic, assign) NSInteger y;

/**
 明确答案
 */
@property (nonatomic, assign) NSInteger answer;

/**
 快速标记是否已经有 答案
 */
@property (nonatomic, assign, readonly) BOOL haveAnswer;

/**
 临时数字
 */
@property (nonatomic, strong) NSMutableArray *tempNmbers;

/**
 初始化 临时数组，1...9
 */
- (void)tempNumbersInit;

/**
 移除 临时数字

 @param number 要移除的数字
 */
- (void)removeTempNmber:(NSInteger)number;

/**
 判断是否有 answer相同

 @param answer 由于判断的 answer
 @return yes 相同
 */
- (BOOL)equalAnswer:(NSInteger)answer;

/**
 把临时 number 转换成 answer
 */
- (void)tempNumberToAnswer;

- (instancetype)initWithAnswer:(NSInteger)answer;

@end
