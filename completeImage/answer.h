//
//  answer.h
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface answer : NSObject

@property (nonatomic , strong) NSArray *choiceBtn;
@property (nonatomic , strong) NSString *fst;
@property (nonatomic , strong) NSString *scd;
@property (nonatomic , strong) NSString *thd;


-(id)initAnswers:(NSString *)first :(NSString *)second :(NSString *)third Level:(NSInteger)lv;

@end
