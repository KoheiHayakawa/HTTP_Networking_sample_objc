//
//  EntryCreationFormViewController.m
//  HTTP_Networking_sample_objc
//
//  Created by Kohei Hayakawa on 5/8/15.
//  Copyright (c) 2015 Kohei Hayakawa. All rights reserved.
//

#import "EntryCreationFormViewController.h"
#import "TextFieldCell.h"
#import "TextViewCell.h"

@interface EntryCreationFormViewController ()

@end

@implementation EntryCreationFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Create Entry";
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(didTouchCloseBarButton:)];
    self.navigationItem.leftBarButtonItem = closeButton;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTouchDoneBarButton:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    UINib *textFieldCellNib = [UINib nibWithNibName:@"TextFieldCell" bundle:nil];
    [self.tableView registerNib:textFieldCellNib forCellReuseIdentifier:@"TextFieldCell"];
    UINib *textViewCellNib = [UINib nibWithNibName:@"TextViewCell" bundle:nil];
    [self.tableView registerNib:textViewCellNib forCellReuseIdentifier:@"TextViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        return 128;
    }
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldCell" forIndexPath:indexPath];
        return cell;
    } else {
        TextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextViewCell" forIndexPath:indexPath];
        return cell;
    }
}


#pragma mark - Bar button action selector

- (void)didTouchCloseBarButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTouchDoneBarButton:(id)sender {
    TextFieldCell *textFieldCell = (TextFieldCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    TextViewCell *textViewCell = (TextViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    NSLog(@"%@", textFieldCell.textField.text);
    NSLog(@"%@", textViewCell.textView.text);

}

@end
