//
//  TTCAddSourceViewController.m
//  iPrompter
//
//  Created by Alex Parella on 9/24/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCAddSourceViewController.h"
#import "TTCTableViewController.h"

@interface TTCAddSourceViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sourceNameField;
@property (weak, nonatomic) IBOutlet UITextField *sourceURLField;

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

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addSource:(id)sender {
    [self.view endEditing:YES];
    
    [self.delegate addSource:self.sourceNameField.text withURL:self.sourceURLField.text];
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
