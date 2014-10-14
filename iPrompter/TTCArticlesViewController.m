//
//  TTCArticlesViewController.m
//  iPrompter
//
//  Created by Alex Parella on 9/29/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCArticlesViewController.h"
#import "TTCFeed.h"
#import "TTCArticleCell.h"
#import "TTCEditFeedViewController.h"
#import "MWFeedItem.h"

@interface TTCArticlesViewController () <UITableViewDataSource>

@end

@implementation TTCArticlesViewController

- (instancetype) initWithFeed:(TTCFeed *) feed {
    self = [super init];
    if (self) {
        self.feed = feed;
        [self.feed updateArticles];
        self.feed.delegate = self;
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(updateFeed:) forControlEvents:UIControlEventValueChanged];

        [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
        
        self.navigationItem.title = self.feed.title;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"\u2699"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self
                                                                                 action:@selector(editFeed:)];
        
        self.tableView.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"TTCArticleCell" bundle:nil] forCellReuseIdentifier:@"TTCArticleCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) editFeed:(id) sender {
    TTCEditFeedViewController *editVC = [[TTCEditFeedViewController alloc] initWithFeed:self.feed];
    editVC.delegate = self;
    
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void) updateFeed:(id) sender {
    [self.feed updateArticles];
    [self.tableView reloadData];
    
    [(UIRefreshControl *)sender endRefreshing];
}

- (void) loadNewData:(TTCFeed *) newFeed withNewURL:(BOOL) newURL{
    self.feed = newFeed;
    self.navigationItem.title = newFeed.title;
    
    if (newURL)
        [self.feed updateArticles];

    [self.tableView reloadData];
}

# pragma mark - TTCFeedDelegate

- (void) feed:(TTCFeed *)feed updatedWithNewArticles:(NSInteger)newArticles {
    [self.tableView reloadData];
}

- (void) feed:(TTCFeed *)feed updateFailedWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error.localizedDescription
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.feed articles] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTCArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TTCArticleCell" forIndexPath:indexPath];
    
    MWFeedItem *feedItem = self.feed.articles[indexPath.row];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm"];
    
    cell.articleTitleLabel.text = feedItem.title;
    cell.datePublishedLabel.text = [dateFormatter stringFromDate:feedItem.date];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    NSURL *link = [NSURL URLWithString:((MWFeedItem *)self.feed.articles[indexPath.row]).link];
    
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
        vc.navigationItem.title = ((MWFeedItem *)self.feed.articles[indexPath.item]).title;
        vc.view = wv;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
