//
//  TTCEditFeedViewController.h
//  iPrompter
//
//  Created by Alex Parella on 10/9/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTCFeed;
@interface TTCEditFeedViewController : UIViewController

@property (nonatomic, weak) id delegate;

- (instancetype) initWithFeed:(TTCFeed *) feed;

@end
