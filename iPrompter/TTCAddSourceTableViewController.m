//
//  TTCAddSourceTableViewController.m
//  iPrompter
//
//  Created by Alex Parella on 10/13/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCAddSourceTableViewController.h"
#import "TTCAddItemViewController.h"
#import "TTCFeedDataStore.h"

@interface TTCAddSourceTableViewController ()

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *URLField;

@end

#pragma mark - Table View Controller

@implementation TTCAddSourceTableViewController

- (instancetype) init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (instancetype) initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Set navigation item properties
        self.navigationItem.title = @"Add Source";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                              target:self
                                                                                              action:@selector(cancel)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                               target:self
                                                                                               action:@selector(confirm)];
        // Set tab bar properties
        self.tabBarItem.title = @"Add Source";
        self.tabBarItem.image = [UIImage imageNamed:@"addSourceIcon"];
        
        // Configure UITextFields
        UITableViewCell *dummyCell = [UITableViewCell new];
        CGRect cellRect = CGRectMake(dummyCell.frame.origin.x + 15,
                                     dummyCell.frame.origin.y,
                                     dummyCell.frame.size.width,
                                     dummyCell.frame.size.height);
        
        self.nameField = [[UITextField alloc] initWithFrame:cellRect];
        self.nameField.placeholder = @"Source Name";

        self.URLField = [[UITextField alloc] initWithFrame:cellRect];
        self.URLField.placeholder = @"Source URL";
        self.URLField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.URLField.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

# pragma mark - Navigation Item methods

- (void)cancel {
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirm {
    [[TTCFeedDataStore sharedStore] addSource:self.nameField.text withURL:self.URLField.text];
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0)
        // Load the name text field
        [cell.contentView addSubview:self.nameField];
    else
        // Load the URL text field
        [cell.contentView addSubview:self.URLField];
    
    return cell;
}

@end
