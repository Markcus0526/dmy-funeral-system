//
//  FirstSceneVC.m
//  BinZang
//
//  Created by Beids on 4/30/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "FirstSceneVC.h"
#import <AVFoundation/AVFoundation.h>

#define AUDIO_FILE_NAME						@"back_audio.aac"

@interface FirstSceneVC ()
{
	AVAudioPlayer *_audioPlayer;
}
@end

@implementation FirstSceneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initControls];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initControls{
	//play background audio
	NSString *path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], AUDIO_FILE_NAME];
	NSURL *soundUrl = [NSURL fileURLWithPath:path];
	
	_audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
	_audioPlayer.numberOfLoops = -1;
	[_audioPlayer play];
	
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
