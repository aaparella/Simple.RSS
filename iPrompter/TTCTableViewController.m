//
//  TTCTableViewController.m
//  iPrompter
//
//  Created by Alex Parella on 9/21/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCTableViewController.h"
#import "TTCAddSourceViewController.h"
#import "TTCAddCollectionViewController.h"
#import "TTCDataStore.h"

@interface TTCTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation TTCTableViewController

- (instancetype) initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
        self.navigationItem.title = @"Sources";
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self action:@selector(newEntry)];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Adding a new source
- (void) newEntry {

    TTCAddSourceViewController* addSource = [[TTCAddSourceViewController alloc] init];
    addSource.delegate = self;
    
    TTCAddCollectionViewController* addCollection = [[TTCAddCollectionViewController alloc] init];
    addCollection.delegate = self;
    
    UITabBarController* tbc = [[UITabBarController alloc] init];
    tbc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                         target:self
                                                                                         action:@selector(dismissViewController)];
    [tbc addChildViewController:addSource];
    [tbc addChildViewController:addCollection];
    
    UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController:tbc];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void) addSource {
    [[TTCDataStore sharedStore] addSource:@"Testing"];
    NSIndexPath* index = [NSIndexPath indexPathForItem:[[TTCDataStore sharedStore] numberOfSources] - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
}

- (void) addCollection {
    [[TTCDataStore sharedStore] addCollection:@"Testing"];
    NSIndexPath* index = [NSIndexPath indexPathForItem:[[TTCDataStore sharedStore] numberOfCollections] - 1 inSection:1];
    [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
}

// Because we can't pass arguments to @selector()'s for whatever reason
- (void) dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view delegate

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[TTCDataStore sharedStore] sectionHeaderForIndex:section];
}

// Push new view for a given feed source or collection of sources
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIView* view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor whiteColor];
    
    UIViewController* vc = [[UIViewController alloc] init];
    
    vc.navigationItem.title = [[TTCDataStore sharedStore] sourceForIndexPath:indexPath];
    vc.view = view;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

//TODO: Change these functions to be determined programatically, could need (n) sections in future
//          Possible use a singleton data store object?

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[TTCDataStore sharedStore] sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Each section stored as an array of items that compose that section
    return [[TTCDataStore sharedStore] itemsForSectionWithIndexPath:section];
}

// Create cell for a given location in a given section
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    
    cell.textLabel.text = [[TTCDataStore sharedStore] sourceForIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// Allow for deleting objects in the sections
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[TTCDataStore sharedStore] deleteObjectAtIndexpath:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // If we're inserting
    }
}

// Allow for rearranging of section entries
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {

    [[TTCDataStore sharedStore] moveObjectAtIndexPath:fromIndexPath toIndexPath:toIndexPath];

}

@end
