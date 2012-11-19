//
//  IATestCreator.m
//  TestJSONKit
//
//  Created by shaowei on 12-11-16.
//
//

#import "IATestCreator.h"
#import "JSONKit.h"
#import "ZipArchive.h"

@implementation IATestCreator

+ (void)generateAllModel{
    [IATestCreator generateLoginResultModel];
    [IATestCreator generateNetResultModel];
    [IATestCreator generateMassExamModel];
}

+ (void)test0{
    //解压
    NSString *pathOfDir = @"/Users/shaaowei/Desktop/test";
    //    ZipArchive *zipFile = [[ZipArchive alloc] init];
    NSString *pathOfZip = [pathOfDir stringByAppendingFormat:@"/test.zip"];
    //    [zipFile CreateZipFile2:pathOfZip];
    //    BOOL isAddSuccess = [zipFile addFileToZip:pathOfDir newname:dataString];
    //    if (isAddSuccess) {
    //        NSLog(@"SW - %@:%d",pathOfZip,isAddSuccess);
    //    }
    //    [zipFile CloseZipFile2];
    //    [zipFile release];
    
    
    ZipArchive* zipFile = [[ZipArchive alloc] init];
    [zipFile UnzipOpenFile:pathOfZip]; // B (the zip got no password)
    [zipFile UnzipFileTo:pathOfDir overWrite:YES];
    [zipFile UnzipCloseFile];
    [zipFile release];
}

+ (void)generateNetResultModel{
    
    //NetResultModel
    NSDictionary *subDic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"status",@"成功-success",@"information", nil];
    NSArray *subArr = [NSArray arrayWithObject:subDic];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:subArr,@"NetResultModel", nil];
    NSString *jsonString = [dic JSONString];
    
    NSError *error = nil;
    [jsonString writeToFile:@"/Users/shaaowei/Desktop/test/NetResultModel.json"
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:&error];
    
    
    
}

+ (void)generateLoginResultModel{
    //LoginResultModel
    NSDictionary *subDic = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"1",@"status",
                            @"成功-success",@"information",
                            @"123456",@"userID",
                            @"33",@"age",
                            @"1",@"sex",nil];
    NSArray *subArr = [NSArray arrayWithObject:subDic];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:subArr,@"LoginResultModel", nil];
    NSString *jsonString = [dic JSONString];
    
    NSError *error = nil;
    [jsonString writeToFile:@"/Users/shaaowei/Desktop/test/LoginResultModel.json"
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:&error];
    
}

+ (void)generateMassExamModel{
    for (int i = 0; i < 5; i++) {
        [self generateExamResultModel];
        [NSThread sleepForTimeInterval:2];
    }
    
    NSLog(@"SW -Log 完成");
    
}

+ (void)generateExamResultModel{
    //    itemID 试题ID，
    //    examID 该题所属试卷ID
    //
    //    userAnswer 用户所选答案
    //    duration 该题已经耗费的时间
    //    isRight 该题的正确与否
    //
    //    itemType 试题类型
    //    questionPicName
    //    referencePicName
    //    figurePicName
    //    relatedKnowledge 知识点
    //    correctAnswer 正确答案
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy_MM_dd__HH_mm_ss"];
    NSString *dataString = [dateFormat stringFromDate:[NSDate date]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *pathOfDir = [@"/Users/shaaowei/Desktop/test/testing/" stringByAppendingString:dataString];
    NSString *pathOfFile = [pathOfDir stringByAppendingFormat:@"/%@.json",dataString];
    
    //创建文件夹
    [fileManager createDirectoryAtPath:pathOfDir
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:nil];
    
    NSMutableArray *mArr = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithCapacity:10];
        
        //小题ID
        [mDic setObject:[IATestCreator generateUuidString] forKey:@"itemID"];
        
        //小题的类型（1代表单选，2代表多选）
        [mDic setObject:[NSNumber numberWithInt:((arc4random()%2)+1)] forKey:@"itemType"];
        
        //题干图片
        NSString *image1 = [@"questionPicName" stringByAppendingFormat:@"_%d.png",i];
        [mDic setObject:image1 forKey:@"questionPicName"];
        
        NSString *pathOfImage1 = [pathOfDir stringByAppendingPathComponent:image1];
        [IATestCreator generateImageWithPath:@"/Users/shaaowei/Desktop/test/exam_title.png"
                          andToPath:pathOfImage1
                            andName:image1];
        
        //附件图片
        NSString *image2 =[@"referencePicName" stringByAppendingFormat:@"_%d.png",i];
        if (arc4random()%2) {
            [mDic setObject:image2 forKey:@"referencePicName"];
            NSString *pathOfImage2 = [pathOfDir stringByAppendingPathComponent:image2];
            [IATestCreator generateImageWithPath:@"/Users/shaaowei/Desktop/test/exam_reference.png"
                              andToPath:pathOfImage2
                                andName:image2];
        }
        
        //插图
        NSString *image3 =[@"figurePicName" stringByAppendingFormat:@"_%d.png",i];
        if (arc4random()%2) {
            [mDic setObject:image3 forKey:@"figurePicName"];
            NSString *pathOfImage3 = [pathOfDir stringByAppendingPathComponent:image3];
            [IATestCreator generateImageWithPath:@"/Users/shaaowei/Desktop/test/exam_insert.png"
                              andToPath:pathOfImage3
                                andName:image3];
        }
        
        //知识点
        [mDic setObject:[@"relatedKnowledge" stringByAppendingFormat:@"_%d",i] forKey:@"relatedKnowledge"];
        
        //正确答案
        [mDic setObject:@"C" forKey:@"correctAnswer"];
        
        [mArr addObject:mDic];
        [mDic release];
        
        
    }
    
    
    //写入文件
    //    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mArr,@"ItemModel", nil];
    NSString *jsonString = [mArr JSONString];
    
    
    NSError *error = nil;
    [jsonString writeToFile:pathOfFile
                 atomically:YES
                   encoding:NSUTF8StringEncoding
                      error:&error];
    
    //压缩
    //    ZipArchive *zipFile = [[ZipArchive alloc] init];
    //    NSString *pathOfZip = [pathOfDir stringByAppendingFormat:@".zip"];
    //    [zipFile CreateZipFile2:pathOfZip];
    //    BOOL isAddSuccess = [zipFile addFileToZip:pathOfDir newname:dataString];
    //    if (isAddSuccess) {
    //        NSLog(@"SW - %@:%d",pathOfZip,isAddSuccess);
    //    }
    //    [zipFile CloseZipFile2];
    //    [zipFile release];
    
    
    
    //为了增加文件大小而已
    NSString *pathOfNoUse = @"/Users/shaaowei/Desktop/test/无用的文件_可以删除.zip";
    NSString *pathOfNoUseDesitination = [pathOfDir stringByAppendingPathComponent:@"无用的文件_可以删除.zip"];
    [fileManager copyItemAtPath:pathOfNoUse
                         toPath:pathOfNoUseDesitination
                          error:nil];
    
}

+ (void)generateImageWithPath:(NSString *)originPath andToPath:(NSString *)toPath andName:(NSString *)name{
    //    NSString *pathOfOrigin = path;
    UIImage *imageTemp = [UIImage imageWithContentsOfFile:originPath];
    UIGraphicsBeginImageContext(imageTemp.size);
    [imageTemp drawAtPoint:CGPointZero];
    [name drawAtPoint:CGPointMake(10, imageTemp.size.height *0.5f+20) forWidth:300
             withFont:[UIFont systemFontOfSize:30]
        lineBreakMode:NSLineBreakByWordWrapping];
    UIImage *imageOfResult = UIGraphicsGetImageFromCurrentImageContext();
    [UIImagePNGRepresentation(imageOfResult) writeToFile:toPath atomically:YES];
    
}

// return a new autoreleased UUID string
+ (NSString*)generateUuidString
{
    
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    NSString*uuidString = (NSString*)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    
    // transfer ownership of the string
    // to the autorelease pool
    [uuidString autorelease];
    
    // release the UUID
    CFRelease(uuid);
    
    return uuidString;
}

@end
