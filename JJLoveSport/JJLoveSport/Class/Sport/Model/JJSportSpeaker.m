//
//  JJSportSpeaker.m
//  JJLoveSport
//
//  Created by 罗文琦 on 2017/5/18.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import "JJSportSpeaker.h"
#import <AVFoundation/AVFoundation.h>

@interface JJSportSpeaker ()


/**
 上一次保存的距离
 */
@property(nonatomic , assign) int  lastDistance;

//语音合成器(需要全局变量，局部变量会被释放)
@property(nonatomic,strong)AVSpeechSynthesizer *synthesizer;

@end

@implementation JJSportSpeaker


/**
 指定初始化方法
 */
-(instancetype)initWithSportType:(JJSportType)sportType andDistanceUnit:(int)distanceUnit{

    if (self = [super init]) {
        self.sportType = sportType;
        self.distanceUnit = distanceUnit;
        //创建语音合成器
        self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    }
    return self;
}

/**
 播报运动开始
 */
-(void)speakSportStart{
    NSString* string = [self judgeSportType];
    [self speakWithString:[NSString stringWithFormat:@"开始%@",string]];
}


/**
判断运动类型,返回运动类型字符串
 */
-(NSString*)judgeSportType{
    NSString* string = @"";
    switch (self.sportType) {
        case JJSportTypeRun :
            string = [NSString stringWithFormat:@"跑步"];
            break;
        case JJSportWalk:
            string = [NSString stringWithFormat:@"走路"];
            break;
        case JJSportRiding:
            string = [NSString stringWithFormat:@"骑行"];
            break;
        default:
            break;
    }
    return string;
}



/**
 播报运动状态
 */
-(void)speakSportState:(JJSportState)sportState{
    
    NSString* string = @"";
    switch (sportState) {
        case  JJSportStatePause:
            string = [NSString stringWithFormat:@"运动已暂停"];
            break;
        case JJSportStateFinish:
            string = [NSString stringWithFormat:@"运动已结束,休息一下吧"];
            break;
        case JJSportStateContinue:
            string = [NSString stringWithFormat:@"运动已恢复"];
            break;
        default:
            break;
    }
    [self speakWithString:string];

}


/**
 播报运动综合信息
 */
-(void)speakSportCompositeDataDistance:(CGFloat)distance time:(int)time speed:(CGFloat)speed{
    if (distance < self.lastDistance + self.distanceUnit ) {
        return;
    }
    NSString* sportTypeString = [self judgeSportType];
    NSString* distanceString = [NSString stringWithFormat:@"您已经%@ %d公里",sportTypeString,(self.lastDistance + self.distanceUnit)];
    int hour = time / 3600;
    int minute = time % 3600 / 60;
    int second = time % 60;
    NSString*  hourString = @"";
    NSString*  minuteString = @"";
    NSString*  secondString  = [NSString stringWithFormat:@"%d 秒",second];
    NSString*  timeString = @"";
    if (hour > 0) {
        hourString = [NSString stringWithFormat:@"%d 小时",hour];
    }
    if (minute > 0) {
        secondString = [NSString stringWithFormat:@"%d 分钟",minute];
    }
    timeString = [NSString stringWithFormat:@"用时%@%@%@",hourString,minuteString,secondString];
   
    NSString* speedString = [NSString stringWithFormat:@"平均速度%.1f公里 每小时",speed];
    
    NSString* totalString = [NSString stringWithFormat:@"%@ %@ %@",distanceString,timeString,speedString];
    self.lastDistance = (int)distance;
    
    [self speakWithString:totalString];
    
}



/**
 根据文字内容进行播报
 */
-(void)speakWithString:(NSString*)string{

    
    //先实例化语音播报器
    //@property(nonatomic,strong)AVSpeechSynthesizer *synthesizer;
   
    if (self.synthesizer.isSpeaking == YES) {
        //结束播报
        /**
         AVSpeechBoundaryImmediate,立即停止
         AVSpeechBoundaryWord，等待上一条播报完毕
         */
        [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    //NSLog(@"%@",string);
    //1.实例化语言（默认朗读英文）
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:string];
    //2.指定声音 zh-CN表示中文
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    //设置语言
    [utterance setVoice:voice];
    
    //    utterance.volume=1.0;  //设置音量（0.0~1.0）默认为1.0
    //    utterance.rate=0.4;  //设置语速
    //utterance.pitchMultiplier=0.5;  //设置语调  [0.5 - 2]
    //3.朗读声音
   // [self.synthesizer speakUtterance:utterance];

}


@end
