//
//  RMWorkoutRoutineViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/3/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMWorkoutRoutineViewController.h"
#import "RMExerciseDataInputViewController.h"

@interface RMWorkoutRoutineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *routineExercises;

@property (strong, nonatomic) IBOutlet UITableView *workoutRoutineTableView;

@end

@implementation RMWorkoutRoutineViewController

- (NSArray *)routineExercises
{
    if (!_routineExercises) {
        _routineExercises = [[NSArray alloc] init];
    }
    return _routineExercises;
}

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
    
    self.workoutRoutineTableView.dataSource = self;
    self.workoutRoutineTableView.delegate = self;
    
    self.navigationItem.title = [self.routine valueForKey:ROUTINE_NAME];
    self.routineExercises = [self.routine valueForKey:ROUTINE_EXERCISES];
    NSLog(@"workout exercises %@", self.routineExercises);
    

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
    
    cell.textLabel.text = self.routineExercises[indexPath.row][WORKOUT_NAME];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.routineExercises count];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"routineToDataInputSegue" sender:indexPath];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.identifier isEqualToString:@"routineToDataInputSegue"]) {
            if ([segue.destinationViewController isKindOfClass:[RMExerciseDataInputViewController class]]) {
                RMExerciseDataInputViewController *exerciseDataInputVC = segue.destinationViewController;
                NSIndexPath *indexPath = sender;
                exerciseDataInputVC.exerciseData = self.routineExercises[indexPath.row];
            }
        }
    }
}


@end
