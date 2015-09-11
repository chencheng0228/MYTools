//
//  MyManger.h
//  MYTool
//
//  Created by admin on 14-8-14.
//  Copyright (c) 2014年 ___DNEUSER___. All rights reserved.
//在项目中获取常用的数据东西



#import <Foundation/Foundation.h>

@interface MyManger : NSObject

/**
 * @brief 获取沙盒路径
 */
+(NSString *)getBoxsPath;

/**
 * @brief 获取沙盒路径+文件名
 *
 * @param name 文件名称
 */
+(NSString *)getBoxsPathWithDocuments:(NSString *)name;

/**
 * @brief 获取沙盒路径下所需要的数据
 *
 * @param name 文件名称
 */

+(NSMutableArray *)getInfoFromBoxsPath:(NSString *)name;

/**
 * @brief 创建NSUserdefault,操作之后记得Synchronize同步操作，否则偶然会因为别的线程占大量内存而没有保存成功，[defaults synchronize]。
 *
 */
+(NSUserDefaults *)createUserDefaults;

/**
 * @brief 标签转义
 *
 */

+(NSString *)flattenHTML:(NSString *)originHtmlStr;

+(NSString *)flattenHTMLtwo:(NSString *)html;

/**
 *   获取当前时间
 *
 *  @return 时间
 */
+ (NSString*)getCurrentTime;

/**
 *   获取当前时间后m天的时间
 *
 *  @return 时间
 */

+(NSString *)nextTime:(int)m;


/**
 *  计算时间差
 *
 *  @param dateString
 *
 *  @return 
 */
+(BOOL)calculateTime:(NSString*)dateString;
/**
 *  使图片有彩色变灰色（图片变灰）
 *
 *  @param sourceImage
 *
 *  @return
 */
+(UIImage*)getGrayImage:(UIImage*)sourceImage;

/**
 *  设置label的行间距自适应高度
 */

+(void)LabelHeightOfRow;


//通过date获取星期
+(NSString*)weekdayStringFromDate:(NSString*)str;


/**
 *  获取路径下的所有的文件。
 */
+(NSArray *)getFileNameInThePath:(NSString *)path;


/**
 *  tableView去除多余分割线 还有什么修改背景的。。。。。。
 */


//+(void)tableViewCleanLine
//{
//    //去除多余分割线
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor clearColor];
//    [_tableView setTableFooterView:view];
//}


@end

//*******************************************NSString类别*************************************************
@interface NSString (myStr)

/**
 *  自适应高度
 *
 *  @param size 设置显示区域的size
 *  @param str  nsstring类型
 *  @param font 字体大小
 *
 *  @return 返回实际显示需要的size
 */
+(CGSize)sizeWithsize:(CGSize)size andStr:(NSString *)str  andFont:(UIFont*)font;

@end
