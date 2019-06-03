//
//  ViewController.m
//  MAudioPlayerDemo
//
//  Created by mal on 2018/12/19.
//  Copyright © 2018 mal. All rights reserved.
//

#define AudioUrl @"https://static.starmakerstudios.com/production/uploading/recordings/6473924391892054/master.mp4"

#import "ViewController.h"
#import "SMKtvAudioPlayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static BOOL isPlay = NO;
    isPlay = !isPlay;
    NSString *url = AudioUrl;
    if (isPlay == NO)
    {
        url = [[NSBundle mainBundle] pathForResource:@"relaySong" ofType:@"m4a"];
    }
    [[SMKtvAudioPlayer defaultPlayer] playWithUrlStr:url];
}

@end
