//
//  TTCAddSourceTableViewController.h
//  iPrompter
//
//  Created by Alex Parella on 10/13/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTCAddItemViewController;

@interface TTCAddSourceTableViewController : UITableViewController

@property (nonatomic, weak) TTCAddItemViewController *delegate;

@end
