//
//  STDataInfo.h
//  FourService
//
//  Created by RyuCJ on 24/11/2012.
//  Copyright (c) 2012 . All rights reserved.
//

#import <Foundation/Foundation.h>

enum EN_PROD_TYPE
{
	PROD_TYPE1 = 0,
	PROD_TYPE2,
	PROD_TYPE3,
	PROD_TYPE4
};

/********************************* User Info ********************************/
@interface STUserInfo : NSObject

@property (nonatomic, readwrite) long  		uid;
@property (nonatomic, retain) NSString *	name;
@property (nonatomic, retain) NSString *    access_token;
@property (nonatomic, readwrite) long		office_id;
@property (nonatomic, retain) NSString *	office_name;
@property (nonatomic, readwrite) int		user_type;
@property (nonatomic, retain) NSString *	credential_image;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end


/********************************* Banner Image Info ****************************/
@interface STBannerImg : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	image_url;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* 36View Info ****************************/
@interface ST36View : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	title;
@property (nonatomic, retain) NSString *   	image_url;
@property (nonatomic, retain) NSString *   	contents;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end


/********************************* Area Point Info ****************************/
@interface STAreaPoint : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString *    contents;
@property (nonatomic, readwrite) double     x_rate;
@property (nonatomic, readwrite) double     y_rate;
@property (nonatomic, readwrite) long   	row_count;
@property (nonatomic, readwrite) long   	column_count;
@property (nonatomic, readwrite) int		type;
@property (nonatomic, retain) NSString*		image_url;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

@interface STAreaPointDetail : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString *    contents;
@property (nonatomic, retain) NSMutableArray * products ;
@property (nonatomic, readwrite) long   	row_count;
@property (nonatomic, readwrite) long   	column_count;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

@interface STAreaPointDetailMembers : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	image_url;
@property (nonatomic, retain) NSString *   	title;
@property (nonatomic, retain) NSString *   	product_origin;
@property (nonatomic, readwrite) double		price;
@property (nonatomic, retain) NSString *   	price_desc;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* After Service Info ****************************/
@interface STBuryService : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	title;
@property (nonatomic, retain) NSString *   	splash_image_url;
@property (nonatomic, retain) NSString *   	video_url;
@property (nonatomic, retain) NSString *   	contents;
@property (nonatomic, readwrite) double		price;
@property (nonatomic, retain) NSString * 	price_desc;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@property (nonatomic, retain) id user_data;

@end


@interface STDeputyService : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *	title;
@property (nonatomic, retain) NSString *   	image_url;
@property (nonatomic, retain) NSString *   	contents;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@property (nonatomic, retain) id user_data;
@end


@interface STAfterService : NSObject

@property (nonatomic, retain) NSMutableArray * bury_services;
@property (nonatomic, retain) NSMutableArray * deputy_services;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

@interface STGpsPos : NSObject

@property (nonatomic, readwrite) double lat;
@property (nonatomic, readwrite) double lng;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;
@end

/********************************* All kind of product info ****************************/
@interface STProduct : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, readwrite) int		type;
@property (nonatomic, retain) NSString *   	type_desc;
@property (nonatomic, retain) NSString *   	title;
@property (nonatomic, retain) NSString *   	image_url;
@property (nonatomic, readwrite) int		amount;
@property (nonatomic, retain) NSString *   	amount_desc;
@property (nonatomic, retain) NSString *   	product_origin;
@property (nonatomic, readwrite) double		price;
@property (nonatomic, retain) NSString *   	price_desc;
@property (nonatomic, readwrite) int		max_amount;
@property (nonatomic, retain) NSString *   	max_amount_desc;
@property (nonatomic, readwrite) int		is_acting;
@property (nonatomic, retain) NSString *   	act_start_time;
@property (nonatomic, retain) NSString *   	act_end_time;

@property int		req_count;
- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end



/********************************* Office info ****************************/
@interface STOffice : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString *   	address;
@property (nonatomic, retain) NSString *   	phone;
@property (nonatomic, retain) NSString *   	image_url;
@property (nonatomic, readwrite) double		lat;
@property (nonatomic, readwrite) double		lng;
@property (nonatomic, retain) NSMutableArray * employees;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

@interface STOfficeEmp : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *    desc;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString *   	photo_url;
@property (nonatomic, retain) NSString *   	phone;
@property (nonatomic, retain) NSString *   	office;
@property (nonatomic, retain) NSString *   	address;
@property (nonatomic, retain) NSString *   	qq;
@property (nonatomic, retain) NSString *   	wechat;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* STOfficeCity info ****************************/

@interface STOfficeCity : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSMutableArray * offices;

//@property (nonatomic, readwrite) BOOL		is_open;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* STOfficeCity info ****************************/

@interface STOfficeCityItem : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString *   	address;
@property (nonatomic, retain) NSString *   	phone;
@property (nonatomic, retain) NSString *   	image_url;
@property (nonatomic, readwrite) double		lat;
@property (nonatomic, readwrite) double		lng;
- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;
@end

/********************************* STVocation info ****************************/

@interface STVocation : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, readwrite) long   	user_id;
@property (nonatomic, retain) NSString *   	user_name;
@property (nonatomic, retain) NSString *   	user_desc;
@property (nonatomic, retain) NSString *   	date;
@property (nonatomic, readwrite) long   	reason;
@property (nonatomic, retain) NSString *   	reason_desc;

@property (nonatomic, retain) NSDate *		vocation;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;
- (NSArray*) makeStringArray;
@end

/********************************* STVocation info ****************************/

@interface STVocationList : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, readwrite) long   	user_id;
@property (nonatomic, retain) NSString *   	user_name;
@property (nonatomic, retain) NSString *   	user_desc;

@property (nonatomic, readwrite) long   	month_count;
@property (nonatomic, readwrite) long   	year_count;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;
- (NSArray*) makeStringArray;
@end

/********************************* QiPan info ****************************/
@interface STMtQiPan : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	title;
@property (nonatomic, retain) NSString *   	address;
@property (nonatomic, retain) NSString *   	phone;
@property (nonatomic, retain) NSString *   	image_url;
@property (nonatomic, retain) NSString *	contents;
@property (nonatomic, readwrite) double		lat;
@property (nonatomic, readwrite) double		lng;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end


/********************************* One Dragon info ****************************/
@interface STDragonService : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString *   	intro;
@property (nonatomic, retain) NSString *   	image_url;
@property (nonatomic, readwrite) double    	price;
@property (nonatomic, retain) NSString *	price_desc;
@property (nonatomic, readwrite) int		user_agree_rate;
@property (nonatomic, retain) NSString *	product_intro;
@property (nonatomic, retain) NSString *	service_contents;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end


@interface STDragonServiceArea : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSMutableArray * services;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end


@interface STDragonServiceCity : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSMutableArray * areas;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Activity info ****************************/
@interface STActivity : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	activity_type;
@property (nonatomic, retain) NSString * 	title;
@property (nonatomic, retain) NSString * 	image_url;
@property (nonatomic, retain) NSString * 	add_time;
@property (nonatomic, retain) NSString * 	act_time;
@property (nonatomic, retain) NSString * 	act_contents;
@property (nonatomic, readwrite) int 		is_oblation;
@property (nonatomic, readwrite) int		is_read;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;


@end


/********************************* Advert Image info ****************************/
@interface STAdvertImage : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	image_url;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end


/********************************* Relative info ****************************/
@interface STRelative : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString * 	relative;
@property (nonatomic, retain) NSString * 	area_no;
@property (nonatomic, retain) NSString * 	birthday;
@property (nonatomic, retain) NSString * 	deathday;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end



/********************************* Bill info ****************************/
@interface STBill : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString *   	type;
@property (nonatomic, retain) NSString * 	buy_time;
@property (nonatomic, retain) NSString * 	service_type;
@property (nonatomic, readwrite) double 	service_price;
@property (nonatomic, retain) NSString * 	service_price_desc;
@property (nonatomic, retain) NSString * 	consume_time;
@property (nonatomic, readwrite) int	 	state;
@property (nonatomic, retain) NSString * 	state_desc;
@property (nonatomic, retain) NSString * 	remark;
@property (nonatomic, readwrite) double 	total_amount;
@property (nonatomic, retain) NSString * 	total_amount_desc;
@property (nonatomic, retain) NSMutableArray * products;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end



/********************************* Deputy Log info ****************************/
@interface STDeputyLog : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	time;
@property (nonatomic, retain) NSString *   	image_url;
@property (nonatomic, retain) NSString * 	service_people;
@property (nonatomic, retain) NSMutableArray * detail_images;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* STCustomer info ****************************/
@interface STCustomer : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString *   	phone;

@property (nonatomic, retain) NSMutableArray * tombs;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end


/********************************* Tomb info ****************************/
@interface STTombInfo : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *	name;
@property (nonatomic, retain) NSString *   	tomb_no;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Tomb info ****************************/
@interface STTombItem : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	tomb_no;
@property (nonatomic, readwrite) long   	row;
@property (nonatomic, readwrite) long   	col;
@property (nonatomic, readwrite) long   	state;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Tomb info ****************************/
@interface STTomb : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	tomb_no;
@property (nonatomic, retain) NSString *   	image_url;
@property (nonatomic, readwrite) long   	row;
@property (nonatomic, readwrite) long   	col;
@property (nonatomic, retain) NSString *   	desc;
@property (nonatomic, readwrite) double   	price;
@property (nonatomic, retain) NSString *   	price_desc;
@property (nonatomic, readwrite) long   	state;
@property (nonatomic, retain) NSString *   	state_desc;

@property (nonatomic, retain) NSString *   	name;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Tomb Stone Area Info ****************************/
@interface STTombStoneArea : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString * 	image_url;
@property (nonatomic, retain) NSMutableArray *parts;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Tomb Stone Part Info ****************************/
@interface STTombStonePart : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString*		name;
@property (nonatomic, retain) NSMutableArray *rows;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Tomb Stone Row Info ****************************/
@interface STTombStoneRow : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSMutableArray *indexes;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Tomb Stone index Info ****************************/
@interface STTombStoneIndex : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, readwrite) long		tablet_id;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Agent info ****************************/
@interface STAgents : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString *   	phone;
@property (nonatomic, readwrite) double	   	month_score;
@property (nonatomic, retain) NSString *   	month_score_desc;
@property (nonatomic, readwrite) double	   	halfyear_score;
@property (nonatomic, retain) NSString *   	halfyear_score_desc;
@property (nonatomic, readwrite) double	   	year_score;
@property (nonatomic, retain) NSString *   	year_score_desc;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Bonus Detail info ****************************/
@interface STBonusDetailInfo : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	user_name;
@property (nonatomic, retain) NSString *   	tomb_no;
@property (nonatomic, retain) NSString *   	buy_time;
@property (nonatomic, readwrite) double	   	bonus;
@property (nonatomic, retain) NSString *   	bonus_desc;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Deposit Log info ****************************/
@interface STDepositLog : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	start_time;
@property (nonatomic, retain) NSString *   	end_time;
@property (nonatomic, retain) NSString *   	name;
@property (nonatomic, retain) NSString *   	tomb_no;
@property (nonatomic, retain) NSString *   	receiver;
@property (nonatomic, readwrite) double	   	price;
@property (nonatomic, retain) NSString *   	price_desc;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

@interface STYVocation : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	date;
@property (nonatomic, readwrite) int reason;
@property (nonatomic, retain) NSString *   	reason_desc;
@property (nonatomic, readwrite) int  	state;
@property (nonatomic, retain) NSString *   	state_desc;
@property (nonatomic, retain) NSDate *		vocation;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

@interface STBuyProductLog : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	customer;
@property (nonatomic, retain) NSString *   	reserve_date;
@property (nonatomic, readwrite) int    	is_read;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

@interface STBuyProductContent : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, readwrite) int   	type;

@property (nonatomic, retain) NSString *   	type_desc ;
@property (nonatomic, retain) NSString *   	title;
@property (nonatomic, readwrite) int   	amount ;
@property (nonatomic, retain) NSString *   	amount_desc ;
@property (nonatomic, readwrite) double	   	price ;
@property (nonatomic, retain) NSString *   	price_desc ;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;
@end

@interface STBuyProductLogDetail : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	customer;
@property (nonatomic, retain) NSString *   	phone;
@property (nonatomic, retain) NSString *   	agent;
@property (nonatomic, retain) NSString *   	reserve_date;
@property (nonatomic, retain) NSString *   	service_type;

@property (nonatomic, retain) NSMutableArray * products ;

@property (nonatomic, readwrite) int   	state;
@property (nonatomic, retain) NSString *   	state_desc;

@property (nonatomic, readwrite) int    	is_read;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Deposit Log info ****************************/
@interface STOfficeDepositLog : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, readwrite) long   	office_id;
@property (nonatomic, retain) NSString *   	office_name;
@property (nonatomic, readwrite) double	   	employee;
@property (nonatomic, readwrite) double	   	agent;
@property (nonatomic, readwrite) double	   	total;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* Deposit Log info ****************************/
@interface STOfficeDailyScore : NSObject

@property (nonatomic, retain) NSString*		name;
@property (nonatomic, readwrite) double	   	agent_score;
@property (nonatomic, readwrite) double	   	employee_score;
@property (nonatomic, readwrite) double	   	daily_total;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;
- (NSArray*) makeStringArray;

@end

/********************************* Deposit Log info ****************************/
@interface STEmployeeDailyScore : NSObject

@property (nonatomic, retain) NSString*		name;
@property (nonatomic, retain) NSString*	   	agent;
@property (nonatomic, readwrite) double	   	price;
@property (nonatomic, readwrite) double	   	actual;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;
- (NSArray*) makeStringArray;

@end

/********************************* STOfficeCurMonthScore info ****************************/
@interface STOfficeCurMonthScore : NSObject

@property (nonatomic, readwrite) long   	office_id;
@property (nonatomic, retain) NSString *   	office_name;

@property (nonatomic, retain) NSString *   	order;
@property (nonatomic, readwrite) double	   	agent;
@property (nonatomic, readwrite) double	   	employee;
@property (nonatomic, readwrite) double	   	self_rate;
@property (nonatomic, readwrite) double	   	response_value;
@property (nonatomic, readwrite) double	   	total;
@property (nonatomic, readwrite) double	   	success_rate;
@property (nonatomic, readwrite) double	   	office_income;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;
- (NSArray*) makeStringArray;

@end

/********************************* STOfficeCurMonthScore info ****************************/
@interface STOfficeMonthlyScore : NSObject

@property (nonatomic, retain) NSString *   	order;
@property (nonatomic, readwrite) double	   	agent;
@property (nonatomic, readwrite) double	   	employee;
@property (nonatomic, readwrite) double	   	self_rate;
@property (nonatomic, readwrite) double	   	response_value;
@property (nonatomic, readwrite) double	   	total;
@property (nonatomic, readwrite) double	   	success_rate;
@property (nonatomic, readwrite) double	   	office_income;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;
- (NSArray*) makeStringArray;

@end

/********************************* Score info ****************************/
@interface STScore : NSObject

@property (nonatomic, readwrite) long   	office_id;
@property (nonatomic, retain) NSString *   	office_name;
@property (nonatomic, readwrite) long   	user_id;
@property (nonatomic, retain) NSString *   	user_name;
@property (nonatomic, readwrite) double   	score;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* STScore_Manager info ****************************/
@interface STScore_Manager : NSObject

@property (nonatomic, readwrite) long   	month;
@property (nonatomic, readwrite) double   	agent;
@property (nonatomic, readwrite) double   	employee;
@property (nonatomic, readwrite) double   	self_rate;
@property (nonatomic, readwrite) double   	response_value;
@property (nonatomic, readwrite) double   	monthly_total;
@property (nonatomic, readwrite) double   	success_rate;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;
- (NSArray*) makeStringArray;

@end

/********************************* STEmpScore_Manager info ****************************/
@interface STEmpScore_Manager : NSObject

@property (nonatomic, readwrite) long   		user_id;
@property (nonatomic, retain) NSString *   		user_name;
@property (nonatomic, retain) NSMutableArray*   scores;

//////////////////////

@property (nonatomic, readwrite) double   	agent;
@property (nonatomic, readwrite) double   	employee;
@property (nonatomic, readwrite) double   	self_rate;
@property (nonatomic, readwrite) double   	response_value;
@property (nonatomic, readwrite) double   	monthly_total;
@property (nonatomic, readwrite) double   	success_rate;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;
- (NSArray*) makeStringArray;

@end

/********************************* STAgentScore_Manager info ****************************/
@interface STAgentScore_Manager : NSObject

@property (nonatomic, readwrite) long   	user_id;
@property (nonatomic, retain) NSString *   	user_name;

@property (nonatomic, readwrite) double   	score;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* STReserveLog info ****************************/
@interface STReserveLog : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	customer_name;
@property (nonatomic, retain) NSString *   	customer_phone;
@property (nonatomic, retain) NSString *   	reserve_date;
@property (nonatomic, readwrite) long   	state;
@property (nonatomic, retain) NSString *   	state_desc;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

/********************************* STParentBirthNotify info ****************************/
@interface STParentBirthNotify : NSObject

@property (nonatomic, readwrite) long   	uid;
@property (nonatomic, retain) NSString *   	tomb_no;
@property (nonatomic, retain) NSString *   	desc;
@property (nonatomic, retain) NSString *   	date;

- (BOOL) parseFromDictionary : (NSDictionary *)dictionary;

@end

