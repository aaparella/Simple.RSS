//
//  TTCEditFeedViewController.m
//  iPrompter
//
//  Created by Alex Parella on 10/9/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCEditFeedViewController.h"
#import "TTCArticlesViewController.h"
#import "TTCFeedDataStore.h"
#import "TTCFeed.h"

@interface TTCEditFeedViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *URLField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *URLLabel;
@property (weak, nonatomic) TTCFeed *feed;

@end

@implementation TTCEditFeedViewController

-(instancetype) initWithFeed:(TTCFeed *)feed {
    self = [super init];
    if (self) {
        _feed = feed;
        self.navigationItem.title = @"Edit Feed";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.text = self.feed.title;
    self.URLField.text = self.feed.URL.description;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    TTCFeed *newFeed = [[TTCFeed alloc] initWithTitle:self.nameField.text withURL:self.URLField.text];
    [[TTCFeedDataStore sharedStore] replaceFeed:self.feed withFeed:newFeed];
    
    [(TTCArticlesViewController *)self.delegate loadNewData:newFeed
                                                 withNewURL:![[NSURL URLWithString:self.URLField.text] isEqual:self.feed.URL]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
