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
        [self tempNumbersInit];
    }
    return self;
}

- (void)removeTempNmber:(NSInteger)number {
    [self.tempNmbers removeObject:@(number)];
}

- (void)tempNumbersInit {
    self.tempNmbers = [@[@1,@2,@3,@4,@5,@6,@7,@8,@9] mutableCopy];
}

- (BOOL)haveAnswer {
    if (self.answer > 0 && self.answer < 10) {
        return YES;
    }
    return NO;
}

- (BOOL)equalAnswer:(NSInteger)answer {
    return answer == self.answer;
}

- (void)tempNumberToAnswer {
    if (self.tempNmbers.count == 1) {
        self.answer = [self.tempNmbers[0] integerValue];
    }
}

@end
