//
//  TTCTableViewController.h
//  iPrompter
//
//  Created by Alex Parella on 9/21/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCTableViewController : UITableViewController

- (void) dismissViewController;
- (void) addSource:(NSString *) sourceName;
- (void) addCollection:(NSString *) collectionName;

@end
