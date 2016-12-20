//
//  ViewController.m
//  Sodoku
//
//  Created by apple on 13/12/2016.
//  Copyright © 2016 apple. All rights reserved.
//

#import "ViewController.h"
#import "BoxView.h"
#import "SodoKuGo.h"

@interface ViewController ()

/**
 九宫格 view
 */
@property (weak) IBOutlet NSView *customConentView;

/**
 九宫格 array
 */
@property (nonatomic, strong) NSMutableArray<BoxView *> *boxViewArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *viewLayer = [CALayer layer];
    [viewLayer setBackgroundColor:CGColorCreateGenericRGB(0.1, 0.1, 0.1, 0.4)];
    [_customConentView setWantsLayer:YES];
    [_customConentView setLayer:viewLayer];
    
    [self configBoxView];
}

- (void)configBoxView {
    CGFloat wh = self.customConentView.frame.size.height / 3.0;
    self.boxViewArray = [NSMutableArray array];

    for (NSInteger i = 0; i < 9; i++) {
        CGFloat x = wh * ( i % 3);
        CGFloat y = wh * ( i / 3);
        BoxView *boxView = [[BoxView alloc] initWithFrame:CGRectMake(x, y, wh, wh)];
        boxView.index = i;
        [_customConentView addSubview:boxView];
        [_boxViewArray addObject:boxView];
    }
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

}

- (IBAction)go:(id)sender {
    SodoKuGo *go = [[SodoKuGo alloc] initWithBoxViews:_boxViewArray];
//    NSLog(@"dd");
    [go goSodoKu];
//    NSMutableArray *a = [NSMutableArray array];
//    for (NSInteger i = 0; i < 9; i++) {
//        Grid *g = [[Grid alloc] initWithAnswer:1];
//        [a addObject:g];
//    }
//    BoxView *b = self.boxViewArray[2];
//    b.gridArray = a;
}

- (IBAction)clear:(id)sender {
    
}

@end
