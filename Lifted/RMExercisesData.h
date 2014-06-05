//
//  RMExercisesData.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/4/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMExercisesData : NSObject

@property (strong, nonatomic) NSString *exerciseName;
@property (nonatomic) int numberOfSets;
@property (nonatomic) int repMinNumber;
@property (nonatomic) int repMaxNumber;
@property (nonatomic) float weightNumber;
@property (strong, nonatomic) NSMutableArray *exerciseData;

+ (NSMutableArray *)exerciseList;

@end
