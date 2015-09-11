//
//  MyManger.m
//  MYTool
//
//  Created by admin on 14-8-14.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//

#import "MyManger.h"

@implementation MyManger


+(NSString *)getBoxsPath
{
    NSArray * pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * str = [pathArr objectAtIndex:0];
    return str;
}



+(NSString *)getBoxsPathWithDocuments:(NSString *)name
{
    NSArray * pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * str = [pathArr objectAtIndex:0];
    NSString * path = [str  stringByAppendingString:name];
    return path;
}


+(NSMutableArray *)getInfoFromBoxsPath:(NSString *)name
{
    NSArray * pathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * str = [pathArr objectAtIndex:0];
    NSString * path = [str  stringByAppendingString:name];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
    return array;
    
}

+(NSUserDefaults *)createUserDefaults
{
    return [NSUserDefaults standardUserDefaults];
}


//字符转义
+(NSString *)flattenHTML:(NSString *)originHtmlStr{
    NSString *result = nil;
    NSRange arrowTagStartRange = [originHtmlStr rangeOfString:@"<"];
    if (arrowTagStartRange.location != NSNotFound) { //如果找到
        NSRange arrowTagEndRange = [originHtmlStr rangeOfString:@">"];
        
        result = [originHtmlStr stringByReplacingCharactersInRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location + 1) withString:@""];
        
       
        return [self flattenHTML:result];    //递归，过滤下一个标签
    }else{
        result = [originHtmlStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];  // 过滤&nbsp等标签
        result = [originHtmlStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //result = [originHtmlStr stringByReplacingOccurrencesOf
    }
    return result;

}

//字符转义
+(NSString *)flattenHTMLtwo:(NSString *)html
{
        NSScanner *theScanner;
        NSString *text = nil;
        theScanner = [NSScanner scannerWithString:html];
        while ([theScanner isAtEnd] == NO) {
            
            [theScanner scanUpToString:@"<" intoString:NULL] ;
            [theScanner scanUpToString:@">" intoString:&text] ;
             html = [html stringByReplacingOccurrencesOfString:
                    [NSString stringWithFormat:@"%@>", text]
                                                   withString:@""];
        }
        return html;

}

+ (NSString*)getCurrentTime{
    NSDateFormatter* formatter =  [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

+(NSString *)nextTime:(int)m
{
    NSDate* now = [NSDate date];
    NSTimeInterval secondPerDay = 24 * 60 * 60*m;
    NSDate* tomorrow = [now dateByAddingTimeInterval:secondPerDay];
    NSDateFormatter* formatter =  [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateTime = [formatter stringFromDate:tomorrow];
    return dateTime;

}

+(BOOL)calculateTime:(NSString*)dateString
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * d = [inputFormatter dateFromString:dateString];
    
    NSTimeInterval late = [d timeIntervalSince1970]*1;
    
    //    NSString * timeString = nil;
    //    CGFloat time;cha/60>60
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    NSTimeInterval cha = now - late;
    
    if (cha/60>60) {
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        [[NSUserDefaults standardUserDefaults] setObject:locationString forKey:@"outTime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        return YES;
        
    }
    else
    {
        return NO;
    }
    
    //    if (cha/3600 < 1) {
    //
    //        timeString = [NSString stringWithFormat:@"%f", cha/60];
    //
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //
    //        int num= [timeString intValue];
    //
    //        if (num <= 1) {
    //
    //            timeString = [NSString stringWithFormat:@"刚刚..."];
    //
    //        }else{
    //
    //            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
    //
    //        }
    //
    //    }
    
    
    
    //    if (cha/3600 > 1 && cha/86400 < 1) {
    //
    //        timeString = [NSString stringWithFormat:@"%f", cha/3600];
    //
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //
    //        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
    //
    //    }
    //
    //    timeString = [NSString stringWithFormat:@"%f", cha/86400];
    //
    //    if (cha/86400 > 1)
    //
    //    {
    //        time = cha/86400;
    //        timeString = [NSString stringWithFormat:@"%f", cha/86400];
    //
    //        timeString = [timeString substringToIndex:timeString.length-7];
    //
    //        int num = [timeString intValue];
    //
    //        if (num < 2) {
    //
    //            timeString = [NSString stringWithFormat:@"昨天"];
    //
    //        }else if(num == 2){
    //
    //            timeString = [NSString stringWithFormat:@"前天"];
    //
    //        }else if (num > 2){
    //
    //            timeString = [NSString stringWithFormat:@"%@天前", timeString];
    //            
    //        }
    //        
    //        NSLog(@"=========%@",timeString);
    //        if (time>=15.0) {
    //            return YES;
    //        }
    //        
    //    }
    
    
    
}

+(UIImage*)getGrayImage:(UIImage*)sourceImage
{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGBitmapByteOrderDefault);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    
    return grayImage;
}

+(void)LabelHeightOfRow
{
//    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:testString];
//    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle1 setLineSpacing:15];
//    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [testString length])];
//    [cLabel setAttributedText:attributedString1];
//    [cLabel sizeToFit];
   
}

//通过date获取星期
+(NSString*)weekdayStringFromDate:(NSString*)str {
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"yyyy-MM-dd HH:mm:mm"];
    NSDate *inputDate = [formate dateFromString:str];
    
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:inputDate];
    NSInteger weekday = (NSInteger)[componets weekday];
    return [weekdays objectAtIndex:weekday];
    
    
}

//获取路径下的所有的文件。。。。。...........................
+(NSArray *)getFileNameInThePath:(NSString *)path
{
    NSArray *array = [[NSFileManager defaultManager] subpathsAtPath:path];
    return array;
}


@end


@implementation NSString (myStr)

+(CGSize)sizeWithsize:(CGSize)size andStr:(NSString *)str  andFont:(UIFont*)font
{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    CGSize s ;
    
    if (version>7.0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
       s = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    else{
        //ios7以下使用。。
        s = [str sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    
      return s ;
}

@end
