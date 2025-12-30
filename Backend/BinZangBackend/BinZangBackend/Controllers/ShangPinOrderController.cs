using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using BinZangBackend.Models;
namespace BinZangBackend.Controllers
{
    public class ShangPinOrderController : Controller
    {
        //
        // GET: /ShangPinOrder/
        [Authorize]
        public ActionResult Index()
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Res";
            ViewData["level2nav"] = "ShangPinOrder";
            //ViewData["level3nav"] = "Staff";
            ViewData["t1"] = "预约管理";
            ViewData["t2"] = "自祭拜预约";
            ViewData["t3"] = "";
         
            return View();
        }
        [Authorize]
        public ActionResult OrderInfo(long sid)
        {
            string rootUri = string.Format("{0}://{1}{2}", Request.Url.Scheme, Request.Url.Authority, Url.Content("~"));
            ViewData["rootUri"] = rootUri;
            ViewData["level1nav"] = "Res";
           // ViewData["level2nav"] = "ShangPinOrder";
            ViewData["t1"] = "预约管理";
            ViewData["t2"] = "商品订单详情";
            ViewData["t3"] = "";
            ViewData["sid"] = sid;
            ViewData["cname"] = new ShangPinModel().Getcname(sid);
            ViewData["zongjia"] = new ShangPinModel().GetAllTotal(sid);
            ViewData["ordertype"] = new ShangPinModel().GetOrderType(sid);
            //ViewData["level3nav"] = "Staff";
            return View();
        }
        //商品订单详情
        public JsonResult GetOrderInfo(string sid)
        {
            long suid = long.Parse(sid);
            JqDataTableInfo list = new ShangPinModel().ShangOrderTable(suid);
            return Json(list, JsonRequestBehavior.AllowGet);



        }
        //删除商品订单
        public JsonResult DelShangPin(long uid)
        {
            string str = "";
            str = new ShangPinModel().DelOrderBy(uid);
            return Json(str, JsonRequestBehavior.AllowGet);
        }
        //获得祭拜信息
        public JsonResult GetJBOrder(string cname, string phone, string stime, string etime, string status)
        {
          JqDataTableInfo list = new ShangPinModel().GetJiBaiTable(cname,phone,stime,etime,status);

          return Json(list, JsonRequestBehavior.AllowGet);
        }
        //获得代祭拜信息
        public JsonResult GetDJBOrder(string cname, string phone, string stime, string etime, string status)
        {
            JqDataTableInfo list = new ShangPinModel().GetDJiBaiTable(cname, phone, stime, etime, status);

            return Json(list, JsonRequestBehavior.AllowGet);
        }
        //取消祭拜
        public JsonResult DelJiBai(long sid)
        {
            string res = new ShangPinModel().DeleteJi(sid);
            return Json(res, JsonRequestBehavior.AllowGet);


        }
        //取消代祭拜
        public JsonResult DelDJiBai(long sid)
        {
            string res = new ShangPinModel().DeleteDJi(sid);
            return Json(res, JsonRequestBehavior.AllowGet);


        }
        //代祭拜的导出
        public void ExportZiJi(string cname, string phone, string stime, string etime, string status)
        {
            List<JiBaiOrderInfo> list = new ShangPinModel().GetZiJi(cname, phone, stime, etime, status);
            string filename = "自祭拜预约";
            string rst = "";

            String meeting = "<html>"
              + "<head>"
              + "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
              + "</head>"
              + "<body>"
              + "<table >";
            string html = "";
            html += "<tr>";
            html += "<td  colspan='2' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "客户姓名" + " </td>";
            html += "<td  colspan='3 ' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "联系方式" + "  </td>";
            html += "<td  colspan='4 ' rowspan='1' id='3' style='font-size:14;border: 1px solid #000000;text-align:center;v'>" + "预约日期" + " </td>";
            html += "<td  colspan='2 ' rowspan='1' id='5' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "代订人" + "  </td>";
            html += "<td  colspan='1 ' rowspan='1' id='5' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "是否取消" + "  </td>";
            html += "</tr>";
            meeting = meeting + html;
            for (int i = 0; i < list.Count; i++)
            {
                rst += "<tr>";
                rst += "<td  colspan='2' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + list[i].client_name + " </td>";
                rst += "<td  colspan='3 ' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + list[i].client_phone + "  </td>";
                rst += "<td  colspan='4 ' rowspan='1' id='3' style='font-size:14;border: 1px solid #000000;text-align:center;v'>" + list[i].reservetimestr + " </td>";
                rst += "<td  colspan='2 ' rowspan='1' id='3' style='font-size:14;border: 1px solid #000000;text-align:center;v'>" + list[i].user_name + " </td>";
                rst += "<td  colspan='1 ' rowspan='1' id='5' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + list[i].isno + "  </td>";
                rst += "</tr>";

            }
            rst = meeting + rst;
           // System.Web.UI.WebControls.DataGrid dgExport = null;
            // 当前对话 
           System.Web.HttpContext curContext = System.Web.HttpContext.Current;
            // IO用于导出并返回excel文件 
         //   System.IO.StringWriter strWriter = null;
          //  System.Web.UI.HtmlTextWriter htmlWriter = null;

            byte[] str = null;
            curContext.Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment;filename=" + filename + ".xls");

            rst += "</table ></body></html>";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            sb.Append(rst);

            //把字符数组写入HTTP响应输出流
            Response.Write(sb.ToString());
            //发送完，关闭
            Response.End();

        }
        //备注信息修改
        public JsonResult RemarkModify(string hua,string gong,string sui,string qi)
        {
            string res = new ShangPinModel().ModifyRemark(hua, gong, sui, qi);

            return Json(res, JsonRequestBehavior.AllowGet);
        }
        //导出商品购买单
        public void Daochu(long sid)
        {
            BinZangDataContext db = new BinZangDataContext();
            List<ShangPinInfo> list = new ShangPinModel().GetShangPin(sid);
            service_reserve s = db.service_reserves.Where(a => a.uid == sid).FirstOrDefault();
            long cid = s.client_id;
           
            client c = db.clients.Where(a => a.uid == cid).FirstOrDefault();
            user u = db.users.Where(a => a.uid == c.owner_id).FirstOrDefault();
            list = list.Where(a => a.deleted == 0).ToList();
            string filename = "商品购买订单";
            string rst = "";
            float zong = 0;
            for (int i = 0; i < list.Count; i++)
            {
                zong = zong + list[i].total;
              

            }
            String meeting = "<html>"
              + "<head>"
              + "<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />"
              + "</head>"
              + "<body>"
              + "<table >";
           
            string html = "";
       
            html += "<tr>";
            html += "<td  colspan='11' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "商品名称购买单" + " </td>";
            html += "</tr>";
            html += "<tr>";
            html += "<td  colspan='1' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "客户姓名" + " </td>";
            html += "<td  colspan='2' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + c.realname + " </td>";
            html += "<td  colspan='1' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "服务人员" + " </td>";
            html += "<td  colspan='1' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + u.realname + " </td>";
            html += "<td  colspan='1' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "联系电话" + " </td>";
            html += "<td  colspan='2' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + c.phone + " </td>";
            html += "<td  colspan='1' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "总价" + " </td>";
            html += "<td  colspan='2' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + zong + " </td>";
            html += "</tr>";
            html += "<tr>";
            html += "<td  colspan='1' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "序号" + " </td>";
            html += "<td  colspan='3' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "商品名称" + " </td>";
            html += "<td  colspan='3 ' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "单价" + "  </td>";
            html += "<td  colspan='2 ' rowspan='1' id='3' style='font-size:14;border: 1px solid #000000;text-align:center;v'>" + "数量" + " </td>";
            html += "<td  colspan='2 ' rowspan='1' id='5' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + "总价" + "  </td>";
            html += "</tr>";
            meeting = meeting + html;
            for (int i = 0; i < list.Count; i++)
            {
                rst += "<tr>";
                rst += "<td  colspan='1' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + (i+1) + " </td>";
                rst += "<td  colspan='3' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + list[i].name+ " </td>";
                rst += "<td  colspan='3 ' rowspan='1' id='1' style='font-size:14;border: 1px solid #000000;text-align:center;'>" + list[i].price + "  </td>";
                rst += "<td  colspan='2 ' rowspan='1' id='3' style='font-size:14;border: 1px solid #000000;text-align:center;v'>" + list[i].num + " </td>";
                rst += "<td  colspan='2 ' rowspan='1' id='3' style='font-size:14;border: 1px solid #000000;text-align:center;v'>" + list[i].total + " </td>";
              
                rst += "</tr>";

            }
            rst = meeting + rst;
           // System.Web.UI.WebControls.DataGrid dgExport = null;
            // 当前对话 
            System.Web.HttpContext curContext = System.Web.HttpContext.Current;
            // IO用于导出并返回excel文件 
         //   System.IO.StringWriter strWriter = null;
          //  System.Web.UI.HtmlTextWriter htmlWriter = null;

            byte[] str = null;
            curContext.Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment;filename=" + filename + ".xls");

            rst += "</table ></body></html>";
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            sb.Append(rst);

            //把字符数组写入HTTP响应输出流
            Response.Write(sb.ToString());
            //发送完，关闭
            Response.End();

        }
    }
}
