//
//  TTCArticleCell.h
//  iPrompter
//
//  Created by Alex Parella on 10/6/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTCArticleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *datePublishedLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

@end
