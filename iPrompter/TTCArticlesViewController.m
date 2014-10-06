//
//  TTCArticlesViewController.m
//  iPrompter
//
//  Created by Alex Parella on 9/29/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCArticlesViewController.h"
#import "TTCFeed.h"
#import "RSSItem.h"

@interface TTCArticlesViewController () <UITableViewDataSource>

@end

@implementation TTCArticlesViewController

- (instancetype) initWithFeed:(TTCFeed *) feed {
    self = [super init];
    if (self) {
        self.feed = feed;
        [self.feed updateArticles];
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(updateFeed:) forControlEvents:UIControlEventValueChanged];

        [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
        
        self.navigationItem.title = self.feed.title;
        self.tableView.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) updateFeed:(id) sender {
    [self.feed updateArticles];
    [self.tableView reloadData];
    
    [(UIRefreshControl *)sender endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.feed articles] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSArray* articles = [self.feed articles];
    cell.textLabel.text = ((RSSItem *)articles[indexPath.item]).title;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    NSURL *link = ((RSSItem *)self.feed.articles[indexPath.item]).link;
    
    if ([link isEqual:[NSURL URLWithString:@""]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Link"
                                                        message:@"We couldn't find a link for that article :("
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
    } else {
        NSURLRequest* req = [[NSURLRequest alloc] initWithURL:link];
        
        UIWebView *wv = [[UIWebView alloc] init];
        [wv loadRequest:req];
        
        UIViewController* vc = [[UIViewController alloc] init];
        vc.navigationItem.title = ((RSSItem *)self.feed.articles[indexPath.item]).title;
        vc.view = wv;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
