package com.damytech.communication;

/**
 * Created by KimHM on 2015-01-30.
 */
public class CommErrMgr {
	/**
	 * Service return codes
	 */
	public static final int ERRCODE_NONE					= 0;				// Success
	public static final int ERRCODE_NORMAL					= -1;				// Failure
	public static final int ERRCODE_ACCOUNT_CRASHED			= -99;				// Account crashed

	public static final int ERRCODE_NETERROR				= -100;			// Network error
	public static final int ERRCODE_CLIENT_EXCEPTION		= -101;			// Network error


	/**
	 * Service error messages
	 */

	// Success message
	public static final String ERRMSG_SUCCESS				= "操作成功";

	// Failure message
	public static final String ERRMSG_FAILURE				= "操作失败";

	// Network error description
	public static final String ERRMSG_NETERROR				= "网络不给力，请稍后重试";



}
