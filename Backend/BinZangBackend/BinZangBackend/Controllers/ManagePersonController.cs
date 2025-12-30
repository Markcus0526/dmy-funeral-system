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
    public class ManagePersonController : Controller
    {
        #region 跳转页面
              [Authorize]
        public ActionResult Staff()
        {
             string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "Staff";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "员工管理";
            ViewData["t3"] = "";
            return View();
        }
              [Authorize]
        public ActionResult AddStaff()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "Staff";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "员工管理";
            ViewData["t3"] = "添加员工";
            return View();
        }
              [Authorize]
        public ActionResult FindStaff(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "Staff";
            user info = new ManagePersonModel().FindOneDaiXiaoShang(id);
            String officename = new ManagePersonModel().FindOneStaffByID((long)info.office_id);
            ViewData["name"] = info.name;
            ViewData["id"] = id;
            ViewData["real_name"] = info.realname;
            ViewData["phone"] = info.phone;
            ViewData["password"] = info.password;
            ViewData["qqname"] = info.qq;
            ViewData["weixin"] = info.weixin;
            ViewData["img"] = info.imgurl;
            ViewData["owner_name"] = info.owner_id;
            ViewData["office"] = new ManagePersonModel().FindOfficeByid(info.office_id);
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "员工管理";
            ViewData["t3"] = "查看员工";
            return View();
        }
              [Authorize]
        public ActionResult EditStaff(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "Staff";
            user info = new ManagePersonModel().FindOneDaiXiaoShang(id);
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["name"] = info.name;
            ViewData["id"] = id;
            ViewData["real_name"] = info.realname;
            ViewData["phone"] = info.phone;
            ViewData["password"] = info.password;
            ViewData["qqname"] = info.qq;
            ViewData["weixin"] = info.weixin;
            ViewData["img"] = info.imgurl;
            ViewData["duty"] = info.planamount_permonth;
            ViewData["office"] = info.office_id;
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "员工管理";
            ViewData["t3"] = "修改员工";
            return View();
        }
              [Authorize]
        public ActionResult OldCustom()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;

            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "OldCustom";
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "旧客户";
            ViewData["t3"] = "";
            return View();
        }
              [Authorize]
        public ActionResult AddOldCustom()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "OldCustom";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewBag.tomblist = new ManagePersonModel().FindTombList();
            ViewBag.paiweilist = new ManagePersonModel().FindPaiweiList();
            ViewBag.ownerlist = new ManagePersonModel().FindOwnerList();
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "旧客户";
            ViewData["t3"] = "添加旧客户";
            return View();
        }
              [Authorize]
        public ActionResult FindOldCustom(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "OldCustom";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
           
            ViewBag.ownerlist = new ManagePersonModel().FindOwnerList();
            client info = new ManagePersonModel().FindOneOldCustom(id);
            user info1 = new ManagePersonModel().FindOneDaiXiaoShang(info.owner_id);
            
            List<grave_site> tomb= new ManagePersonModel().FindTombList1(info.uid);
            ViewBag.tomblist = tomb;
            List<grave_tablet> paiwei= new ManagePersonModel().FindPaiweiList1(info.uid);
            ViewBag.paiweilist = paiwei;
            ViewData["name"] = info.name;
            ViewData["real_name"] = info.realname;
            ViewData["phone"] = info.phone;
            ViewData["password"] = info.password;
            ViewData["img"] = info.imgurl;
            ViewData["owner_name"] = info.owner_id;
             ViewData["office"]=  info1.office_id;
             List<client_parent> infopar = new List<client_parent>();
             if (tomb.Count != 0)
             {
                 infopar = new ManagePersonModel().FindClientParrent(tomb.FirstOrDefault().uid);
             }
            if (infopar.Count==1)
            {
                ViewData["guanxi1"] = infopar[0].relation;
                ViewData["guanxi2"] = "";
                ViewData["qname1"] = infopar[0].name;
                ViewData["danchen1"] = infopar[0].birthday;
                ViewData["jiri1"] = infopar[0].deathday;
                ViewData["qname2"] ="";
                ViewData["danchen2"] = "";
                ViewData["jiri2"] = "";
            }
            if (infopar.Count == 0)
            {
                ViewData["guanxi1"] = "";
                ViewData["guanxi2"] = "";
                ViewData["qname1"] = "";
                ViewData["danchen1"] = "";
                ViewData["jiri1"] = "";
                ViewData["qname2"] = "";
                ViewData["danchen2"] = "";
                ViewData["jiri2"] = "";
            }
            if (infopar.Count == 2)
            {
                ViewData["guanxi1"] = infopar[0].relation;
                ViewData["guanxi2"] = infopar[1].relation;
                ViewData["qname1"] = infopar[0].name;
                ViewData["danchen1"] = infopar[0].birthday;
                ViewData["jiri1"] = infopar[0].deathday;
                ViewData["qname2"] = infopar[1].name;
                ViewData["danchen2"] = infopar[1].birthday;
                ViewData["jiri2"] = infopar[1].deathday;
            }
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "旧客户";
            ViewData["t3"] = "查看旧客户";
            return View();
        }
              [Authorize]
        public ActionResult EditOldCustom(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "OldCustom";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();

            ViewBag.ownerlist = new ManagePersonModel().FindOwnerList();
            client info = new ManagePersonModel().FindOneOldCustom(id);
            user info1 = new ManagePersonModel().FindOneDaiXiaoShang(info.owner_id);

            List<grave_site> tomb = new ManagePersonModel().FindTombList1(info.uid);
            ViewBag.tomblist = tomb;
            List<grave_tablet> paiwei = new ManagePersonModel().FindPaiweiList1(info.uid);
            ViewBag.paiweilist = paiwei;
            ViewData["name"] = info.name;
            ViewData["real_name"] = info.realname;
            ViewData["phone"] = info.phone;
            ViewData["password"] = info.password;
            ViewData["img"] = info.imgurl;
            ViewData["owner_name"] = info.owner_id;
            ViewData["office"] = info1.office_id;
            ViewData["id"] = id;
            List<client_parent> infopar = new ManagePersonModel().FindClientParrent(tomb.FirstOrDefault().uid);
            if (infopar.Count == 1)
            {
                ViewData["guanxi1"] = infopar[0].relation;
                ViewData["guanxi2"] = "";
                ViewData["qname1"] = infopar[0].name;
                ViewData["danchen1"] = infopar[0].birthday;
                ViewData["jiri1"] = infopar[0].deathday;
                ViewData["qname2"] = "";
                ViewData["danchen2"] = "";
                ViewData["jiri2"] = "";
            }
            if (infopar.Count == 0)
            {
                ViewData["guanxi1"] = "";
                ViewData["guanxi2"] = "";
                ViewData["qname1"] = "";
                ViewData["danchen1"] = "";
                ViewData["jiri1"] = "";
                ViewData["qname2"] = "";
                ViewData["danchen2"] = "";
                ViewData["jiri2"] = "";
            }
            if (infopar.Count == 2)
            {
                ViewData["guanxi1"] = infopar[0].relation;
                ViewData["guanxi2"] = infopar[1].relation;
                ViewData["qname1"] = infopar[0].name;
                ViewData["danchen1"] = infopar[0].birthday;
                ViewData["jiri1"] = infopar[0].deathday;
                ViewData["qname2"] = infopar[1].name;
                ViewData["danchen2"] = infopar[1].birthday;
                ViewData["jiri2"] = infopar[1].deathday;
            }
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "旧客户";
            ViewData["t3"] = "修改旧客户";
            return View();
        }
              [Authorize]
        public ActionResult DaiXiaoShang()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "DaiXiaoShang";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "代销商";
            ViewData["t3"] = "";
            return View();
        }
              [Authorize]
        public ActionResult AddDaiXiaoShang()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "DaiXiaoShang";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "代销商";
            ViewData["t3"] = "添加代销商";
            return View();
        }
              [Authorize]
        public ActionResult FindDaiXiaoShang(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "DaiXiaoShang";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            user info = new ManagePersonModel().FindOneDaiXiaoShang(id);
            ViewData["name"] = info.name;
            ViewData["real_name"] = info.realname;
            ViewData["phone"] = info.phone;
            ViewData["password"] = info.password;
            ViewData["qqname"] = info.qq;
            ViewData["weixin"] = info.weixin;
            ViewData["img"] = info.imgurl;
            ViewData["owner_name"] = info.owner_id;
            ViewData["office"] = info.office_id;
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "代销商";
            ViewData["t3"] = "查看代销商";
            return View();
        }
              [Authorize]
        public ActionResult EditDaiXiaoShang(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "DaiXiaoShang";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["id"] = id;
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "代销商";
            ViewData["t3"] = "修改代销商";
            return View();
        }
              [Authorize]
        public ActionResult LingDao()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "LingDao";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "领导";
            ViewData["t3"] = "";
            return View();
        }
              [Authorize]
        public ActionResult AddLingDao()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "LingDao";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "领导";
            ViewData["t3"] = "添加领导";
            return View();
        }
              [Authorize]
        public ActionResult FindLingDao(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "LingDao";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            user info = new ManagePersonModel().FindOneDaiXiaoShang(id);
            ViewData["name"] = info.name;
            ViewData["real_name"] = info.realname;
            ViewData["phone"] = info.phone;
            ViewData["password"] = info.password;
            ViewData["qqname"] = info.qq;
            ViewData["weixin"] = info.weixin;
            ViewData["img"] = info.imgurl;
            ViewData["type"] = info.type;
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "领导";
            ViewData["t3"] = "查看领导";
            return View();
        }
              [Authorize]
        public ActionResult EditLingDao(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "LingDao";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["id"] = id;
            user info = new ManagePersonModel().FindOneDaiXiaoShang(id);
            ViewData["name"] = info.name;
            ViewData["real_name"] = info.realname;
            ViewData["phone"] = info.phone;
            ViewData["password"] = info.password;
            ViewData["qqname"] = info.qq;
            ViewData["weixin"] = info.weixin;
            ViewData["img"] = info.imgurl;
            ViewData["type"] = info.type;
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "领导";
            ViewData["t3"] = "修改领导";
            return View();
        }
              [Authorize]
        public ActionResult HouTaiYongHu()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "HouTaiYongHu";
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "后台使用者";
            ViewData["t3"] = "";
            return View();
        }
              [Authorize]
        public ActionResult AddHouTaiYongHu()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "HouTaiYongHu";
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "后台使用者";
            ViewData["t3"] = "添加后台用户";
            return View();
        }
              [Authorize]
        public ActionResult FindHouTaiYongHu(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "HouTaiYongHu";
            user info = new ManagePersonModel().FindOneDaiXiaoShang(id);
            ViewData["name"] = info.name;
            ViewData["real_name"] = info.realname;
            ViewData["phone"] = info.phone;
            ViewData["password"] = info.password;
            ViewData["qqname"] = info.qq;
            ViewData["weixin"] = info.weixin;
            admin_right rightinfo = new ManagePersonModel().FindRightById((long)info.adminright_id);
            ViewData["role"] = rightinfo.role ;
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "后台使用者";
            ViewData["t3"] = "查看后台用户";
            return View();
        }
              [Authorize]
        public ActionResult EditHouTaiYongHu(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "HouTaiYongHu";
            user info = new ManagePersonModel().FindOneDaiXiaoShang(id);
            ViewData["name"] = info.name;
            ViewData["real_name"] = info.realname;
            ViewData["phone"] = info.phone;
            ViewData["password"] = info.password;
            ViewData["qqname"] = info.qq;
            ViewData["weixin"] = info.weixin;
            admin_right rightinfo = new ManagePersonModel().FindRightById((long)info.adminright_id);
            ViewData["role"] = rightinfo.role;
            ViewData["id"] = id;
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "后台使用者";
            ViewData["t3"] = "修改后台用户";
            return View();
        }
              [Authorize]
        public ActionResult BanShiChuZhuRen()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "BanShiChuZhuRen";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "办事处主任";
            ViewData["t3"] = "";
            return View();
        }
              [Authorize]
        public ActionResult AddBanShiChuZhuRen()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "LingDao";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "办事处主任";
            ViewData["t3"] = "添加办事处主任";
            return View();
        }
              [Authorize]
        public ActionResult FindBanShiChuZhuRen(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "BanShiChuZhuRen";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            user info = new ManagePersonModel().FindOneDaiXiaoShang(id);
            ViewData["name"] = info.name;
            ViewData["real_name"] = info.realname;
            ViewData["phone"] = info.phone;
            ViewData["password"] = info.password;
            ViewData["qqname"] = info.qq;
            ViewData["weixin"] = info.weixin;
            ViewData["img"] = info.imgurl;
            ViewData["type"] = info.type;
            ViewData["office"] = info.office_id;
            ViewData["duty"] = info.planamount_permonth;
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "办事处主任";
            ViewData["t3"] = "查看办事处主任";
            return View();
        }
              [Authorize]
        public ActionResult EditBanShiChuZhuRen(long id)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "SystemPerson";
            ViewData["level2nav"] = "ManagePerson";
            ViewData["level3nav"] = "BanShiChuZhuRen";
            ViewBag.officelist = new OtherFeatureModel().FindOfficeList();
            ViewData["id"] = id;
            user info = new ManagePersonModel().FindOneDaiXiaoShang(id);
            ViewData["name"] = info.name;
            ViewData["real_name"] = info.realname;
            ViewData["phone"] = info.phone;
            ViewData["password"] = info.password;
            ViewData["qqname"] = info.qq;
            ViewData["weixin"] = info.weixin;
            ViewData["img"] = info.imgurl;
            ViewData["type"] = info.type;
            ViewData["office"] = info.office_id;
            ViewData["duty"] = info.planamount_permonth;
            ViewData["t1"] = "用户管理";
            ViewData["t2"] = "办事处主任";
            ViewData["t3"] = "修改办事处主任";
            return View();
        }
        #endregion
        #region 代销商
        public JsonResult FindAllDaiXiaoShang(int? secho,String name,String banshichu,String phone,String owner_name)
        {
            List<DaiXiaoShang> list = new List<DaiXiaoShang>();
            list = new ManagePersonModel().FindAllDaiXiaoShang(list,name,banshichu,phone,owner_name);
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = list.Count(),
                aaData = list
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult FindEmpByOffice(String office)
        {
            List<user> list = new List<user>();
            list = new ManagePersonModel().FindEmpByOffice(office);
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public JsonResult UploadifyImageS(HttpPostedFileBase Filedata)
        {
            if (Filedata != null)
            {
                try
                {
                    // 文件上传后的保存路径
                    string filePath = Server.MapPath("~/Content/ManagePerson/Daixiaoshang/");
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    string fileName = Path.GetFileName(Filedata.FileName);// 原始文件名称
                    string fileExtension = Path.GetExtension(fileName); // 文件扩展名
                    string saveName = Guid.NewGuid().ToString() + fileExtension; // 保存文件名称

                    Filedata.SaveAs(filePath + saveName);

                    //return Json(new { Success = true, FileName = fileName, SaveName = "Content/uploads/video/" + saveName }, JsonRequestBehavior.AllowGet);
                    return Json("Content/ManagePerson/Daixiaoshang/" + saveName, JsonRequestBehavior.AllowGet);
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

        public JsonResult AddDaiXiaoShangInfo(
            String img,  String name,  String real_name,  String phone,
            String owner_name, String office, String weixin, String qqname, 
            String password)
        {

            String status = new ManagePersonModel().AddDaiXiaoShangInfo(
                img, name, real_name, phone, owner_name,
                office, weixin, qqname ,password
                );
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        public JsonResult FindOneById(String id)
        {
            user info = new ManagePersonModel().FindOneDaiXiaoShang(long.Parse(id));
            return Json(info, JsonRequestBehavior.AllowGet);
        }
        
        public JsonResult EditDaiXiaoShangInfo(
            String id,String img,  String name,  String real_name,  String phone,
            String owner_name, String office, String weixin, String qqname)
        {

            String status = new ManagePersonModel().EditDaiXiaoShangInfo(
                id , img, name, real_name, phone, owner_name,
                office, weixin, qqname );
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeletedDaiXiaoShang(long id)
        {

            String status = new ManagePersonModel().DeletedDaiXiaoShang(id);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region 领导
        public JsonResult FindAllLingDao(int? secho,String name,String type,String phone)
        {
            List<LingDao> list = new List<LingDao>();
            list = new ManagePersonModel().FindAllLingDao(name,type,phone,list);
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = list.Count(),
                aaData = list
            }, JsonRequestBehavior.AllowGet);
        }


        public JsonResult AddLingDaoInfo(
            String img, String name, String real_name, String phone,
            String office, String weixin, String qqname,
            String password,string type)
        {

            String status = new ManagePersonModel().AddLingDaoInfo(
                img, name, real_name, phone, office, weixin, qqname, password,type
                );
            return Json(status, JsonRequestBehavior.AllowGet);
        }

   
        public JsonResult EditLingDaoInfo(
            String id,String img,  String name,  String real_name,  String phone,
             String type, String weixin, String qqname)
        {

            String status = new ManagePersonModel().EditLingDaoInfo(
                id , img, name, real_name, phone, type, weixin, qqname  );
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeletedDLingDao(long id)
        {

            String status = new ManagePersonModel().DeletedDLingDao(id);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region 主任
        public JsonResult FindAllZhuRen(int? secho, String name,String banshichu, String type, String phone)
        {
            List<LingDao> list = new List<LingDao>();
            list = new ManagePersonModel().FindAllZhuRen(name, banshichu, type, phone, list);
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = list.Count(),
                aaData = list
            }, JsonRequestBehavior.AllowGet);
        }
       
        public JsonResult AddBanShiChuInfo(
       String img, String real_name, String phone, String name, 
        String weixin, String qqname, String banshichu,
       String password,String type,string duty)
        {

            String status = new ManagePersonModel().AddBanShiChuInfo(
                img, name, real_name, phone,
                banshichu, weixin, qqname, password, type, duty);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult EditBanShiChuZhuRenInfo(
            String id,String img,  String name,  String real_name,  String phone,
            String type,  String weixin, String qqname, String banshichu,string duty)
        {

            String status = new ManagePersonModel().EditBanShiChuZhuRenInfo(
                id , img, name, real_name, phone, type,
                banshichu, weixin, qqname,duty
                );
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeletedDaBanShiChuZhuRen(long id)
        {

            String status = new ManagePersonModel().DeletedDaBanShiChuZhuRen(id);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        #endregion

        #region 后台用户

        public JsonResult FindAllHouTaiYongHu(int? secho)
        {
            List<HouTaiYongHu> list = new List<HouTaiYongHu>();
            list = new ManagePersonModel().FindAllHouTaiYongHu(list);
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = list.Count(),
                aaData = list
            }, JsonRequestBehavior.AllowGet);

        }


        public JsonResult AddHouTaiYouHuInfo(String img, String real_name, String phone, String name,
        String weixin, String qqname, String password, string[] configuration)
        {
            String role = "";
            String status="";
            if (configuration != null)
            {
                role = String.Join(",", configuration);
               status  = new ManagePersonModel().AddHouTaiYouHuInfo(name, real_name, phone, weixin, qqname, password, role);
            }
            else
            {
                status = "权限不能为空,请选择权限";
            }

            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult EditHouTaiYouHuInfo(String img, String real_name, String phone, String name,
      String weixin, String qqname, String id, string[] configuration)
        {
            String role = "";
            String status = "";
            if (configuration != null)
            {
                role = String.Join(",", configuration);
                status = new ManagePersonModel().EditHouTaiYouHuInfo(name, real_name, phone, weixin, qqname,id, role);
            }
            else
            {
                status = "权限不能为空,请选择权限";
            }

            return Json(status, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DeletedHouTaiYongHu(long id)
        {

            String status = new ManagePersonModel().DeletedHouTaiYongHu(id);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        #endregion
        #region 旧客户

        public JsonResult FindAllOldCustom(int? secho,String name,String phone)
        {
            List<OldCustom> list = new List<OldCustom>();
            list = new ManagePersonModel().FindAllOldCustom(list,name,phone);
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = list.Count(),
                aaData = list
            }, JsonRequestBehavior.AllowGet);
        }     
            public JsonResult AddOldCustomInfo(String real_name, String phone,String tombnum,String tombjiage,
                String paiweinum, String paiweijiage, string qinrenguanxi1, String qinrenguanxi2, string qinrenname1, String qinrenname2, String qinrendanchen1, String qinrendanchen2,
                String qinrenjiri1, String qinrenjiri2, String office, String owner_name, string daixiao_name,string paiweichengjiao,string tombchengjiao)
        {

            String status = new ManagePersonModel().AddOldCustomInfo(real_name, phone,tombnum,tombjiage,
                paiweinum, paiweijiage, qinrenguanxi1, qinrenguanxi2, qinrenname1, qinrenname2, qinrendanchen1, qinrendanchen2, qinrenjiri1, qinrenjiri2, office, owner_name, daixiao_name, paiweichengjiao, tombchengjiao);
            return Json(status, JsonRequestBehavior.AllowGet);
        }


            public JsonResult EditOldCustomInfo(String real_name,String id, String phone, String tombnum, String tombjiage,
                String paiweinum, String paiweijiage, string qinrenguanxi1, String qinrenguanxi2, string qinrenname1, String qinrenname2, String qinrendanchen1, String qinrendanchen2,
                String qinrenjiri1, String qinrenjiri2, String office, String owner_name)
        {

            String status = new ManagePersonModel().EditOldCustomInfo(real_name, id, phone, tombnum, tombjiage,
                paiweinum, paiweijiage, qinrenguanxi1, qinrenguanxi2, qinrenname1, qinrenname2, qinrendanchen1, qinrendanchen2, qinrenjiri1, qinrenjiri2, office, owner_name);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeletedOldCustom(long id)
        {

            String status = new ManagePersonModel().DeletedOldCustom(id);
            return Json(status, JsonRequestBehavior.AllowGet);
        }

        public JsonResult FindPriceByPaiwei(String id)
        {

            grave_tablet paiwei  = new ManagePersonModel().FindPriceByPaiwei(id);
            int price = paiwei.price;
            return Json(price, JsonRequestBehavior.AllowGet);
        }
        public JsonResult FindPriceByTomb(String id)
        {
            ClientTomb tomb = new ManagePersonModel().FindPriceByTomb(id);
            return Json(tomb, JsonRequestBehavior.AllowGet);
        }
        
        #endregion
        #region  员工

        public JsonResult FindAllStaff(int? secho, String name, String phone, String banshichu)
        {
            List<StaffInfo> list = new List<StaffInfo>();
            list = new ManagePersonModel().FindAllStaff(list, name, phone, banshichu);
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = list.Count(),
                aaData = list
            }, JsonRequestBehavior.AllowGet);
        }
        public JsonResult FindOldCustomById(int? secho, String id)
        {
            List<OldCustom> list = new List<OldCustom>();
            list = new ManagePersonModel().FindOldCustomById(list, id);
            return Json(new
            {
                sEcho = secho,
                iTotalRecords = list.Count(),
                aaData = list
            }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult AddStaffInfo(
     String img, String name, String real_name, String phone,
      String weixin, String qqname, String password, String banshichu, String duty)
        {

            String status = new ManagePersonModel().AddStaffInfo(img, name, real_name, phone, banshichu, weixin, qqname, password, duty);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        
        public JsonResult EditStaffInfo(
            String id,String img,  String name,  String real_name,  String phone,
            String office, String duty)
        {

            String status = new ManagePersonModel().EditStaffInfo(id , img, name, real_name, phone, office,duty);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        public JsonResult DeletedStaff(long id)
        {

            String status = new ManagePersonModel().DeletedStaff(id);
            return Json(status, JsonRequestBehavior.AllowGet);
        }
        #endregion

    }
}
