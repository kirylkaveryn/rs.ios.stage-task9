//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kirill
// On: 29.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "RSTableViewCell.h"

@interface RSTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *selectedIndicator;
//@property (nonatomic, strong) UILabel *titleLabel;

@end



@implementation RSTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}


- (void)setupViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:NO];
    
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:0.898 green:0.898 blue:0.918 alpha:1];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
