using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BinZangBackend.Models
{
    public class LuoZangInfo
    {
        public long uid { get; set; }
        public long client_id { get; set; }
        public string client_name { get; set; }
        public string client_phone { get; set; }
        public long user_id { get; set; }
        public string user_name { get; set; }
        public DateTime reservetime { get; set; }
        public long? service_id { get; set; }
        public string service_name { get; set; }
        public float yishi { get; set; }
        public DateTime createtime { get; set; }
        public byte status { get; set; }
        public string note { get; set; }
        public string reservetimestr { get; set; }
        public string isno { get; set; } 
        

        

    }
    public class ExportInfo{
        public long uid{get;set;}
        public string cname{get;set;}
        public string stime{get;set;}
        public string yishiname{get;set;}
        public string jipins{get;set;}
        public string fuwuren{get;set;}


    }
    public class jipininfo
    {

        public long uid { get; set; }
        public long sid { get; set; }
        public string jname { get; set; }
    }
    public class LuoZangModel
    {
        BinZangDataContext db = new BinZangDataContext();
        public List<LuoZangInfo> GetLuoZang( ) {
            return db.service_reserves.Where(sr => sr.deleted == 0 && sr.service_type == 0).Join(db.tomb_services, sr => sr.service_id, ts => ts.uid, (sr, ts) => new { sr1 = sr, ts1 = ts }).Join(db.clients, yu => yu.sr1.client_id, cl => cl.uid, (yu, cl) => new { yu1 = yu, cl1 = cl }).Select(al => new LuoZangInfo
            {
                uid = al.yu1.sr1.uid,
                client_id = al.yu1.sr1.client_id,
                client_name = al.cl1.realname,
                client_phone =al.cl1.phone,
                reservetime = al.yu1.sr1.reserve_time,
                service_id =al.yu1.sr1.service_id,
                service_name =al.yu1.ts1.name,
                createtime = al.yu1.sr1.createtime,
                status =al.yu1.sr1.status,
                yishi = al.yu1.ts1.price,
                reservetimestr = al.yu1.sr1.reserve_time.Year + "年" + al.yu1.sr1.reserve_time.Month + "月" + al.yu1.sr1.reserve_time.Day + "日" + " " + al.yu1.sr1.reserve_time.Hour + "点" + al.yu1.sr1.reserve_time.Minute + "分",
                isno = al.yu1.sr1.status==1?"是":"否"


            }).ToList();
        
        
        
        
        }
        public List<LuoZangInfo> GetLuoZang1()
        {
            return db.service_reserves.Where(sr => sr.deleted == 0).Join(db.clients, sr1 => sr1.client_id, c => c.uid, (sr1, c) => new { sr2 = sr1, c1 = c }).Select(sc => new LuoZangInfo
            {
                uid = sc.sr2.uid,
                client_name = sc.c1.realname
            }).ToList();






        }
        public List<tomb_service> GetServiceType()
        {

            return db.tomb_services.Where(a => a.deleted == 0 && a.type == 0).ToList();


        }
        public JqDataTableInfo GetLuoTable(string clientname, string clientphone, string stime, string etime, string serviceid, string status)
        {
            List<LuoZangInfo> list = GetLuoZang();
            if (clientname!=null&&clientname!="")
            {
                list = list.Where(a => a.client_name.Contains(clientname)).ToList();
            }
            if (clientphone!=null&&clientphone!="")
            {
                list = list.Where(a => a.client_phone.Contains(clientphone)).ToList();
            }
            if (stime!=null&&stime!="")
            {
                DateTime s = DateTime.Parse(stime);
                list = list.Where(a => a.reservetime >= s).ToList();
            }
            if (etime!=null&&etime!="")
            {
                DateTime e = DateTime.Parse(etime);
                list = list.Where(a => a.reservetime <= e).ToList();
            }
            if (serviceid!=null&&serviceid!="")
            {
                list = list.Where(a => a.service_id == long.Parse(serviceid)).ToList();
            }
            if (status=="0")
            {
                list = new List<LuoZangInfo>();
            }
            if (status=="1")
            {
                list = list.Where(a => a.status == 0).ToList();
            }
            if (status=="2")
            {
                list = list.Where(a => a.status == 1).ToList();
            }
            if (status=="3")
            {
                list = list.Where(a => a.status == 0 || a.status == 1).ToList();
            }
            JqDataTableInfo jes = new JqDataTableInfo();
            jes.iTotalRecords = list.Count;
            jes.aaData = list.OrderByDescending(m=>m.uid).ToList();
            return jes;





        }
        public List<LuoZangInfo> GetExportInfo(string clientname, string clientphone, string stime, string etime, string serviceid, string status)
        {
            List<LuoZangInfo> list = GetLuoZang();
            if (clientname != null && clientname != "")
            {
                list = list.Where(a => a.client_name.Contains(clientname)).ToList();
            }
            if (clientphone != null && clientphone != "")
            {
                list = list.Where(a => a.client_phone.Contains(clientphone)).ToList();
            }
            if (stime != null && stime != "")
            {
                DateTime s = DateTime.Parse(stime);
                list = list.Where(a => a.reservetime >= s).ToList();
            }
            if (etime != null && etime != "")
            {
                DateTime e = DateTime.Parse(etime);
                list = list.Where(a => a.reservetime <= e).ToList();
            }
            if (serviceid != null && serviceid != "")
            {
                list = list.Where(a => a.service_id == long.Parse(serviceid)).ToList();
            }
            if (status == "0")
            {
                list = new List<LuoZangInfo>();
            }
            if (status == "1")
            {
                list = list.Where(a => a.status == 0).ToList();
            }
            if (status == "2")
            {
                list = list.Where(a => a.status == 1).ToList();
            }
            if (status == "3")
            {
                list = list.Where(a => a.status == 0 || a.status == 1).ToList();
            }
            return list;

        }

        public string DeleteLuo(long uid)
        {
            string str = "ok";
            try
            {
                service_reserve sr = db.service_reserves.Where(a =>  a.uid == uid).SingleOrDefault();
                sr.status = 1;
                sr.total_price = 0;
                db.SubmitChanges();
                
                List<sacrifice_reserve> slist = db.sacrifice_reserves.Where(a =>a.servicereserve_id == uid).ToList();
                for (int i = 0; i < slist.Count; i++)
                {
                    sacrifice_reserve srd = new sacrifice_reserve();
                    srd = db.sacrifice_reserves.Where(a =>a.uid == slist[i].uid).SingleOrDefault();
                    srd.deleted =1;
                    db.SubmitChanges();

                }
            }
            catch (System.Exception ex)
            {
                str = ex.ToString();
            }

            return str;

        }
        //根据时间导出行事历
        public List<ExportInfo> ExportBy(string extmie)
        {
            DateTime xt = DateTime.Parse(extmie);
            var list = db.service_reserves.Where(a => a.deleted == 0 &&a.service_type==0&& a.status == 0&&(a.reserve_time>xt&&a.reserve_time<xt.AddHours(23).AddMinutes(59))).Join(db.clients, sr => sr.client_id, c => c.uid, (sr, c) => new { sr1 = sr, c1 = c }).Join(db.users, src => src.c1.owner_id, u => u.uid, (src, u) => new { src1 = src, u1 = u }).Join(db.tomb_services, src2 => src2.src1.sr1.service_id, ts => ts.uid, (src2, ts) => new { src3 = src2, ts1 = ts }).Select(ser => new ExportInfo
            {   
                uid = ser.src3.src1.sr1.uid,
                cname = ser.src3.src1.c1.realname,
                stime = ser.src3.src1.sr1.reserve_time.Year + "年" + ser.src3.src1.sr1.reserve_time.Month + "月" + ser.src3.src1.sr1.reserve_time.Day + "日 " + ser.src3.src1.sr1.reserve_time.Hour + "点" + ser.src3.src1.sr1.reserve_time.Minute+"分",
                yishiname =ser.ts1.name,
                fuwuren =ser.src3.u1.realname


            }).ToList();
            List<ExportInfo> exlist = new List<ExportInfo>();

            exlist = list;
            for (int i = 0; i < exlist.Count;i++ )
            {
                List<jipininfo> jlist = new List<jipininfo>();
                jlist = Getjipin(exlist[i].uid);
                string jname = "";
                for (int j = 0; j < jlist.Count;j++ )
                {
                    jname += jlist[j].jname + ";";
                }
                exlist[i].jipins = jname;
        
      
            }
            return exlist;

        }
        public List<jipininfo> Getjipin(long sid)
        {
            List<jipininfo> jlist = db.sacrifice_reserves.Where(a => a.deleted == 0 && a.servicereserve_id == sid).Join(db.sacrifices, sr => sr.sacrifice_id, s => s.uid, (sr, s) => new { sr1 = sr, s1 = s }).Select(src => new jipininfo
            {
                uid = src.sr1.uid,
                jname = src.s1.name+"*"+src.sr1.count,
                sid = sid




            }).ToList();

            return jlist;
        }
        public string GetHtml(List<ExportInfo> jlist)
        {
            string html = "";
            for (int i = 0; i < jlist.Count; i++)
            {
                html += "<tr>";
                html += "<td  colspan='2' rowspan='1' id='1' style='height:90px;font-size:14;border-bottom: 1px solid #000000;text-align:center;'>" + "姓名：" + jlist[i].cname + " </td>";
                html += "<td  colspan='3 ' rowspan='1' id='2' style='height:90px;font-size:14;border-bottom: 1px solid #000000;text-align:center;'>" + "日期：" + jlist[i].stime + " </td>";
                html += "<td  colspan='3 ' rowspan='1' id='3' style='height:90px;font-size:14;border-bottom: 1px solid #000000;text-align:center;v'>" + "仪式项目:" + jlist[i].yishiname + " </td>";
                html += "<td  colspan='3 ' rowspan='1' id='report_time' style='height:90px;font-size:14;border-bottom: 1px solid #000000;text-align:center;'>" + "祭品:" + jlist[i].jipins + "</td>";
                html += "<td  colspan='3 ' rowspan='1' id='report_time' style='height:90px;font-size:14;border-bottom: 1px solid #000000;border-right:0px solid red;text-align:center;'>" + "服务人：" + jlist[i].fuwuren + " </td>";
                html += "</tr>";
            }
           
            return html;
        }
    }
}
