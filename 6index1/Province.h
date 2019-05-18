//
//  Province.h
//  6index1
//
//  Created by Kwangchiu on 2019/5/18.
//  Copyright © 2019年 Kwangchiu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Province : NSObject

@property(nonatomic,copy)NSString *header;
@property(nonatomic,copy)NSString *footer;
@property(nonatomic,strong)NSArray *cities;
+(id)provinceWithHeader:(NSString *)header Footer:(NSString *)footer Cities:(NSArray *)cities;


@end

NS_ASSUME_NONNULL_END
