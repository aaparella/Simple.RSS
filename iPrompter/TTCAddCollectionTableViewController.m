//
//  TTCAddCollectionTableViewController.m
//  iPrompter
//
//  Created by Alex Parella on 10/12/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCAddCollectionTableViewController.h"
#import "TTCFeedDataStore.h"
#import "TTCFeedCollection.h"
#import "TTCFeed.h"

@interface TTCAddCollectionTableViewController ()

@property (nonatomic, strong) TTCFeedCollection* collection;

@end

@implementation TTCAddCollectionTableViewController

- (instancetype) init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.collection = [[TTCFeedCollection alloc] initWithTitle:@""];
        self.tabBarItem.title = @"Add Collection";
        self.tabBarItem.image = [UIImage imageNamed:@"addCollectionIcon"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0 ? 1 : [[TTCFeedDataStore sharedStore] numberOfSources]);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0)
        cell.textLabel.text = @"PlaceHolder";
    else
        cell.textLabel.text = [[[TTCFeedDataStore sharedStore] feedForIndex:indexPath.row] title];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (selectedCell.accessoryType != UITableViewCellAccessoryCheckmark) {
            selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.collection insertSource:[[TTCFeedDataStore sharedStore] feedForIndex:indexPath.row]];
        }
        else {
            selectedCell.accessoryType = UITableViewCellAccessoryNone;
            [self.collection removeSource:[[TTCFeedDataStore sharedStore] feedForIndex:indexPath.row]];
        }
        
        selectedCell.selected = NO;
    }
    
    NSLog(@"%@", self.collection.feeds);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
