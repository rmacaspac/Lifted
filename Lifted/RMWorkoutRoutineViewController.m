//
//  RMWorkoutRoutineViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 6/3/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMWorkoutRoutineViewController.h"

@interface RMWorkoutRoutineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *workoutRoutineTableView;

@end

@implementation RMWorkoutRoutineViewController

- (NSArray *)workoutExercises
{
    if (!_workoutExercises) {
        _workoutExercises = [[NSArray alloc] init];
    }
    return _workoutExercises;
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
    
    self.workoutExercises = [self.workoutObject valueForKey:WORKOUT_EXERCISES];
    
    [self.workoutRoutineTableView reloadData];
    
    NSLog(@"workout exercises %@", self.workoutExercises);
    

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
    
    
    cell.textLabel.text = self.workoutExercises[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.workoutExercises count];
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

@end
