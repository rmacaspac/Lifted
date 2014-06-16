//
//  RMWorkoutRoutineViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/3/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMWorkoutRoutineViewController.h"
#import "RMExerciseDataInputViewController.h"
#import "RMCoreDataHelper.h"

@interface RMWorkoutRoutineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *workoutRoutineTableView;

@end

@implementation RMWorkoutRoutineViewController

- (NSMutableArray *)routineExercises
{
    if (!_routineExercises) {
        _routineExercises = [[NSMutableArray alloc] init];
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
    
    self.navigationItem.title = [self.routine valueForKey:@"name"];

    [self orderRoutineExercises];
    
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
    
    cell.textLabel.text = [self.routineExercises valueForKey:@"name"][indexPath.row];
    
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
                NSIndexPath *indexPath = [self.workoutRoutineTableView indexPathForSelectedRow];
                exerciseDataInputVC.selectedExercise = self.routineExercises[indexPath.row];
                exerciseDataInputVC.selectedRoutine = self.routine;
            }
        }
    }
}

- (void)orderRoutineExercises
{
    NSSet *unorderedExercises = self.routine.exercises;
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *orderedExercises = [unorderedExercises sortedArrayUsingDescriptors:@[sortDescriptor]];
    self.routineExercises = [orderedExercises mutableCopy];
}



@end
