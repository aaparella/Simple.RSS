//
//  TTCTableViewController.m
//  iPrompter
//
//  Created by Alex Parella on 9/21/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCTableViewController.h"
#import "TTCFeedDataStore.h"
#import "TTCArticlesViewController.h"
#import "TTCFeed.h"
#import "TTCFeedCollection.h"
#import "TTCCollectionViewController.h"
#import "TTCAddItemViewController.h"

@interface TTCTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray* sectionHeaders;

@end

@implementation TTCTableViewController

- (instancetype) initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
        self.sectionHeaders = @[@"Sources", @"Collections"];
        
        self.navigationItem.title = @"Simple.rss";
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self action:@selector(newEntry)];
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(refreshFeeds:)
                      forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

- (void) viewDidLoad {
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
}

- (void) refreshFeeds:(id) sender {
    [[TTCFeedDataStore sharedStore] updateFeeds];
    [(UIRefreshControl *)sender endRefreshing];
}

// Adding a new source, present addSource / addCollection view controllers
- (void) newEntry {
    TTCAddItemViewController *addVC = [[TTCAddItemViewController alloc] init];
    addVC.dismissDelegate = self;
    addVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                            target:self
                                                                                            action:@selector(dismissViewController)];
    
    UINavigationController* nvc = [[UINavigationController alloc] initWithRootViewController:addVC];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void) addSource:(NSString *) sourceName withURL:(NSString *) URL {    
    [[TTCFeedDataStore sharedStore] addSource:sourceName withURL:URL];
    NSIndexPath* index = [NSIndexPath indexPathForItem:[[TTCFeedDataStore sharedStore] numberOfSources] - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
}

- (void) addCollection:(NSString *) collectionName {
    [[TTCFeedDataStore sharedStore] addCollection:collectionName withFeeds:@[]];
    NSIndexPath* index = [NSIndexPath indexPathForItem:[[TTCFeedDataStore sharedStore] numberOfCollections] - 1 inSection:1];
    [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
}

// Because we can't pass arguments to @selector()'s for whatever reason
- (void) dismissViewController {
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view delegate

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionHeaders[section];
}

// Push new view for a given feed source or collection of sources
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TTCFeed *selectedFeed = [[TTCFeedDataStore sharedStore] feedForIndex:indexPath.row];
    if (indexPath.section == 0) {
        TTCArticlesViewController *avc = [[TTCArticlesViewController alloc] initWithFeed:selectedFeed];
        [self.navigationController pushViewController:avc animated:YES];
    } else {
        TTCFeedCollection *selectedCollection = [[TTCFeedDataStore sharedStore] collectionForIndex:indexPath.row];
        TTCCollectionViewController *tvc = [[TTCCollectionViewController alloc] initWithCollection:selectedCollection];
        [self.navigationController pushViewController:tvc animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionHeaders count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return [[TTCFeedDataStore sharedStore] numberOfSources];
    
    return [[TTCFeedDataStore sharedStore] numberOfCollections];
}

// Create cell for a given location in a given section
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0)
        cell.textLabel.text = [[[TTCFeedDataStore sharedStore] feedForIndex:indexPath.item] title];
    else
        cell.textLabel.text = [[[TTCFeedDataStore sharedStore] collectionForIndex:indexPath.item] title];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// Allow for deleting objects in the sections
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0)
            [[TTCFeedDataStore sharedStore] deleteFeedAtIndex:indexPath.item];
        else
            [[TTCFeedDataStore sharedStore] deleteCollectionAtIndex:indexPath.item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // If we're inserting...
        // Don't really need to do anything
    }
}

// Allow for rearranging of section entries
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if (fromIndexPath.section == 0)
        [[TTCFeedDataStore sharedStore] moveFeedAtIndex:fromIndexPath.item toIndex:toIndexPath.item];
    else
        [[TTCFeedDataStore sharedStore] moveCollectionAtIndex:fromIndexPath.item toIndex:toIndexPath.item];
        
}

@end
