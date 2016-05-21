//
//  ViewController.m
//  Test_Suteng3
//
//  Created by  suteng on 16/2/17.
//  Copyright © 2016年 suteng. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "PhoneVerificationView.h"
#import "RongClouldMessageControllerViewController.h"
#import "HitTestView.h"

#import <RongIMKit/RongIMKit.h>


#define WeakSelf __weak typeof(self) weakSelf = self;

#define WeakSelf2 __weak __typeof(self) weakSelf = self;

static NSString *const RONGCLOUD_IM_APPKEY = @"n19jmcy5934m9"; //<!融云的Key p5tvi9dstz8i4   n19jmcy5934m9

static NSString *const RONGCLOUD_IM_TOKEN = @"TMoJmfT71gMJ0TgmiDiFZ0NsFYdxP1Yv6S70MRjyp/5Tdgg8LYtH6O+1/7UJc3eV0fKvrcbSzxGa0pkX1gmepQ=="; //<!融云Token
static NSString *const OTHER_IM_TOKEN = @"JcMoTrB11myhg1PiQlRRPWnAB6QkODEROUlvql67YLoW+tiyBdx0mXe961zQEMZlh6q9//E6XZsoKBZOaZ8gPw==";

@interface ViewController ()
{
    NSString*DateStr;
    UIImageView* imageView;
    NSInteger num;
    HitTestView* hitView;
    UIView* backView;
    
}
@property(nonatomic,strong)UIButton*start_Button;
@property(nonatomic,strong)UILabel*title_Lab;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self View];
//    //[self createDB];
//    //[self test];
//    //[self kk];
//    
//    NSString* phoneRegx = @"^(1[3|4|5|7|8|])\\d{9}$"; ///< 手机
//    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegx];
//    BOOL bringht = [numberPre evaluateWithObject:@"15528358573"];
//    
//    NSArray *arr = [@"155****8573" componentsSeparatedByString:@"*"];
//    num = 5;
//    //_phoneNumber = arr[0];
//    [self gg];
    
    
    NSString* ss = @"aaa\\bbb\\\\cgg\\d\\eee\\ff";
    
    NSString*gg = [ss stringByReplacingOccurrencesOfString: @"\\\\" withString:@"/" ];
    NSString*hh = [gg stringByReplacingOccurrencesOfString: @"\\" withString:@"/" ];
    
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    [[RCIM sharedRCIM] connectWithToken:RONGCLOUD_IM_TOKEN
                                success:^(NSString* userID){

                                }error:^(RCConnectErrorCode status) {
        
                                }
                                tokenIncorrect:^{
                             
                                }];
    
}

- (void) gg
{
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PhoneVerificationView" owner:nil options:nil];
//    
//    PhoneVerificationView *phoneView = [nib objectAtIndex:0];
//    
//    phoneView.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200);
//    
//    [self.view addSubview:phoneView];
    
//    [phoneView setCustomer:@"155****8573"];

//    RongClouldMessageControllerViewController *chat = [[RongClouldMessageControllerViewController alloc] init];
//    chat.conversationType = ConversationType_PRIVATE;
//    chat.targetId = @"571207";
//    chat.title = @"想显示的会话标题";
//    [self.navigationController pushViewController:chat animated:YES];
    
    backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.6;
    
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(onTap:)];
    gesture.numberOfTapsRequired = 1;
    [backView addGestureRecognizer:gesture];
    
    hitView = [[HitTestView alloc] initWithFrame:CGRectMake(50, 100, [UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - 200)];
    hitView.abc = @"123";

    //[backView addSubview:hitView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:backView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:hitView];
    
    
}

- (void) onTap: (id) geu
{
    backView.hidden = YES;
    hitView.hidden = YES;
}

-(void)start
{
   // MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   // hud.labelText = @"testasdfasd";
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 300, 300)];
    NSString* imageUrl = @"http://192.168.0.149/aa/aa.bmp";
    
     //NSString* imageUrl = @"http://192.168.0.251/zentaopms/www/data/upload/1/201605/031153580160jlo.bmp";
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage: [UIImage imageNamed:@"查看全景图"]];
    
    [self.view addSubview:imageView];
    //[MBProgressHUD showHUDWithText:@"720相机数据库打开失败" animated:YES];
}

- (void) kk
{
    NSString* dbpath = [ NSHomeDirectory()stringByAppendingPathComponent:@"Library/720Camera/db/720Camera.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath: dbpath];
    
    if (![db open])
    {
        return;
    }
    {
        NSString * sql = [NSString stringWithFormat: @"SELECT * FROM '720Camera'"];
        FMResultSet * rs = [db executeQuery:sql];
        NSError* reeor;
        if (rs == nil) {
            reeor = [db lastError];
            NSLog(@"%@", reeor);
        }
        
        while ([rs next])
        {
            NSInteger Id = [rs intForColumn: @"ID"];
            NSString * scenename = [rs stringForColumn:@"SCENENAME"];
            NSString * shootangle = [rs stringForColumn:@"SHOOTANGLE"];
            NSString * date = [rs stringForColumn:@"DATEFLODER"];
            NSString * datesuffixes = [rs stringForColumn:@"DATESUFFIXES"];
            NSLog(@"id = %ld, scenename = %@, shootangleage = %@ , date = %@,  datesuffixes = %@ ", Id, scenename, shootangle, date,datesuffixes);
        }
        NSLog(@"111111111111111");
    }
    
    NSString *deleteSql = @"DELETE FROM '720Camera' WHERE DATESUFFIXES = '666'";
    BOOL res = [db executeUpdate:deleteSql];
    
    if (!res)
    {
        NSLog(@"error when delete db table item");
        NSError*reeor = [db lastError];
        
        NSLog(@"%@", reeor);


    }
    else
    {
        NSLog(@"success to delete db table item");
        NSString * sql = [NSString stringWithFormat: @"SELECT * FROM '720Camera'"];
        FMResultSet * rs = [db executeQuery:sql];
        NSError* reeor;
        if (rs == nil) {
            reeor = [db lastError];
            NSLog(@"%@", reeor);
        }
        
        while ([rs next])
        {
            NSInteger Id = [rs intForColumn: @"ID"];
            NSString * scenename = [rs stringForColumn:@"SCENENAME"];
            NSString * shootangle = [rs stringForColumn:@"SHOOTANGLE"];
            NSString * date = [rs stringForColumn:@"DATEFLODER"];
            NSString * datesuffixes = [rs stringForColumn:@"DATESUFFIXES"];
            NSLog(@"id = %ld, scenename = %@, shootangleage = %@ , date = %@,  datesuffixes = %@ ", Id, scenename, shootangle, date,datesuffixes);
        }
        NSLog(@"2222222222222");
    }
    [db close];
}

- (void) test
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSMutableString *path = [NSMutableString string];
    [path appendString:[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"720Camera"]];
    NSString* zz = [path mutableCopy];
    [path appendString:@"/"];
    [path appendString:@"db"];
    

    
    BOOL removeSuccess = [fileManager removeItemAtPath:path error:nil];
    if (removeSuccess)
    {
        NSArray* array = [fileManager contentsOfDirectoryAtPath: zz error:nil];
        if ([array count] ==0)
        {
            removeSuccess = [fileManager removeItemAtPath:zz error:nil];
            if (removeSuccess) {
                NSLog(@"123");
            }
        }
        
    }

    
    
}

- (void) createDB
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = FALSE;
    
    NSMutableString *path = [NSMutableString string];
    [path appendString:[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"720Camera/db"]];
    
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        
        if(!bCreateDir)
        {
            NSLog(@"Create Audio Directory Failed.");
            return;
        }
        NSLog(@"%@",path);
    }

    
//    {
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//        NSString *libDirectory = [paths objectAtIndex:0];
//        NSString *writableDBPath = [libDirectory stringByAppendingPathComponent:@"720Camera/db/sh.sqlite"];
//        FMDatabase* ddb = [FMDatabase databaseWithPath:writableDBPath];
//        NSLog(@"1111%@ ",writableDBPath);
//        if (![ddb open])
//        {
//            //[MBProgressHUD showHUDWithText:@"720相机数据库打开失败" animated:YES];
//            return;
//        }
//    }
    
    NSString* dbpath = [ NSHomeDirectory()stringByAppendingPathComponent:@"Library/720Camera/db/720Camera.sqlite"];
    NSLog(@"2222%@ ",dbpath);
    FMDatabase* db = [FMDatabase databaseWithPath: dbpath];
    //
    if (![db open])
    {
        //[MBProgressHUD showHUDWithText:@"720相机数据库打开失败" animated:YES];
        return;
    }
    
    
    NSString* createtableString = @"CREATE TABLE IF NOT EXISTS '720Camera' ('ID' INTEGER PRIMARY KEY AUTOINCREMENT, 'SCENENAME' TEXT, 'SHOOTANGLE' TEXT, 'DATEFLODER' TEXT, 'DATESUFFIXES' TEXT)";
    
    
//    [dict setObject:@"SCENENAME" forKey: _sceneName];
//    [dict setObject:@"SHOOTANGLE" forKey: _shootingAngle];
//    [dict setObject:@"DATEFLODER" forKey:_dateName];
//    [dict setObject:@"DATESUFFIXES" forKey:_suffixes];
    
    BOOL res =  [db executeUpdate: createtableString];
    if (!res)
    {
        //[MBProgressHUD showHUDWithText:@"720相机数据库 建表失败" animated:YES];
        return;
    }
    else
    {
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            [dict setObject:@"111" forKey: @"SCENENAME"];
            [dict setObject:@"222" forKey: @"SHOOTANGLE"];
            [dict setObject:@"333" forKey: @"DATEFLODER"];
            [dict setObject:@"444" forKey: @"DATESUFFIXES"];
//        NSString *insertString = @"insert into '720Camera' values(:SCENENAME, :SHOOTANGLE, :DATEFLODER, :DATESUFFIXES)";
//        BOOL res =  [db executeUpdate:insertString withParameterDictionary:dict];
//        
        NSString *insertString= [NSString stringWithFormat: @"INSERT INTO '720Camera' ('SCENENAME', 'SHOOTANGLE', 'DATEFLODER', 'DATESUFFIXES') VALUES ('%@', '%@', '%@', '%@')", @"123", @"456", @"789", @"666"];
        BOOL res = [db executeUpdate: insertString];
        if (!res)
        {
            //[MBProgressHUD showHUDWithText:@"720相机数据库 写入数据失败" animated:YES];
            return;
        }
        
        NSString * sql = [NSString stringWithFormat: @"SELECT * FROM '720Camera'"];
        FMResultSet * rs = [db executeQuery:sql];
        NSError* reeor;
        if (rs == nil) {
            reeor = [db lastError];
            NSLog(@"%@", reeor);
        }
            
        while ([rs next])
        {
            NSInteger Id = [rs intForColumn: @"ID"];
            NSString * scenename = [rs stringForColumn:@"SCENENAME"];
            NSString * shootangle = [rs stringForColumn:@"SHOOTANGLE"];
            NSLog(@"id = %ld, name = %@, age = %@ ", Id, scenename, shootangle);
        }
    }
}

-(void)View
{
    self.start_Button=[UIButton buttonWithType:UIButtonTypeCustom];
    self.start_Button.bounds=CGRectMake(0, 0, 100, 100);
    self.start_Button.center=self.view.center;
    [self.start_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.start_Button setTitle:@"开始" forState:UIControlStateNormal];
    [self.start_Button addTarget:self action:@selector(gg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.start_Button];
    
    self.title_Lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    self.title_Lab.textAlignment=NSTextAlignmentCenter;
    self.title_Lab.center=CGPointMake(self.view.center.x, self.view.center.y+100);
    self.title_Lab.userInteractionEnabled=NO;
    [self.view addSubview:self.title_Lab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
