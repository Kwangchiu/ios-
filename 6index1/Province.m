
//
//  Province.m
//  6index1
//
//  Created by Kwangchiu on 2019/5/18.
//  Copyright © 2019年 Kwangchiu. All rights reserved.
//

#import "Province.h"

@implementation Province
+(id)provinceWithHeader:(NSString *)header Footer:(NSString *)footer Cities:(NSArray *)cities{
    Province *p=[[Province alloc] init];
    p.header=header;
    p.footer=footer;
    p.cities=cities;
    return p;
}
@end
