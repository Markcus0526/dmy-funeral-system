using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BinZangBackend.Models
{
    public class LingMuInfo
    {
        public long uid { get; set; }
        public string cname { get; set; }
        public string phone { get; set; }
        public string yuanqu { get; set; }
        public string muwei { get; set; }
        public string officename { get; set; }
        public long officeid { get; set; }
        public string uname { get; set; }
        public string onwername { get; set; }
        public long yuanid { get; set; }
        public int cishu { get; set; }
        public long xiadanid { get; set; }
        public int status { get; set; }
        public string endtime { get; set; }

    }
    public class LingMuModel
    {
        BinZangDataContext db = new BinZangDataContext();
        public List<LingMuInfo> GetLingMuRes(string cname,string phone,long yuanid,string muwei)
        {
            environ e = new environ();
            e= db.environs.Where(a=>a.name=="mudiyuliushijian").SingleOrDefault();
            int t = (int )e.value;
            List<LingMuInfo> list = new List<LingMuInfo>();
            var l = db.tomb_purchases.Where(a => a.deleted == 0).ToList();
            var reslist = db.tomb_reserves.Where(a => a.deleted == 0&&a.reserve_time.AddHours(t)>DateTime.Now).Join(db.users, tr => tr.user_id, us=> us.uid, (tr, us) => new { tr1 = tr, u1 = us }).Join(db.grave_sites, tru => tru.tr1.tombsite_id, tbs => tbs.uid, (tru, tbs) => new { tru1 = tru, tb1 = tbs }).Join(db.tomb_areas, tru2 => tru2.tb1.tombarea_id, ta => ta.uid, (tru2, ta) => new { tru3=tru2,ta1=ta}).Join(db.offices,tru4=>tru4.tru3.tru1.u1.office_id,o=>o.uid,(tru4,o)=>new{tru5=tru4,o1=o}).Select(trs => new LingMuInfo
            {
               uid = trs.tru5.tru3.tru1.tr1.uid,
              cname  = trs.tru5.tru3.tru1.tr1.name,
              phone = trs.tru5.tru3.tru1.tr1.phone,
              yuanqu = trs.tru5.ta1.name,
              muwei = trs.tru5.tru3.tb1.row_number + "排" + trs.tru5.tru3.tb1.column_number + "列",
              uname = trs.tru5.tru3.tru1.u1.realname,
              xiadanid = trs.tru5.tru3.tru1.u1.uid,
              status=1,
              yuanid = trs.tru5.ta1.uid,
              officeid = trs.o1.uid,
              officename = trs.o1.name,
               endtime = trs.tru5.tru3.tru1.tr1.reserve_time.AddHours(t).Year + "年" + trs.tru5.tru3.tru1.tr1.reserve_time.AddHours(t).Month + "月" + trs.tru5.tru3.tru1.tr1.reserve_time.AddHours(t).Day + "日 " + trs.tru5.tru3.tru1.tr1.reserve_time.AddHours(t).Hour + "点" + trs.tru5.tru3.tru1.tr1.reserve_time.AddHours(t).Minute+"分"


            }).OrderByDescending(m=>m.uid).ToList();
          if (cname!=null&&cname!="")
          {
              reslist = reslist.Where(a => a.cname.Contains(cname)).ToList();
          }
         
            if (phone != null && phone != "")
            {
                reslist = reslist.Where(a => a.phone.Contains(phone)).ToList();

            }
            if (yuanid!=null&&yuanid >0)
            {
                reslist = reslist.Where(a => a.yuanid == yuanid).ToList();
            }
            if (muwei!=null&&muwei!="")
            {
                reslist = reslist.Where(a => a.muwei.Contains(muwei)).ToList();
            }
            for (int i = 0; i < reslist.Count;i++)
            {  List<LingMuInfo> clist = new List<LingMuInfo>();
            user us1 = db.users.Where(a => a.uid == reslist[i].xiadanid).FirstOrDefault();
            if (us1.type == 7)
            {
                user us2 = db.users.Where(a => a.uid == us1.owner_id).FirstOrDefault();
                reslist[i].onwername = us2.realname;
            }
            else
            {
                reslist[i].onwername = us1.realname;
            }

            clist = reslist.Where(a => a.xiadanid == reslist[i].xiadanid).ToList();
            reslist[i].cishu = clist.Count;
            }
            list = reslist;
            return list;

        }
        public List<tomb_area> Getyuan()
        {


            return db.tomb_areas.Where(a => a.deleted == 0).ToList();
        }
        public string DelLingMu(long uid)
        {
            string res = "ok";
            try
            {
                tomb_reserve t = db.tomb_reserves.Where(a => a.deleted == 0 && a.uid == uid).FirstOrDefault();
                t.deleted = 1;
                db.SubmitChanges();
            }
            catch (System.Exception ex)
            {
                res = ex.ToString();
            }
            return res;

        }

    }
}
