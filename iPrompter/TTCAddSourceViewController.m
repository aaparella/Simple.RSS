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
#import "TTCAddItemViewController.h"

@interface TTCAddSourceViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sourceNameField;
@property (weak, nonatomic) IBOutlet UITextField *sourceURLField;

@end

@implementation TTCAddSourceViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        self.navigationItem.title = @"Add Source";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                              target:self
                                                                                              action:@selector(cancel)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                               target:self
                                                                                               action:@selector(confirm)];
        
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

- (void) confirm {
    [[TTCFeedDataStore sharedStore] addSource:self.sourceNameField.text withURL:self.sourceNameField.text];
    [(TTCAddItemViewController *)self.delegate dismissViewControllerAnimated:YES completion:nil];
}

- (void) cancel {
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
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
