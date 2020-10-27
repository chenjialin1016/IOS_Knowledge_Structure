//
//  ViewController.m
//  CJLCustom
//
//  Created by - on 2020/10/26.
//  Copyright © 2020 CJL. All rights reserved.
//

#import "ViewController.h"
#import "CJLPerson.h"
#import "NSObject+CJLKVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CJLPerson *person = [[CJLPerson alloc] init];
    [person cjl_setValue:@"CJL" forKey:@"name"];
    NSLog(@"取值：%@", [person cjl_valueForKey:@"name"]);
    
}


@end
