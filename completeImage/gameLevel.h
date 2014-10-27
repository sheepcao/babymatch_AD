//
//  gameLevel.h
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "uncompleteImage.h"

@interface gameLevel : NSObject

@property uncompleteImage *toBeCompelte;
@property (nonatomic , strong) NSArray *answers;
@property (nonatomic , strong) UIButton *choices;

//-(BOOL)judgeAswer
@end
