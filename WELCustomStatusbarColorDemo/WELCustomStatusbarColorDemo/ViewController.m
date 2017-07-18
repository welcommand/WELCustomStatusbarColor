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

@property (weak, nonatomic) IBOutlet UIButton *changeColorBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _changeColorBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _changeColorBtn.layer.borderWidth = 1;
}

- (IBAction)changeColor:(id)sender {
    UIColor *color = [UIColor colorWithRed:arc4random() % 255 /255.0
                                     green:arc4random() % 255 /255.0
                                      blue:arc4random() % 255 /255.0
                                     alpha:1];
    
    [WELCustomStatusbarColor updateStatusbarIconColor:color];
}

@end
