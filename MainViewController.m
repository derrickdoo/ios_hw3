//
//  MainViewController.m
//  ios_hw3
//
//  Created by Derrick Or on 6/20/14.
//  Copyright (c) 2014 derrickor. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (nonatomic, assign) BOOL showMenu;

@property (weak, nonatomic) IBOutlet UIImageView *carousel;
@property (weak, nonatomic) IBOutlet UIScrollView *carouselScrollView;
@property (weak, nonatomic) IBOutlet UIView *postContainer;
- (IBAction)panPost:(UIPanGestureRecognizer *)sender;

@end

@implementation MainViewController

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

    self.showMenu = NO;
    
    //Define the size of the carouselScrollView's contents
    CGSize sz = CGSizeMake(1428, 251);
    self.carouselScrollView.contentSize = sz;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)panPost:(UIPanGestureRecognizer *)sender {
    //NSLog(@"test %d", self.showMenu);
    
    //pan stats
    CGPoint translation = [sender translationInView:self.view];
    //CGPoint point = [sender locationInView:self.view];
    //CGPoint velocity = [sender velocityInView:self.view];
    
    //static vars
    int maxYPos = self.view.frame.size.height - 80;
    int transY = translation.y;
    CGRect frame = self.postContainer.frame;
    
    //check to see if panning in progress
    if (sender.state == UIGestureRecognizerStateChanged) {
        //panning down
        if(transY > 0) {
            if (self.showMenu) {
                frame.origin.y = maxYPos + (transY * 0.1);
            }
            else {
                frame.origin.y = transY;
            }
        }
        //panning up
        else {
            if(self.showMenu) {
                frame.origin.y = maxYPos + transY;
            }
            else {
                frame.origin.y = 0 + (transY * 0.1);
            }
        }
    }
    //check to see if the user finished panning
    else if (sender.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"translation %@", NSStringFromCGPoint(translation));
        
        //panned down
        if(transY > 0) {
            self.showMenu = YES;
            
            frame.origin.y = maxYPos;
        }
        //panned up
        else {
            self.showMenu = NO;
            
            frame.origin.y = 0;
        }
    }

    [UIView animateWithDuration:0.5 animations:^{
        self.postContainer.frame = frame;
    } completion:nil];
}
@end
