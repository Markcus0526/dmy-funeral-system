//
//  STDataInfo.m
//  4S-C
//
//  Created by RyuCJ on 24/10/2012.
//  Copyright (c) 2012 PIC. All rights reserved.
//

#import "STDataInfo.h"
#import "NSDate+String.h"

@implementation STUserInfo

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"user_id" Dict:dictionary];
	self.access_token = [GlobalFunc getStringValueWithKey:@"access_token" Dict:dictionary];
	self.office_id = [GlobalFunc getLongValueWithKey:@"office_id" Dict:dictionary];
	self.office_name = [GlobalFunc getStringValueWithKey:@"office_name" Dict:dictionary];
	self.user_type = [GlobalFunc getIntValueWithKey:@"user_type" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.credential_image = [GlobalFunc getStringValueWithKey:@"credential_image" Dict:dictionary];
	
	return true;
}

@end


@implementation STBannerImg

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		 || [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
	
	return true;
}

@end

@implementation ST36View

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
        || [dictionary count] <= 0) return false;
    
    self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
    self.title = [GlobalFunc getStringValueWithKey:@"title" Dict:dictionary];
    self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
    self.contents = [GlobalFunc getStringValueWithKey:@"contents" Dict:dictionary];
    
    return true;
}

@end


@implementation STAreaPoint

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
        || [dictionary count] <= 0) return false;
    
    self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
    self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
    self.contents = [GlobalFunc getStringValueWithKey:@"contents" Dict:dictionary];
    self.x_rate = [GlobalFunc getDoubleValueWithKey:@"x_rate" Dict:dictionary];
    self.y_rate = [GlobalFunc getDoubleValueWithKey:@"y_rate" Dict:dictionary];
	self.row_count = [GlobalFunc getLongValueWithKey:@"row_count" Dict:dictionary];
	self.column_count = [GlobalFunc getLongValueWithKey:@"column_count" Dict:dictionary];
	self.type = [GlobalFunc getIntValueWithKey:@"type" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
    return true;
}

@end

@implementation STAreaPointDetail
- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
        || [dictionary count] <= 0) return false;
    
    self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];;
    self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
    self.contents = [GlobalFunc getStringValueWithKey:@"contents" Dict:dictionary];
	self.row_count = [GlobalFunc getLongValueWithKey:@"row_count" Dict:dictionary];
	self.column_count = [GlobalFunc getLongValueWithKey:@"column_count" Dict:dictionary];
	
    self.products = [[NSMutableArray alloc] init];
    NSDictionary * jsonDic = [dictionary objectForKey:@"products"];
    for (NSDictionary * jsonItem in jsonDic)
    {
        STAreaPointDetailMembers * iteminfo = [[STAreaPointDetailMembers alloc] init];
        
        [iteminfo parseFromDictionary:jsonItem];
        [self.products addObject:iteminfo];
    }
    
    return true;
}
@end

@implementation STAreaPointDetailMembers
- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
        || [dictionary count] <= 0) return false;
    
    self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
    self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
    self.title = [GlobalFunc getStringValueWithKey:@"title" Dict:dictionary];
    self.product_origin = [GlobalFunc getStringValueWithKey:@"product_origin" Dict:dictionary];
    self.price  = [GlobalFunc getDoubleValueWithKey:@"price" Dict:dictionary];
    self.price_desc = [GlobalFunc getStringValueWithKey:@"price_desc" Dict:dictionary];
    return true;
}
@end

@implementation STAfterService : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	self.bury_services = [[NSMutableArray alloc] init];
	NSMutableArray * dictBury = [dictionary objectForKey:@"bury_services"];
	for (NSDictionary * oneBury in dictBury)
	{
		STBuryService * buryItem = [[STBuryService alloc] init];
		[buryItem parseFromDictionary:oneBury];
		[self.bury_services addObject:buryItem];
	}
	
	self.deputy_services = [[NSMutableArray alloc] init];
	NSMutableArray * dictDeputy = [dictionary objectForKey:@"deputy_services"];
	for (NSDictionary * onDeputy in dictDeputy)
	{
		STDeputyService * deputyItem = [[STDeputyService alloc] init];
		[deputyItem parseFromDictionary:onDeputy];
		[self.deputy_services addObject:deputyItem];
	}
	
	return true;
}

@end



@implementation STBuryService : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.title = [GlobalFunc getStringValueWithKey:@"title" Dict:dictionary];
	self.splash_image_url = [GlobalFunc getStringValueWithKey:@"splash_image_url" Dict:dictionary];
	self.video_url = [GlobalFunc getStringValueWithKey:@"video_url" Dict:dictionary];
	self.contents = [GlobalFunc getStringValueWithKey:@"contents" Dict:dictionary];
	self.price = [GlobalFunc getDoubleValueWithKey:@"price" Dict:dictionary];
	self.price_desc = [GlobalFunc getStringValueWithKey:@"price_desc" Dict:dictionary];
	
	return true;
}

@end


@implementation STDeputyService : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.title = [GlobalFunc getStringValueWithKey:@"title" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
	self.contents = [GlobalFunc getStringValueWithKey:@"contents" Dict:dictionary];
	
	return true;
}

@end

@implementation STGpsPos : NSObject
-(id)init{
    self = [super init];
    if ( self )
    {
        self.lat = self.lng = 0;
    }
    return self;
}

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
        || [dictionary count] <= 0) return false;
    
    self.lat = [GlobalFunc getDoubleValueWithKey:@"lat" Dict:dictionary];
    self.lng = [GlobalFunc getDoubleValueWithKey:@"lng" Dict:dictionary];
    
    return true;
}

@end

@implementation STProduct : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.type = [GlobalFunc getIntValueWithKey:@"type" Dict:dictionary];
	self.type_desc = [GlobalFunc getStringValueWithKey:@"type_desc" Dict:dictionary];
	self.title = [GlobalFunc getStringValueWithKey:@"title" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
	self.amount = [GlobalFunc getIntValueWithKey:@"amount" Dict:dictionary];
	self.amount_desc = [GlobalFunc getStringValueWithKey:@"amount_desc" Dict:dictionary];
	self.product_origin = [GlobalFunc getStringValueWithKey:@"product_origin" Dict:dictionary];
	self.price = [GlobalFunc getDoubleValueWithKey:@"price" Dict:dictionary];
	self.price_desc = [GlobalFunc getStringValueWithKey:@"price_desc" Dict:dictionary];
	self.max_amount = [GlobalFunc getIntValueWithKey:@"max_amount" Dict:dictionary];
	self.max_amount_desc = [GlobalFunc getStringValueWithKey:@"max_amount_desc" Dict:dictionary];
	
	self.is_acting = [GlobalFunc getIntValueWithKey:@"is_acting" Dict:dictionary];
	self.act_start_time = [GlobalFunc getStringValueWithKey:@"act_start_time" Dict:dictionary];
	self.act_end_time = [GlobalFunc getStringValueWithKey:@"act_end_time" Dict:dictionary];
	
	self.req_count = 0;
	return true;
}

@end


@implementation STOffice : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.address = [GlobalFunc getStringValueWithKey:@"address" Dict:dictionary];
	self.phone = [GlobalFunc getStringValueWithKey:@"phone" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
	self.lat = [GlobalFunc getDoubleValueWithKey:@"lat" Dict:dictionary];
	self.lng = [GlobalFunc getDoubleValueWithKey:@"lng" Dict:dictionary];
	
	self.employees = [[NSMutableArray alloc] init];
	NSDictionary * jsonDic = [dictionary objectForKey:@"employees"];
	for (NSDictionary * jsonItem in jsonDic)
	{
		STOfficeEmp * iteminfo = [[STOfficeEmp alloc] init];
		
		[iteminfo parseFromDictionary:jsonItem];
		[self.employees addObject:iteminfo];
	}
	
	return true;
}

@end


@implementation STOfficeEmp : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.desc = [GlobalFunc getStringValueWithKey:@"description" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.photo_url = [GlobalFunc getStringValueWithKey:@"photo_url" Dict:dictionary];
	self.phone = [GlobalFunc getStringValueWithKey:@"phone" Dict:dictionary];
	self.office = [GlobalFunc getStringValueWithKey:@"office" Dict:dictionary];
	self.address = [GlobalFunc getStringValueWithKey:@"address" Dict:dictionary];
	self.qq = [GlobalFunc getStringValueWithKey:@"qq" Dict:dictionary];
	self.wechat = [GlobalFunc getStringValueWithKey:@"wechat" Dict:dictionary];
	
	return true;
}

@end


@implementation STOfficeCity

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];

	self.offices = [[NSMutableArray alloc] init];
	NSDictionary * jsonDic = [dictionary objectForKey:@"offices"];
	for (NSDictionary * jsonItem in jsonDic)
	{
		STOfficeCityItem * iteminfo = [[STOfficeCityItem alloc] init];
		
		[iteminfo parseFromDictionary:jsonItem];
		[self.offices addObject:iteminfo];
	}
	
	return true;
}

@end

@implementation STOfficeCityItem

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
    self.address = [GlobalFunc getStringValueWithKey:@"address" Dict:dictionary];
    self.phone = [GlobalFunc getStringValueWithKey:@"phone" Dict:dictionary];
    self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
    self.lat = [GlobalFunc getDoubleValueWithKey:@"lat" Dict:dictionary];
    self.lng = [GlobalFunc getDoubleValueWithKey:@"lng" Dict:dictionary];
	return true;
}
@end

@implementation STVocation : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.user_id = [GlobalFunc getLongValueWithKey:@"user_id" Dict:dictionary];
	self.user_name = [GlobalFunc getStringValueWithKey:@"user_name" Dict:dictionary];
	self.user_desc = [GlobalFunc getStringValueWithKey:@"user_desc" Dict:dictionary];
	self.date = [GlobalFunc getStringValueWithKey:@"date" Dict:dictionary];
	self.reason = [GlobalFunc getLongValueWithKey:@"reason" Dict:dictionary];
	self.reason_desc = [GlobalFunc getStringValueWithKey:@"reason_desc" Dict:dictionary];
	
	return true;
}

- (NSArray*) makeStringArray
{
	return @[self.user_name,
			 self.user_desc,
			 self.date,
			 self.reason_desc
			 ];
}

@end

@implementation STVocationList : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.user_id = [GlobalFunc getLongValueWithKey:@"user_id" Dict:dictionary];
	self.user_name = [GlobalFunc getStringValueWithKey:@"user_name" Dict:dictionary];
	self.user_desc = [GlobalFunc getStringValueWithKey:@"user_desc" Dict:dictionary];
	
	self.month_count = [GlobalFunc getLongValueWithKey:@"month_count" Dict:dictionary];
	self.year_count = [GlobalFunc getLongValueWithKey:@"year_count" Dict:dictionary];
	return true;
}

- (NSArray*) makeStringArray
{
	return @[self.user_name,
			 self.user_desc,
			 [NSString stringWithFormat:@"%ld", self.month_count],
			 [NSString stringWithFormat:@"%ld", self.year_count],
			 ];
}

@end

@implementation STMtQiPan

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.title = [GlobalFunc getStringValueWithKey:@"title" Dict:dictionary];
	self.address = [GlobalFunc getStringValueWithKey:@"address" Dict:dictionary];
	self.phone = [GlobalFunc getStringValueWithKey:@"phone" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
	self.contents = [GlobalFunc getStringValueWithKey:@"contents" Dict:dictionary];
	self.lat = [GlobalFunc getDoubleValueWithKey:@"lat" Dict:dictionary];
	self.lng = [GlobalFunc getDoubleValueWithKey:@"lng" Dict:dictionary];
	
	
	return true;
}

@end



@implementation STDragonService

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.intro = [GlobalFunc getStringValueWithKey:@"intro" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
	self.price = [GlobalFunc getDoubleValueWithKey:@"price" Dict:dictionary];
	self.price_desc = [GlobalFunc getStringValueWithKey:@"price_desc" Dict:dictionary];
	self.user_agree_rate = [GlobalFunc getIntValueWithKey:@"user_agree_rate" Dict:dictionary];
	self.product_intro = [GlobalFunc getStringValueWithKey:@"product_intro" Dict:dictionary];
	self.service_contents = [GlobalFunc getStringValueWithKey:@"service_contents" Dict:dictionary];
	
	return true;
}

@end


@implementation STDragonServiceArea

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.services = [[NSMutableArray alloc] init];
	
 	NSMutableArray * dicServices = [dictionary objectForKey:@"services"];
	for (NSDictionary * oneDic in dicServices) {
		STDragonService * oneItem = [[STDragonService alloc] init];
		[oneItem parseFromDictionary:oneDic];
		[self.services addObject:oneItem];
	}
	
	return true;
}

@end


@implementation STDragonServiceCity

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.areas = [[NSMutableArray alloc] init];
	
	NSMutableArray * dicServices = [dictionary objectForKey:@"areas"];
	for (NSDictionary * oneDic in dicServices) {
		STDragonServiceArea * oneItem = [[STDragonServiceArea alloc] init];
		[oneItem parseFromDictionary:oneDic];
		[self.areas addObject:oneItem];
	}
	
	return true;
}

@end


@implementation STActivity

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.activity_type = [GlobalFunc getStringValueWithKey:@"activity_type" Dict:dictionary];
	self.title = [GlobalFunc getStringValueWithKey:@"title" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
	self.add_time = [GlobalFunc getStringValueWithKey:@"add_time" Dict:dictionary];
	self.act_time = [GlobalFunc getStringValueWithKey:@"act_time" Dict:dictionary];
	self.act_contents = [GlobalFunc getStringValueWithKey:@"act_contents" Dict:dictionary];
	self.is_oblation = [GlobalFunc getIntValueWithKey:@"is_oblation" Dict:dictionary];
	self.is_read = [GlobalFunc getIntValueWithKey:@"is_read" Dict:dictionary];
	
	return true;
}

@end


@implementation STAdvertImage

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
	
	return true;
}

@end


@implementation STRelative

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.relative = [GlobalFunc getStringValueWithKey:@"relative" Dict:dictionary];
	self.area_no = [GlobalFunc getStringValueWithKey:@"area_no" Dict:dictionary];
	self.birthday = [GlobalFunc getStringValueWithKey:@"birthday" Dict:dictionary];
	self.deathday = [GlobalFunc getStringValueWithKey:@"deathday" Dict:dictionary];
	
	return true;
}

@end


@implementation STBill

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.type = [GlobalFunc getStringValueWithKey:@"type" Dict:dictionary];
	self.buy_time = [GlobalFunc getStringValueWithKey:@"buy_time" Dict:dictionary];
	self.service_type = [GlobalFunc getStringValueWithKey:@"service_type" Dict:dictionary];
	self.service_price = [GlobalFunc getDoubleValueWithKey:@"service_price" Dict:dictionary];
	self.service_price_desc = [GlobalFunc getStringValueWithKey:@"service_price_desc" Dict:dictionary];
	self.consume_time = [GlobalFunc getStringValueWithKey:@"consume_time" Dict:dictionary];
	self.state = [GlobalFunc getIntValueWithKey:@"state" Dict:dictionary];
	self.state_desc = [GlobalFunc getStringValueWithKey:@"state_desc" Dict:dictionary];
	self.remark = [GlobalFunc getStringValueWithKey:@"remark" Dict:dictionary];
	self.total_amount = [GlobalFunc getDoubleValueWithKey:@"total_amount" Dict:dictionary];
	self.total_amount_desc = [GlobalFunc getStringValueWithKey:@"total_amount_desc" Dict:dictionary];
	self.products = [[NSMutableArray alloc] init];
	
	NSMutableArray * dicProducts = [dictionary objectForKey:@"products"];
	for (NSDictionary * oneDic in dicProducts) {
		STProduct * oneItem = [[STProduct alloc] init];
		[oneItem parseFromDictionary:oneDic];
		[self.products addObject:oneItem];
	}
	
	return true;
}

@end


@implementation STDeputyLog

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.time = [GlobalFunc getStringValueWithKey:@"time" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
	self.service_people = [GlobalFunc getStringValueWithKey:@"service_people" Dict:dictionary];
	self.detail_images = [[NSMutableArray alloc] init];
	
	NSMutableArray * dicImgs = [dictionary objectForKey:@"detail_images"];
	for (NSDictionary * oneDic in dicImgs)
	{
		NSString * imageUrl = (NSString *)[GlobalFunc getStringValueWithKey:@"image_url" Dict:oneDic];
		[self.detail_images addObject:imageUrl];
	}
	
	return true;
}

@end

@implementation STCustomer

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.phone = [GlobalFunc getStringValueWithKey:@"phone" Dict:dictionary];
	
	self.tombs = [[NSMutableArray alloc] init];
	
	NSMutableArray * dics = [dictionary objectForKey:@"tombs"];
	for (NSDictionary * oneDic in dics) {
		STTomb * oneItem = [[STTomb alloc] init];
		[oneItem parseFromDictionary:oneDic];
		[self.tombs addObject:oneItem];
	}
	
	return true;
}

@end

@implementation STTombInfo

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"tomb_no" Dict:dictionary];
	self.tomb_no = [GlobalFunc getStringValueWithKey:@"tomb_no" Dict:dictionary];
	
	return true;
}

@end

@implementation STTombItem

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.tomb_no = [GlobalFunc getStringValueWithKey:@"tomb_no" Dict:dictionary];
	self.row = [GlobalFunc getLongValueWithKey:@"row" Dict:dictionary];
	self.col = [GlobalFunc getLongValueWithKey:@"col" Dict:dictionary];
	self.state = [GlobalFunc getLongValueWithKey:@"state" Dict:dictionary];
	
	return true;
}

@end

@implementation STTomb

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.tomb_no = [GlobalFunc getStringValueWithKey:@"tomb_no" Dict:dictionary];
	self.row = [GlobalFunc getLongValueWithKey:@"row" Dict:dictionary];
	self.col = [GlobalFunc getLongValueWithKey:@"col" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
	self.desc = [GlobalFunc getStringValueWithKey:@"desc" Dict:dictionary];
	self.price = [GlobalFunc getDoubleValueWithKey:@"price" Dict:dictionary];
	self.price_desc = [GlobalFunc getStringValueWithKey:@"price_desc" Dict:dictionary];
	self.state = [GlobalFunc getLongValueWithKey:@"state" Dict:dictionary];
	self.state_desc = [GlobalFunc getStringValueWithKey:@"state_desc" Dict:dictionary];

	self.name = self.tomb_no;
	return true;
}

@end

/********************************* Tomb Stone Area Info ****************************/
@implementation STTombStoneArea

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.image_url = [GlobalFunc getStringValueWithKey:@"image_url" Dict:dictionary];
	self.parts = [[NSMutableArray alloc] init];
	
	NSDictionary * dics = [dictionary objectForKey:@"parts"];
	
	for (NSDictionary *dic in dics) {
		STTombStonePart *part = [[STTombStonePart alloc] init];
		
		[part parseFromDictionary:dic];
		
		[self.parts addObject:part];
	}
	return true;
}

@end

/********************************* Tomb Stone Part Info ****************************/
@implementation STTombStonePart

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.rows = [[NSMutableArray alloc] init];
	
	NSDictionary * dics = [dictionary objectForKey:@"rows"];
	
	for (NSDictionary *dic in dics) {
		STTombStoneRow *row = [[STTombStoneRow alloc] init];
		
		[row parseFromDictionary:dic];
		
		[self.rows addObject:row];
	}
	return true;
}

@end

/********************************* Tomb Stone Row Info ****************************/
@implementation STTombStoneRow

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.indexes = [[NSMutableArray alloc] init];
	
	NSDictionary * dics = [dictionary objectForKey:@"indexes"];
	
	for (NSDictionary *dic in dics) {
		STTombStoneIndex *index = [[STTombStoneIndex alloc] init];
		
		[index parseFromDictionary:dic];
		
		[self.indexes addObject:index];
	}
	return YES;
}

@end

/********************************* Tomb Stone index Info ****************************/
@implementation STTombStoneIndex

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.tablet_id = [GlobalFunc getLongValueWithKey:@"tablet_id" Dict:dictionary];
	return YES;
}

@end

@implementation STAgents

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
        || [dictionary count] <= 0) return false;
    
    self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
    self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
    self.phone = [GlobalFunc getStringValueWithKey:@"phone" Dict:dictionary];
    
    self.month_score = [GlobalFunc getDoubleValueWithKey:@"month_score" Dict:dictionary];
    self.month_score_desc = [GlobalFunc getStringValueWithKey:@"month_score_desc" Dict:dictionary];
    self.halfyear_score = [GlobalFunc getDoubleValueWithKey:@"halfyear_score" Dict:dictionary];
    self.halfyear_score_desc = [GlobalFunc getStringValueWithKey:@"halfyear_score_desc" Dict:dictionary];
    self.year_score = [GlobalFunc getDoubleValueWithKey:@"year_score" Dict:dictionary];
    self.year_score_desc = [GlobalFunc getStringValueWithKey:@"year_score_desc" Dict:dictionary];
    return true;
}

@end

@implementation STBonusDetailInfo

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.user_name = [GlobalFunc getStringValueWithKey:@"user_name" Dict:dictionary];
	self.tomb_no = [GlobalFunc getStringValueWithKey:@"tomb_no" Dict:dictionary];
	self.buy_time = [GlobalFunc getStringValueWithKey:@"buy_time" Dict:dictionary];
	self.bonus = [GlobalFunc getDoubleValueWithKey:@"bonus" Dict:dictionary];
	self.bonus_desc = [GlobalFunc getStringValueWithKey:@"bonus_desc" Dict:dictionary];
	
	return true;
}

@end

@implementation STDepositLog

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.start_time = [GlobalFunc getStringValueWithKey:@"start_time" Dict:dictionary];
	self.end_time = [GlobalFunc getStringValueWithKey:@"end_time" Dict:dictionary];
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.tomb_no = [GlobalFunc getStringValueWithKey:@"tomb_no" Dict:dictionary];
	self.receiver = [GlobalFunc getStringValueWithKey:@"receiver" Dict:dictionary];
	self.price = [GlobalFunc getDoubleValueWithKey:@"price" Dict:dictionary];
	self.price_desc = [GlobalFunc getStringValueWithKey:@"price_desc" Dict:dictionary];
	
	return true;
}

@end

@implementation STYVocation

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
        || [dictionary count] <= 0) return false;
    
    self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
    self.date = [GlobalFunc getStringValueWithKey:@"date" Dict:dictionary];
    self.reason = [GlobalFunc getIntValueWithKey:@"reason" Dict:dictionary];
    self.reason_desc = [GlobalFunc getStringValueWithKey:@"reason_desc" Dict:dictionary];
    self.state = [GlobalFunc getIntValueWithKey:@"state" Dict:dictionary];
    self.state_desc = [GlobalFunc getStringValueWithKey:@"state_desc" Dict:dictionary];
    self.vocation = [NSDate dateWithString:self.date withFormat:@"yyy-MM-dd hh:mm"];
    return true;
}

@end

@implementation STBuyProductLog

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
        || [dictionary count] <= 0) return false;
    
    self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
    self.customer = [GlobalFunc getStringValueWithKey:@"customer" Dict:dictionary];
    self.reserve_date = [GlobalFunc getStringValueWithKey:@"reserve_date" Dict:dictionary];
    self.is_read = [GlobalFunc getIntValueWithKey:@"is_read" Dict:dictionary];
        
    return true;
}

@end

@implementation STBuyProductContent


- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
    self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
    self.type = [GlobalFunc getIntValueWithKey:@"type" Dict:dictionary];
    self.type_desc = [GlobalFunc getStringValueWithKey:@"type_desc" Dict:dictionary];
    self.title = [GlobalFunc getStringValueWithKey:@"title" Dict:dictionary];
    self.amount = [GlobalFunc getIntValueWithKey:@"amount" Dict:dictionary];
    self.amount_desc = [GlobalFunc getStringValueWithKey:@"amount_desc" Dict:dictionary];
    self.price = [GlobalFunc getDoubleValueWithKey:@"price" Dict:dictionary];
    self.price_desc = [GlobalFunc getStringValueWithKey:@"price_desc" Dict:dictionary];
    return  true;
}
@end

@implementation STBuyProductLogDetail


- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
        || [dictionary count] <= 0) return false;
    
    self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
    self.customer = [GlobalFunc getStringValueWithKey:@"customer" Dict:dictionary];
    self.phone = [GlobalFunc getStringValueWithKey:@"phone" Dict:dictionary];
    self.reserve_date = [GlobalFunc getStringValueWithKey:@"reserve_date" Dict:dictionary];
    self.service_type = [GlobalFunc getStringValueWithKey:@"service_type" Dict:dictionary];
    
    self.products = [[NSMutableArray alloc] init];
    NSDictionary * jsonDic = [dictionary objectForKey:@"products"];
    for (NSDictionary * jsonItem in jsonDic)
    {
        STBuyProductContent * iteminfo = [[STBuyProductContent alloc] init];
        
        [iteminfo parseFromDictionary:jsonItem];
        [self.products addObject:iteminfo];
    }
    
    self.state = [GlobalFunc getIntValueWithKey:@"state" Dict:dictionary];
    self.state_desc = [GlobalFunc getStringValueWithKey:@"state_desc" Dict:dictionary];
    self.is_read = [GlobalFunc getIntValueWithKey:@"is_read" Dict:dictionary];
    
    return true;
}
@end

@implementation STOfficeDepositLog

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.office_id = [GlobalFunc getLongValueWithKey:@"office_id" Dict:dictionary];
	self.office_name = [GlobalFunc getStringValueWithKey:@"office_name" Dict:dictionary];
	self.employee = [GlobalFunc getDoubleValueWithKey:@"employee" Dict:dictionary];
	self.agent = [GlobalFunc getDoubleValueWithKey:@"agent" Dict:dictionary];
	self.total = [GlobalFunc getDoubleValueWithKey:@"total" Dict:dictionary];
	
	return true;
}

@end


/********************************* Deposit Log info ****************************/
@implementation STOfficeDailyScore

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.employee_score = [GlobalFunc getDoubleValueWithKey:@"employee_score" Dict:dictionary];
	self.agent_score = [GlobalFunc getDoubleValueWithKey:@"agent_score" Dict:dictionary];
	self.daily_total = [GlobalFunc getDoubleValueWithKey:@"daily_total" Dict:dictionary];
	
	return true;
}

- (NSArray*) makeStringArray
{
	return @[ 
			 self.name,
			 [NSString stringWithFormat:@"%ld", (long)self.employee_score],
			 [NSString stringWithFormat:@"%ld", (long)self.agent_score],
			 [NSString stringWithFormat:@"%ld", (long)self.daily_total],
			 ];
}
@end

/********************************* Deposit Log info ****************************/
@implementation STEmployeeDailyScore

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.name = [GlobalFunc getStringValueWithKey:@"name" Dict:dictionary];
	self.agent = [GlobalFunc getStringValueWithKey:@"employee" Dict:dictionary];
	self.price = [GlobalFunc getDoubleValueWithKey:@"price" Dict:dictionary];
	self.actual = [GlobalFunc getDoubleValueWithKey:@"actual" Dict:dictionary];
	
	return true;
}

- (NSArray*) makeStringArray
{
	return @[
			 self.name,
			 self.agent,
			 [NSString stringWithFormat:@"%ld", (long)self.price],
			 [NSString stringWithFormat:@"%ld", (long)self.actual],
			 ];
}
@end

@implementation STOfficeCurMonthScore : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.office_id = [GlobalFunc getLongValueWithKey:@"office_id" Dict:dictionary];
	self.office_name = [GlobalFunc getStringValueWithKey:@"office_name" Dict:dictionary];

	self.order = [GlobalFunc getStringValueWithKey:@"order" Dict:dictionary];
	self.agent = [GlobalFunc getDoubleValueWithKey:@"agent" Dict:dictionary];
	self.employee = [GlobalFunc getDoubleValueWithKey:@"employee" Dict:dictionary];
	self.self_rate = [GlobalFunc getDoubleValueWithKey:@"self_rate" Dict:dictionary];
	self.response_value = [GlobalFunc getDoubleValueWithKey:@"response_value" Dict:dictionary];
	self.total = [GlobalFunc getDoubleValueWithKey:@"total" Dict:dictionary];
	self.success_rate = [GlobalFunc getDoubleValueWithKey:@"success_rate" Dict:dictionary];
	self.office_income = [GlobalFunc getDoubleValueWithKey:@"office_income" Dict:dictionary];
	
	return true;
}

- (NSArray*) makeStringArray
{
	return @[self.office_name,
			 [NSString stringWithFormat:@"%ld", (long)self.agent],
			 [NSString stringWithFormat:@"%ld", (long)self.employee],
			 [NSString stringWithFormat:@"%ld%%", (long)self.self_rate],
			 [NSString stringWithFormat:@"%ld", (long)self.response_value],
			 [NSString stringWithFormat:@"%ld", (long)self.total],
			 [NSString stringWithFormat:@"%ld%%", (long)self.success_rate],
			 [NSString stringWithFormat:@"%.1f", self.office_income]
			 ];
}

@end

/********************************* STOfficeCurMonthScore info ****************************/
@implementation STOfficeMonthlyScore : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.order = [GlobalFunc getStringValueWithKey:@"order" Dict:dictionary];
	self.agent = [GlobalFunc getDoubleValueWithKey:@"agent" Dict:dictionary];
	self.employee = [GlobalFunc getDoubleValueWithKey:@"employee" Dict:dictionary];
	self.self_rate = [GlobalFunc getDoubleValueWithKey:@"self_rate" Dict:dictionary];
	self.response_value = [GlobalFunc getDoubleValueWithKey:@"response_value" Dict:dictionary];
	self.total = [GlobalFunc getDoubleValueWithKey:@"total" Dict:dictionary];
	self.success_rate = [GlobalFunc getDoubleValueWithKey:@"success_rate" Dict:dictionary];
	self.office_income = [GlobalFunc getDoubleValueWithKey:@"office_income" Dict:dictionary];
	
	return true;
}

- (NSArray*) makeStringArray
{
	return @[self.order,
			 [NSString stringWithFormat:@"%ld", (long)self.agent],
			 [NSString stringWithFormat:@"%ld", (long)self.employee],
			 [NSString stringWithFormat:@"%ld%%", (long)self.self_rate],
			 [NSString stringWithFormat:@"%ld", (long)self.response_value],
			 [NSString stringWithFormat:@"%ld", (long)self.total],
			 [NSString stringWithFormat:@"%ld%%", (long)self.success_rate],
			 [NSString stringWithFormat:@"%.1f", self.office_income]
			 ];
}

@end


@implementation STScore

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.office_id = [GlobalFunc getLongValueWithKey:@"office_id" Dict:dictionary];
	self.office_name = [GlobalFunc getStringValueWithKey:@"office_name" Dict:dictionary];
	self.user_id = [GlobalFunc getLongValueWithKey:@"user_id" Dict:dictionary];
	self.user_name = [GlobalFunc getStringValueWithKey:@"user_name" Dict:dictionary];
	self.score = [GlobalFunc getDoubleValueWithKey:@"score" Dict:dictionary];
	
	return true;
}

@end

/********************************* STScore_Manager info ****************************/
@implementation STScore_Manager

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.month = [GlobalFunc getLongValueWithKey:@"month" Dict:dictionary];
	self.agent = [GlobalFunc getDoubleValueWithKey:@"agent" Dict:dictionary];
	self.employee = [GlobalFunc getDoubleValueWithKey:@"employee" Dict:dictionary];
	self.self_rate = [GlobalFunc getDoubleValueWithKey:@"self_rate" Dict:dictionary];
	self.response_value = [GlobalFunc getDoubleValueWithKey:@"response_value" Dict:dictionary];
	self.monthly_total = [GlobalFunc getDoubleValueWithKey:@"monthly_total" Dict:dictionary];
	self.success_rate = [GlobalFunc getDoubleValueWithKey:@"success_rate" Dict:dictionary];
	
	return true;
}

- (NSArray*) makeStringArray
{
	return @[[NSString stringWithFormat:@"%ld月", (long)self.month],
			 [NSString stringWithFormat:@"%ld", (long)self.agent],
			 [NSString stringWithFormat:@"%ld", (long)self.employee],
			 [NSString stringWithFormat:@"%ld%%", (long)self.self_rate],
			 [NSString stringWithFormat:@"%ld", (long)self.response_value],
			 [NSString stringWithFormat:@"%ld", (long)self.monthly_total],
			 [NSString stringWithFormat:@"%ld%%", (long)self.success_rate]
		];
}

@end

/********************************* STEmpScore_Manager info ****************************/
@implementation STEmpScore_Manager

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.user_id = [GlobalFunc getLongValueWithKey:@"user_id" Dict:dictionary];
	self.user_name = [GlobalFunc getStringValueWithKey:@"user_name" Dict:dictionary];
	
	self.scores = [[NSMutableArray alloc] init];
	NSDictionary * dics = [dictionary objectForKey:@"scores"];
	
	for (NSDictionary *dic in dics) {
		STScore_Manager *index = [[STScore_Manager alloc] init];
		
		[index parseFromDictionary:dic];
		
		[self.scores addObject:index];
	}

	return true;
}

- (NSArray*) makeStringArray
{
	for (STScore_Manager *score in self.scores)
	{
		self.agent += score.agent;
		self.employee += score.employee;
		self.response_value += score.response_value;
		self.monthly_total += score.monthly_total;
	}
	self.self_rate = self.employee * 100 / (self.employee + self.agent);
	self.success_rate = (self.agent + self.employee) * 100 / self.response_value;
	
	return @[@"", @"总合计",
			 [NSString stringWithFormat:@"%ld", (long)self.agent],
			 [NSString stringWithFormat:@"%ld", (long)self.employee],
			 [NSString stringWithFormat:@"%ld%%", (long)self.self_rate],
			 [NSString stringWithFormat:@"%ld", (long)self.response_value],
			 [NSString stringWithFormat:@"%ld", (long)self.monthly_total],
			 [NSString stringWithFormat:@"%ld%%", (long)self.success_rate]
			 ];
}

@end

/********************************* STAgentScore_Manager info ****************************/
@implementation STAgentScore_Manager

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.user_id = [GlobalFunc getLongValueWithKey:@"user_id" Dict:dictionary];
	self.user_name = [GlobalFunc getStringValueWithKey:@"user_name" Dict:dictionary];
	
	self.score = [GlobalFunc getDoubleValueWithKey:@"score" Dict:dictionary];
	return true;
}

@end

/********************************* STReserveLog info ****************************/
@implementation STReserveLog : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.customer_name = [GlobalFunc getStringValueWithKey:@"customer_name" Dict:dictionary];
	self.customer_phone = [GlobalFunc getStringValueWithKey:@"customer_phone" Dict:dictionary];
	self.reserve_date = [GlobalFunc getStringValueWithKey:@"reserve_date" Dict:dictionary];
	self.state = [GlobalFunc getIntValueWithKey:@"state" Dict:dictionary];
	self.state_desc = [GlobalFunc getStringValueWithKey:@"state_desc" Dict:dictionary];
	
	return true;
}

@end


/********************************* STParentBirthNotify info ****************************/
@implementation STParentBirthNotify : NSObject

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary
{
	if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]
		|| [dictionary count] <= 0) return false;
	
	self.uid = [GlobalFunc getLongValueWithKey:@"uid" Dict:dictionary];
	self.tomb_no = [GlobalFunc getStringValueWithKey:@"tomb_no" Dict:dictionary];
	self.desc = [GlobalFunc getStringValueWithKey:@"desc" Dict:dictionary];
	self.date = [GlobalFunc getStringValueWithKey:@"date" Dict:dictionary];
	
	return true;
}

@end


