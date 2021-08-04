//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kiryl Kaveryn
// On: 29.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "RSSettingsVC.h"
#import "RSStrokeColorVC.h"
#import "RSTableViewCell.h"
#import "RSColorItem.h"

@interface RSSettingsVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) RSStrokeColorVC *strokeColorVC;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UISwitch *switchItem;
@property (strong, nonatomic) RSColorItem *drawColor;
@property (strong, nonatomic) NSIndexPath *indexForCellReload;

@end

@implementation RSSettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    self.strokeColorVC = [RSStrokeColorVC new];
    [self.strokeColorVC loadViewIfNeeded];
    [self addChildViewController:self.strokeColorVC];
}

- (void)viewWillAppear:(BOOL)animated {
    self.drawColor = self.strokeColorVC.drawColor;
    if (self.indexForCellReload != nil ) {
        [self.tableView reloadData];
    }
    
}

- (void)setupViews {
    self.drawColor = self.strokeColorVC.drawColor;
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
    self.tableView.scrollEnabled = false;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.switchItem = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 51, 30)];
    [self.switchItem setOn:true];
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
        cell.detailTextLabel.textColor = self.drawColor.color;
        cell.detailTextLabel.text = self.drawColor.colorName;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.indexForCellReload = [NSIndexPath new];
        self.indexForCellReload = indexPath;
        return cell;
    }
}
    
- (void)backButtonTapped:(id)sender {
    NSLog(@"backButtonTapped");
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)switchItemTapped:(id)sender {
    if ([sender isOn]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchButtonIsOn" object:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SwitchButtonIsOff" object:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:self.strokeColorVC animated:true];
    }
}

@end
