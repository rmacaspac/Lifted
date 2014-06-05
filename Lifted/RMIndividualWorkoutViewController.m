//
//  RMIndividualWorkoutViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/3/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMIndividualWorkoutViewController.h"
#import "RMExerciseObject.h"

@interface RMIndividualWorkoutViewController ()

@property (strong, nonatomic) IBOutlet UITableView *workoutTableView;
@property (strong, nonatomic) IBOutlet UITextField *repsTextField;
@property (strong, nonatomic) IBOutlet UITextField *weightTextField;


@end

@implementation RMIndividualWorkoutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
#pragma mark - Helper Method

- (NSDictionary *)individualExercise:(NSString *)workoutName with:(int)workoutReps andWith:(int)workoutWeight
{
    NSDictionary *individualExerciseData = @{WORKOUT_NAME : workoutName, WORKOUT_REPS : [NSNumber numberWithInt:workoutReps], WORKOUT_WEIGHT : [NSNumber numberWithInt:workoutWeight]};
    
    return individualExerciseData;
}
*/

@end
