//
//  ViewController.m
//  YBSlider
//
//  Created by Yogev Barber on 21/08/2017.
//  Copyright © 2017 Yogev Barber. All rights reserved.
//
#import "ViewController.h"
#import "YBSlider.h"

@interface ViewController () <YBSliderDelegate>
@property (weak, nonatomic) IBOutlet YBSlider *slider;
@property (nonatomic, assign) float buffer;
@property (nonatomic, assign) float position;
@property (nonatomic, strong) NSTimer *bufferTimer;
@property (nonatomic, strong) NSTimer *positionTimer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.slider.delegate = self;
    self.buffer = 10;
    [self updateBuffer];
    [self startBufferTimer];
    [self startPositionTimer];
}

-(void)updatePosition{
    if (self.position > 100) {
        [self.positionTimer invalidate];
        return;
    }
    
    NSLog(@"%f", self.position);
    [self.slider setCurrentPosition:self.position];
    self.position += 0.5;
}

-(void)updateBuffer{
    if (self.buffer > 100) {
        [self.bufferTimer invalidate];
        return;
    }
    [self.slider setBufferPosition:self.buffer];
    self.buffer += 5;
}

-(void)startPositionTimer{
    [self.positionTimer invalidate];
    self.positionTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updatePosition) userInfo:nil repeats:true];
}

-(void)stopPositionTimer{
    [self.positionTimer invalidate];
}

-(void)startBufferTimer{
    [self.bufferTimer invalidate];
    self.bufferTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateBuffer) userInfo:nil repeats:true];
}

-(void)stopBuffertimer{
    [self.bufferTimer invalidate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self stopBuffertimer];
    [self stopPositionTimer];
}

-(void)sliderValueWillChange:(YBSlider *)slider{
    [self stopPositionTimer];
}

-(void)sliderValueChange:(YBSlider *)slider value:(float)value{
    self.position = value;
    [self startPositionTimer];
}
@end
