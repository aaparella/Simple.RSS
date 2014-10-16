//
//  TTCAddCollectionTableViewController.m
//  iPrompter
//
//  Created by Alex Parella on 10/12/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCAddCollectionTableViewController.h"
#import "TTCAddItemViewController.h"
#import "TTCFeedDataStore.h"
#import "TTCFeedCollection.h"
#import "TTCFeed.h"

@interface TTCAddCollectionTableViewController () <UITextFieldDelegate>

@property (nonatomic, strong) TTCFeedCollection* collection;
@property (nonatomic, strong) UITextField *collectionNameField;

@end

#pragma mark - Table View Controller

@implementation TTCAddCollectionTableViewController

- (instancetype) init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Ugliest hack in all of ugly hacks
        UITableViewCell *dummyCell = [UITableViewCell new];
        self.collectionNameField = [[UITextField alloc] initWithFrame:CGRectMake(dummyCell.frame.origin.x + 15,
                                                                                 dummyCell.frame.origin.y,
                                                                                 dummyCell.frame.size.width,
                                                                                 dummyCell.frame.size.height)];
        self.collectionNameField.placeholder = @"New Collection";
        
        self.collectionNameField.delegate = self;
        self.navigationItem.title = @"Add Collection";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                              target:self action:@selector(cancel)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                               target:self action:@selector(confirm)];
        self.collection = [[TTCFeedCollection alloc] initWithTitle:@""];
        self.tabBarItem.title = @"Add Collection";
        self.tabBarItem.image = [UIImage imageNamed:@"addCollectionIcon"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation Item methods

- (void) confirm {
    [self.tableView endEditing:YES];
    [[TTCFeedDataStore sharedStore] addCollection:self.collectionNameField.text withFeeds:self.collection.feeds];
    [self.delegate resignFirstResponder];
    
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

- (void) cancel {
    [self.tableView endEditing:YES];
    [self.delegate dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0 ? 1 : [[TTCFeedDataStore sharedStore] numberOfSources]);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        [cell.contentView addSubview:self.collectionNameField];
    } else
        cell.textLabel.text = [[[TTCFeedDataStore sharedStore] feedForIndex:indexPath.row] title];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (selectedCell.accessoryType != UITableViewCellAccessoryCheckmark) {
            selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.collection insertSource:[[TTCFeedDataStore sharedStore] feedForIndex:indexPath.row]];
        }
        else {
            selectedCell.accessoryType = UITableViewCellAccessoryNone;
            [self.collection removeSource:[[TTCFeedDataStore sharedStore] feedForIndex:indexPath.row]];
        }
        
        selectedCell.selected = NO;
    }
}


# pragma UITextFieldDelegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
