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
    
    self.exerciseName = exerciseInfo[WORKOUT_NAME];
    self.numberOfSets = [exerciseInfo[WORKOUT_SETS] intValue];
    self.repMinNumber = [exerciseInfo[WORKOUT_REP_MIN] intValue];
    self.repMaxNumber = [exerciseInfo[WORKOUT_REP_MAX] intValue];
    self.weightNumber = [exerciseInfo[WORKOUT_WEIGHT] floatValue];
    
    return self;
}

- (NSMutableArray *)exerciseData
{
    NSMutableArray *exercise = [[NSMutableArray alloc] initWithObjects:self.exerciseName, self.numberOfSets , self.repMinNumber, self.repMinNumber, self.weightNumber, nil];
    
    return exercise;
}




@end
