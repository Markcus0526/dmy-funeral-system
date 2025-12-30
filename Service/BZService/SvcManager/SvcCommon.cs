using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using BZService.DBManager;

namespace BZService.SvcManager
{
	public class SvcCommon
	{
		public static String sendSMS(String mobile, String msg)
		{
			String sendurl = "http://smsapi.c123.cn/OpenPlatform/OpenApi";
			String ac = "1001@501041380001";									// User name
			String authkey = "F8F6EA00795F58253D03C79C49256CAB";				// Password
			String cgid = "2874";												// Channel ID
			String csid = "1";													// Default value
			String m = mobile;													// Mobile
			String c = msg;														// Send content
			String action = "sendOnce";

			StringBuilder sbTemp = new StringBuilder();

			// POST Method
			sbTemp.Append("action=" + action + "&ac=" + ac + "&authkey=" + authkey + "&m=" + m + "&cgid=" + cgid + "&csid=" + csid + "&c=" + c);
			byte[] bTemp = System.Text.Encoding.GetEncoding("utf-8").GetBytes(sbTemp.ToString());

			String postReturn = doPostRequest(sendurl, bTemp);

			Regex linkReg = new Regex("result=(.+)/>");
			MatchCollection linkCollection = linkReg.Matches(postReturn);
			string str = linkCollection[0].Groups[1].Value;
			str = str.Replace(">", "");

			return str.Replace("\"", "");
		}

		private static String doPostRequest(string url, byte[] bData)
		{
			System.Net.HttpWebRequest hwRequest;
			System.Net.HttpWebResponse hwResponse;

			string strResult = string.Empty;
			try
			{
				hwRequest = (System.Net.HttpWebRequest)System.Net.WebRequest.Create(url);
				hwRequest.Timeout = 5000;
				hwRequest.Method = "POST";
				hwRequest.ContentType = "application/x-www-form-urlencoded";
				hwRequest.ContentLength = bData.Length;

				System.IO.Stream smWrite = hwRequest.GetRequestStream();
				smWrite.Write(bData, 0, bData.Length);
				smWrite.Close();
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);
				return strResult;
			}

			// Get response
			try
			{
				hwResponse = (HttpWebResponse)hwRequest.GetResponse();
				StreamReader srReader = new StreamReader(hwResponse.GetResponseStream(), Encoding.ASCII);
				strResult = srReader.ReadToEnd();
				srReader.Close();
				hwResponse.Close();
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);
			}

			return strResult;
		}


		public static String createAccessToken(String user_name, String password, int platform, String device_token)
		{
			String result = String.Empty;


			// At first, create md5 hash strings. Encoding method can be changed as you need.
			String encoded_name = Global.MD5Hash(user_name + "," + user_name);
			String encoded_pwd = Global.MD5Hash(password + "," + password);
			String encoded_platform = platform.ToString();
			String encoded_devtoken = device_token;
			String curTime = Global.MD5Hash((DateTime.Now.Millisecond / 2).ToString());

			result = Global.MD5Hash(encoded_name
				+ encoded_pwd
				+ encoded_platform
				+ encoded_devtoken
				+ curTime);

			return result;
		}


		//
		// Summary:
		//     Method to verify user who called api
		//
		// Parameters:
		//   user_id:
		//     The uid field of the user table to specify user.
		//   check_sum:
		//     User uploaded checksum value.
		//   api_name:
		//     The api method name which is called by user.
		//
		// Returns:
		//     Empty string if verify success, the error description otherwise.
		//
		public static String verifyServiceConsumer(long user_id, String check_sum, String api_name)
		{
			String result = String.Empty;

			if (check_sum == null)
			{
				result = "Invalid checksum";
			}
			else
			{
                /*
				STUser user_info = SvcCommon.getUserInfoFromID(user_id);
				if (user_info == null)
				{
					result = "Invalid user id";
				}
				else
				{
					String checksum_service = SvcCommon.createCheckSum(user_info.access_token, api_name);
					if (!checksum_service.Equals(check_sum))
					{
						result = "Invalid checksum";
					}
				}
                 */
			}

			return result;
		}


		public static String createCheckSum(String access_token, String method_name)
		{
			if (method_name == null)
				method_name = "";

			String result = String.Empty;
			result = Global.MD5Hash(access_token + "," + method_name);
			return result;
		}


		//
		// Method to get user information specified by user_id from the DB
		//
		public static STUser getUserInfoFromID(long user_id)
		{
            BZDatabaseDataContext dbConn = null;
            dbConn = new BZDatabaseDataContext();

			STUser result = dbConn.clients
                .Where(m => m.uid == user_id && m.deleted == 0)
                .Select(m => new STUser
                {
                    uid = m.uid,
                    name = m.name,
                    phone = m.phone,
                    type = (int)ConstMgr.UserType.USER_TYPE_CUSTOMER,
                    access_token = m.access_token
                })
                .FirstOrDefault();

            if (result == null)
            {
                result = dbConn.users
                .Where(m => m.uid == user_id && m.deleted == 0)
                .Select(m => new STUser
                {
                    uid = m.uid,
                    name = m.name,
                    phone = m.phone,
                    type = m.type,
                    access_token = m.access_token
                })
                .FirstOrDefault();
            }
            /*
			result.uid = 1;
			result.name = "金学敏";
			result.phone = "13840030313";
			result.type = (int)ConstMgr.UserType.USER_TYPE_CUSTOMER;
			result.access_token = "923ca9aea0b333a7b53278e1f70e516c";
             */

			return result;
		}
	}
}