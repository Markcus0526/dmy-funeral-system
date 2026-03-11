//
//  ServiceParams.h
//  BodyWear
//
//  Created by ChungJin.Sim on 9/4/13.
//  Copyright (c) 2013 damytech. All rights reserved.
//

#define DEV_TYPE                        @"2"                    // iphone默认

#define DEF_DELAY                       2
#define DEF_CORNER_RADIO				5
#define PAGE_COUNT                      10

#define DEF_IMAGE           			[UIImage imageNamed:@"def_image.png"]

// 网络请求返回状态
#define SVCERR_SUCCESS                  0                       // 성공
#define SVCERR_FAILURE                  -1
#define SVCERR_DUPLICATE_USER           -2

#define PLATFORM	                    @"1"                    // iOS

#define SVCERR_MSG_ERROR                @"跟服务器连接失败"        // HttpClient오유
#define SVCERR_MSG_SUCCESS              @""

#define YUANSYMBOL                      @"￥"
#define YUAN                            @"元"

// Product Dictonary
#define PRODUCT_INFO					@"product"
#define PRODUCT_COUNT					@"count"
#define MSG_SELECT_PRODUCT				@"请首先选择产品"

#define VC_ID_PURCHASE					@"vcPurchase"

// Pull to refresh table
#define MSG_TBLHEADER_PULL              @"下拉可以刷新了"
#define MSG_TBLHEADER_RELEASE           @"松开马上刷新了"
#define MSG_TBLHEADER_REFRESHING        @"正在刷新中..."

#define MSG_TBLFOOTER_PULL              @"上拉可以加载更多数据了"
#define MSG_TBLFOOTER_RELEASE           @"松开马上加载更多数据了"
#define MSG_TBLFOOTER_REFRESHING        @"正在加载中..."

// Common Text
#define MSG_PLEASE_WAIT                 @"请稍候..."
#define MSG_SUCCESS                     @"操作成功!"

#define STR_ALERT						@"提示"
#define STR_BUTTON_CONFIRM              @"确定"
#define STR_BUTTON_CANCEL               @"取消"
#define MSG_GOTO_ADDRESS				@"确定要导航到该景点吗？"
#define MSG_GOTO_OFFICE                 @"确定要导航到该办事处吗？"
#define MSG_GOTO_PHONE                  @"确定要呼叫%@吗？"
#define STRING_DATAMANAGER_PHOTOSIZE	@"头像图片大小不可超过 256x256"
#define MSG_CORRECT_SECPWD              @"密码不一致"
#define MSG_SELECT_IMAGE                @"请选择图片"

#define MSG_INPUT_PHONENUM				@"请输入手机号码"
#define MSG_ERROR_PHONENUM				@"手机号长度必须为11位数字"
#define MSG_INPUT_VERIFYKEY				@"请输入验证码"
#define MSG_INPUT_PASSWORD				@"请输入密码"
#define MSG_CONFIRM_PASSWORD			@"确认密码不一致"

#define MSG_INPUT_PRICE					@"请输入价格"
#define MSG_INPUT_PERCENT				@"请输入折扣"
#define MSG_ALART_PRICE					@"价格输入的不正确"
#define MSG_ALART_PERCENT				@"折扣输入的不正确"
#define MSG_ALART_OVERFLOW				@"折扣值超过了范围, 请查看"
#define MSG_MESSAGE_NOBONUS				@"超过授权，无法销售！"


#define STR_LOGOUT						@"退出"
#define MSG_LOGOUT						@"确定要退出吗？"

#define MSG_NONE_YISHI					@"您没有选择仪式，确定下一步吗？"
#define MSG_NONE_JIPINPROD				@"您没有选择祭品产品，确定下一步吗？"
#define MSG_BUY_YISHI					@"您没有选择仪式还是祭品产品，您必须至少选择一个。"
#define MSG_BUY_JIPINPROD				@"您没有选择祭品产品，您必须至少选择一个。"

#define MSG_EMPTY_PAIWEI				@"对不起，这园区没有空排位。\n请您选择别的园区吧。"

#define STR_JIBAI						@"祭拜"
#define STR_BINZANG						@"殡葬"

///////////////////////////////// Basic Service Value //////////////////////////////
#define SVCC_RET                        @"retcode"
#define SVCC_DATA                       @"retdata"
#define SVCC_RETMSG                     @"retmsg"

///////////////////////////////// Map View Consts //////////////////////////////////
///////////////////////////////// Map View Consts //////////////////////////////////
#define MAPIMG_WIDTH                    1000.0
#define MAPIMG_HEIGHT                   667.0
#define MAP_MAXSCALE                    2.5



