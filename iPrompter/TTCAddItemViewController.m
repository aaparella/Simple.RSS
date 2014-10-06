//
//  TTCAddItemViewController.m
//  iPrompter
//
//  Created by Alex Parella on 10/5/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCAddItemViewController.h"
#import "TTCTableViewController.h"
#import "TTCAddCollectionViewController.h"
#import "TTCAddSourceViewController.h"

@interface TTCAddItemViewController ()

@end

@implementation TTCAddItemViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        [self addChildViewController:[[TTCAddSourceViewController alloc] init]];
        [self addChildViewController:[[TTCAddCollectionViewController alloc] init]];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(confirmAddition:)];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) confirmAddition:(id) sender {
    if ([self.selectedViewController isKindOfClass:TTCAddSourceViewController.class])
        [(TTCAddSourceViewController *)self.selectedViewController addSource:self];
    else
        [(TTCAddCollectionViewController *)self.selectedViewController addCollection:self];
    
    [self.dismissDelegate dismissViewController];
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
