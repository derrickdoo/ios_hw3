//
//  Main2ViewController.m
//  ios_hw3
//
//  Created by Derrick Or on 6/22/14.
//  Copyright (c) 2014 derrickor. All rights reserved.
//

#import "Main2ViewController.h"

@interface Main2ViewController ()
@property (weak, nonatomic) IBOutlet UIView *postView;
@property (weak, nonatomic) IBOutlet UIScrollView *carouselScrollView;
- (IBAction)postPan:(UIPanGestureRecognizer *)sender;

@end

@implementation Main2ViewController

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
    // Do any additional setup after loading the view from its nib.
    //Define the size of the carouselScrollView's contents
    CGSize sz = CGSizeMake(1404, 245);
    self.carouselScrollView.contentSize = sz;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)postPan:(UIPanGestureRecognizer *)sender {
    //pan stats
    CGPoint translation = [sender translationInView:self.view];
    CGPoint point = [sender locationInView:self.view];
    //CGPoint velocity = [sender velocityInView:self.view];
    
    NSLog(@"point info: %@", NSStringFromCGPoint(point));
    
    //static vars
    int maxYPos = self.view.frame.size.height - 80;
    int transY = translation.y;
    CGRect frame = self.postView.frame;
    
    //check to see if panning in progress
    if (sender.state == UIGestureRecognizerStateChanged) {
        //panning down
        if(transY > 0) {
            frame.origin.y = transY;
        }
        //panning up
        else {
            frame.origin.y = maxYPos + transY;
        }
    }
    //check to see if the user finished panning
    else if (sender.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"translation %@", NSStringFromCGPoint(translation));
        
        //panned down
        if(transY > 0) {
            frame.origin.y = maxYPos;
        }
        //panned up
        else {
            frame.origin.y = 0;
        }
    }
    
    self.postView.frame = frame;
}
@end
