//
//  ViewController.m
//  WELCustomStatusbarColorDemo
//
//  Created by WELCommand on 2017/7/12.
//  Copyright © 2017年 WELCommand. All rights reserved.
//

#import "ViewController.h"
#import "WELCustomStatusbarColor.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)changeColor:(id)sender {
    
    UIColor *color = [UIColor colorWithRed:arc4random() % 255 /255.0
                                     green:arc4random() % 255 /255.0
                                      blue:arc4random() % 255 /255.0
                                     alpha:1];
    
    [WELCustomStatusbarColor updateStatusbarIconColor:color];
}

@end
