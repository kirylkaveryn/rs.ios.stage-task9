//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kirill
// On: 29.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "RSStrokeColorVC.h"
#import "RSColorItem.h"
#import "RSTableViewCell.h"
#import "RSTableViewColorCell.h"

@interface RSStrokeColorVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<RSColorItem*> *colorSet;
@property (strong, nonatomic) UIColor *drawColor;

@end

@implementation RSStrokeColorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupColorSet];
    
//    NSLog(@"viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
//    NSLog(@"viewWillAppear");
    
}


- (void)setupViews {
    
    // setup table view
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    [self.tableView registerClass:RSTableViewColorCell.class forCellReuseIdentifier:@"colorCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    
    [NSLayoutConstraint activateConstraints: @[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
    ]];
    
    // setup default drawing color
    self.drawColor = [[UIColor alloc] initWithRed:0.953 green:0.686 blue:0.133 alpha:1];
    NSLog(@"self.drawColor = %@", self.drawColor);

}


// MARK: data for UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colorSet.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RSTableViewColorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"colorCell" forIndexPath:indexPath];
    cell.textLabel.text = self.colorSet[indexPath.row].colorName;
    cell.textLabel.textColor = self.colorSet[indexPath.row].color;
    return cell;
    
}

- (void)setupColorSet {
    NSArray *colorSet = @[
        [[RSColorItem alloc] initWithName:@"#be2813" andColor: [UIColor colorWithRed:0.745 green:0.157 blue:0.075 alpha:1]],
        [[RSColorItem alloc] initWithName:@"#3802da" andColor: [UIColor colorWithRed:0.22 green:0.008 blue:0.855 alpha:1]],
        [[RSColorItem alloc] initWithName:@"#467c24" andColor: [UIColor colorWithRed:0.275 green:0.486 blue:0.141 alpha:1]],
        [[RSColorItem alloc] initWithName:@"#808080" andColor: [UIColor colorWithRed:0.502 green:0.502 blue:0.502 alpha:1]],
        [[RSColorItem alloc] initWithName:@"#8e5af7" andColor: [UIColor colorWithRed:0.557 green:0.353 blue:0.969 alpha:1]],
        [[RSColorItem alloc] initWithName:@"#f07f5a" andColor: [UIColor colorWithRed:0.941 green:0.498 blue:0.353 alpha:1]],
        [[RSColorItem alloc] initWithName:@"#3dacf7" andColor: [UIColor colorWithRed:0.239 green:0.675 blue:0.969 alpha:1]],
        [[RSColorItem alloc] initWithName:@"#e87aa4" andColor: [UIColor colorWithRed:0.91 green:0.478 blue:0.643 alpha:1]],
        [[RSColorItem alloc] initWithName:@"#0f2e3f" andColor: [UIColor colorWithRed:0.059 green:0.18 blue:0.247 alpha:1]],
        [[RSColorItem alloc] initWithName:@"#213711" andColor: [UIColor colorWithRed:0.129 green:0.216 blue:0.067 alpha:1]],
        [[RSColorItem alloc] initWithName:@"#511307" andColor: [UIColor colorWithRed:0.318 green:0.075 blue:0.027 alpha:1]],
        [[RSColorItem alloc] initWithName:@"#92003b" andColor: [UIColor colorWithRed:0.573 green:0.0 blue:0.231 alpha:1]]
    ];
    self.colorSet = [[NSArray alloc] initWithArray:colorSet];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.drawColor = self.colorSet[indexPath.row].color;
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"self.drawColor = %@", self.drawColor);
}

@end



//    NSDictionary *colorSet = @{
//         @"#be2813": [UIColor colorWithRed:0.745 green:0.157 blue:0.075 alpha:1],
//         @"#3802da": [UIColor colorWithRed:0.22 green:0.008 blue:0.855 alpha:1],
//         @"#467c24": [UIColor colorWithRed:0.275 green:0.486 blue:0.141 alpha:1],
//         @"#808080": [UIColor colorWithRed:0.502 green:0.502 blue:0.502 alpha:1],
//         @"#8e5af7": [UIColor colorWithRed:0.557 green:0.353 blue:0.969 alpha:1],
//         @"#f07f5a": [UIColor colorWithRed:0.941 green:0.498 blue:0.353 alpha:1],
//         @"#3dacf7": [UIColor colorWithRed:0.239 green:0.675 blue:0.969 alpha:1],
//         @"#e87aa4": [UIColor colorWithRed:0.91 green:0.478 blue:0.643 alpha:1],
//         @"#0f2e3f": [UIColor colorWithRed:0.059 green:0.18 blue:0.247 alpha:1],
//         @"#213711": [UIColor colorWithRed:0.129 green:0.216 blue:0.067 alpha:1],
//         @"#511307": [UIColor colorWithRed:0.318 green:0.075 blue:0.027 alpha:1],
//         @"#92003b": [UIColor colorWithRed:0.573 green:0.0 blue:0.231 alpha:1]
//    };
