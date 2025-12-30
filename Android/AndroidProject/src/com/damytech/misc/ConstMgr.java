package com.damytech.misc;

/**
 * Created by KimHM on 2015/1/14.
 */
public class ConstMgr {
	// User type constants
	public static final int USER_TYPE_ADMIN = 0;				// 超管
	public static final int USER_TYPE_CHAIRMAN = 1;
	public static final int USER_TYPE_GENERALMANAGER = 2;
	public static final int USER_TYPE_VICE_GENERALMANAGER = 3;
	public static final int USER_TYPE_MANAGER = 4;				// 主任
	public static final int USER_TYPE_VICE_MANAGER = 5;			// 副主任
	public static final int USER_TYPE_EMPLOYEE = 6;				// 员工
	public static final int USER_TYPE_AGENT = 7;				// 代销商
	public static final int USER_TYPE_CUSTOMER = 8;				// 旧客户


	// BuyProductLog type
	public static final int BUY_PRODUCT_LOG_TYPE_WAITING = 0;		// 待执行
	public static final int BUY_PRODUCT_LOG_TYPE_COMPLETED = 1;		// 已执行


	// Vocation type
	public static final int VOCATION_TYPE_NORMAL = 0;		// 列休
	public static final int VOCATION_TYPE_ILLNESS = 1;		// 病休
	public static final int VOCATION_TYPE_OTHERS = 2;		// 其他


	// Vocation state
	public static final int VOCATION_STATE_CREATED = 0;		// 已申请
	public static final int VOCATION_STATE_CANCELLED = 1;	// 已取消


	// Reserve visit state
	public static final int RESERVE_STATE_WAIT = 0;				// 待处理
	public static final int RESERVE_STATE_CONFIRMED = 1;		// 已确认
	public static final int RESERVE_STATE_CANCELLED = 2;		// 已取消

	public static String getReserveVisitStateDesc(int state) {
		String result = "";

		if (state == RESERVE_STATE_WAIT) {
			result = "待处理";
		} else if (state == RESERVE_STATE_CONFIRMED) {
			result = "已确认";
		} else if (state == RESERVE_STATE_CANCELLED) {
			result = "已取消";
		}

		return result;
	}

	// Point Area Type
	public static final int AREA_TYPE_SITE = 0;		// 墓地园区
	public static final int AREA_TYPE_TABLET = 1;	// 牌位园区
}















