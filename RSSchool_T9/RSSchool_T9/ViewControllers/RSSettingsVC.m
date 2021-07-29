//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kirill
// On: 29.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "RSSettingsVC.h"
#import "RSStrokeColorVC.h"
#import "RSTableViewCell.h"

@interface RSSettingsVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) RSStrokeColorVC *strokeColorVC;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISwitch *switchItem;

@end

@implementation RSSettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    self.strokeColorVC = [RSStrokeColorVC new];
    [self addChildViewController:self.strokeColorVC];

}


- (void)setupViews {
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Settings";
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor blackColor],
        NSFontAttributeName: [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold],};
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(backButtonTapped:)];
    [backButton setTitleTextAttributes:@{
            NSForegroundColorAttributeName: [UIColor redColor],
            NSFontAttributeName: [UIFont systemFontOfSize:17.0 weight:UIFontWeightRegular],} forState:UIControlStateHighlighted];
    [backButton setTitleTextAttributes:@{
            NSForegroundColorAttributeName: [UIColor redColor],
            NSFontAttributeName: [UIFont systemFontOfSize:17.0 weight:UIFontWeightRegular],} forState:UIControlStateNormal];
    [backButton setTintColor:[UIColor redColor]];

    self.navigationItem.backBarButtonItem = backButton;
    
    // setup table view
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    [self.tableView registerClass: RSTableViewCell.class forCellReuseIdentifier:@"drawStoriesCell"];
    [self.tableView registerClass: RSTableViewCell.class forCellReuseIdentifier:@"strokeColorCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.switchItem = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [self.switchItem addTarget:self action:@selector(switchItemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.switchItem addTarget:self action:@selector(switchItemTapped:) forControlEvents:UIControlEventTouchDragInside];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint activateConstraints: @[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
    ]];

}


// MARK: data for UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        RSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"drawStoriesCell" forIndexPath:indexPath];
        cell.textLabel.text = @"Draw stories";
        cell.accessoryView = self.switchItem;
        return cell;
    }
    else {
        RSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"strokeColorCell" forIndexPath:indexPath];
        cell.textLabel.text = @"Stroke color";
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.text = @"#color0000";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
}
    
- (void)backButtonTapped:(id)sender {
    NSLog(@"backButtonTapped");
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)switchItemTapped:(id)sender {
    if ([self.switchItem isOn]) {
        NSLog(@"swich mode is: ON");
    }
    else {
        NSLog(@"swich mode is: OFF");
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:self.strokeColorVC animated:true];
//        [self.navigationController showViewController:self.strokeColorVC animated:true sender:self];
    }
}

//- (void)viewWillLayoutSubviews {
//    [self viewWillLayoutSubviews];
//    [self.tableView setRowHeight:51.0];
//}

@end
