//
//  RMExercisesData.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/4/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Routine.h"

@interface RMExercisesData : NSObject

@property (nonatomic, retain) NSString *exerciseName;
@property (nonatomic) int16_t repMax;
@property (nonatomic) int16_t repMin;
@property (nonatomic) int16_t numberOfSets;
@property (nonatomic, retain) Routine *routine;

- (id)initWithData:(NSDictionary *)exerciseInfo;
+ (NSMutableArray *)exerciseList;

@end
