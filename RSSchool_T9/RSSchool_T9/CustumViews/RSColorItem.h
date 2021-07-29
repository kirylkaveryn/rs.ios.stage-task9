//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kirill
// On: 30.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RSColorItem : NSObject

@property (nonatomic, strong) NSString *colorName;
@property (nonatomic, strong) UIColor *color;

-(instancetype)initWithName: (NSString *)name andColor: (UIColor*)color;


@end


