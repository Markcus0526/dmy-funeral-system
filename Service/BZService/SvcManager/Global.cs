using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;
using System.IO;
using System.Net;
using Newtonsoft.Json.Linq;
using System.Text.RegularExpressions;

namespace BZService.SvcManager
{
	public class Global
	{
		public static String log_name = "BinZang Source";
		public static String log_desc = "BinZang Log";

		public static EventLog eventLog = null;

		public static String getBasePath() { return ConfigurationManager.AppSettings["basePath"]; }
		public static String getImagePath() { return ConfigurationManager.AppSettings["uploadImagePath"]; }
		public static String getSiteUrl() { return ConfigurationManager.AppSettings["siteUrl"]; }

		public const int PAGEITEM_COUNT = 10;


		public static void initEventLog()
		{
			if (eventLog != null)
				return;

			eventLog = new EventLog();
			eventLog.Log = log_desc;
			eventLog.Source = log_name;

			if (!EventLog.SourceExists(Global.log_name))
				EventLog.CreateEventSource(Global.log_name, Global.log_desc);
		}


		public static void logError(String szMsg)
		{
			if (eventLog == null)
				initEventLog();

			eventLog.Source = Global.log_name;
			eventLog.Log = Global.log_desc;
			eventLog.WriteEntry(szMsg, EventLogEntryType.Information);
		}


		public static String MD5Hash(String szValue)
		{
			MD5 md5Hasher = MD5.Create();

			byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(szValue));

			StringBuilder sBuilder = new StringBuilder();
			for (int i = 0; i < data.Length; i++)
			{
				sBuilder.Append(data[i].ToString("x2"));
			}

			return sBuilder.ToString();
		}


		public static String genRandCode(int len)
		{
			Random _rng = new Random();
			String _chars = "0123456789";
			char[] buffer = new char[len];

			for (int i = 0; i < len; i++)
				buffer[i] = _chars[_rng.Next(_chars.Length)];

			return new String(buffer);
		}



		public static String getAbsImgUrl(String url)
		{
			if (url == null || url.Equals(""))
				return "";

			return Global.getSiteUrl() + url;
		}


		public static String getAbsVoiceUrl(String url)
		{
			if (url == null || url.Equals(""))
				return "";

			return Global.getSiteUrl() + url;
		}

        public static string GetHtmlContent(string contents)
        {
            string strSymbol = "%22";   // escaped string of " character.
            string strAttachUrl = "/Content/";
            string strReplaced = contents.Replace(strSymbol + strAttachUrl, strSymbol + getSiteUrl() + strAttachUrl);

            return HttpUtility.UrlDecode(strReplaced, System.Text.Encoding.Default);
        }

		public static String ignoreNullStr(String value)
		{
			if (value == null)
				return "";

			return value;
		}


		public static DateTime getLowerBound(DateTime dtVal)
		{
			return new DateTime(dtVal.Year, dtVal.Month, dtVal.Day, 0, 0, 0);
		}


		public static DateTime getUpperBound(DateTime dtVal)
		{
			return new DateTime(dtVal.Year, dtVal.Month, dtVal.Day, 23, 59, 59);
		}


		public static String getParentDir(String szPath)
		{
			String szParentDir = szPath;

			szParentDir = szParentDir.Replace("\\", "/");
			int nIndex = szParentDir.LastIndexOf("/");

			if (nIndex > 0)
				szParentDir = szParentDir.Substring(0, nIndex);

			return szParentDir;
		}


		public static string saveImage(string szImageData)
		{
			if (szImageData == string.Empty || szImageData == null)
				return string.Empty;

			string szFileName = DateTime.Now.ToString("yyyyMMdd_HHmmss") + Global.genRandCode(2) + ".png";
			string filePath = getImagePath() + szFileName;

			try
			{
				byte[] imgData = Convert.FromBase64String(szImageData);

				string szFullPath = getBasePath() + filePath;
				string szTmpPath = szFullPath.Replace("/", "\\");
				string szDir = Global.getParentDir(szTmpPath);

				if (!File.Exists(szDir))
				{
					Directory.CreateDirectory(szDir);
				}

				File.WriteAllBytes(szFullPath, imgData);
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);
				filePath = string.Empty;
			}

			return filePath;
		}


		public static string saveIdImage(string szImageData, bool isFore)
		{
			if (szImageData == string.Empty || szImageData == null)
				return string.Empty;

			String szPrefix = isFore ? "idfore_" : "idback_";
			string szFileName = szPrefix + DateTime.Now.ToString("yyyyMMdd_HHmmss") + Global.genRandCode(2) + ".png";
			string filePath = getImagePath() + szFileName;

			try
			{
				byte[] imgData = Convert.FromBase64String(szImageData);

				string szFullPath = getBasePath() + filePath;
				string szTmpPath = szFullPath.Replace("/", "\\");
				string szDir = Global.getParentDir(szTmpPath);

				if (!File.Exists(szDir))
				{
					Directory.CreateDirectory(szDir);
				}

				File.WriteAllBytes(szFullPath, imgData);
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);
				filePath = string.Empty;
			}

			return filePath;
		}

		public static double calcDist(double flat1,
			double flng1,
			double flat2,
			double flng2,
			String start_city,
			String end_city)
		{
			String url = String.Empty;
			double fDist = 0;

			try
			{
				url = "http://api.map.baidu.com/direction/v1?";
				url += "mode=driving&output=json"
					+ "&origin=" + flat1.ToString() + "," + flng1.ToString()
					+ "&destination=" + flat2.ToString() + "," + flng2.ToString()
					+ "&origin_region=" + start_city
					+ "&destination_region=" + end_city
					+ "&ak=" + Global.getBaiduKey();

				WebClient client = new WebClient();
				HttpWebRequest http_request = (HttpWebRequest)HttpWebRequest.Create(url);
				HttpWebResponse response = (HttpWebResponse)http_request.GetResponse();
				using (StreamReader sr = new StreamReader(response.GetResponseStream()))
				{
					String responseJson = sr.ReadToEnd();

					JObject result = JObject.Parse(responseJson);

					Object objTemp = result["status"];
					int nStatus = Convert.ToInt32(objTemp);

					if (nStatus == 0)
					{
						objTemp = result["result"];

						JObject objResult = JObject.Parse(objTemp.ToString());
						JArray arrRoutes = JArray.Parse(objResult["routes"].ToString());
						if (arrRoutes.Count != 0)
						{
							JObject first_route = JObject.Parse(arrRoutes[0].ToString());
							String szDist = first_route["distance"].ToString();
							fDist = int.Parse(szDist);
							fDist = ((int)fDist / 100) / 10.0;
						}
					}
				}
			}
			catch (Exception ex)
			{
				Global.logError(ex.Message);
			}

			return fDist;
		}

		private static double deg2rad(double deg)
		{
			return (deg * Math.PI / 180.0);
		}


		private static double rad2deg(double rad)
		{
			return (rad / Math.PI * 180.0);
		}


		public static String convertDateToString(DateTime? dtVal, String szFormat)
		{
			if (dtVal == null)
				return String.Empty;

			return ((DateTime)dtVal).ToString(szFormat);
		}


		public static int getYearSpan(DateTime? dtStart, DateTime? dtEnd)
		{
			if (dtStart == null || dtEnd == null)
				return 0;

			return ((DateTime)dtEnd).Year - ((DateTime)dtStart).Year;
		}


		public static String getBaiduKey()
		{
			return "KfZXtzv4ZI3aMySr3Kc8Y0pg";
		}

        public static long getJPushTagIdForClient(long client_id)
        {
            return client_id + 100000;
        }
	}
}