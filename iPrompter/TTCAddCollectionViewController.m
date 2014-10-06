//
//  TTCAddCollectionViewController.m
//  iPrompter
//
//  Created by Alex Parella on 9/25/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCAddCollectionViewController.h"
#import "TTCTableViewController.h"
#import "TTCFeedDataStore.h"
#import "TTCFeed.h"

@interface TTCAddCollectionViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *collectionNameField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;

@end

@implementation TTCAddCollectionViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        // Needs an image, we'll get there eventually
        self.tabBarItem.title = @"Add Collection";
        self.tabBarItem.image = [UIImage imageNamed:@"addCollectionIcon"];
    }
    
    return self;
}

- (void)addCollection:(id)sender {
    [[TTCFeedDataStore sharedStore] addCollection:self.collectionNameField.text withFeeds:@[]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[TTCFeedDataStore sharedStore] numberOfSources];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [[[TTCFeedDataStore sharedStore] feedForIndex:indexPath.row] title];
    
    return cell;
}

@end
