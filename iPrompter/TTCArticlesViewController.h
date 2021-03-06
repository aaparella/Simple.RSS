//
//  TTCArticlesViewController.h
//  iPrompter
//
//  Created by Alex Parella on 9/29/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTCFeed.h"

@interface TTCArticlesViewController : UITableViewController <TTCFeedDelegate>

@property (nonatomic, strong) TTCFeed* feed;

- (instancetype) initWithFeed:(TTCFeed *) feed;
- (void) loadNewData:(TTCFeed *) newFeed withNewURL:(BOOL) newURL;

@end
