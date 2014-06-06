//
//  RMIndividualWorkoutViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/3/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMExerciseDataInputViewController.h"
#import "RMExerciseObject.h"
#import "RMExerciseDataInputTableViewCell.h"

@interface RMExerciseDataInputViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (strong, nonatomic) IBOutlet UITableView *workoutTableView;
@property (strong, nonatomic) IBOutlet UILabel *repMinLabel;
@property (strong, nonatomic) IBOutlet UILabel *repMaxLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;


@end

@implementation RMExerciseDataInputViewController

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
    
    self.workoutTableView.dataSource = self;
    self.workoutTableView.delegate = self;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    
    self.exerciseNameLabel.text = [self.exerciseData valueForKey:WORKOUT_NAME];
    self.repMinLabel.text = [NSString stringWithFormat:@"%@",[self.exerciseData valueForKey:WORKOUT_REP_MIN]];
    self.repMaxLabel.text = [NSString stringWithFormat:@"%@",[self.exerciseData valueForKey:WORKOUT_REP_MAX]];
    
    NSLog(@"the exercises data for routine is %@", self.exerciseData);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    RMExerciseDataInputTableViewCell *tableViewCell = [[RMExerciseDataInputTableViewCell alloc] init];
    tableViewCell.numberOfRepsTextField.text = nil;
    if (indexPath.section == 1) {
        cell.textLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:14.0];
        cell.textLabel.text = @"Add Set";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [[self.exerciseData valueForKey:WORKOUT_SETS] integerValue];
    } else {
        return 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
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
