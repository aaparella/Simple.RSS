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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
