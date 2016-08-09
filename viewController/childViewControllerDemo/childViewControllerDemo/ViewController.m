//
//  ViewController.m
//  childViewControllerDemo
//
//  Created by 杨晴贺 on 8/9/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong,nonatomic) FirstViewController *firstVC ;
@property (strong,nonatomic) SecondViewController *secondVC ;
@property (strong,nonatomic) ThirdViewController *thirdVC ;

@property (strong,nonatomic) UIViewController *currentVC ;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstVC = [[FirstViewController alloc]initWithNibName:@"FirstViewController" bundle:nil] ;
    [self addChildViewController:_firstVC] ;
    
    _secondVC = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil] ;
    [self addChildViewController:_secondVC] ;
    
    
    _thirdVC = [[ThirdViewController alloc]initWithNibName:@"ThirdViewController" bundle:nil] ;
    [self addChildViewController:_thirdVC] ;
    
    self.currentVC = self.thirdVC ;
    self.currentVC.view.frame = self.contentView.bounds ;
    [self.contentView addSubview:self.currentVC.view] ;
    
}


- (IBAction)clickAction:(UIButton *)button{
    if ((_currentVC == _firstVC && button.tag == 1)
        || (_currentVC == _secondVC && button.tag == 2 )
        || (_currentVC == _thirdVC && button.tag == 3)){
        return ;
    }
    UIViewController *oldVC = self.currentVC ;
    switch (button.tag) {
        case 1:{
            NSLog(@"第一个控制器") ;
            [self transitionFromViewController:oldVC toViewController:self.firstVC duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentVC = self.firstVC ;
                    self.currentVC.view.frame = self.contentView.bounds ;
                }else{
                    self.currentVC = oldVC ;
                }
            }] ;
        }
            break;
        case 2:{
            NSLog(@"第二个控制器") ;
            [self transitionFromViewController:oldVC toViewController:self.secondVC duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentVC = self.secondVC ;
                    self.currentVC.view.frame = self.contentView.bounds ;
                }else{
                    self.currentVC = oldVC ;
                }
            }] ;
        }
            break ;
        case 3:{
            NSLog(@"第三个控制器") ;
            [self transitionFromViewController:oldVC toViewController:self.thirdVC duration:1 options:UIViewAnimationOptionTransitionCurlDown animations:nil completion:^(BOOL finished) {
                if (finished) {
                    self.currentVC = self.thirdVC ;
                    self.currentVC.view.frame = self.contentView.bounds ;
                }else{
                    self.currentVC = oldVC ;
                }
            }] ;
        }
            break ;
        default:
            break;
    }
}
@end
