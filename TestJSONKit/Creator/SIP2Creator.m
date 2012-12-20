//
//  SIP2Creator.m
//  TestJSONKit
//
//  Created by shaowei on 12-12-20.
//
//

#import "SIP2Creator.h"

@implementation SIP2Creator

static NSString *pathOfDir = @"/Users/shaaowei/Desktop/Http/sip2";

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
    
    [SIP2Creator generateBikePoint];
    [SIP2Creator generateHotPoint];
    
    NSLog(@"SW - 完成了！！！");
    
}

+ (void)generateHotPoint{
    NSString *pathOfFile = [pathOfDir stringByAppendingFormat:@"/hotpoint"];
    
    NSError *error = nil;
    
    NSMutableDictionary *mMianDic = [[NSMutableDictionary alloc] initWithCapacity:1];

    
    NSInteger voteCount = arc4random()%3 + 100;
    NSMutableArray *arrOfOption = [[[NSMutableArray alloc] initWithCapacity:voteCount] autorelease];
    [mMianDic setObject:arrOfOption forKey:@"SIP2HotPointModel"];
    
    for (int i = 0; i < voteCount; i++) {
        NSMutableDictionary *dicModel = [[NSMutableDictionary alloc] initWithCapacity:6];
        
//        @property (nonatomic, copy) NSString *title;
//        @property (nonatomic, copy) NSString *subtitle;
//        @property (nonatomic, assign) CLLocationCoordinate2D coordinate;
//        
//        @property (nonatomic, assign) NSInteger type;
//        @property (nonatomic, copy) NSString *latitude;
//        @property (nonatomic, copy) NSString *longitude;
        
        [dicModel setObject:[NSString stringWithFormat:@"title_%d",arc4random()%100] forKey:@"title"];
        [dicModel setObject:[NSString stringWithFormat:@"subtitle_%d",arc4random()%100] forKey:@"subtitle"];
        [dicModel setObject:[NSNumber numberWithInteger:i%10] forKey:@"type"];
        [dicModel setObject:[NSString stringWithFormat:@"%f",31.290386+arc4random()%1000/1000.0f] forKey:@"latitude"];
        [dicModel setObject:[NSString stringWithFormat:@"%f",120.662656+arc4random()%1000/1000.0f] forKey:@"longitude"];
       
        
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
        NSLog(@"SW -SIP2-file-creat-error %@",[error userInfo]);
    }
    
}

+ (void)generateBikePoint{
    NSString *pathOfFile = [pathOfDir stringByAppendingFormat:@"/bike"];
    
    NSError *error = nil;
    
    NSMutableDictionary *mMianDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    
    NSInteger voteCount = arc4random()%3 + 100;
    NSMutableArray *arrOfOption = [[[NSMutableArray alloc] initWithCapacity:voteCount] autorelease];
    [mMianDic setObject:arrOfOption forKey:@"SIP2HotPointModel"];
    
    for (int i = 0; i < voteCount; i++) {
        NSMutableDictionary *dicModel = [[NSMutableDictionary alloc] initWithCapacity:6];
        
//        @property (nonatomic, copy) NSString *title;
//        @property (nonatomic, copy) NSString *subtitle;
//        @property (nonatomic, assign) CLLocationCoordinate2D coordinate;
//        
//        @property (nonatomic, copy) NSString *latitude;
//        @property (nonatomic, copy) NSString *longitude;
//        @property (nonatomic, copy) NSString *name;
//        @property (nonatomic, copy) NSString *address;
//        @property (nonatomic, assign) NSInteger borrowNum;
//        @property (nonatomic, assign) NSInteger stopNum;
//        
//        @property (nonatomic, assign) NSInteger distance;
        
        [dicModel setObject:[NSString stringWithFormat:@"title_%d",arc4random()%100] forKey:@"title"];
        [dicModel setObject:[NSString stringWithFormat:@"subtitle_%d",arc4random()%100] forKey:@"subtitle"];
        [dicModel setObject:[NSString stringWithFormat:@"%f",31.290386+arc4random()%1000/1000.0f] forKey:@"latitude"];
        [dicModel setObject:[NSString stringWithFormat:@"%f",120.662656+arc4random()%1000/1000.0f] forKey:@"longitude"];
        [dicModel setObject:[NSString stringWithFormat:@"name_%d",arc4random()%100] forKey:@"name"];
        [dicModel setObject:[NSString stringWithFormat:@"address_%d",arc4random()%100] forKey:@"address"];
        [dicModel setObject:[NSNumber numberWithInteger:arc4random()%100] forKey:@"borrowNum"];
        [dicModel setObject:[NSNumber numberWithInteger:arc4random()%100] forKey:@"stopNum"];
        
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
        NSLog(@"SW -SIP2-file-creat-error %@",[error userInfo]);
    }
    
}



@end
