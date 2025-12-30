using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BinZangBackend.Models;
using System.Reflection;
using System.IO;
using System.Text.RegularExpressions;
using System.Globalization;
namespace BinZangBackend.Controllers
{
    public class OtherFeatureController : Controller
    {
        #region 跳转页面 

        /*
         * 注册用户审核
         */
              [Authorize]
        public ActionResult DiQuManage()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "RegistCheck";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "地区管理";
            ViewData["t3"] = "";
            ViewBag.citylist = new OtherFeatureModel().FindCityList();
            return View();
        }
        /*
       * 游戏上传
       */
              [Authorize]
        public ActionResult GameUpload()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "GameUpload";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "游戏上传";
            ViewData["t3"] = "";
            return View();
        }
        /*
       * 查看真奖金计算公式页面
       */
              [Authorize]
        public ActionResult TrueAwardCalculation()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "TrueAwardCalculation";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "真奖金计算公式";
            ViewData["t3"] = "";
            return View();
        }
        /*
      * 查看假奖金计算公式页面
      */
              [Authorize]
        public ActionResult FalseAwardCalculation()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "FalseAwardCalculation";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "假奖金计算公式";
            ViewData["t3"] = "";
            return View();
        }
        /*
       * 查看衣食住行管理页面
       */
              [Authorize]
        public ActionResult BasicLife()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "BasicLife";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "衣食住行管理";
            ViewData["t3"] = "";
            return View();
        }
        /*
       * 查看景点管理页面
       */
              [Authorize]
        public ActionResult ScenicSpots()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "ScenicSpots";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "旅游景点管理";
            ViewData["t3"] = "";
            return View();
        }
        /*
       * 查看责任额调度页面
       */
              [Authorize]
        public ActionResult CoverDispatch()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "CoverDispatch";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "责任额调整";
            ViewData["t3"] = "";
            ViewBag.citylist = new OtherFeatureModel().FindCityList();
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            return View();
        }
        /*
         * 查看注册用户管理的详细页面
         */
              [Authorize]
        public ActionResult RegistCheckDetails()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "RegistCheck";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "注册用户审核";
            ViewData["t3"] = "查看申请";
            return View();
        }
        /*
         * 查看景点管理的详细页面
         */
              [Authorize]
        public ActionResult ScenicSpotsDetails(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "ScenicSpots";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "旅游景点管理";
            ViewData["t3"] = "查看景点";
            jingdian jingdianinfo = new OtherFeatureModel().FindJingDianDetails(id);
            ViewData["name"] =jingdianinfo.name ;
            ViewData["address"] = jingdianinfo.address;
            ViewData["html_content"] = jingdianinfo.html_content;
            ViewData["phone"] = jingdianinfo.phone;
            ViewData["imgurl"] = jingdianinfo.imgurl;
            
            return View();
        }
        

        /*
         * 修改新增景点页面
         */
              [Authorize]
        public ActionResult EditSpotsDetails(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "ScenicSpots";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "旅游景点管理";
            ViewData["t3"] = "修改旅游景点";
            jingdian jingdianinfo = new OtherFeatureModel().FindJingDianDetails(id);
            ViewData["name"] = jingdianinfo.name;
            ViewData["address"] = jingdianinfo.address;
            ViewData["html_content"] = jingdianinfo.html_content;
            ViewData["phone"] = jingdianinfo.phone;
            ViewData["imgurl"] = jingdianinfo.imgurl;
            ViewData["id"] = jingdianinfo.uid;
            ViewData["lat"] = jingdianinfo.latitude;
            ViewData["lng"] = jingdianinfo.longitude;
            return View();
        }
         /*
         * 查看新增景点页面
         */
              [Authorize]
        public ActionResult AddScenicSpots()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "ScenicSpots";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "旅游景点管理";
            ViewData["t3"] = "添加景点";
            return View();
        }
        /*
       * 修改密码
       */
              [Authorize]
        public ActionResult UpdatePassword()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "UpdatePassword";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "修改密码";
            ViewData["t3"] = "";
            return View();
        }
        /*
       * 数据调整
       */
              [Authorize]
        public ActionResult DataAdjust()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "DataAdjust";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "数据调整";
            ViewData["t3"] = "";
            return View();
        }
              [Authorize]
        public ActionResult TestImg()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "TImg";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "考试管理";
            ViewData["t3"] = "";
            return View();

        }
        /************************************************************************/
        /* 短期预留时间调整                                                                     */
        /************************************************************************/
              [Authorize]
        public ActionResult VIP()
        {
            BinZangDataContext db = new BinZangDataContext();
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "OtherFeature";
            ViewData["level2nav"] = "VIP";
            ViewData["t1"] = "其他";
            ViewData["t2"] = "贵宾证管理";
            ViewData["t3"] = "";
            string s = "";
            link_url lu = db.link_urls.Where(a => a.name == "credential_image").FirstOrDefault();
            if (lu==null)
            {
            }else{
                  s = lu.url; 
            }
            
            
            ViewData["img"] = rootUri+s;
            return View();


        }
        [AcceptVerbs(HttpVerbs.Post)]
        //贵宾证照片上传
        public JsonResult VIPIMG(HttpPostedFileBase Filedata)
        {
            BinZangDataContext db = new BinZangDataContext();

            if (Filedata != null)
            {
                try
                {
                    // 文件上传后的保存路径
                    string filePath = Server.MapPath("~/Content/VIP/img/");
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    string fileName = Path.GetFileName(Filedata.FileName);// 原始文件名称
                    string fileExtension = Path.GetExtension(fileName); // 文件扩展名
                    string saveName = Guid.NewGuid().ToString() + fileExtension; // 保存文件名称

                    Filedata.SaveAs(filePath + saveName);

                    //return Json(new { Success = true, FileName = fileName, SaveName = "Content/uploads/video/" + saveName }, JsonRequestBehavior.AllowGet);
                    string url = "Content/VIP/img/" + saveName;
                    link_url l = db.link_urls.Where(a => a.deleted == 0 && a.name == "credential_image").FirstOrDefault();
                    if (l == null)
                    {
                        link_url l1 = new link_url();
                        l1.name = "credential_image";
                        l1.url = url;
                        l1.note = "贵宾证照片";
                        db.link_urls.InsertOnSubmit(l1);
                        db.SubmitChanges();
                    }
                    else
                    {
                        l.url = url;
                        db.SubmitChanges();
                    }
                    return Json("~/Content/VIP/img/" + saveName, JsonRequestBehavior.AllowGet);
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
        //公务员
        public JsonResult IMG1(HttpPostedFileBase Filedata)
        {
            BinZangDataContext db = new BinZangDataContext();

            if (Filedata != null)
            {
                try
                {
                    // 文件上传后的保存路径
                    string filePath = Server.MapPath("~/Content/EXImg/i1");
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    string fileName = Path.GetFileName(Filedata.FileName);// 原始文件名称
                    string fileExtension = Path.GetExtension(fileName); // 文件扩展名
                    string saveName = Guid.NewGuid().ToString() + fileExtension; // 保存文件名称

                    Filedata.SaveAs(filePath + saveName);

                    //return Json(new { Success = true, FileName = fileName, SaveName = "Content/uploads/video/" + saveName }, JsonRequestBehavior.AllowGet);
                    string url = "Content/EXImg/i1" + saveName;

                    return Json(url, JsonRequestBehavior.AllowGet);
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
        //学校考试
        public JsonResult IMG2(HttpPostedFileBase Filedata)
        {
            BinZangDataContext db = new BinZangDataContext();

            if (Filedata != null)
            {
                try
                {
                    // 文件上传后的保存路径
                    string filePath = Server.MapPath("~/Content/EXImg/i2");
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    string fileName = Path.GetFileName(Filedata.FileName);// 原始文件名称
                    string fileExtension = Path.GetExtension(fileName); // 文件扩展名
                    string saveName = Guid.NewGuid().ToString() + fileExtension; // 保存文件名称

                    Filedata.SaveAs(filePath + saveName);

                    //return Json(new { Success = true, FileName = fileName, SaveName = "Content/uploads/video/" + saveName }, JsonRequestBehavior.AllowGet);
                    string url = "Content/EXImg/i2" + saveName;

                    return Json(url, JsonRequestBehavior.AllowGet);
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
        //证照考试
        public JsonResult IMG3(HttpPostedFileBase Filedata)
        {
            BinZangDataContext db = new BinZangDataContext();

            if (Filedata != null)
            {
                try
                {
                    // 文件上传后的保存路径
                    string filePath = Server.MapPath("~/Content/EXImg/i3");
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    string fileName = Path.GetFileName(Filedata.FileName);// 原始文件名称
                    string fileExtension = Path.GetExtension(fileName); // 文件扩展名
                    string saveName = Guid.NewGuid().ToString() + fileExtension; // 保存文件名称

                    Filedata.SaveAs(filePath + saveName);

                    //return Json(new { Success = true, FileName = fileName, SaveName = "Content/uploads/video/" + saveName }, JsonRequestBehavior.AllowGet);
                    string url = "Content/EXImg/i3" + saveName;

                    return Json(url, JsonRequestBehavior.AllowGet);
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
        public JsonResult UpImg(string url1,string url2,string url3)
        {
            string res = new OtherFeatureModel().ExamImg(url1, url2, url3);

            return Json(res, JsonRequestBehavior.AllowGet);

        }

        #endregion
        #region 游戏上传
        /*
         * 查看android和ios的连接
         */
        public JsonResult FindGameURL()
        {
            List<GameURL> list = new List<GameURL>();
            list = new OtherFeatureModel().FindGameURL(list);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        
            
        /*
         * 修改android和ios的连接
         */
        public JsonResult UpdateGameURL(String androidurl, String iosurl)
        {
            String status = new OtherFeatureModel().UpdateGameURL(androidurl,iosurl);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region 衣食住行
        /*
         * 查看android和ios的连接
         */
        public JsonResult FindBasicLiftURL()
        {
            List<GameURL> list = new List<GameURL>();
            list = new OtherFeatureModel().FindBasicLiftURL(list);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        /*
         * 修改android和ios的连接
         */
        public JsonResult UpdateBasicLiftURL(String meishi, String dianying, String jiudian, String huochepiao, String feijipiao)
        {
            String status = new OtherFeatureModel().UpdateBasicLiftURL(meishi, dianying, jiudian, huochepiao, feijipiao);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        
        #endregion
        #region 景点旅游
        /*
         * 查看景点信息的连接
         */
        public ActionResult FindAllScenicSpots(int? secho)
        {
            var jingdianlist = new List<JingDian>();
            List<jingdian> jindian = new OtherFeatureModel().FindAllScenicSpots();
            for (int i = 0; i < jindian.Count; i++)
            {
                jingdianlist.Add(new JingDian
                {
                    Id = jindian[i].uid,
                    Name = jindian[i].name,
                    DiZhi = jindian[i].address,
                });
            }

            /*var objs = new List<object>();
            foreach (var jingdian in jingdianlist)
            {
                objs.Add(GetPropertyList(jingdian).ToArray());
            }*/
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = jindian.Count(),
                aaData = jingdianlist
            }, JsonRequestBehavior.AllowGet);
        }
       

        private List<string> GetPropertyList(object obj)
        {
            var propertyList = new List<string>();
            var properties = obj.GetType().GetProperties(BindingFlags.Instance | BindingFlags.Public);
            foreach (var property in properties)
            {
                object o = property.GetValue(obj, null);
                propertyList.Add(o == null ? "" : o.ToString());
            }
            return propertyList;
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult UploadifyImageS(HttpPostedFileBase Filedata)
        {
            if (Filedata != null)
            {
                try
                {
                    // 文件上传后的保存路径
                    string filePath = Server.MapPath("~/Content/OtherFeature/scenic/");
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    string fileName = Path.GetFileName(Filedata.FileName);// 原始文件名称
                    string fileExtension = Path.GetExtension(fileName); // 文件扩展名
                    string saveName = Guid.NewGuid().ToString() + fileExtension; // 保存文件名称

                    Filedata.SaveAs(filePath + saveName);

                    //return Json(new { Success = true, FileName = fileName, SaveName = "Content/uploads/video/" + saveName }, JsonRequestBehavior.AllowGet);
                    return Json("Content/OtherFeature/scenic/" + saveName, JsonRequestBehavior.AllowGet);
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


        public JsonResult AddScenicSpotsDetails(String img, String name, String address, String phone, String contents ,String lng,String lat)
        {
            String status = new OtherFeatureModel().AddScenicSpots(img, name, address, phone, contents,lng,lat);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        public JsonResult EditScenicSpots(String img, String name, String address, String phone, String contents, String id, String lng, String lat)
        {
            String status = new OtherFeatureModel().EditScenicSpots(img, name, address, phone, contents, id, lng, lat);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeletedScenicSpots(long id)
        {
            String status = new OtherFeatureModel().DeletedScenicSpots(id);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        
        #endregion
        #region 责任额
        public JsonResult FindEmpCover(int? secho, String office)
        {
            List<EmployCover> list = new List<EmployCover>();
            list = new OtherFeatureModel().FindEmpCover(office);
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = list.Count(),
                aaData = list
            }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult FindStationCover(int? secho,String city)
        {
            List<OfficeCover> list = new List<OfficeCover>();
            list = new OtherFeatureModel().FindStationCover(list,city);
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = list.Count(),
                aaData = list
            }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult FindEmployeById(long id)
        {
            EmployCover list = new EmployCover();
            list = new OtherFeatureModel().FindEmployeById(id);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult FindOfficeById(long id)
        {
            OfficeCover list = new OfficeCover();
            list = new OtherFeatureModel().FindOfficeById(id);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult EditEmployById(String id,string duty)
        {
          
            String status = new OtherFeatureModel().EditEmployById(id,duty);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        public JsonResult EditOfficeById(String id, string yiyue, string eryue, string sanyue,
                                        string siyue, string wuyue, string liuyue,
                                        string qiyue, string bayue, string jiuyue,
                                        string shiyue, string shiyiyue, string shieryue)
        {
            String duty = "";
            if (yiyue!=""&&yiyue!=null)
            {
                duty = duty + "," + yiyue;
            }
            else {
                duty = duty + "," + 0;
            }
            if (eryue != "" && eryue != null)
            {
                duty = duty + "," + eryue;
            }
            else
            {
                duty = duty + "," + 0;
            }
            if (sanyue != "" && sanyue != null)
            {
                duty = duty + "," + sanyue;
            }
            else
            {
                duty = duty + "," + 0;
            }
            if (siyue != "" && siyue != null)
            {
                duty = duty + "," + siyue;
            }
            else
            {
                duty = duty + "," + 0;
            }
            if (wuyue != "" && wuyue != null)
            {
                duty = duty + "," + wuyue;
            }
            else
            {
                duty = duty + "," + 0;
            }
            if (liuyue != "" && liuyue != null)
            {
                duty = duty + "," + liuyue;
            }
            else
            {
                duty = duty + "," + 0;
            }
            if (qiyue != "" && qiyue != null)
            {
                duty = duty + "," + qiyue;
            }
            else
            {
                duty = duty + "," + 0;
            }
            if (bayue != "" && bayue != null)
            {
                duty = duty + "," + bayue;
            }
            else
            {
                duty = duty + "," + 0;
            }
            
            if (jiuyue != "" && jiuyue != null)
            {
                duty = duty + "," + jiuyue;
            }else
            {
                duty = duty + "," + 0;
            }
            if (shiyue != "" && shiyue != null)
            {
                duty = duty + "," + shiyue;
            }
            else
            {
                duty = duty + "," + 0;
            }
            if (shiyiyue != "" && shiyiyue != null)
            {
                duty = duty + "," + shiyiyue;
            }
            else
            {
                duty = duty + "," + 0;
            }
            if (shieryue != "" && shieryue != null)
            {
                duty = duty + "," + shieryue;
            }
            else
            {
                duty = duty + "," + 0;

            }
            duty = duty.Substring(1, duty.Length-1);
            String status = new OtherFeatureModel().EditOfficeById(id, duty);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        #endregion
        #region 区域

        public JsonResult FindCity(int? secho)
        {
            var jingdianlist = new List<ChengShiInfo>();
            List<chengshi> jindian = new OtherFeatureModel().FindAllCity();
            for (int i = 0; i < jindian.Count; i++)
            {
                jingdianlist.Add(new ChengShiInfo
                {
                    id = jindian[i].uid,
                    name = jindian[i].name,
                });
            }
            /*var objs = new List<object>();
            foreach (var jingdian in jingdianlist)
            {
                objs.Add(GetPropertyList(jingdian).ToArray());
            }*/
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = jindian.Count(),
                aaData = jingdianlist
            }, JsonRequestBehavior.AllowGet);
        }
           public JsonResult FindQuYu(int? secho)
        {
            var jingdianlist = new List<QuYuInfo>();
            List<quyu> quyus = new OtherFeatureModel().FindAllQuyu();
            for (int i = 0; i < quyus.Count; i++)
            {
                string shiname=new OtherFeatureModel().FindShiName(quyus[i].chengshi_id);
                jingdianlist.Add(new QuYuInfo
                {
                    id = quyus[i].uid,
                    name = quyus[i].name,
                    city_name = shiname
                });
            }
            /*var objs = new List<object>();
            foreach (var jingdian in jingdianlist)
            {
                objs.Add(GetPropertyList(jingdian).ToArray());
            }*/
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = quyus.Count(),
                aaData = jingdianlist
            }, JsonRequestBehavior.AllowGet);
        }

           public JsonResult FindQuyuById(long id)
           {
               quyu info=new OtherFeatureModel().FindQuyuById(id);
               return Json(info, JsonRequestBehavior.AllowGet);
           }
           public JsonResult FindShiById(long id)
           {
               chengshi info = new OtherFeatureModel().FindShiById(id);
               return Json(info, JsonRequestBehavior.AllowGet);
           }

           public JsonResult AddQuyu(string quyu,String city)
           {
               String status = new OtherFeatureModel().AddQuyu(quyu,city);
               return Json(status, JsonRequestBehavior.AllowGet);
           }
           public JsonResult EditQuyu(String id,String name,String chengshi)
           {
               String status = new OtherFeatureModel().EditQuyu(id, name, chengshi);
               return Json(status, JsonRequestBehavior.AllowGet);
           }
           public JsonResult AddOffice(String city)
           {
               String status = new OtherFeatureModel().AddOffice(city);
               return Json(status, JsonRequestBehavior.AllowGet);
           }
           public JsonResult EditOffice(String id,String city)
           {
               String status = new OtherFeatureModel().EditOffice(id,city);
               return Json(status, JsonRequestBehavior.AllowGet);
           }
           public JsonResult DeletedOffice(String id)
           {
               String status = new OtherFeatureModel().DeletedOffice(id);
               return Json(status, JsonRequestBehavior.AllowGet);
           }
           public JsonResult DeletedQuyu(String id)
           {
               String status = new OtherFeatureModel().DeletedQuyu(id);
               return Json(status, JsonRequestBehavior.AllowGet);
           }
           #endregion
        #region 奖金

        public JsonResult FindTrueAward()
        {
            TrueAWardInfo list = new TrueAWardInfo();
            list = new OtherFeatureModel().FindTrueAward(list);
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        public JsonResult FindFalseAward()
        {
            FalseAWardInfo list = new FalseAWardInfo();
            list = new OtherFeatureModel().FindFalseAward(list);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult EditFalseAward(String param, string leixing)
        {
            
            String status = new OtherFeatureModel().EditFalseAward(param,leixing);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        public JsonResult EditTrueAward(String param, string leixing)
        {

            String status = new OtherFeatureModel().EditTrueAward(param, leixing);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region  密码修改
        public JsonResult FindInfoByName(string name)
        {
            int status = 0;
            user info = new OtherFeatureModel().FindInfoByName(name);
            if (info==null)
            {
                status = 1;
            }
            return Json(new { status = status, info = info }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult EditPassword(String password, String id)
        {
            String status = new OtherFeatureModel().EditPassword(password,id);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        #endregion
         #region  调整数据

        public JsonResult FindNumberAndTime()
        {
            NumberAndTime list = new NumberAndTime();
            list = new OtherFeatureModel().FindNumberAndTime(list);
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult FindPriceAndTime(int? secho)
        {
            List<PriceAndTime> list = new List<PriceAndTime>();
            list = new OtherFeatureModel().FindPriceAndTime(list);
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = list.Count(),
                aaData = list
            }, JsonRequestBehavior.AllowGet);
        }
        
        public JsonResult FindUpdateInfo(long id)
        {
            PriceAndTime list = new PriceAndTime();
            list = new OtherFeatureModel().FindUpdateInfo(id);
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateAdjustInfo(String kaishijiage, String jieshujiage,String yuliushijian,String id)
        {
            String status = new OtherFeatureModel().UpdateAdjustInfo(kaishijiage, jieshujiage, yuliushijian, id);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        
        public JsonResult AddAdjustInfo(String kaishijiage, String jieshujiage, String yuliushijian)
        {
            String status = new OtherFeatureModel().AddAdjustInfo(kaishijiage, jieshujiage, yuliushijian);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DeletedAdjustInfo(long id)
        {
            String status = new OtherFeatureModel().DeletedAdjustInfo(id);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateNumberInfo(String number)
        {
            String status = new OtherFeatureModel().UpdateNumberInfo(number);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult UpdateTimeInfo(String time)
        {
            String status = new OtherFeatureModel().UpdateTimeInfo(time);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        #endregion

    }
}
