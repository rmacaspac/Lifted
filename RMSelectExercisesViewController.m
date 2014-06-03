//
//  RMSelectExercisesViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 5/30/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMSelectExercisesViewController.h"


@interface RMSelectExercisesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *exerciseObjects;
@property (strong, nonatomic) NSMutableArray *selectedExercise;
@property (strong, nonatomic) RMExercises *exercises;

@property (strong, nonatomic) IBOutlet UITableView *exercisesTableView;

@end

@implementation RMSelectExercisesViewController

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
    
    self.exercisesTableView.delegate = self;
    self.exercisesTableView.dataSource = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[RMExercises exerciseList] objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[RMExercises exerciseList] count];
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *selectedExercise = [[RMExercises exerciseList] objectAtIndex:indexPath.row];
    [self.delegate didSelectExercise:selectedExercise];
    
    NSLog(@"%@", selectedExercise);
     
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}





@end
