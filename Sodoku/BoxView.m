//
//  BoxView.m
//  Sodoku
//
//  Created by apple on 18/12/2016.
//  Copyright © 2016 apple. All rights reserved.
//

#import "BoxView.h"

@interface BoxView ()

/**
 自定义view
 */
@property (strong) IBOutlet BoxView *view;

/**
 存放所有 textView
 */
@property (nonatomic, strong) NSMutableArray<NSTextField *> *numberArray;

@property (weak) IBOutlet NSTextField *textField1;
@property (weak) IBOutlet NSTextField *textField2;
@property (weak) IBOutlet NSTextField *textField3;
@property (weak) IBOutlet NSTextField *textField4;
@property (weak) IBOutlet NSTextField *textField5;
@property (weak) IBOutlet NSTextField *textField6;
@property (weak) IBOutlet NSTextField *textField7;
@property (weak) IBOutlet NSTextField *textField8;
@property (weak) IBOutlet NSTextField *textField9;

@end

@implementation BoxView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (self.view.subviews) {
        _numberArray = [@[_textField1,_textField2,_textField3,_textField4,_textField5,_textField6,_textField7,_textField8,_textField9] mutableCopy];
    };
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        
        NSString* nibName = NSStringFromClass([self class]);
        [[NSBundle mainBundle] loadNibNamed:nibName owner:self topLevelObjects:nil];
        [self.view setFrame:[self bounds]];
        [self addSubview:self.view];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    CALayer *viewLayer = [CALayer layer];
    if ((_index % 2)) {
        [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)];
    }else{
        [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.31, 0.3, 0.3, 0.4)];
    }
    
    [self.view setWantsLayer:YES];
    [self.view setLayer:viewLayer];
}

- (NSArray<Grid *> *)boxViewNumbersWithType:(BoxViewNumbersType)type index:(NSInteger)index {
    NSMutableArray *array = [NSMutableArray array];
    switch (type) {
        case BoxViewNumbersTypeHor: {
            for (NSInteger i = 0; i < 3; i++) {
                NSInteger n = index * 3 + i;
                NSInteger answer = [_numberArray[n].stringValue integerValue];
                Grid *g = [[Grid alloc] initWithAnswer:answer];
                [array addObject:g];
            }
        }
            break;
        case BoxViewNumbersTypeVer: {
            for (NSInteger i = 0; i < 3; i++) {
                NSInteger n = index + i * 3;
                NSInteger answer = [_numberArray[n].stringValue integerValue];
                Grid *g = [[Grid alloc] initWithAnswer:answer];
                [array addObject:g];
            }
        }
            break;
        default:
            return nil;
            break;
    }
    return array;
}

- (NSArray<Grid *> *)boxViewAllNubers {
    NSMutableArray *array = [NSMutableArray array];

    for (NSInteger i = 0; i < _numberArray.count; i++) {
        NSInteger answer = [_numberArray[i].stringValue integerValue];
        Grid *g = [[Grid alloc] initWithAnswer:answer];
        [array addObject:g];
    }
    
    return array;
}

- (void)setGridArray:(NSArray<Grid *> *)gridArray {
    
    NSAssert(gridArray.count == 9, @"grid array count not equal 9");
    
    _gridArray = gridArray;
    for (NSInteger i = 0; i < gridArray.count; i ++) {
        Grid *g = gridArray[i];
        _numberArray[i].stringValue = [NSString stringWithFormat:@"%@",@(g.answer)];
    }
}

@end
