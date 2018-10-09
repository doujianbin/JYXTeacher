//
//  JYXUser.m
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXUser.h"
#import "MJExtension.h"
#import "MSDBHelper.h"
#import "MSPath.h"

static NSString *const token              = @"token";
static NSString *const userId             = @"id";
static NSString *const avatar             = @"head";
static NSString *const teacherId          = @"teacherid";
static NSString *const credit             = @"credit";
static NSString *const nickname           = @"nick";
static NSString *const cardname           = @"cardname";
static NSString *const sex                = @"sex";
static NSString *const cityId             = @"cityid";
static NSString *const citypriceone       = @"citypriceone";
static NSString *const citypricetwo       = @"citypricetwo";
static NSString *const citypricethree     = @"citypricethree";
static NSString *const citypricefour      = @"citypricefour";
static NSString *const citypricefive      = @"citypricefive";
static NSString *const citypricesix       = @"citypricesix";
static NSString *const citypriceseven     = @"citypriceseven";
static NSString *const citypriceeight     = @"citypriceeight";
static NSString *const citypricenine      = @"citypricenine";
static NSString *const citypriceten       = @"citypriceten";
static NSString *const citypriceeleven    = @"citypriceeleven";
static NSString *const citypricetwelve    = @"citypricetwelve";
static NSString *const addr               = @"addr";
static NSString *const range              = @"range";
static NSString *const teachertohome      = @"teachertohome";
static NSString *const studenttohome      = @"studenttohome";
static NSString *const ispush             = @"ispush";
static NSString *const cardstatu          = @"cardstatu";
static NSString *const educationstatu     = @"educationstatu";
static NSString *const senioritystatu     = @"senioritystatu";

static NSString *const education          = @"education";
static NSString *const worktime           = @"worktime";
static NSString *const unit               = @"unit";
static NSString *const unitlook           = @"unitlook";
static NSString *const oneselfinfo        = @"oneselfinfo";
static NSString *const unittype           = @"unittype";
static NSString *const teachertype        = @"teachertype";
static NSString *const planhour           = @"planhour";

@implementation JYXUser
{
    MSDBHelper *mHelper;
}

/**
 归档的实现
 */
MJExtensionCodingImplementation

- (void)dealloc
{
    NSLog(@"%@ ------> %@", NSStringFromSelector(_cmd), NSStringFromClass([self class]));
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/// 配置用户信息
- (void)configUserData:(NSDictionary *)dict
{
    if (!dict) return;
    if (!dict.count) return;
    
    self.teacherId = dict[teacherId];
    self.userId = dict[userId];
    self.cityId = dict[cityId];
    self.credit = dict[credit];
    self.avatar = dict[avatar];
    self.nickname = dict[nickname];
    self.cardname = dict[cardname];
    self.sex = dict[sex];
    self.token = dict[token];
    self.citypriceone = dict[citypriceone];
    self.citypricetwo = dict[citypricetwo];
    self.citypricethree = dict[citypricethree];
    self.citypricefour = dict[citypricefour];
    self.citypricefive = dict[citypricefive];
    self.citypricesix = dict[citypricesix];
    self.citypriceseven = dict[citypriceseven];
    self.citypriceeight = dict[citypriceeight];
    self.citypricenine = dict[citypricenine];
    self.citypriceten = dict[citypriceten];
    self.citypriceeleven = dict[citypriceeleven];
    self.citypricetwelve = dict[citypricetwelve];
    self.addr = dict[addr];
    self.range = dict[range];
    self.teachertohome = dict[teachertohome];
    self.studenttohome = dict[studenttohome];
    self.ispush = dict[ispush];
    self.cardstatu = dict[cardstatu];
    self.educationstatu = dict[educationstatu];
    self.senioritystatu = dict[senioritystatu];
    
    self.education = dict[education];
    self.worktime = dict[worktime];
    self.unit = dict[unit];
    self.unittype = dict[unittype];
    self.unitlook = dict[unitlook];
    self.oneselfinfo = dict[oneselfinfo];
    self.teachertype = dict[teachertype];
    self.planhour = dict[planhour];
}

/**
 *  保存当前用户的数据
 */
- (BOOL)save
{
    @synchronized(self) {
        
        NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
        [json setValue:_token forKey:token];
        [json setValue:_teacherId forKey:teacherId];
        [json setValue:_userId forKey:userId];
        [json setValue:_credit forKey:credit];
        [json setValue:_avatar forKey:avatar];
        [json setValue:_nickname forKey:nickname];
        [json setValue:_cardname forKey:cardname];
        [json setValue:_sex forKey:sex];
        [json setValue:_cityId forKey:cityId];
        
        [json setValue:_citypriceone forKey:citypriceone];
        [json setValue:_citypricetwo forKey:citypricetwo];
        [json setValue:_citypricethree forKey:citypricethree];
        [json setValue:_citypricefour forKey:citypricefour];
        [json setValue:_citypricefive forKey:citypricefive];
        [json setValue:_citypricesix forKey:citypricesix];
        [json setValue:_citypriceseven forKey:citypriceseven];
        [json setValue:_citypriceeight forKey:citypriceeight];
        [json setValue:_citypricenine forKey:citypricenine];
        [json setValue:_citypriceten forKey:citypriceten];
        [json setValue:_citypriceeleven forKey:citypriceeleven];
        [json setValue:_citypricetwelve forKey:citypricetwelve];
        [json setValue:_addr forKey:addr];
        [json setValue:_range forKey:range];
        
        [json setValue:_range forKey:teachertohome];
        [json setValue:_studenttohome forKey:studenttohome];
        [json setValue:_ispush forKey:ispush];
        [json setValue:_cardstatu forKey:cardstatu];
        [json setValue:_educationstatu forKey:educationstatu];
        [json setValue:_senioritystatu forKey:senioritystatu];
        
        [json setValue:_education forKey:education];
        [json setValue:_worktime forKey:worktime];
        [json setValue:_unit forKey:unit];
        [json setValue:_unitlook forKey:unitlook];
        [json setValue:_unittype forKey:unittype];
        [json setValue:_oneselfinfo forKey:oneselfinfo];
        [json setValue:_teachertype forKey:teachertype];
        
        [self openDB];
        NSLog(@"fullPathForDocument==%@",[MSPath fullPathForDocument:nil]);
        [mHelper executeUpdate:@"DELETE FROM UserInfo WHERE UserId=?", _userId];
        return [mHelper executeUpdate:@"INSERT INTO UserInfo (UserId,Data) VALUES (?,?)", _userId, [self descriptionWithDictM:json]];
    }
}

/**
 * 加载用户数据到当前对象，如果加载失败则不改变当前 User 的内容
 * @param userId 用户 id
 * @return 是否加载成功，如果没有保存过则返回 NO
 */
- (BOOL)load:(int64_t)userId
{
    @synchronized(self) {
        [self openDB];
        
        MSDBResultSet *result = [mHelper executeQuery:@"SELECT UserId,Data FROM UserInfo WHERE UserId=?",@(userId)];
        if ([result next]) {
            [self clear];
            
            NSString *str = [result stringForColumn:@"Data"];
            [self configUserData:[self objectFromJSONString:str]];
            
            return YES;
        } else{
            return NO;
        }
    }
}

/**
 *  清除用户信息
 */
- (void)clear
{
    @synchronized (self) {
        _token = @"";
        _avatar = @"";
        _cityId = @"";
        _credit = @"";
        _nickname = @"";
        _cardname = @"";
        _sex = @"";
        _userId = @"";
        _teacherId = @"";
        _citypriceone = @"";
        _citypricetwo = @"";
        _citypricethree = @"";
        _citypricefour = @"";
        _citypricefive = @"";
        _citypricesix = @"";
        _citypriceseven = @"";
        _citypriceeight = @"";
        _citypricenine = @"";
        _citypriceten = @"";
        _citypriceeleven = @"";
        _citypricetwelve = @"";
        _addr = @"";
        _range = @0;
        _teachertohome = @0;
        _studenttohome = @0;
        _ispush = @0;
        _cardstatu = @0;
        _educationstatu = @0;
        _senioritystatu = @0;
        
        _education = @"";
        _worktime = @"";
        _unittype = @"";
        _unit = @"";
        _oneselfinfo = @"";
        _unitlook = @0;
        _teachertype = @"";
    }
}

#pragma mark - DB -
- (void)openDB
{
    @synchronized(self) {
        
        if (!mHelper) {
            mHelper = [[MSDBHelper alloc] init];
            [mHelper setFileName:@"UserInfo"];
            [mHelper setKey:@".JYXVIP#$"];
            [mHelper open];
        }
        
        [mHelper executeUpdate:@"CREATE TABLE IF NOT EXISTS UserInfo (UserId INTEGER PRIMARY KEY,Data TEXT)"];
        /// 扩展信息表
        //        [mHelper executeUpdate:@"CREATE TABLE IF NOT EXISTS UserInfoExtra (UserId INTEGER,DataKey TEXT,DataType INTEGER, Data BLOB)"];
    }
}

#pragma mark - 私有 -
/// 对象转json字符串
- (NSString *)descriptionWithDictM:(NSMutableDictionary *)dictM
{
    NSError *error;
    NSData  *data  = [NSJSONSerialization dataWithJSONObject: dictM
                                                     options: NSJSONWritingPrettyPrinted
                                                       error: &error];
    if (!error){
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return str;
    }
    
    return @"{}";
}

/// json字符串转对象
- (id)objectFromJSONString:(NSString *)jsonString
{
    NSError *error;
    id obj = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                             options:0
                                               error:&error];
    if (!error) {
        return obj;
    }
    return @"{}";
}

#pragma mark - getter -
- (NSString *)cacheRootDirectory
{
    NSString *fullPath = [MSPath fullPathFromAssetsInLibrary:[NSString stringWithFormat:@"Database/User/"]];
    return fullPath;
}

@end
