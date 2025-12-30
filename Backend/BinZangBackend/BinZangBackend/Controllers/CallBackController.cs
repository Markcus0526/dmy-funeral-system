using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using JpushApiClient;
using BinZangBackend.Models;
namespace BinZangBackend.Controllers
{
    public class CallBackController : Controller
    {
        //
        // GET: /CallBack/
       [Authorize]
        public ActionResult Index(long uid)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Res";
            ViewData["level2nav"] = "CallBack";
            ViewData["t1"] = "预约管理";
            ViewData["t2"] = "代祭拜预约";
            ViewData["t3"] = "回函发送";
            ViewData["uid"] = uid;
      
            //ViewData["level3nav"] = "Staff";
            return View();
        }
       [Authorize]
       public ActionResult SeeCallBack(long uid)
       {
           string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
           ViewData["rootUri"] = rootUri;
           ViewData["level1nav"] = "Res";
           ViewData["level2nav"] = "CallBack";
           ViewData["t1"] = "预约管理";
           ViewData["t2"] = "代祭拜预约";
           ViewData["t3"] = "查看回函";
           ViewData["uid"] = uid;
           ViewData["callbackimg"] = "";
           ViewData["callbackcontents"] = "";
           BinZangDataContext db = new BinZangDataContext();
           agentservice_result s = db.agentservice_results.Where(a => a.deleted == 0 && a.servicereserve_id ==uid).FirstOrDefault();
           if (s != null)
           {
               ViewData["callbackimg"] = s.img_urls;
               ViewData["callbackcontents"] = s.note;
           }
           //ViewData["level3nav"] = "Staff";
           return View();
       }
        [HttpPost]
        [SessionExpireFilter]
        //回函发送，附带推送
        public JsonResult TUI(string urls,long d,string remark)
        { BinZangDataContext db = new BinZangDataContext();
        service_reserve s = db.service_reserves.Where(a => a.deleted == 0 && a.uid == d).FirstOrDefault();
        long cid = s.client_id;
        client c = db.clients.Where(a => a.uid == cid).FirstOrDefault();
        user u = db.users.Where(a => a.uid == c.owner_id).FirstOrDefault();
        long usid = u.uid;
        agentservice_result ar = new agentservice_result();
        ar.client_id = cid;
        ar.img_urls = urls;
        ar.servicereserve_id = d;
        ar.user_id = usid;
        ar.note = remark;
        ar.createtime = DateTime.Now;
        ar.deleted = 0;
        db.agentservice_results.InsertOnSubmit(ar);
        db.SubmitChanges();
        s.status = 2;
        db.SubmitChanges();
        JPushApi.SendPushNotification(Convert.ToString(cid + 100000), "ServiceResult\n" + c.realname + ",您有一个代祭拜回函！");
        JPushApi.SendPushNotification(Convert.ToString(usid), "ServiceResult\n您的客户："+c.realname+",有一个代祭拜回函！");
    

            return Json("", JsonRequestBehavior.AllowGet);
        }
       [AcceptVerbs(HttpVerbs.Post)]
        //回函的照片的保存
        public JsonResult SendCallBack(HttpPostedFileBase Filedata)
        {

            if (Filedata != null)
            {
                try
                {
                    // 文件上传后的保存路径
                    string filePath = Server.MapPath("~/Content/upload/img/");
                    if (!Directory.Exists(filePath))
                    {
                        Directory.CreateDirectory(filePath);
                    }
                    string fileName = Path.GetFileName(Filedata.FileName);// 原始文件名称
                    string fileExtension = Path.GetExtension(fileName); // 文件扩展名
                    string saveName = Guid.NewGuid().ToString() + fileExtension; // 保存文件名称

                    Filedata.SaveAs(filePath + saveName);

                    //return Json(new { Success = true, FileName = fileName, SaveName = "Content/uploads/video/" + saveName }, JsonRequestBehavior.AllowGet);

                    return Json("Content/upload/img/" + saveName, JsonRequestBehavior.AllowGet);
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
       public JsonResult SubmitHuiHan(string urls,long sid)
       {


           return Json("", JsonRequestBehavior.AllowGet);
       }

    }
}
