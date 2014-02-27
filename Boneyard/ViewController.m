//
//  ViewController.m
//  Boneyard
//
//  Created by Jimmy on 2/27/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//
//
//  *DIFFERENCES PART1 PART2*
//
//  PART1 shows how to create an NSArray withObjects where PART2 creates an NSMutableArray in a for loop
//  PART1 uses an NSTimer to call move ever 15 seconds where PART2:
//      uses the animateWithDuration: animations: compltion: to call move again
//

#import "ViewController.h"
#import "UIView+Category.h"

#define PART1

@implementation ViewController

#ifdef PART1

-(void)viewDidLoad {
    [super viewDidLoad];
    
    _skeleton.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"b1"],
                                 [UIImage imageNamed:@"b2"],
                                 [UIImage imageNamed:@"b3"],
                                 [UIImage imageNamed:@"b4"],
                                 [UIImage imageNamed:@"b5"],
                                 [UIImage imageNamed:@"b6"],
                                 [UIImage imageNamed:@"b7"],
                                 [UIImage imageNamed:@"b8"],
                                 [UIImage imageNamed:@"b9"],
                                 [UIImage imageNamed:@"b10"],
                                 [UIImage imageNamed:@"b11"],
                                 [UIImage imageNamed:@"b12"],
                                 [UIImage imageNamed:@"b13"],
                                 [UIImage imageNamed:@"b14"],
                                 [UIImage imageNamed:@"b15"],
                                 nil];
    _skeleton.animationDuration = 1.5;
    [_skeleton startAnimating];
}

-(void)viewDidLayoutSubviews {
    [self move];
    [NSTimer scheduledTimerWithTimeInterval:16 target:self selector:@selector(move) userInfo:nil repeats:YES];
}

-(void)move {
    _skeleton.x = -_skeleton.width;
    [UIView animateWithDuration:15.0 animations:^{
        _skeleton.x = [ViewController screenSize].width;
    }];
}

#endif

#ifdef PART2

-(void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *images = [NSMutableArray array];
    for(int i=1; i<=15; i++) {
        NSString *filename = [NSString stringWithFormat:@"b%d",i];
        UIImage *image = [UIImage imageNamed:filename];
        [images addObject:image];
    }
    
    _skeleton.animationImages = images;
    _skeleton.animationDuration = 1.5;
    [_skeleton startAnimating];
}

-(void)viewDidLayoutSubviews {
    [self move];
}

-(void)move {
    _skeleton.x = -_skeleton.width;
    [UIView animateWithDuration:15.0 animations:^{
        _skeleton.x = [ViewController screenSize].width;
    } completion:^(BOOL finished) {
        [self move];
    }];
}

#endif

+(CGSize)screenSize {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    UIInterfaceOrientation or = [UIApplication sharedApplication].statusBarOrientation;
    if(UIDeviceOrientationIsLandscape(or)) {
        float w = size.width;
        size.width = size.height;
        size.height = w;
    }
    return size;
}

@end
