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
 明确答案
 */
@property (nonatomic, assign) NSInteger answer;

/**
 临时数字
 */
@property (nonatomic, strong) NSMutableArray *tempNmbers;

- (instancetype)initWithAnswer:(NSInteger)answer;

@end
