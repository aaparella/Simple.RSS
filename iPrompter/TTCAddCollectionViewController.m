//
//  TTCAddCollectionViewController.m
//  iPrompter
//
//  Created by Alex Parella on 9/25/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCAddCollectionViewController.h"

@interface TTCAddCollectionViewController ()

@end

@implementation TTCAddCollectionViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        // Needs an image, we'll get there eventually
        self.tabBarItem.title = @"Add Collection";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
