//
//  RMHomeViewController.m
//  Lifted
//
//  Created by Ryan Macaspac on 5/31/14.
//  Copyright (c) 2014 Ryan Macaspac. All rights reserved.
//

#import "RMHomeViewController.h"

@interface RMHomeViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation RMHomeViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
