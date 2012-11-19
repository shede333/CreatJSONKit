//
//  YSYNViewController.m
//  TestJSONKit
//
//  Created by  on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "YSYNViewController.h"
#import "ZipArchive.h"
#import "PTCreator.h"

@interface YSYNViewController ()

@end

@implementation YSYNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if ([self respondsToSelector:@selector(initView)]) {
        [self performSelector:@selector(initView)];
    }
    
    [PTCreator generateAllModel];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}






-(void)initView{
    NSString *res = nil;  
    
    /* 
     * json格式编码 
     */  
    
    //字符串  
    NSString *str = @"this is a nsstring";  
    res = [str JSONString];  
    NSLog(@"res= %@", [NSString stringWithString: res]);  
    //res= "this is a nsstring"  
    
    
    //数组  
    NSArray *arr = [[NSArray alloc] initWithObjects:@"One",@"Two",@"Three",nil];  
    res = [arr JSONString];  
    NSLog(@"res= %@", [NSString stringWithString: res]);  
    [arr release];  
    //res= ["One","Two","Three"]  
    
    
    //字典类型（对象）  
    NSArray *arr1 = [NSArray arrayWithObjects:@"dog",@"cat",nil];  
    NSArray *arr2 = [NSArray arrayWithObjects:[NSNumber numberWithBool:YES],[NSNumber numberWithInt:30],nil];  
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:arr1,@"pets",arr2,@"other",nil];  
    res = [dic JSONString];  
    NSLog(@"res= %@", [NSString stringWithString: res]);  
    //res= {"pets":["dog","cat"],"other":[true,30]}   
    
    
    /* 
     * json格式解码 
     */  
    JSONDecoder *jd=[[JSONDecoder alloc] init];  
    
    //针对NSData数据  
    NSData *data = [dic JSONData];  
    NSDictionary *ret = [jd objectWithData: data];  
    NSLog(@"res= %@", [ret objectForKey:@"pets"]);  
    //res= (  
    //  dog,  
    //  cat  
    //)  
    NSLog(@"res= %@", [[ret objectForKey:@"other"] objectAtIndex:0]);  
    //res= 1  
    
    //针对NSString字符串数据  
    NSString *nstr = [dic JSONString];  
    NSDictionary *ret2 = [jd objectWithUTF8String:(const unsigned char *)[nstr UTF8String] length:(unsigned int)[nstr length]];  
    NSLog(@"res= %d", [[ret2 objectForKey:@"pets"] indexOfObject:@"cat"]);  
    //res= 1  
    NSLog(@"res= %@", [[ret2 objectForKey:@"other"] objectAtIndex:1]);  
    //res= 30  
    
    [jd release];  
}

@end
