package com.damytech.binzang.activities.preset;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;
import cn.jpush.android.api.JPushInterface;
import com.damytech.binzang.activities.custom.*;
import com.damytech.utils.AppUtility;

/**
 * Created by Personal on 2015/4/28.
 */
public class BCReceiver extends BroadcastReceiver {
    private static final String TAG = "JPush";

    @Override
    public void onReceive(Context context, Intent intent) {
        Bundle bundle = intent.getExtras();
        Log.d(TAG, "[MyReceiver] onReceive - " + intent.getAction() + ", extras: " + printBundle(bundle));

        if (JPushInterface.ACTION_REGISTRATION_ID.equals(intent.getAction())) {
            String regId = bundle.getString(JPushInterface.EXTRA_REGISTRATION_ID);
            Log.d(TAG, "[MyReceiver] ����Registration Id : " + regId);
            //send the Registration Id to your server...

        } else if (JPushInterface.ACTION_MESSAGE_RECEIVED.equals(intent.getAction())) {
            Log.d(TAG, "[MyReceiver] ���յ������������Զ�����Ϣ: " + bundle.getString(JPushInterface.EXTRA_MESSAGE));
            processCustomMessage(context, bundle);

        } else if (JPushInterface.ACTION_NOTIFICATION_RECEIVED.equals(intent.getAction())) {
            Log.d(TAG, "[MyReceiver] ���յ�����������֪ͨ");
            int notifactionId = bundle.getInt(JPushInterface.EXTRA_NOTIFICATION_ID);
            Log.d(TAG, "[MyReceiver] ���յ�����������֪ͨ��ID: " + notifactionId);

        } else if (JPushInterface.ACTION_NOTIFICATION_OPENED.equals(intent.getAction())) {
            Log.d(TAG, "[MyReceiver] �û��������֪ͨ");

            //���Զ����Activity
            /*if (AppUtility.isAppBackgroundMode(context))
            {
//            	Intent i = new Intent(context, TestActivity.class);
                Intent i = new Intent(context, PresetLogoActivity.class);
                i.putExtras(bundle);
                //i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP );
                context.startActivity(i);
            }*/
            processCustomMessage(context, bundle);

        } else if (JPushInterface.ACTION_RICHPUSH_CALLBACK.equals(intent.getAction())) {
            Log.d(TAG, "[MyReceiver] �û��յ���RICH PUSH CALLBACK: " + bundle.getString(JPushInterface.EXTRA_EXTRA));
            //��������� JPushInterface.EXTRA_EXTRA �����ݴ�����룬������µ�Activity�� ��һ����ҳ��..

        } else if(JPushInterface.ACTION_CONNECTION_CHANGE.equals(intent.getAction())) {
            boolean connected = intent.getBooleanExtra(JPushInterface.EXTRA_CONNECTION_CHANGE, false);
            Log.w(TAG, "[MyReceiver]" + intent.getAction() +" connected state change to "+connected);
        } else {
            Log.d(TAG, "[MyReceiver] Unhandled intent - " + intent.getAction());
        }
    }

    // ��ӡ���е� intent extra ����
    private static String printBundle(Bundle bundle) {
        StringBuilder sb = new StringBuilder();
        for (String key : bundle.keySet()) {
            if (key.equals(JPushInterface.EXTRA_NOTIFICATION_ID)) {
                sb.append("\nkey:" + key + ", value:" + bundle.getInt(key));
            }else if(key.equals(JPushInterface.EXTRA_CONNECTION_CHANGE)){
                sb.append("\nkey:" + key + ", value:" + bundle.getBoolean(key));
            }
            else {
                sb.append("\nkey:" + key + ", value:" + bundle.getString(key));
            }
        }
        return sb.toString();
    }

    public void pushNewActivityAnimated(Activity srcActivity,
                                        final Class dstClass,
                                        final int animation,
                                        final int activity_flags,
                                        final Bundle extras,
                                        final int req_code) {
        Intent intent = new Intent(srcActivity, dstClass);
        intent.putExtra(SuperActivity.AnimConst.EXTRA_ANIMDIR, animation);

        if (activity_flags != 0)
            intent.addFlags(activity_flags);

        if (extras != null)
            intent.putExtras(extras);

        srcActivity.startActivityForResult(intent, req_code);
    }

    //send msg to MainActivity
    private void processCustomMessage(Context context, Bundle bundle) {

        String msg = bundle.getString(JPushInterface.EXTRA_ALERT);
        String[] identiStr = msg.split("\r\n");

        if (identiStr[0].equals("Activity"))
        {
            //Intent i = new Intent(context, YuanQuHuoDongActivity.class);
            //i.putExtras(bundle);
            //i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            //context.startActivity(i);
            pushNewActivityAnimated(SuperActivity.top_instance, YuanQuHuoDongActivity.class, SuperActivity.AnimConst.ANIMDIR_FROM_RIGHT, 0, bundle, -1);
        }
        else if (identiStr[0].equals("ParentBirth"))
        {
            //Intent i = new Intent(context, JiuKeHuShouYeActivity.class);
            //i.putExtras(bundle);
            //i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            //context.startActivity(i);
            pushNewActivityAnimated(SuperActivity.top_instance, JiuKeHuShouYeActivity.class, SuperActivity.AnimConst.ANIMDIR_FROM_RIGHT, 0, bundle, -1);
        }
        else if (identiStr[0].equals("ServiceResult"))
        {
            //Intent i = new Intent(context, DaiJiBaiHuiHanActivity.class);
            //i.putExtras(bundle);
            //i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            //context.startActivity(i);
            pushNewActivityAnimated(SuperActivity.top_instance, DaiJiBaiHuiHanActivity.class, SuperActivity.AnimConst.ANIMDIR_FROM_RIGHT, 0, bundle, -1);
        }
        else if (identiStr[0].equals("ClientPurchase"))
        {
            //Intent i = new Intent(context, ZiYouKeHuShangPinDingGouActivity.class);
            //i.putExtras(bundle);
            //i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            //context.startActivity(i);
            pushNewActivityAnimated(SuperActivity.top_instance, ZiYouKeHuShangPinDingGouActivity.class, SuperActivity.AnimConst.ANIMDIR_FROM_RIGHT, 0, bundle, -1);
        }
        else if (identiStr[0].equals("VisitReserve"))
        {
            //Intent i = new Intent(context, YuYueCanGuanChaXunActivity.class);
            //i.putExtras(bundle);
            //i.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
            //context.startActivity(i);
            pushNewActivityAnimated(SuperActivity.top_instance, YuYueCanGuanChaXunActivity.class, SuperActivity.AnimConst.ANIMDIR_FROM_RIGHT, 0, bundle, -1);
        }

//		if (MainActivity.isForeground) {
//			String message = bundle.getString(JPushInterface.EXTRA_MESSAGE);
//			String extras = bundle.getString(JPushInterface.EXTRA_EXTRA);
//			Intent msgIntent = new Intent(MainActivity.MESSAGE_RECEIVED_ACTION);
//			msgIntent.putExtra(MainActivity.KEY_MESSAGE, message);
////			if (!ExampleUtil.isEmpty(extras)) {
////				try {
////					JSONObject extraJson = new JSONObject(extras);
////					if (null != extraJson && extraJson.length() > 0) {
////						msgIntent.putExtra(MainActivity.KEY_EXTRAS, extras);
////					}
////				} catch (JSONException e) {
////
////				}
////
////			}
//			context.sendBroadcast(msgIntent);
//		}
    }
}
