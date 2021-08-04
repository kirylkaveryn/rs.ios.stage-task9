//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kiryl Kaveryn
// On: 30.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "RSTableViewCell.h"
#import "RSTableViewColorCell.h"

@implementation RSTableViewColorCell


- (void)setupViews {
    [self setTintColor: [UIColor redColor]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
