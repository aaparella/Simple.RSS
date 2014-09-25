//
//  TTCDataStore.h
//  iPrompter
//
//  Created by Alex Parella on 9/24/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TTCDataStore : NSObject

@property (nonatomic, strong) NSMutableArray* sectionHeaders;
@property (nonatomic, strong) NSMutableArray* sources;

+ (instancetype) sharedStore;

- (NSString *) sectionHeaderForIndex:(NSInteger) index;
- (int) itemsForSectionWithIndexPath:(NSInteger) index;
- (NSString *) sourceForIndexPath: (NSIndexPath*) index;
- (int) sectionCount;

- (void) moveObjectToIndexPath: (NSIndexPath*) toIndexPath
                 fromIndexPath: (NSIndexPath*) fromIndexPath;

@end
