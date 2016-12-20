//
//  SodoKuGo.m
//  Sodoku
//
//  Created by apple on 18/12/2016.
//  Copyright © 2016 apple. All rights reserved.
//

#import "SodoKuGo.h"
#import "Grid.h"

@interface SodoKuGo ()

@property (nonatomic, strong) NSMutableArray<NSMutableArray<Grid *> *> *gridRowArray;

@property (nonatomic, strong) NSArray<BoxView *> *boxViewArray;

@end

@implementation SodoKuGo

- (instancetype)initWithBoxViews:(NSArray<BoxView *> *)array {
    if (self = [super init]) {
        self.boxViewArray = array;
        [self updateGridRowArray];
    }
    return self;
}

- (void)updateGridRowArray {
    self.gridRowArray = [NSMutableArray array];

    for (NSInteger i = 0; i < 9; i++) {
        NSInteger l = 3 * (i / 3);
        NSInteger index = i % 3;
        NSArray *line1 = [_boxViewArray[l + 0] boxViewNumbersWithType:BoxViewNumbersTypeHor index:index];
        NSArray *line2 = [_boxViewArray[l + 1] boxViewNumbersWithType:BoxViewNumbersTypeHor index:index];
        NSArray *line3 = [_boxViewArray[l + 2] boxViewNumbersWithType:BoxViewNumbersTypeHor index:index];
        
        NSMutableArray<Grid *> *row = [NSMutableArray array];
        [row addObjectsFromArray:line1];
        [row addObjectsFromArray:line2];
        [row addObjectsFromArray:line3];
        
        for (NSInteger j = 0; j < row.count; j++) {
            row[j].x = j;
            row[j].y = i;
        }
        
        [_gridRowArray addObject:row];
    }
    
//    _gridRowArray[0][3].answer = 2;
//    _gridRowArray[0][6].answer = 6;
//    _gridRowArray[0][7].answer = 9;
//    _gridRowArray[0][8].answer = 4;
//    
//    _gridRowArray[1][0].answer = 4;
//    _gridRowArray[1][1].answer = 6;
//    _gridRowArray[1][2].answer = 2;
//    _gridRowArray[1][3].answer = 9;
//    _gridRowArray[1][4].answer = 3;
//    _gridRowArray[1][5].answer = 1;
//    _gridRowArray[1][6].answer = 7;
//    _gridRowArray[1][7].answer = 5;
//    _gridRowArray[1][8].answer = 8;
//    
//    _gridRowArray[2][5].answer = 6;
//    _gridRowArray[2][6].answer = 3;
//    _gridRowArray[2][7].answer = 1;
//    _gridRowArray[2][8].answer = 2;
//    
//    _gridRowArray[3][2].answer = 3;
//    _gridRowArray[3][3].answer = 1;
//    _gridRowArray[3][8].answer = 7;
//    
//    _gridRowArray[4][6].answer = 5;
//    _gridRowArray[4][8].answer = 3;
//    
//    _gridRowArray[5][2].answer = 4;
//    _gridRowArray[5][3].answer = 7;
//    _gridRowArray[5][6].answer = 9;
//    _gridRowArray[5][7].answer = 2;
//    _gridRowArray[5][8].answer = 1;
//    
//    _gridRowArray[6][8].answer = 5;
//    
//    _gridRowArray[7][0].answer = 5;
//    _gridRowArray[7][1].answer = 9;
//    _gridRowArray[7][7].answer = 7;
//    _gridRowArray[7][8].answer = 6;
//    
//    _gridRowArray[8][2].answer = 7;
//    _gridRowArray[8][3].answer = 5;
//    _gridRowArray[8][5].answer = 2;
//    _gridRowArray[8][6].answer = 1;
//    _gridRowArray[8][7].answer = 3;
//    _gridRowArray[8][8].answer = 9;
}

/**
 获取某一整行

 @param y 行号 0...9
 @return (NSArray<Grid *> *)
 */
- (NSArray<Grid *> *)rowWithPoint:(NSInteger)y {
    return _gridRowArray[y];
}

/**
 获取某一列

 @param x 列号 0...9
 @return (NSArray<Grid *> *)
 */
- (NSArray<Grid *> *)lineWithPoint:(NSInteger)x {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < 9; i++) {
        NSArray *temp = _gridRowArray[i];
        [array addObject:temp[x]];
    }
    return array;
}

/**
 检查 是否 得到所有的 答案（是否完成的唯一标准）

 @return yes 完成
 */
- (BOOL)allAnswer {
    for (NSInteger y = 0; y < 9; y++) {
        for (NSInteger x = 0; x < 9; x ++) {
            Grid *g = _gridRowArray[y][x];
            if (!g.haveAnswer) {
                return NO;
            }
        }
    }
    return YES;
}

/**
 插入 某个答案

 @param x x坐标
 @param y y坐标
 @param answer 插入的答案
 @return yes 插入成功
 */
- (BOOL)insertAnswerX:(NSInteger)x Y:(NSInteger)y answer:(NSInteger)answer {
    for (Grid *temp in [self rowWithPoint:y]) {
        if ([temp equalAnswer:answer]) {
            return NO;
        }
    }
    for (Grid *temp in [self lineWithPoint:x]) {
        if ([temp equalAnswer:answer]) {
            return NO;
        }
    }
    _gridRowArray[y][x].answer = answer;
    return YES;
}

/**
 清空临时数组中 的 不必要数据
 */
- (BOOL)clearAllTempNumber{
    for (NSInteger y = 0; y < 9; y++) {
        for (NSInteger x = 0; x < 9; x ++) {
            [_gridRowArray[y][x] tempNumbersInit];
        }
    }
    
    for (NSInteger y = 0; y < 9; y++) {
        for (NSInteger x = 0; x < 9; x ++) {
            Grid *g = _gridRowArray[y][x];
            if (g.haveAnswer) {
                for (Grid *temp in [self rowWithPoint:y]) {
                    [temp removeTempNmber:g.answer];
                }
                for (Grid *temp in [self lineWithPoint:x]) {
                    [temp removeTempNmber:g.answer];
                }
            }
        }
    }
    
    for (BoxView *view in _boxViewArray) {
        [view clearBoxTempNumbers];
    }
    
    for (NSInteger y = 0; y < 9; y++) {
        for (NSInteger x = 0; x < 9; x ++) {
            Grid *g = _gridRowArray[y][x];
            if (!g.haveAnswer) {
                if (g.tempNmbers.count == 0) {
                    return NO;
                }
            }
        }
    }
    return YES;
}

/**
 遍历查找 是否有单一的 临时数据

 @return @[x,y]
 */
- (NSArray *)findSingleTmepNumber {
    for (NSInteger y = 0; y < 9; y++) {
        for (NSInteger x = 0; x < 9; x ++) {
            Grid *g = _gridRowArray[y][x];
            if (!g.haveAnswer && g.tempNmbers.count == 1) {
                return @[@(x),@(y)];
            }
        }
    }
    return nil;
}

/**
 遍历查找 临时数据 最少的 grid

 @return @[x,y]
 */
- (NSArray *)findLessTempNumber {
    NSArray *array;
    NSInteger count = 10;
    for (NSInteger y = 0; y < 9; y++) {
        for (NSInteger x = 0; x < 9; x++) {
            Grid *g = _gridRowArray[y][x];
            if (!g.haveAnswer) {
                if (g.tempNmbers.count < count) {
                    array = @[@(x),@(y)];
                    count = g.tempNmbers.count;
                }
            }
        }
    }
    return array;
}

- (void)printSodoKu {
    NSLog(@"-----------------------");
    for (NSInteger y = 0; y < 9; y++) {
        NSString *row = @"";
        for (NSInteger x = 0; x < 9; x ++) {
            Grid *g = _gridRowArray[y][x];
            row = [NSString stringWithFormat:@"%@ %@",row,@(g.answer)];
        }
        NSLog(@"%@", row);
    }
}

- (void)goSodoKu {
    for (BoxView *v in _boxViewArray) {
        [v updateOriginalGridArray];
    }
    [self updateGridRowArray];
    
    if ([self go]) {
        for (BoxView *v in _boxViewArray) {
            [v updateAnswer];
        }
    }
}

- (BOOL)go {
    if (![self clearAllTempNumber]) {
        return NO;
    }
    
    [self printSodoKu];
    
    while(![self allAnswer]) {
        
        NSArray *array = [self findSingleTmepNumber];
        if (array) {
            NSInteger x = [array[0] integerValue];
            NSInteger y = [array[1] integerValue];
            [_gridRowArray[y][x] tempNumberToAnswer];
            if (![self go]) {
                _gridRowArray[y][x].answer = 0;
                return NO;
            }
        }else{
            NSArray *index = [self findLessTempNumber];
            NSInteger x = [index[0] integerValue];
            NSInteger y = [index[1] integerValue];
            Grid *g = _gridRowArray[y][x];
            NSArray *newTempNumbers = [g.tempNmbers copy];
            
            BOOL bb = YES;
            for (NSNumber *n in newTempNumbers) {
                g.answer = [n integerValue];
                bb = [self go];
                if (bb) {
                    break;
                }
            }
            if (!bb) {
                _gridRowArray[y][x].answer = 0;
                return NO;
            }
        }
    }
    return YES;
}

@end
