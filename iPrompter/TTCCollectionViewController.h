//
//  TTCCollectionViewController.h
//  iPrompter
//
//  Created by Alex Parella on 10/1/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTCFeedCollection;

@interface TTCCollectionViewController : UITableViewController

- (instancetype) initWithCollection:(TTCFeedCollection *) collection;

@end
