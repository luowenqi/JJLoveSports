//
//  DJFSportSpeaker.m
//  LoveWalking
//
//  Created by 佃杰峰 on 2017/5/2.
//  Copyright © 2017年 佃杰峰. All rights reserved.
//

#import "DJFSportSpeaker.h"
#import <AVFoundation/AVFoundation.h>

@interface DJFSportSpeaker ()
/**
 *  播音员
 */
@property(nonatomic,strong)AVSpeechSynthesizer * speaker;
@end
@implementation DJFSportSpeaker

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.speaker = [[AVSpeechSynthesizer alloc] init];
    }
    return self;
}

/**
 根据内容进行播报

 @param text 文本内容
 */
- (void)reportByText:(NSString*)text{
    
    //若上一次播报未完成，立即停止上一条
    if (self.speaker.isSpeaking) {
        [self.speaker stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    
    //实例化、设置内容、这种问题
    AVSpeechUtterance* utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    AVSpeechSynthesisVoice* voice =  [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    [utterance setVoice:voice];
    
    //播报
    [self.speaker speakUtterance:utterance];
}
@end
