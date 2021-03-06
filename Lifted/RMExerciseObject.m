//
//  RMExercises.m
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMExerciseObject.h"

@implementation RMExerciseObject

- (id)init
{
    self = [self initWithData:nil];
    
    return self;
}

- (id)initWithData:(NSDictionary *)exerciseInfo
{
    self = [super init];
    
    self.name = exerciseInfo[EXERCISE_NAME];
    self.muscle = exerciseInfo[EXERCISE_MUSCLE_GROUP];
    self.numberOfSets = [exerciseInfo[EXERCISE_SETS] intValue];
    self.repMin = [exerciseInfo[EXERCISE_REP_MIN] intValue];
    self.repMax = [exerciseInfo[EXERCISE_REP_MAX] intValue];
    
    return self;
}


@end
