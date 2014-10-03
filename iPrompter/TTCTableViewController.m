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
#import "TTCFeedDataStore.h"
#import "TTCArticlesViewController.h"
#import "TTCFeed.h"
#import "TTCFeedCollection.h"
#import "TTCCollectionViewController.h"

@interface TTCTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray* sectionHeaders;

@end

@implementation TTCTableViewController

- (instancetype) initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
        self.sectionHeaders = @[@"Sources", @"Collections"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
        self.navigationItem.title = @"iPrompter";
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self action:@selector(newEntry)];
        
        self.toolbarItems = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                            target:self
                                                                            action:@selector(refreshFeeds:)]];
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(refreshFeeds:)
                      forControlEvents:UIControlEventValueChanged];
    }
    
    return self;
}

- (void) refreshFeeds:(id) sender {
    [[TTCFeedDataStore sharedStore] updateFeeds];
    [(UIRefreshControl *)sender endRefreshing];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view delegate

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionHeaders[section];
}

// Push new view for a given feed source or collection of sources
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TTCArticlesViewController *avc = [[TTCArticlesViewController alloc] initWithFeed:[[TTCFeedDataStore sharedStore] feedForIndex:indexPath.item]];
        [self.navigationController pushViewController:avc animated:YES];
    } else {
        TTCCollectionViewController *tvc = [[TTCCollectionViewController alloc] initWithCollection:[[TTCFeedDataStore sharedStore] collectionForIndex:indexPath.item]];
        [self.navigationController pushViewController:tvc animated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionHeaders count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Each section stored as an array of items that compose that section
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
        // If we're inserting
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
