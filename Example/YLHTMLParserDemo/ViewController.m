//
//  ViewController.m
//  YLHTMLParserDemo
//
//  Created by Yong Li on 5/19/14.
//  Copyright (c) 2014 Yong Li. All rights reserved.
//

#import "ViewController.h"
#import <OHAttributedLabel.h>
#import "YLHTMLParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString* str = @"Hello <b>World</b>! \nI'm <a href='https://github.com/liyong03'>Yong Li</a>";
	// Do any additional setup after loading the view, typically from a nib.
    [OHAttributedLabel appearance].linkColor = [UIColor redColor];
    OHAttributedLabel* label = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
    label.underlineLinks = NO;
    label.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:label];
    label.backgroundColor = [UIColor lightGrayColor];
    label.attributedText = [[[YLHTMLParser alloc] init] attributedStringByProcessingHTMLString:str withBaseFont:label.font];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
