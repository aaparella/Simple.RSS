//
//  TTCAddSourceViewController.m
//  iPrompter
//
//  Created by Alex Parella on 9/24/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCAddSourceViewController.h"
#import "TTCTableViewController.h"

@interface TTCAddSourceViewController ()

@end

@implementation TTCAddSourceViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"Add Source";
        // Needs an image, we'll get there eventually
    }
        
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) foo {}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addSource:(id)sender {
    [self.delegate addSource];
    [self.delegate dismissViewController];
}

- (IBAction)addCollection:(id)sender {
    [self.delegate addCollection];
    [self.delegate dismissViewController];
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
