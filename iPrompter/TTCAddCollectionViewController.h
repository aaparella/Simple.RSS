//
//  TTCAddCollectionViewController.h
//  iPrompter
//
//  Created by Alex Parella on 9/25/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <UIKit/UIKit.h>

// Because we don't need to actually send any messages
@class TTCTableViewController;

@interface TTCAddCollectionViewController : UIViewController

@property (nonatomic, weak) TTCTableViewController* delegate;

@end
