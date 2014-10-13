//
//  TTCAddSourceViewController.h
//  iPrompter
//
//  Created by Alex Parella on 9/24/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTCTableViewController.h"

@class TTCAddItemViewController;

@interface TTCAddSourceViewController : UIViewController

@property (nonatomic, weak) TTCAddItemViewController *delegate;

@end
