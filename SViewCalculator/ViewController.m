//
//  ViewController.m
//  SViewCalculator
//
//  Created by Alex Georgescu on 03/01/2016.
//  Copyright © 2016 Alex Georgescu. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *uibDelete;
@property (strong, nonatomic) UIButton *uibReset;
@property (strong, nonatomic) UIButton *uibPercent;
@property (strong, nonatomic) UIButton *uibDiv;
@property (strong, nonatomic) UIButton *uib7;
@property (strong, nonatomic) UIButton *uib8;
@property (strong, nonatomic) UIButton *uib9;
@property (strong, nonatomic) UIButton *uibMultiply;
@property (strong, nonatomic) UIButton *uib4;
@property (strong, nonatomic) UIButton *uib5;
@property (strong, nonatomic) UIButton *uib6;
@property (strong, nonatomic) UIButton *uibMinus;
@property (strong, nonatomic) UIButton *uib1;
@property (strong, nonatomic) UIButton *uib2;
@property (strong, nonatomic) UIButton *uib3;
@property (strong, nonatomic) UIButton *uibPlus;
@property (strong, nonatomic) UIButton *uibZero;
@property (strong, nonatomic) UIButton *uibDot;
@property (strong, nonatomic) UIButton *uibSign;
@property (strong, nonatomic) UIButton *uibEquals;
@property (strong, nonatomic) UITextField *uilNumbersArea;

@end


@implementation ViewController


-(void)createResultTextArea : (UIView*)superview{
    
    // 1. Create TEXT AREA and add to our view
    self.uilNumbersArea = [[UITextField alloc]initWithFrame: CGRectMake(0, 0, 1000, 30)];
    self.uilNumbersArea.borderStyle = UITextBorderStyleRoundedRect;
    self.uilNumbersArea.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addSubview:self.uilNumbersArea];
    
    // 2. Text field Constraints
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uilNumbersArea attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:superview
                                           attribute:NSLayoutAttributeTop multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uilNumbersArea attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                            NSLayoutAttributeLeft multiplier:1.0 constant:10];
    
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uilNumbersArea attribute:NSLayoutAttributeRight
                                             relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                             NSLayoutAttributeRight multiplier:1.0 constant:-10];
    
    [superview addConstraints:@[tfTopConstraint, tfLeftConstraint, tfRightConstraint]];
}


-(void)createDelButton : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uibDelete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uibDelete.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uibDelete setTitle:Delete forState:UIControlStateNormal];
    [superview addSubview:self.uibDelete];
    
    // 2. Constraints
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                                 constraintWithItem:self.uibDelete attribute:NSLayoutAttributeLeft
                                                 relatedBy:NSLayoutRelationEqual toItem:self.uilNumbersArea
                                                 attribute:NSLayoutAttributeLeft
                                                 multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                                 constraintWithItem:self.uibDelete attribute:NSLayoutAttributeTop
                                                 relatedBy:NSLayoutRelationEqual toItem:self.uilNumbersArea
                                                 attribute: NSLayoutAttributeBottom
                                                 multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfLeftConstraint]];
}


-(void)createResetButton : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uibReset = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uibReset.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uibReset setTitle:Reset forState:UIControlStateNormal];
    [superview addSubview:self.uibReset];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uibReset
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.uibDelete
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibReset
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uilNumbersArea
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createPercentButton : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uibPercent = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uibPercent.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uibPercent setTitle:Percent forState:UIControlStateNormal];
    [superview addSubview:self.uibPercent];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibPercent
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibReset
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibPercent
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uilNumbersArea
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createDivisionButton : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uibDiv = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uibDiv.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uibDiv setTitle:Division forState:UIControlStateNormal];
    [superview addSubview:self.uibDiv];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibDiv
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibPercent
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibDiv
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uilNumbersArea
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createButton7 : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uib7 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uib7.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uib7 setTitle:Seven forState:UIControlStateNormal];
    [superview addSubview:self.uib7];
    
    // 2. Constraints
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uib7 attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual toItem:self.uilNumbersArea
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib7 attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual toItem:self.uibDelete
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfLeftConstraint]];
}


-(void)createButton8 : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uib8 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uib8.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uib8 setTitle:Eight forState:UIControlStateNormal];
    [superview addSubview:self.uib8];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib8
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib7
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib8
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibReset
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createButton9 : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uib9 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uib9.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uib9 setTitle:Nine forState:UIControlStateNormal];
    [superview addSubview:self.uib9];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib9
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib8
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib9
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibPercent
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createMultiplyButton : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uibMultiply = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uibMultiply.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uibMultiply setTitle:Multiply forState:UIControlStateNormal];
    [superview addSubview:self.uibMultiply];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibMultiply
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib9
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibMultiply
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibDiv
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createButton4 : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uib4 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uib4.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uib4 setTitle:Four forState:UIControlStateNormal];
    [superview addSubview:self.uib4];
    
    // 2. Constraints
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uib4
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.uib7
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib4
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib7
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfLeftConstraint]];
}


-(void)createButton5 : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uib5 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uib5.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uib5 setTitle:Five forState:UIControlStateNormal];
    [superview addSubview:self.uib5];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib5
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib4
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib5
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib8
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createButton6 : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uib6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uib6.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uib6 setTitle:Six forState:UIControlStateNormal];
    [superview addSubview:self.uib6];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib6
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib5
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib6
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib9
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createMinusButton : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uibMinus = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uibMinus.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uibMinus setTitle:Minus forState:UIControlStateNormal];
    [superview addSubview:self.uibMinus];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibMinus
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib6
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibMinus
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibMultiply
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createButton1 : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uib1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uib1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uib1 setTitle:One forState:UIControlStateNormal];
    [superview addSubview:self.uib1];
    
    // 2. Constraints
    NSLayoutConstraint *tfLeftConstraint = [NSLayoutConstraint
                                            constraintWithItem:self.uib1
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self.uib4
                                            attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib1
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib4
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfLeftConstraint]];
}


-(void)createButton2 : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uib2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uib2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uib2 setTitle:Two forState:UIControlStateNormal];
    [superview addSubview:self.uib2];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib2
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib1
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib2
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib5
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createButton3 : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uib3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uib3.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uib3 setTitle:Three forState:UIControlStateNormal];
    [superview addSubview:self.uib3];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uib3
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib2
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uib3
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib6
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createPlusButton : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uibPlus = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uibPlus.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uibPlus setTitle:Plus forState:UIControlStateNormal];
    [superview addSubview:self.uibPlus];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibPlus
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib3
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibPlus
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibMinus
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createButton0 : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uibZero = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uibZero.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uibZero setTitle:Zero forState:UIControlStateNormal];
    [superview addSubview:self.uibZero];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibZero
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uib1
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:0];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibZero
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib1
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createDotButton : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uibDot = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uibDot.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uibDot setTitle:Dot forState:UIControlStateNormal];
    [superview addSubview:self.uibDot];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibDot
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibZero
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:60];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibDot
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uib3
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}


-(void)createEqualsButton : (UIView*)superview{
    
    // 1. Create buttons and add to our view
    self.uibEquals = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.uibEquals.translatesAutoresizingMaskIntoConstraints = NO;
    [self.uibEquals setTitle:Equals forState:UIControlStateNormal];
    [superview addSubview:self.uibEquals];
    
    // 2. Constraints
    NSLayoutConstraint *tfRightConstraint = [NSLayoutConstraint
                                             constraintWithItem:self.uibEquals
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                             toItem:self.uibDot
                                             attribute:NSLayoutAttributeLeft
                                             multiplier:1.0 constant:30];
    
    NSLayoutConstraint *tfTopConstraint = [NSLayoutConstraint
                                           constraintWithItem:self.uibEquals
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                           toItem:self.uibPlus
                                           attribute: NSLayoutAttributeBottom
                                           multiplier:1.0 constant:10];
    
    // 3. Add the constraints to button's superview
    [superview addConstraints:@[tfTopConstraint, tfRightConstraint]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create and align text area
    [self createResultTextArea:self.view];
    
    // create and align calculating buttons
    [self createDelButton:self.view];
    [self createResetButton:self.view];
    [self createPercentButton:self.view];
    [self createDivisionButton:self.view];
    
    [self createButton7:self.view];
    [self createButton8:self.view];
    [self createButton9:self.view];
    [self createMultiplyButton:self.view];
    
    [self createButton4:self.view];
    [self createButton5:self.view];
    [self createButton6:self.view];
    [self createMinusButton:self.view];
    
    [self createButton1:self.view];
    [self createButton2:self.view];
    [self createButton3:self.view];
    [self createPlusButton:self.view];
    
    [self createButton0:self.view];
    [self createDotButton:self.view];
    [self createEqualsButton:self.view];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
