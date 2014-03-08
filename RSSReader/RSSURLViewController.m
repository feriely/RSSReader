//
//  RSSURLViewController.m
//  RSSReader
//
//  Created by Coremail on 14-3-8.
//  Copyright (c) 2014年 Coremail. All rights reserved.
//

#import "RSSURLViewController.h"
#import "RSSContentViewController.h"
#import "RSSAddFeedViewController.h"

@interface RSSURLViewController ()
@property (nonatomic, strong) NSMutableArray *rssList;
@end

@implementation RSSURLViewController

- (NSMutableArray *)rssList
{
    if (!_rssList) _rssList = [[NSMutableArray alloc] init];
    return _rssList;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.rssList addObject:[NSURL URLWithString:@"http://coolshell.cn/feed"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.rssList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RSS List Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.rssList[indexPath.row] absoluteString];
    
    return cell;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[RSSContentViewController class]]) {
        RSSContentViewController *contentViewController = (RSSContentViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        contentViewController.url = self.rssList[indexPath.row];
    }
}

#pragma mark - Actions

- (IBAction)unwindToFeedList:(UIStoryboardSegue *)segue
{
    NSLog(@"source:%@, dest:%@", segue.sourceViewController, segue.destinationViewController);
    if ([segue.sourceViewController isKindOfClass:[RSSAddFeedViewController class]]) {
        RSSAddFeedViewController *addFeedVC = (RSSAddFeedViewController *)segue.sourceViewController;
        if (addFeedVC.feedURL) {
            [self.rssList addObject:addFeedVC.feedURL];
            [self.tableView reloadData];
        }
    }
}


@end
