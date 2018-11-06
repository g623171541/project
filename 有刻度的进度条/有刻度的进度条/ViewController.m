//
//  ViewController.m
//  有刻度的进度条
//
//  Created by UBK on 2018/11/4.
//  Copyright © 2018 UBK. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSlider];
}

-(void)initSlider{
    //左右轨的图片
    UIImage *stetchLeftTrack= [UIImage imageNamed:@"brightness_bar.png"];
    UIImage *stetchRightTrack = [UIImage imageNamed:@"brightness_bar.png"];
    //滑块图片
    UIImage *thumbImage = [UIImage imageNamed:@"mark.png"];
    
    UISlider *sliderA=[[UISlider alloc]initWithFrame:CGRectMake(30, 320, 257, 20)];
    sliderA.backgroundColor = [UIColor clearColor];
    sliderA.value=1.0;
    sliderA.minimumValue=0.7;
    sliderA.maximumValue=1.0;
    
    [sliderA setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [sliderA setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    //注意这里要加UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
    [sliderA setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [sliderA setThumbImage:thumbImage forState:UIControlStateNormal];
    //滑块拖动时的事件
    [sliderA addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    //滑动拖动后的事件
    [sliderA addTarget:self action:@selector(sliderDragUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sliderA]; 
    
}

-(void)sliderValueChanged:(UISlider *)slider{
    NSLog(@"%f",slider.value);
}

-(void)sliderDragUp:(UISlider *)slider{
    NSLog(@"拖动后：%f",slider.value);
}


@end
