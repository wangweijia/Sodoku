//
//  Grid.m
//  Sodoku
//
//  Created by apple on 13/12/2016.
//  Copyright © 2016 apple. All rights reserved.
//

#import "Grid.h"

@interface Grid ()


@end

@implementation Grid

- (instancetype)initWithAnswer:(NSInteger)answer {
    if (self = [super init]) {
        self.answer = answer;
    }
    return self;
}

- (void)setAnswer:(NSInteger)answer {
    _answer = answer;
    self.tempNmbers = [NSMutableArray array];
}

@end
