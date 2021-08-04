//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kiryl Kaveryn
// On: 30.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "RSColorItem.h"


@implementation RSColorItem

-(instancetype)initWithName: (NSString *)name andColor: (UIColor *)color {
    self = [super init];
    if (self) {
        _colorName = name;
        _color = color;
    }
    return self;
}

@end
