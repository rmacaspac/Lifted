//
//  Sets.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/6/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface Sets : NSManagedObject

@property (nonatomic) int16_t numberOfSets;
@property (nonatomic) int16_t weight;
@property (nonatomic) int16_t numberOfReps;
@property (nonatomic, retain) Exercise *exercise;

@end
