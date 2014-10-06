//
//  TTCAddSourceViewController.m
//  iPrompter
//
//  Created by Alex Parella on 9/24/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCAddSourceViewController.h"
#import "TTCTableViewController.h"
#import "TTCFeedDataStore.h"

@interface TTCAddSourceViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sourceNameField;
@property (weak, nonatomic) IBOutlet UITextField *sourceURLField;

@end

@implementation TTCAddSourceViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.tabBarItem.title = @"Add Source";
        self.tabBarItem.image = [UIImage imageNamed:@"addSourceIcon"];
    }
        
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addSource:(id)sender {
    [[TTCFeedDataStore sharedStore] addSource:self.sourceNameField.text withURL:self.sourceURLField.text];
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
