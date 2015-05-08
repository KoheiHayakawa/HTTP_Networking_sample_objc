//
//  EntryListTableViewController.m
//  HTTP_Networking_sample_objc
//
//  Created by Kohei Hayakawa on 5/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

#import "EntryListTableViewController.h"
#import "Entry.h"
#import "EntryCreationFormViewController.h"

static NSString* const cellIdentifier = @"CellIdentifier";

@interface EntryListTableViewController ()

@property (strong, nonatomic) NSMutableArray *entries;

@end


@implementation EntryListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Entries";
    
    [self.tableView registerClass:UITableViewCell.self forCellReuseIdentifier:cellIdentifier];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTouchEntryCreationBarButton:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // pull to reflesh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshEntries];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshEntries {
    [Entry getEntriesWithSuccess:^(NSArray *entries) {
        self.entries = [[[entries reverseObjectEnumerator] allObjects] mutableCopy];
        [self.tableView reloadData];
    }OrFailure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)onRefresh:(id)sender {
    [self.refreshControl beginRefreshing];
    [Entry getEntriesWithSuccess:^(NSArray *entries) {
        self.entries = [[[entries reverseObjectEnumerator] allObjects] mutableCopy];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }OrFailure:^(NSError *error) {
        NSLog(@"%@", error);
        [self.refreshControl endRefreshing];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.entries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Entry *entry = self.entries[indexPath.row];
    cell.textLabel.text = entry.title;
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Entry *entry = self.entries[indexPath.row];
        [entry deleteEntryWithSuccess:^{
            [self.entries removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } OrFailure:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    }   
}


#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //Shop *shop = self.dataSource.shops[indexPath.row];
    //ShopDetailViewController *shopDetailViewController = [[ShopDetailViewController alloc] initWithShopModel:shop];
    //[self.navigationController pushViewController:shopDetailViewController animated:YES];
}


#pragma mark - Bar button action selector

- (void)didTouchEntryCreationBarButton:(id)sender {
    EntryCreationFormViewController *entryCreationFormViewController = [[EntryCreationFormViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:entryCreationFormViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
