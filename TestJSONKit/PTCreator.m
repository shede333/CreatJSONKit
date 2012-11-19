//
//  PTCreator.m
//  TestJSONKit
//
//  Created by shaowei on 12-11-16.
//
//

#import "PTCreator.h"
#import "JSONKit.h"

@implementation PTCreator

+ (void)generateAllModel{
    [PTCreator generaTopicModel];
}

+ (void)generaTopicModel{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *pathOfDir = @"/Users/shaaowei/Desktop/test/PT";
    NSString *pathOfFile = [pathOfDir stringByAppendingFormat:@"/topiclist"];
    
    //创建文件夹
    NSError *error = nil;
    [fileManager createDirectoryAtPath:pathOfDir
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:&error];
    if (error) {
        NSLog(@"SW -Directionary-creat-error %@",[error userInfo]);
    }
    
    NSMutableDictionary *mMianDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [mMianDic setObject:@"1" forKey:@"status"];
    [mMianDic setObject:@"成功" forKey:@"information"];
    
    NSInteger countOfArr = 10;
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:countOfArr];
    [mMianDic setObject:mArr forKey:@"PTTopicModel"];
    
    NSArray *arrOfPicURL = [CommonFunction getPicImageURLArr];
    NSArray *arrOfAudio = [CommonFunction getAudioURLArr];
    
    for (int i = 0; i < countOfArr; i++) {
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithCapacity:10];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy_MM_dd"];
        NSString *dateString = [dateFormat stringFromDate:[NSDate dateWithTimeIntervalSinceNow:(-60*60*24*i)]];
        
        //        话题ID：topicID
        //        话题标题：title
        //        话题时间范围：timeRange
        //        话题发布日期：dateOfTopic
        //        话题简介：descriptionOfTopic
        //        话题内容：content
        //        话题图片连接：picURL
        //        话题声频连接：audioURL
        
        [mDic setObject:[NSString stringWithFormat:@"topicID_%d",arc4random()%10000] forKey:@"topicID"];
        [mDic setObject:[NSString stringWithFormat:@"title_%d",arc4random()%10000] forKey:@"title"];
        [mDic setObject:[NSString stringWithFormat:@"12:00~12:30"] forKey:@"timeRange"];
        [mDic setObject:dateString forKey:@"dateOfTopic"];
        [mDic setObject:[NSString stringWithFormat:@"这是话题描述_%d",arc4random()%10000] forKey:@"descriptionOfTopic"];
        [mDic setObject:[NSString stringWithFormat:@"这是话题内容_%d",arc4random()%10000] forKey:@"content"];
        [mDic setObject:[arrOfPicURL objectAtIndex:i] forKey:@"picURL"];
        [mDic setObject:[arrOfAudio objectAtIndex:(i%[arrOfAudio count])] forKey:@"audioURL"];
        
        
        [mArr addObject:mDic];
        [mDic release];
    }
    
    
    //写入文件
    //    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mArr,@"ItemModel", nil];
    NSString *jsonString = [mMianDic JSONString];
    
    error = nil;
    [jsonString writeToFile:pathOfFile
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:&error];
    if (error) {
        NSLog(@"SW -PTfile-creat-error %@",[error userInfo]);
    }
    
    
}



@end
