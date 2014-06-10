//
//  Sets.h
//  Lifted
//
//  Created by Ryan Macaspac on 6/9/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface Sets : NSManagedObject

@property (nonatomic, retain) NSString * numberOfReps;
@property (nonatomic, retain) NSString * numberOfSets;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) Exercise *exerciseName;

@end
