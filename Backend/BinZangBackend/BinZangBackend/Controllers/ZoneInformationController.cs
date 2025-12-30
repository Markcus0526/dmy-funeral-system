using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using System.Collections;
using System.Text.RegularExpressions;
using System.Globalization;
using BinZangBackend.Models;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Web.Hosting;

namespace BinZangBackend.Controllers
{
    public class ZoneInformationController : Controller
    {
        //
        // GET: /ZoneInformation/
        #region  页面
        [Authorize]
        public ActionResult ADragonService()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ADragonService";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "一条龙服务";
            ViewData["t3"] = "";
            ViewBag.chengshi = new ZoneInformation().GetAllChengshi();
            //ViewData["level3nav"] = "Staff";
            return View();
        }
             [Authorize]
        public ActionResult AddADragon()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ADragonService";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "一条龙服务";
            ViewData["t3"] = "添加服务";
            ViewBag.chengshi = new ZoneInformation().GetAllChengshi();
            //ViewData["level3nav"] = "Staff";
            return View();
        }
              [Authorize]
        public ActionResult SeeADragon(int makeid, long uid)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ADragonService";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "一条龙服务";
            ViewData["t3"] = "服务详情";
            ViewBag.chengshi1 = new ZoneInformation().GetAllChengshi();
            yitiaolong ytl= new ZoneInformation().GetOneADragon(makeid, uid);
            ViewBag.adragon = ytl;
            ViewData["makeid"] = makeid;
            ViewData["chengshi"] = new ZoneInformation().Getquyu(ytl.quyu_id).chengshi_id;
            //ViewData["level3nav"] = "Staff";
            return View();
        }
             [Authorize]
        public ActionResult OfficeManagement()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "OfficeManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "办事处管理";
            ViewData["t3"] = "";
            ViewBag.chengshi = new ZoneInformation().GetAllChengshi();
            //ViewData["level3nav"] = "Staff";
            return View();
        }
            [Authorize]
        public ActionResult AddOffice()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "OfficeManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "办事处管理";
            ViewData["t3"] = "办事处增加";
            ViewBag.chengshi = new ZoneInformation().GetAllChengshi();
            //ViewData["level3nav"] = "Staff";
            return View();
        }
             [Authorize]
        public ActionResult SeeOffice(int makeid,long uid)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "OfficeManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "办事处管理";
            ViewData["t3"] = "办事处详情";
            ViewBag.chengshi= new ZoneInformation().GetAllChengshi();
            ViewBag.office = new ZoneInformation().GetOneOffice(makeid,uid);
            ViewData["makeid"] = makeid;
            //ViewData["level3nav"] = "Staff";
            return View();
        }
        [Authorize]
        public ActionResult ActivityManagement()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ActivityManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区活动管理";
            ViewData["t3"] = "";
            //ViewData["level3nav"] = "Staff";
            return View();
        }
         [Authorize] 
        public ActionResult AddActivity()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ActivityManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区活动管理";
            ViewData["t3"] = "添加活动";
            //ViewData["level3nav"] = "Staff";
            return View();
        }
      [Authorize]
        public ActionResult SeeActivity(int makeid,long uid)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ActivityManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区活动管理";
            ViewData["t3"] = "活动详情";
            scenery scen = new scenery();
           
            scen = new ZoneInformation().SeeScenery(uid);
            ViewData["content"] = scen.html_content;
            ViewData["activityname"] = scen.name;
            ViewData["activityurl"] = scen.imgurl;
            ViewData["makeid"] =makeid;
            ViewData["uid"] = uid;
            //ViewData["level3nav"] = "Staff";
            return View();
        }
          [Authorize]  
        public ActionResult ActivityNotice()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ActivityNotice";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区通知管理";
            ViewData["t3"] = "";
            //ViewData["level3nav"] = "Staff";
            return View();
        }
            [Authorize]
        public ActionResult AddNotice()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ActivityNotice";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区通知管理";
            ViewData["t3"] = "园区通知添加";
            //ViewData["level3nav"] = "Staff";
            return View();
        }
      [Authorize]
        public ActionResult SeeNotice(int makeid, long uid)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ActivityNotice";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区通知管理";
            ViewData["t3"] = "园区通知详情";
            //ViewData["level3nav"] = "Staff";
            tomb_activity ta= new ZoneInformation().SeeNotice(uid);
            ViewData["content"] = ta.contents;
            ViewData["activityname"] = ta.title;
            ViewData["activityurl"] = ta.img_url;
            ViewData["noticetype"] = ta.category;
            ViewData["starttime"]=ta.starttime;
            ViewData["endtime"] = ta.endtime;
            ViewData["makeid"] = makeid;
            ViewData["uid"] = uid;
            //ViewData["level3nav"] = "Staff";
            return View();
        }
              [Authorize]
        public ActionResult CompanyProfile()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "EditZoneInformation";
            ViewData["level3nav"] = "CompanyProfile";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区信息修改";
            ViewData["t3"] = "";
            ViewBag.allxisu = new ZoneInformation().GetAllXisu();
            ViewData["gongsijianjie"] = new ZoneInformation().GetContents("gongsijianjie");
            ViewData["goumuliucheng"] = new ZoneInformation().GetContents("goumuliucheng");
            ViewData["goumuzhuyishixiang"] = new ZoneInformation().GetContents("goumuzhuyishixiang");
            ViewData["bingzanglink"] = new ZoneInformation().GetluozangLink().url;
            ViewData["luozangxisu"] = "%3Ch1%20style%3D%22text-align%3Acenter%3B%22%3E%0A%09%3Cbr%20/%3E%0A%3C/h1%3E%0A%3Ch1%20style%3D%22text-align%3Acenter%3B%22%3E%0A%09%3Cbr%20/%3E%0A%3C/h1%3E%0A%3Ch1%20style%3D%22text-align%3Acenter%3B%22%3E%0A%09%3Cbr%20/%3E%0A%3C/h1%3E%0A%3Ch1%20style%3D%22text-align%3Acenter%3B%22%3E%0A%09%3Cbr%20/%3E%0A%3C/h1%3E%0A%3Ch1%20style%3D%22text-align%3Acenter%3B%22%3E%0A%09%3Cstrong%3E%3Cspan%20style%3D%22font-family%3A%27Arial%20Black%27%3Bfont-size%3A36px%3B%22%3E%u8BF7%u5728%u53F3%u8FB9%u9009%u62E9%u8981%u7F16%u8F91%u7684%u843D%u846C%u4E60%u4FD7%3C/span%3E%3C/strong%3E%20%0A%3C/h1%3E";
            ViewData["curl"] = new ZoneInformation().Getcompany("gongsijianjie");
            ViewData["phone"] = new ZoneInformation().GetEnviron("fuwurexian");
            return View();
        }
            [Authorize]  
        public ActionResult CemeteryManagement()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ZoneGoods";
            ViewData["level3nav"] = "CemeteryManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区商品";
            ViewData["t3"] = "墓地类管理";
            ViewBag.zone = new ZoneInformation().GetAllzone();
            ViewBag.vrzone = new ZoneInformation().GetAllVrenzone();
            return View();
        }
              [Authorize]
        public ActionResult AddCemetery()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ZoneGoods";
            ViewData["level3nav"] = "CemeteryManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区商品";
            ViewData["t3"] = "墓地添加";
            ViewBag.zone = new ZoneInformation().GetAllzone();
           
            //ViewData["level3nav"] = "Staff";
            return View();
        }
         [Authorize]
        public ActionResult AddVren()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ZoneGoods";
            ViewData["level3nav"] = "CemeteryManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区商品";
            ViewData["t3"] = "牌位添加";
            ViewBag.zone = new ZoneInformation().GetAllVrenzone();
            //ViewData["level3nav"] = "Staff";
            return View();
        }

            [Authorize]

        public ActionResult ServiceManagement()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ZoneGoods";
            ViewData["level3nav"] = "ServiceManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区商品";
            ViewData["t3"] = "服务类商品";
            ViewBag.allluozang = new ZoneInformation().GetAllLuo();
            ViewData["daijibai"] = new ZoneInformation().GetContents("daijibai");
            ViewData["jipindaigou"] = new ZoneInformation().GetContents("jipindaigou");
            return View();
        }
             [Authorize]
        public ActionResult SacrificeManagement()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ZoneGoods";
            ViewData["level3nav"] = "SacrificeManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区商品";
            ViewData["t3"] = "祭拜用品管理";
            return View();
        }
              [Authorize]
        public ActionResult AddSacrifice()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ZoneGoods";
            ViewData["level3nav"] = "SacrificeManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区商品";
            ViewData["t3"] = "祭拜用品管理";
            ViewBag.fahui = new ZoneInformation().GetAllfahui();
            return View();
        }
              [Authorize]
        public ActionResult ZoneManage()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ZoneManage";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区管理";
            return View();
        }
          [Authorize]
        public ActionResult AddZone()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ZoneManage";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区管理";
            ViewData["t3"] = "添加园区";
            string basePath = HostingEnvironment.MapPath("~/");
            Image orgimg = Image.FromFile(basePath + "Content/img/qimg.jpg");
            int orgWidth = orgimg.Width;
            int orgHeight = orgimg.Height;
            float disWidth = 800, disHeight = 600, disRatio = 1;

            if (disWidth >= orgWidth && orgHeight <= disHeight)
            {
                disWidth = orgWidth;
                disHeight = orgHeight;
            }
            else
            {
                if (orgWidth >= orgHeight)
                {
                    disRatio = orgWidth / disWidth;
                    disHeight = orgHeight / disRatio;
                }
                else
                {
                    disRatio = orgHeight / disHeight;
                    disWidth = orgWidth / disRatio;
                }
            }

            orgimg.Dispose();

            ViewData["disWidth"] = disWidth;
            ViewData["disHeight"] = disHeight;
            ViewData["disRatio"] = disRatio;
            string basePath2 = HostingEnvironment.MapPath("~/");
            Image orgimg2 = Image.FromFile(basePath + "Content/img/qimg.jpg");
            int orgWidth2 = orgimg2.Width;
            int orgHeight2 = orgimg2.Height;
            float disWidth2 = 800, disHeight2 = 600, disRatio2 = 1;

            if (disWidth2 >= orgWidth2 && orgHeight2 <= disHeight2)
            {
                disWidth2 = orgWidth2;
                disHeight2 = orgHeight2;
            }
            else
            {
                if (orgWidth2 >= orgHeight2)
                {
                    disRatio2 = orgWidth2 / disWidth2;
                    disHeight2 = orgHeight2 / disRatio2;
                }
                else
                {
                    disRatio2 = orgHeight2 / disHeight2;
                    disWidth2 = orgWidth2 / disRatio2;
                }
            }
            
            orgimg.Dispose();
            ViewData["disWidth2"] = disWidth2;
            ViewData["disHeight2"] = disHeight2;
            ViewData["disRatio2"] = disRatio2;
            return View();
        }
        public ActionResult EditZone(long uid)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ZoneManage";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区管理";
            ViewData["t3"] = "园区编辑";
            tomb_area ta=new ZoneInformation().GetZone( uid);
            ViewBag.Zone = ta;
           
            string basePath = HostingEnvironment.MapPath("~/");
            Image orgimg = Image.FromFile(basePath + "Content/img/qimg.jpg");
            int orgWidth = orgimg.Width;
            int orgHeight = orgimg.Height;
            float disWidth = 800, disHeight = 600, disRatio = 1;

            if (disWidth >= orgWidth && orgHeight <= disHeight)
            {
                disWidth = orgWidth;
                disHeight = orgHeight;
            }
            else
            {
                if (orgWidth >= orgHeight)
                {
                    disRatio = orgWidth / disWidth;
                    disHeight = orgHeight / disRatio;
                }
                else
                {
                    disRatio = orgHeight / disHeight;
                    disWidth = orgWidth / disRatio;
                }
            }

            orgimg.Dispose();

            ViewData["disWidth"] = disWidth;
            ViewData["disHeight"] = disHeight;
            ViewData["disRatio"] = disRatio;
            string basePath2 = HostingEnvironment.MapPath("~/");
            Image orgimg2 = Image.FromFile(basePath + "Content/img/qimg.jpg");
            int orgWidth2 = orgimg2.Width;
            int orgHeight2 = orgimg2.Height;
            float disWidth2 = 800, disHeight2 = 600, disRatio2 = 1;

            if (disWidth2 >= orgWidth2 && orgHeight2 <= disHeight2)
            {
                disWidth2 = orgWidth2;
                disHeight2 = orgHeight2;
            }
            else
            {
                if (orgWidth2 >= orgHeight2)
                {
                    disRatio2 = orgWidth2 / disWidth2;
                    disHeight2 = orgHeight2 / disRatio2;
                }
                else
                {
                    disRatio2 = orgHeight2 / disHeight2;
                    disWidth2 = orgWidth2 / disRatio2;
                }
            }

            orgimg.Dispose();
            ViewData["disWidth2"] = disWidth2;
            ViewData["disHeight2"] = disHeight2;
            ViewData["disRatio2"] = disRatio2;
            return View();
        }
        public ActionResult SeeSacrifice(int makeid, long uid)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "ZoneInformation";
            ViewData["level2nav"] = "ZoneGoods";
            ViewData["level3nav"] = "SacrificeManagement";
            ViewData["t1"] = "园区信息";
            ViewData["t2"] = "园区商品";
            ViewData["t3"] = "祭拜用品管理";
            ViewBag.fahui = new ZoneInformation().GetAllfahui();
            sacrifice sac = new ZoneInformation().GetOnesacrifice(makeid, uid);
            ViewData["fahuiid"] = sac.tombactivity_id;
            ViewBag.sacrifice = sac;
            ViewData["makeid"] = makeid;
            return View();
        }
        #endregion
        #region  编辑器图片上传
        [Authorize]
        public ActionResult UploadKindEditorImageT()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            string savePath = "/Content/EditZoneInformation/";
            string saveUrl = "/Content/EditZoneInformation/";
            string fileTypes = "gif,jpg,jpeg,png,bmp";
            int maxSize = 8000000;   //800k

            Hashtable hash = new Hashtable();


            long merchantUid = 11;

            //try
            //{
            //    merchantUid = long.Parse(rootUri.Split('.')[0]);
            //}
            //catch (System.Exception ex)
            //{

            //}

            string datelbl = String.Format("{0:yyyyMMdd}", DateTime.Now);
            string tempPath = Server.MapPath(savePath) + merchantUid.ToString() + "\\" + datelbl;

            if (!System.IO.Directory.Exists(tempPath))
            {
                System.IO.Directory.CreateDirectory(tempPath);
            }

            savePath = savePath + merchantUid.ToString() + "/" + datelbl + "/";
            saveUrl = savePath;

            HttpPostedFileBase file = Request.Files["imgFile"];
            if (file == null)
            {
                hash = new Hashtable();
                hash["error"] = 1;
                hash["message"] = "请选择文件";
                return Json(hash, "text/html;charset=UTF-8");
            }

            string dirPath = Server.MapPath(savePath);
            if (!Directory.Exists(dirPath))
            {
                hash = new Hashtable();
                hash["error"] = 1;
                hash["message"] = "上传目录不存在";
                return Json(hash, "text/html;charset=UTF-8");
            }

            string fileName = file.FileName;
            string fileExt = Path.GetExtension(fileName).ToLower();

            ArrayList fileTypeList = ArrayList.Adapter(fileTypes.Split(','));

            if (file.InputStream == null || file.InputStream.Length > maxSize)
            {
                hash = new Hashtable();
                hash["error"] = 1;
                hash["message"] = "上传文件大小超过限制";
                return Json(hash, "text/html;charset=UTF-8");
            }

            if (string.IsNullOrEmpty(fileExt) || Array.IndexOf(fileTypes.Split(','), fileExt.Substring(1).ToLower()) == -1)
            {
                hash = new Hashtable();
                hash["error"] = 1;
                hash["message"] = "上传文件扩展名是不允许的扩展名";
                return Json(hash, "text/html;charset=UTF-8");
            }

            string newFileName = Path.GetFileNameWithoutExtension(fileName) + "_" + DateTime.Now.ToString("yyyyMMddHHmmss_ffff", DateTimeFormatInfo.InvariantInfo) + fileExt;
            string filePath = dirPath + newFileName;
            file.SaveAs(filePath);
            string fileUrl = saveUrl + newFileName;

            hash = new Hashtable();
            hash["error"] = 0;
            hash["url"] = fileUrl;

            return Json(hash, "text/html;charset=UTF-8");
        }
              [Authorize]
        public ActionResult ProcessKindEditorRequestT()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            //String aspxUrl = context.Request.Path.Substring(0, context.Request.Path.LastIndexOf("/") + 1);

            //根目录路径，相对路径
            String rootPath = "/Content/EditZoneInformation/";
            //根目录URL，可以指定绝对路径，
            String rootUrl = "/Content/EditZoneInformation/";

            long merchantUid = 11;

            //try
            //{
            //    merchantUid = long.Parse(rootUri.Split('.')[0]);
            //}
            //catch (System.Exception ex)
            //{

            //}

            string datelbl = String.Format("{0:yyyyMMdd}", DateTime.Now);
            string tempPath = Server.MapPath(rootPath) + merchantUid.ToString() + "\\" + datelbl;

            if (!System.IO.Directory.Exists(tempPath))
            {
                System.IO.Directory.CreateDirectory(tempPath);
            }

            rootPath = rootPath + merchantUid.ToString() + "/";
            rootUrl = rootPath;

            //图片扩展名
            String fileTypes = "gif,jpg,jpeg,png,bmp";

            String currentPath = "";
            String currentUrl = "";
            String currentDirPath = "";
            String moveupDirPath = "";

            //根据path参数，设置各路径和URL
            String path = Request.QueryString["path"];
            path = String.IsNullOrEmpty(path) ? "" : path;
            if (path == "")
            {
                currentPath = Server.MapPath(rootPath);
                currentUrl = rootUrl;
                currentDirPath = "";
                moveupDirPath = "";
            }
            else
            {
                currentPath = Server.MapPath(rootPath) + path;
                currentUrl = rootUrl + path;
                currentDirPath = path;
                moveupDirPath = Regex.Replace(currentDirPath, @"(.*?)[^\/]+\/$", "$1");
            }

            //排序形式，name or size or type
            String order = Request.QueryString["order"];
            order = String.IsNullOrEmpty(order) ? "" : order.ToLower();

            //不允许使用..移动到上一级目录
            if (Regex.IsMatch(path, @"\.\."))
            {
                Response.Write("Access is not allowed.");
                Response.End();
            }
            //最后一个字符不是/
            if (path != "" && !path.EndsWith("/"))
            {
                Response.Write("Parameter is not valid.");
                Response.End();
            }
            //目录不存在或不是目录
            if (!Directory.Exists(currentPath))
            {
                Response.Write("Directory does not exist.");
                Response.End();
            }

            //遍历目录取得文件信息
            string[] dirList = Directory.GetDirectories(currentPath);
            string[] fileList = Directory.GetFiles(currentPath);

            switch (order)
            {
                case "size":
                    Array.Sort(dirList, new NameSorter());
                    Array.Sort(fileList, new SizeSorter());
                    break;
                case "type":
                    Array.Sort(dirList, new NameSorter());
                    Array.Sort(fileList, new TypeSorter());
                    break;
                case "name":
                default:
                    Array.Sort(dirList, new NameSorter());
                    Array.Sort(fileList, new NameSorter());
                    break;
            }

            Hashtable result = new Hashtable();
            result["moveup_dir_path"] = moveupDirPath;
            result["current_dir_path"] = currentDirPath;
            result["current_url"] = currentUrl;
            result["total_count"] = dirList.Length + fileList.Length;
            List<Hashtable> dirFileList = new List<Hashtable>();
            result["file_list"] = dirFileList;
            for (int i = 0; i < dirList.Length; i++)
            {
                DirectoryInfo dir = new DirectoryInfo(dirList[i]);
                Hashtable hash = new Hashtable();
                hash["is_dir"] = true;
                hash["has_file"] = (dir.GetFileSystemInfos().Length > 0);
                hash["filesize"] = 0;
                hash["is_photo"] = false;
                hash["filetype"] = "";
                hash["filename"] = dir.Name;
                hash["datetime"] = dir.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss");
                dirFileList.Add(hash);
            }
            for (int i = 0; i < fileList.Length; i++)
            {
                FileInfo file = new FileInfo(fileList[i]);
                Hashtable hash = new Hashtable();
                hash["is_dir"] = false;
                hash["has_file"] = false;
                hash["filesize"] = file.Length;
                hash["is_photo"] = (Array.IndexOf(fileTypes.Split(','), file.Extension.Substring(1).ToLower()) >= 0);
                hash["filetype"] = file.Extension.Substring(1);
                hash["filename"] = file.Name;
                hash["datetime"] = file.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss");
                dirFileList.Add(hash);
            }
            //Response.AddHeader("Content-Type", "application/json; charset=UTF-8");
            //context.Response.Write(JsonMapper.ToJson(result));
            //context.Response.End();
            return Json(result, "text/html;charset=UTF-8", JsonRequestBehavior.AllowGet);
        }
         #endregion
        #region  园区信息修改
        public JsonResult UpdateProfile(String introduce,string img,string phone)
        {
            bool success = new ZoneInformation().UpdateProfile(introduce,img,phone);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateFlow(String introduce)
        {
            bool success = new ZoneInformation().UpdateFlow(introduce);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateDaiJiBai(String introduce)
        {
            bool success = new ZoneInformation().UpdateDaiJiBai(introduce);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateJiPinDaiGou(String introduce)
        {
            bool success = new ZoneInformation().UpdateJiPinDaiGou(introduce);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateMatters(String introduce)
        {
            bool success = new ZoneInformation().UpdateMatters(introduce);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateXisu(long uid,string xisuname,String introduce)
        {
            bool success = new ZoneInformation().UpdateXisu(uid, xisuname, introduce);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult LuozangLink(String link)
        {
            bool success = new ZoneInformation().LuozangLink(link);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Getonexisu(long uid)
        {
            information ifm = new information();
            ifm = new ZoneInformation().Getonexisu(uid);
            return Json(ifm, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Getoneluozang(long uid)
        {
            tomb_service ifm = new tomb_service();
            ifm = new ZoneInformation().Getoneluozang(uid);
            return Json(ifm, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetAllxisu()
        {
            List<information> list = new List<information>();
            list =new ZoneInformation().GetAllXisu();
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetAllluozang()
        {
            List<tomb_service> list = new List<tomb_service>();
            list = new ZoneInformation().GetAllLuo();
            return Json(list, JsonRequestBehavior.AllowGet);
        }
         #endregion
        #region  园区活动
        public JsonResult InsertActivity(string activityname, string imageurl, string introduce) 
        {
           bool success=false;
           success = new ZoneInformation().InsertActivity(activityname,imageurl,introduce);
           return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateActivity(long uid, string activityname, string imageurl, string introduce)
        {
            bool success = false;
            success = new ZoneInformation().UpdateActivity(uid, activityname, imageurl, introduce);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SerchActivity(string activityname, int? sEcho)
        {
            JqDataTableInfo list = new JqDataTableInfo();
            list = new ZoneInformation().SerchActivity(activityname, sEcho);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DelActivity(long uid)
        {
            bool success = false;
            success = new ZoneInformation().DelActivity(uid);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region  园区通知
        public JsonResult InsertNote(string notename, string imgurl, string activitytype, string starttime, string endtime, string introduce)
        {
            bool success = false;
            success = new ZoneInformation().InsertNote(notename, imgurl, activitytype, starttime, endtime, introduce);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateNote(long uid,string notename, string imgurl, string activitytype, string starttime, string endtime, string introduce)
        {
            bool success = false;
            success = new ZoneInformation().UpdateNote(uid,notename, imgurl, activitytype, starttime, endtime, introduce);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
       
       
        public JsonResult SerchNotice(string notename, string notetype, int? sEcho)
        {
            JqDataTableInfo list = new JqDataTableInfo();
            list = new ZoneInformation().SerchNotice(notename, notetype, sEcho);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
       
        public JsonResult DelNotice(long uid)
        {
            bool success = false;
            success = new ZoneInformation().DelNotice(uid);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetSamePoint(String lng, string lat)
        {
            bool success = false;
            success = new ZoneInformation().GetSamePoint(lng, lat);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetADrgonSamePoint(String lng, string lat)
        {
            bool success = false;
            success = new ZoneInformation().GetADrgonSamePoint(lng, lat);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region  办事处
        public JsonResult InserOffice(string officename, string img, string officehead, string subchief, string phone, string area, string suggestId, string lng, string lat)
        {
            bool success=false;
            success = new ZoneInformation().InserOffice(officename, img, officehead, subchief, phone, area, suggestId, lng, lat);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SerchOffice(string officename,long area ,int? sEcho)
        {
            JqDataTableInfo list = new JqDataTableInfo();
            list = new ZoneInformation().SerchOffice(officename,area, sEcho);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateOffice(long uid,string officename, string img, string officehead, string subchief, string phone, string area, string suggestid, string lng, string lat)
        {
            bool success = false;
            success = new ZoneInformation().UpdateOffice(uid,officename, img, officehead, subchief, phone, area, suggestid, lng, lat);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DelOffice(long uid)
        {
            bool success = false;
            success = new ZoneInformation().DelOffice(uid);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Getarea(long uid)
        {
            List<quyu> list = new List<quyu>();
            list = new ZoneInformation().Getarea(uid);
            return Json(list, JsonRequestBehavior.AllowGet); 
        }
        #endregion
        #region  一条龙服务
        public JsonResult InserADragon(string cname, string img, string price,string approve, string phone, string area, string suggestId, string lng, string lat,string contents,string cdetail,string productdetail)
        {
            bool success = false;
            success = new ZoneInformation().InserADragon(cname, img, price, approve, phone, area, suggestId, lng, lat, contents, cdetail, productdetail);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateADragon(long uid,string cname, string img, string price, string approve, string phone, string area, string suggestId, string lng, string lat, string contents, string cdetail, string productdetail)
        {
            bool success = false;
            success = new ZoneInformation().UpdateADragon(uid,cname, img, price, approve, phone, area, suggestId, lng, lat, contents, cdetail, productdetail);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SerchADagon(string cname,long chengshi,long area, int? sEcho)
        {
            JqDataTableInfo list = new JqDataTableInfo();
            list = new ZoneInformation().SerchADagon(cname, chengshi, area, sEcho);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DelADragon(long uid)
        {
            bool success = false;
            success = new ZoneInformation().DelADragon(uid);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Operateluozang(string sname, string uid, int price, string img, string img2, string servicedetail)
        {
            bool success = false;
            success = new ZoneInformation().Operateluozang(sname, uid, price, img, img2, servicedetail);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region  祭拜用品管理
        public JsonResult InserSacrifice(string pname, string img, string price, string ptype, long fahuiactivity, string pdetail)
        {

            bool success = false;
            success = new ZoneInformation().InserSacrifice(pname,  img,  price,  ptype,  fahuiactivity,  pdetail);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateSacrifice(long uid,string pname, string img, string price, string ptype, long fahuiactivity, string pdetail)
        {

            bool success = false;
            success = new ZoneInformation().UpdateSacrifice(uid,pname, img, price, ptype, fahuiactivity, pdetail);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SerchSacrifice(string pname, string price, string ptype, int? sEcho)
        {
            JqDataTableInfo list = new JqDataTableInfo();
            list = new ZoneInformation().SerchSacrifice(pname, price, ptype, sEcho);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult GetOneZone(long uid)
        {

            tomb_area ta = new ZoneInformation().GetOneZone(uid);
            return Json(ta, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DelSacrifice(long uid)
        {
            bool success = false;
            success = new ZoneInformation().DelSacrifice(uid);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region  墓地管理
        public JsonResult InserCemetery(long zonename, string img, string price, string ctype, int cpai, int clie, string cnum)
        {

            bool success = false;
            success = new ZoneInformation().InserCemetery(zonename, img, price, ctype, cpai, clie, cnum);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SerchCemmetery(long zonename, int cpai, int clie, int? sEcho)
        {
            JqDataTableInfo list = new JqDataTableInfo();
            list = new ZoneInformation().SerchCemmetery(zonename, cpai, clie, sEcho);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdatePrice(long zonename1, int zpai, int mprice)
        {
            bool success = false;
            success = new ZoneInformation().UpdatePrice(zonename1, zpai, mprice);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult EditCemetery(long uid)
        {
            int status = 0;
            status = new ZoneInformation().EditCemetery(uid);
            List<long> list = new List<long>();
            list.Add(status);
            list.Add(uid);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult yanzheng(long uid,string yname,string yphone)
        {
            bool success = false;
            success = new ZoneInformation().yanzheng(uid,yname,yphone);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Getdays(int price)
        {
            int days = 0;
            days = new ZoneInformation().Getdays(price);
            return Json(days, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateCemetery(long uid,int statusnum,string bname,string bphone,string rname,string rphone,string bmname1,string bmname2,string bfname1,string bfname2,string bprice,string bdays,int upstatus)
        {
            int success = 0;
            success=new ZoneInformation().UpdateCemetery(uid,statusnum,bname,bphone,rname,rphone,bmname1,bmname2,bfname1,bfname2,bprice,bdays,upstatus);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region  园区管理
        public JsonResult InserZone(string zonename, string img, string zonetype, string paishu, string lieshu, string quyushu, string contents, double xpos, double ypos)
        {
            bool success = false;
            success = new ZoneInformation().InserZone(zonename, img, zonetype, paishu, lieshu, quyushu, contents, xpos, ypos);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdateZone(long uid, string zonename, string img, string zonetype, string paishu, string lieshu, string quyushu, string contents, double xpos, double ypos)
        {
            bool success = false;
            success = new ZoneInformation().UpdateZone(uid, zonename, img, zonetype, paishu, lieshu, quyushu, contents, xpos, ypos);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SerchZone(string zonename, string zonetype, int? sEcho)
        {
            JqDataTableInfo list = new JqDataTableInfo();
            list = new ZoneInformation().SerchZone(zonename, zonetype, sEcho);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DelZone(long uid)
        {
            bool success = false;
            success = new ZoneInformation().DelZone(uid);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region  牌位管理
        public JsonResult InserVren(long zonename, string img, string price, string quyu, int cpai, int clie, string cnum)
        {

            bool success = false;
            success = new ZoneInformation().InserVren(zonename, img, price, quyu, cpai, clie, cnum);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult SerchVren(long vrzonename, int vrpaishu, int vrlieshu, string qushu, int? sEcho)
        {
            JqDataTableInfo list = new JqDataTableInfo();
            list = new ZoneInformation().SerchVren(vrzonename, vrpaishu, vrlieshu,qushu, sEcho);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult EditPaiWei(long uid)
        {
            int status = 0;
            status = new ZoneInformation().EditPaiWei(uid);
            List<long> list = new List<long>();
            list.Add(status);
            list.Add(uid);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdatePwPrice(long pwzone,string pwzonenum, int pwpaishu, int pwprice)
        {
            bool success = false;
            success = new ZoneInformation().UpdatePwPrice(pwzone,pwzonenum, pwpaishu,pwprice);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult UpdatePaiWei(long uid, int statusnum, string bname, string bphone, string rname, string rphone, string bmname1, string bmname2, string bfname1, string bfname2, string bprice, string bdays, int upstatus)
        {
            int success = 0;
            success = new ZoneInformation().UpdatePaiWei(uid, statusnum, bname, bphone, rname, rphone, bmname1, bmname2, bfname1, bfname2, bprice, bdays, upstatus);
            return Json(success, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Getpw(long uid)
        {
            tomb_area ta = new ZoneInformation().GetZone(uid);
            List<string> quyulist = new List<string>();
            List<string> pwpailist = new List<string>();
            List<string> pwlielist = new List<string>();
            if (ta.area_size != null && ta.area_size != "")
            {
                string[] pw = ta.area_size.Split(',');
                for (int i = 0; i < pw.Length - 1; i++)
                {
                    quyulist.Add(pw[i].Split(':')[0]);
                    pwpailist.Add(pw[i].Split(':')[1]);
                    pwlielist.Add(pw[i].Split(':')[2]);
                }
            }
            List<List<string>> list = new List<List<string>>();
            list.Add(quyulist);
            list.Add(pwpailist);
            list.Add(pwlielist);
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        public JsonResult Getpwqu(long quname)
        {
            List<string> list = new List<string>();
            list=new ZoneInformation().Getpwqu(quname);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Getpwqupai(string quname, long zonename)
        {
            List<int> list = new List<int>();
            list = new ZoneInformation().Getpwqupai( quname,  zonename);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region  上传图片
        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult UploadifyActivityImage(HttpPostedFileBase Filedata)
        {
            if (Filedata != null)
            {
                try
                {
                    // 文件上传后的保存路径
                    string filePath = Server.MapPath("~/Content/ActivityImage/");
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    string fileName = Path.GetFileName(Filedata.FileName);// 原始文件名称
                    string fileExtension = Path.GetExtension(fileName); // 文件扩展名
                    string saveName = Guid.NewGuid().ToString() + fileExtension; // 保存文件名称
                    Image imageFile = resizeImage(Image.FromStream(Filedata.InputStream, true, true), new Size { Height = 200, Width = 200 });
                    //imageFile.Save(Server.MapPath(file));
                    imageFile.Save(filePath + saveName);
                    //List<string> list = new List<string>();
                    //list.Add("Content/ActivityImage/" + saveName);
                    //return Json(new { Success = true, FileName = fileName, SaveName = "Content/uploads/video/" + saveName }, JsonRequestBehavior.AllowGet);
                    return Json("Content/ActivityImage/" + saveName, JsonRequestBehavior.AllowGet);
                }
                catch (Exception ex)
                {
                    return Json(new { Success = false, Message = ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            else
            {

                return Json(new { Success = false, Message = "请选择要上传的文件！" }, JsonRequestBehavior.AllowGet);
            }
        }
        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult UploadifyServiceImage(HttpPostedFileBase Filedata)
        {
            if (Filedata != null)
            {
                try
                {
                    // 文件上传后的保存路径
                    string filePath = Server.MapPath("~/Content/ServiceImage/");
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    string fileName = Path.GetFileName(Filedata.FileName);// 原始文件名称
                    string fileExtension = Path.GetExtension(fileName); // 文件扩展名
                    string saveName = Guid.NewGuid().ToString() + fileExtension; // 保存文件名称
                    Filedata.SaveAs(filePath + saveName);
                   
                    return Json("Content/ServiceImage/" + saveName, JsonRequestBehavior.AllowGet);
                }
                catch (Exception ex)
                {
                    return Json(new { Success = false, Message = ex.Message }, JsonRequestBehavior.AllowGet);
                }
            }
            else
            {

                return Json(new { Success = false, Message = "请选择要上传的文件！" }, JsonRequestBehavior.AllowGet);
            }
        }
        #endregion
        #region  编辑器
        private static Image resizeImage(Image imgToResize, Size size)
        {
            int sourceWidth = imgToResize.Width;
            int sourceHeight = imgToResize.Height;

            float nPercent = 0;
            float nPercentW = 0;
            float nPercentH = 0;

            nPercentW = ((float)size.Width / (float)sourceWidth);
            nPercentH = ((float)size.Height / (float)sourceHeight);

            if (nPercentH < nPercentW)
                nPercent = nPercentH;
            else
                nPercent = nPercentW;

            int destWidth = (int)(sourceWidth * nPercent);
            int destHeight = (int)(sourceHeight * nPercent);

            Bitmap b = new Bitmap(destWidth, destHeight);
            Graphics g = Graphics.FromImage((Image)b);
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;

            g.DrawImage(imgToResize, 0, 0, destWidth, destHeight);
            g.Dispose();

            return (Image)b;
        }
    }
    public class NameSorter : IComparer
    {
        public int Compare(object x, object y)
        {
            if (x == null && y == null)
            {
                return 0;
            }
            if (x == null)
            {
                return -1;
            }
            if (y == null)
            {
                return 1;
            }
            FileInfo xInfo = new FileInfo(x.ToString());
            FileInfo yInfo = new FileInfo(y.ToString());

            return xInfo.FullName.CompareTo(yInfo.FullName);
        }
    }

    public class SizeSorter : IComparer
    {
        public int Compare(object x, object y)
        {
            if (x == null && y == null)
            {
                return 0;
            }
            if (x == null)
            {
                return -1;
            }
            if (y == null)
            {
                return 1;
            }
            FileInfo xInfo = new FileInfo(x.ToString());
            FileInfo yInfo = new FileInfo(y.ToString());

            return xInfo.Length.CompareTo(yInfo.Length);
        }
    }

    public class TypeSorter : IComparer
    {
        public int Compare(object x, object y)
        {
            if (x == null && y == null)
            {
                return 0;
            }
            if (x == null)
            {
                return -1;
            }
            if (y == null)
            {
                return 1;
            }
            FileInfo xInfo = new FileInfo(x.ToString());
            FileInfo yInfo = new FileInfo(y.ToString());

            return xInfo.Extension.CompareTo(yInfo.Extension);
        }
    }
}
        #endregion
