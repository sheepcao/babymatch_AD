//
//  answer.m
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "answer.h"

@implementation answer

-(id)initAnswers:(NSString *)first :(NSString *)second :(NSString *)third Level:(NSInteger)lv
{
    self = [super init];
    if (self) {
        // Initialization code
        self.choiceBtn = [[NSArray alloc] initWithObjects:self.fst,self.scd,self.thd, nil];
      //  unsigned int randomNumber = arc4random();

        
        self.fst = [NSString stringWithFormat:@"an1_right-%d",(int)lv];
        
        self.scd = [NSString stringWithFormat:@"an2_wrong1-%d",(int)lv];
        
        self.thd = [NSString stringWithFormat:@"an3_wrong2-%d",(int)lv];


        
    }
    return self;
}

@end
