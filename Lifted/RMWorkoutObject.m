//
//  RMWorkoutObject.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/2/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMWorkoutObject.h"


@implementation RMWorkoutObject

- (id)init
{
    self = [self initWithData:nil];
    return self;
}


- (id)initWithData:(NSDictionary *)addedExercises
{
    self = [super init];
    
    self.workoutName = addedExercises[WORKOUT_NAME];
    self.workoutExercises = addedExercises[WORKOUT_EXERCISES];
    
    return self;
}

@end
