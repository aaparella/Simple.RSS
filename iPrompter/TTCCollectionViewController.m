//
//  TTCCollectionViewController.m
//  iPrompter
//
//  Created by Alex Parella on 10/1/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCCollectionViewController.h"
#import "TTCFeedCollection.h"
#import "TTCArticleCell.h"
#import "MWFeedItem.h"

@interface TTCCollectionViewController ()

@property (nonatomic, weak) TTCFeedCollection *collection;

@end

@implementation TTCCollectionViewController

- (instancetype) initWithCollection:(TTCFeedCollection *)collection {
    self = [super init];
    if (self) {
        self.navigationItem.title = collection.title;
        self.collection = collection;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"TTCArticleCell" bundle:nil] forCellReuseIdentifier:@"TTCArticleCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.collection numberOfArticles];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTCArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TTCArticleCell" forIndexPath:indexPath];
    MWFeedItem *article = [self.collection articleForindex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"MM/dd/yyyy HH:mm"];
    
    cell.articleTitleLabel.text = article.title;
    cell.datePublishedLabel.text = [dateFormatter stringFromDate:article.date];
    
    return cell;
}

@end
