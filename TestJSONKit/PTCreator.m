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
static NSString *pathOfDir = @"/Users/shaaowei/Desktop/Http/pt";

+ (void)generateAllModel{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //创建文件夹
    NSError *error = nil;
    if (![fileManager fileExistsAtPath:pathOfDir]) {
        [fileManager createDirectoryAtPath:pathOfDir
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
        if (error) {
            NSLog(@"SW -Directionary-creat-error %@",[error userInfo]);
        }
    }
    
    
    [PTCreator generateTopicModel];
    [PTCreator generateCommnetModel];
    [PTCreator generateNetNormalModel];
    [PTCreator generateVoteModel];
    [PTCreator generateVoteResultModel];
    
    NSLog(@"SW - 完成了！！！");
}

+ (void)generateVoteResultModel{
    NSString *pathOfFile = [pathOfDir stringByAppendingFormat:@"/sendvote"];
    
    NSError *error = nil;
    
    NSMutableDictionary *mMianDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [mMianDic setObject:@"1" forKey:@"status"];
    [mMianDic setObject:@"成功" forKey:@"information"];
    
    NSInteger voteCount = arc4random()%3 + 4;
    NSMutableArray *arrOfOption = [[[NSMutableArray alloc] initWithCapacity:voteCount] autorelease];
    [mMianDic setObject:arrOfOption forKey:@"PTVoteResultModel"];

    for (int i = 0; i < voteCount; i++) {
        NSMutableDictionary *dicModel = [[NSMutableDictionary alloc] initWithCapacity:2];
        [dicModel setObject:[NSString stringWithFormat:@"选项_%d",i] forKey:@"optionTitle"];
        [dicModel setObject:[NSNumber numberWithInteger:arc4random()%1000] forKey:@"numOfVote"];
        
        [arrOfOption addObject:dicModel];
        [dicModel release];
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

+ (void)generateVoteModel{
    NSString *pathOfFile = [pathOfDir stringByAppendingFormat:@"/votecotent"];
    
    NSError *error = nil;
    
    NSMutableDictionary *mMianDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [mMianDic setObject:@"1" forKey:@"status"];
    [mMianDic setObject:@"成功" forKey:@"information"];
    
    NSMutableDictionary *mDicOfVote = [[[NSMutableDictionary alloc] initWithCapacity:3] autorelease];
    [mMianDic setObject:mDicOfVote forKey:@"PTVoteModel"];
    
    [mDicOfVote setObject:@"VoteTitle投票的标题内容描述" forKey:@"voteTitle"];
//    [mDicOfVote setObject:[NSString stringWithFormat:@"voteID_%d",arc4random()%10000] forKey:@"voteID"];
    
    NSInteger voteCount = arc4random()%3 + 4;
    NSMutableArray *arrOfOption = [[[NSMutableArray alloc] initWithCapacity:voteCount] autorelease];
    for (int i = 0; i < voteCount; i++) {
        [arrOfOption addObject:[NSString stringWithFormat:@"这是第_%d_个选项",i]];
    }
    
    [mDicOfVote setObject:arrOfOption forKey:@"arrOfOption"];
    
    
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

+ (void)generateNetNormalModel{
    NSString *pathOfFile = [pathOfDir stringByAppendingFormat:@"/sendcomment"];
    
    NSError *error = nil;
    
    NSMutableDictionary *mMianDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [mMianDic setObject:@"1" forKey:@"status"];
    [mMianDic setObject:@"成功" forKey:@"information"];

    
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


+ (void)generateCommnetModel{
    NSString *pathOfFile = [pathOfDir stringByAppendingFormat:@"/commentlist"];
    
    NSError *error = nil;
    
    NSMutableDictionary *mMianDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [mMianDic setObject:@"1" forKey:@"status"];
    [mMianDic setObject:@"成功" forKey:@"information"];
    
    NSInteger countOfArr = 30;
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:countOfArr];
    [mMianDic setObject:mArr forKey:@"PTCommentModel"];
    
    
    for (int i = 0; i < countOfArr; i++) {
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithCapacity:10];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy_MM_dd HH:mm:ss"];
        NSString *dateString = [dateFormat stringFromDate:[NSDate dateWithTimeIntervalSinceNow:(-60*60*24*i)]];
        
//        @property (nonatomic, copy) NSString *commentID;
//        @property (nonatomic, copy) NSString *contentOfComment;
//        @property (nonatomic, copy) NSString *timeOfComment;
//        @property (nonatomic, copy) NSString *userName;
        
        NSString *contentOfTopic = nil;
        if (arc4random()%2) {
            contentOfTopic =@"紧紧围绕坚持和发展中国特色社会主义　学习宣传贯彻党的十八大精神,——在十八届中共中央政治局第一次集体学习时的讲话";
        }
        
        [mDic setObject:[NSString stringWithFormat:@"commentID_%d",arc4random()%10000] forKey:@"commentID"];
        [mDic setObject:[NSString stringWithFormat:@"contentOfComment_%d_%@",arc4random()%10000,contentOfTopic] forKey:@"contentOfComment"];
        [mDic setObject:dateString forKey:@"timeOfComment"];
        [mDic setObject:[NSString stringWithFormat:@"userName_%d",arc4random()%10000] forKey:@"userName"];
 
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

+ (void)generateTopicModel{

    NSString *pathOfFile = [pathOfDir stringByAppendingFormat:@"/topiclist"];

    NSError *error = nil;
    
    
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
        NSString *descriptOfTopic = @"紧紧围绕坚持和发展中国特色社会主义　学习宣传贯彻党的十八大精神,——在十八届中共中央政治局第一次集体学习时的讲话";
//        NSString *contentOfTopic = @"";
        
        [mDic setObject:[NSString stringWithFormat:@"topicID_%d",arc4random()%10000] forKey:@"topicID"];
        [mDic setObject:[NSString stringWithFormat:@"我不想长大_%d",arc4random()%10000] forKey:@"title"];
        [mDic setObject:[NSString stringWithFormat:@"12:00~12:30"] forKey:@"timeRange"];
        [mDic setObject:dateString forKey:@"dateOfTopic"];
        [mDic setObject:[NSString stringWithFormat:@"这是话题描述_%d_%@",arc4random()%10000,descriptOfTopic] forKey:@"descriptionOfTopic"];
//        [mDic setObject:[NSString stringWithFormat:@"这是话题内容_%d_%@",arc4random()%10000,contentOfTopic] forKey:@"content"];
        [mDic setObject:[arrOfPicURL objectAtIndex:(arc4random()%[arrOfPicURL count])] forKey:@"picURL"];
        [mDic setObject:@"http://192.168.10.171/pt/Topic.html" forKey:@"contentURL"];
        
        //音频
        if (arc4random()%2) {
            [mDic setObject:[arrOfAudio objectAtIndex:0] forKey:@"audioURL"];
        }
        
        //投票
        NSMutableDictionary *mDicOfVote = [[[NSMutableDictionary alloc] initWithCapacity:3] autorelease];
        if (arc4random()%2) {
            [mDic setObject:mDicOfVote forKey:@"voteModel"];
        }
        
        [mDicOfVote setObject:@"VoteTitle投票的标题内容描述" forKey:@"voteTitle"];
        //    [mDicOfVote setObject:[NSString stringWithFormat:@"voteID_%d",arc4random()%10000] forKey:@"voteID"];
        
        NSInteger voteCount = arc4random()%3 + 4;
        NSMutableArray *arrOfOption = [[[NSMutableArray alloc] initWithCapacity:voteCount] autorelease];
        for (int i = 0; i < voteCount; i++) {
            [arrOfOption addObject:[NSString stringWithFormat:@"这是第_%d_个选项",i]];
        }
        
        [mDicOfVote setObject:arrOfOption forKey:@"arrOfOption"];
        
        
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
