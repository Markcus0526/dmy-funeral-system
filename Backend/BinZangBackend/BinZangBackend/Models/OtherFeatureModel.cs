using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BinZangBackend.Models
{
    public class GameURL
    {
        public String name { get; set; }
        public String game_url { get; set; }
    }
    public class JingDian
    {
        public long Id { get; set; }
        public String Name { get; set; }
        public String DiZhi { get; set; }
       // public long caozuo { get; set; }
    }
    public class QuYuInfo
    {
        public long id { get; set; }
        public String name { get; set; }
        public String city_name { get; set; }
    }
    public class ChengShiInfo
    {
        public long id { get; set; }
        public String name { get; set; }
    }
    public class EmployCover
    {
        public long id { get; set; }
        public string name { get; set; }
        public String emp_code { get; set; }
        public int? duty { get; set; }
        // public long caozuo { get; set; }
    }
    public class OfficeCover
    {
        public long id { get; set; }
        public string name { get; set; }
        public string yiyue { get; set; }
        public string eryue { get; set; }
        public string sanyue { get; set; }
        public string siyue { get; set; }
        public string wuyue { get; set; }
        public string liuyue { get; set; }
        public string qiyue { get; set; }
        public string bayue { get; set; }
        public string jiuyue { get; set; }
        public string shiyue { get; set; }
        public string shiyiyue { get; set; }
        public string shieryue { get; set; }
    }
    public class TrueAWardInfo
    {
        public int zuidiqianyuejia { get; set; }
        public int true_mudi_ticheng { get; set; }
        public int true_jipin_ticheng { get; set; }
        public int yingxiaobili { get; set; }
        public int zongyejibili { get; set; }
        public int shuilv { get; set; }
        public int lingdaobili { get; set; }
    }
    public class FalseAWardInfo
    {
        public int false_mudi_ticheng { get; set; }
        public int false_jipin_ticheng { get; set; }
    }
    public class NumberAndTime
    {
        public int? number { get; set; }
        public int? time { get; set; }
    }
    public class PriceAndTime
    {
        public long id{ get; set; }
        public int kaishijiage { get; set; }
        public int jieshujiage { get; set; }
        public int yuliushijian { get; set; }
    }
    public class OtherFeatureModel
    {
        BinZangDataContext db = new BinZangDataContext();
        public List<GameURL> FindGameURL(List<GameURL> list)
        {
            list = db.link_urls.Where(m => m.deleted == 0 && (m.name == "android_games" || m.name == "iphone_games"))
                     .Select(s => new GameURL
                     {
                        name=s.name,
                        game_url=s.url
                     }).ToList();
            return list; 
        }

        public string UpdateGameURL(string androidurl, string iosurl)
        {
            String status = "";
           try
           {
               link_url androidlink = db.link_urls.Single(m => m.name == "android_games" && m.deleted == 0);
               androidlink.url = androidurl;
               link_url ioslink = db.link_urls.Single(m => m.name == "iphone_games" && m.deleted == 0);
               ioslink.url = iosurl;
               db.SubmitChanges();
               status = "success";
           }
           catch (System.Exception ex)
           {
               status = "数据保存出错,请检查数据";
           }
           return status;
        }

        public List<GameURL> FindBasicLiftURL(List<GameURL> list)
        {
            list = db.link_urls.Where(m => m.deleted == 0 && (m.name == "meishi" || m.name == "dianyingshikebiao" || m.name == "jiudian" || m.name == "huochepiao" || m.name == "feijipiao"))
                  .Select(s => new GameURL
                  {
                      name = s.name,
                      game_url = s.url
                  }).ToList();
            return list; 
        }

        public string UpdateBasicLiftURL(string meishi, string dianying, string jiudian, string huochepiao, string feijipiao)
        {
            String status = "";
            try
            {
                List<link_url> infolist = db.link_urls.Where(m => (m.name == "meishi" || m.name == "dianyingshikebiao" || m.name == "jiudian" || m.name == "huochepiao" || m.name == "feijipiao") && m.deleted == 0).ToList();
                for (int i = 0; i < infolist.Count;i++ )
                {
                    if (infolist[i].name=="meishi")
                    {
                        infolist[i].url = meishi;
                    }
                    if (infolist[i].name == "dianyingshikebiao")
                    {
                        infolist[i].url = dianying;
                    }
                    if (infolist[i].name == "jiudian")
                    {
                        infolist[i].url = jiudian;
                    }
                    if (infolist[i].name == "huochepiao")
                    {
                        infolist[i].url = huochepiao;
                    }
                    if (infolist[i].name == "feijipiao")
                    {
                        infolist[i].url = feijipiao;
                    }

                }
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "数据保存出错,请检查数据";
            }
            return status;
        }


        public List<jingdian> FindAllScenicSpots()
        {
            List<jingdian> list = new List<jingdian>();
            list = db.jingdians.Where(m => m.deleted == 0).ToList();
            return list;
        }

        public string AddScenicSpots(string img, string name, string address, string phone, string contents, String lng, String lat)
        {
            String status = "";
           try
           {
               jingdian info = new jingdian();
               info.name = name;
               info.phone = phone;
               info.imgurl = img;
               info.address = address;
               info.html_content = contents;
               info.createtime = DateTime.Now;
               info.deleted = 0;
               info.longitude = decimal.Parse(lng);
               info.latitude = decimal.Parse(lat);
               db.jingdians.InsertOnSubmit(info);
               db.SubmitChanges();
               status = "success";
           }
           catch (System.Exception ex)
           {
               status = "保存数据有问题,请重试";
           }
           return status;
        }

        public string DeletedScenicSpots(long id)
        {
            String status = "";
            try
            {
                jingdian info = db.jingdians.Single(m => m.deleted == 0 && m.uid == id);
                info.deleted = 1;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "保存数据有问题,请重试";
            }
            return status;
        }
        public jingdian FindJingDianDetails(long id)
        {
            jingdian info = db.jingdians.Where(m => m.deleted == 0 && m.uid == id).FirstOrDefault();
            return info;
        }

        public string EditScenicSpots(string img, string name, string address, string phone, string contents, string id, String lng, String lat)
        {
            String status = "";
            try
            {
                jingdian info = db.jingdians.Single(m=>m.deleted==0&& m.uid==long.Parse(id));
                info.name = name;
                info.phone = phone;
                info.imgurl = img;
                info.address = address;
                info.html_content = contents;
                info.deleted = 0;
                info.longitude = decimal.Parse(lng);
                info.latitude = decimal.Parse(lat);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据数据有问题,请重试";
            }
            return status;
        }

        public List<EmployCover> FindEmpCover(String office)
        {
              List<EmployCover> list=new List<EmployCover>();
            if (office == "0")
            {
                      list = db.users.Where(m => m.deleted == 0&&(m.type==6||m.type==4||m.type==5))
                                    .Select(s => new EmployCover
                                    {
                                        id = s.uid,
                                        name = s.name,
                                        emp_code = s.realname,
                                        duty = s.planamount_permonth
                                    }).ToList();
            }
            else
            {
                        list  = db.users.Where(m => m.deleted == 0 && m.office_id == long.Parse(office))
                                         .Select(s => new EmployCover
                                         {
                                             id = s.uid,
                                             name = s.name,
                                             emp_code = s.realname,
                                             duty = s.planamount_permonth
                                         }).ToList();
            }
            return list;
        }

        public List<OfficeCover> FindStationCover(List<OfficeCover> list,string city)
        {
            List<office> list1 = db.offices.Where(m => m.deleted == 0).ToList();
            if (city=="0")
            {

            }
            else
            {
                list1 = list1.Where(m => m.chengshi_id == long.Parse(city)).ToList();
            }
            for (int i = 0; i < list1.Count;i++ )
            {
                OfficeCover info = new OfficeCover();
                info.id = list1[i].uid;
                var mouths = list1[i].plan_amounts.Split(',');
                for (int j = 0; j < mouths.Length;j++ )
                {
                    if (j==0)
                    {
                        info.yiyue = mouths[j];
                    }
                    if (j == 1)
                    {
                        info.eryue = mouths[j];
                    }
                    if (j == 2)
                    {
                        info.sanyue = mouths[j];
                    }
                    if (j == 3)
                    {
                        info.siyue = mouths[j];
                    }
                    if (j == 4)
                    {
                        info.wuyue = mouths[j];
                    }
                    if (j == 5)
                    {
                        info.liuyue = mouths[j];
                    }
                    if (j == 6)
                    {
                        info.qiyue = mouths[j];
                    }
                    if (j == 7)
                    {
                        info.bayue = mouths[j];
                    }
                    if (j == 8)
                    {
                        info.jiuyue = mouths[j];
                    }
                    if (j == 9)
                    {
                        info.shiyue = mouths[j];
                    }
                    if (j == 10)
                    {
                        info.shiyiyue = mouths[j];
                    }
                    if (j == 11)
                    {
                        info.shieryue = mouths[j];
                    }
                   
                }
                info.name = list1[i].name;
                list.Add(info);
            }
            return list;
        }

        public EmployCover FindEmployeById(long id)
        {
            EmployCover list = db.users.Where(m => m.deleted == 0&&m.uid==id)
                                   .Select(s => new EmployCover
                                   {
                                       id = s.uid,
                                       name = s.name,
                                       emp_code = s.realname,
                                       duty = s.planamount_permonth
                                   }).FirstOrDefault();
            return list;
        }

        public OfficeCover FindOfficeById(long id)
        {
            office officeinfo = db.offices.Where(m => m.deleted == 0 && m.uid == id).FirstOrDefault();
            OfficeCover info = new OfficeCover();
            info.id = officeinfo.uid;
            var mouths = officeinfo.plan_amounts.Split(',');
            for (int j = 0; j < mouths.Length; j++)
            {
                if (j == 0)
                {
                    info.yiyue = mouths[j];
                }
                if (j == 1)
                {
                    info.eryue = mouths[j];
                }
                if (j == 2)
                {
                    info.sanyue = mouths[j];
                }
                if (j == 3)
                {
                    info.siyue = mouths[j];
                }
                if (j == 4)
                {
                    info.wuyue = mouths[j];
                }
                if (j == 5)
                {
                    info.liuyue = mouths[j];
                }
                if (j == 6)
                {
                    info.qiyue = mouths[j];
                }
                if (j == 7)
                {
                    info.bayue = mouths[j];
                }
                if (j == 8)
                {
                    info.jiuyue = mouths[j];
                }
                if (j == 9)
                {
                    info.shiyue = mouths[j];
                }
                if (j == 10)
                {
                    info.shiyiyue = mouths[j];
                }
                if (j == 11)
                {
                    info.shieryue = mouths[j];
                }

            }
            info.name = officeinfo.name;
            return info;
        }

        public  string EditEmployById(string id, string duty)
        {
            string status = "";
            try
            {
                user info = db.users.Single(m=>m.deleted==0&&m.uid==long.Parse(id));
                if (duty!=""&&duty!=null)
                {
                    info.planamount_permonth = int.Parse(duty);
                }
                else
                {
                    info.planamount_permonth = 0;
                }
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal string EditOfficeById(string id, string duty)
        {
            string status = "";
            try
            {
                office info = db.offices.Single(m => m.deleted == 0 && m.uid == long.Parse(id));
                if (duty != "" && duty != null)
                {
                    info.plan_amounts = duty;
                }
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        public List<office>  FindOfficeList()
        {
            List<office> list = db.offices.Where(m => m.deleted == 0).ToList();
            return list;
        }

        public List<chengshi> FindCityList()
        {
            
            List<chengshi> list = db.chengshis.Where(m => m.deleted == 0).ToList();
            return list;
        }


        public List<chengshi> FindAllCity()
        {
            List<chengshi> list = db.chengshis.Where(m => m.deleted == 0).ToList();
            return list;
        }
        public List<quyu> FindAllQuyu()
        {
            List<quyu> list = db.quyus.Where(m => m.deleted == 0).ToList();
            return list;
        }

        public string FindShiName(long p)
        {
            return db.chengshis.Where(m => m.deleted == 0 && m.uid == p).FirstOrDefault().name;
        }

        public quyu FindQuyuById(long id)
        {
            return db.quyus.Where(m => m.uid == id && m.deleted == 0).FirstOrDefault();
        }

        public chengshi FindShiById(long id)
        {
            return db.chengshis.Where(m => m.uid == id && m.deleted == 0).FirstOrDefault();
        }

        public string AddQuyu(string quyu, string city)
        {
            string status = "";
            try
            {
                quyu info = new quyu();
                info.chengshi_id = long.Parse(city);
                info.name = quyu;
                info.deleted = 0;
                db.quyus.InsertOnSubmit(info);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }
        public string EditQuyu(string id, string name, string chengshi)
        {
            string status = "";
            try
            {
                quyu info = db.quyus.Single(m => m.deleted == 0 && m.uid == long.Parse(id));
                info.chengshi_id = long.Parse(chengshi);
                info.name = name;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        public string AddOffice(string city)
        {
            string status = "";
            try
            {
                chengshi info = new chengshi();
                info.name = city;
                db.chengshis.InsertOnSubmit(info);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }
        public string EditOffice(string id, string city)
        {
            string status = "";
            try
            {
                chengshi info = db.chengshis.Single(m => m.deleted == 0 && m.uid == long.Parse(id));
                info.name = city;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        public string DeletedOffice(string id)
        {
            string status = "";
            try
            {
                chengshi info = db.chengshis.Single(m => m.deleted == 0 && m.uid == long.Parse(id));
                info.deleted = 1;
                db.SubmitChanges();
                List<quyu> list = db.quyus.Where(m => m.chengshi_id == long.Parse(id)&&m.deleted==0).ToList();
                foreach(quyu q in list)
                {
                    q.deleted = 1;
                    db.SubmitChanges();

                }
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        public string DeletedQuyu(string id)
        {
            string status = "";
            try
            {
                quyu info = db.quyus.Single(m => m.deleted == 0 && m.uid == long.Parse(id));
                info.deleted = 1;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        public string ExamImg(string url1,string url2,string url3)
        {
            string res = "ok";
            try
            {
                if (url1 != null && url1 != "")
                {
                    link_url lu1 = db.link_urls.Where(a => a.name == "gongwuyuankaoshi").FirstOrDefault();
                    if (lu1 == null)
                    {
                        link_url l1 = new link_url();
                        l1.name = "gongwuyuankaoshi";
                        l1.deleted = 0;
                        l1.note = "公务员考试";
                        l1.url = url1;
                        db.link_urls.InsertOnSubmit(l1);
                        db.SubmitChanges();

                    }
                    else
                    {
                        lu1.url = url1;
                        db.SubmitChanges();
                    }
                }
                if (url2 != null && url2 != "")
                {
                    link_url lu2 = db.link_urls.Where(a => a.name == "xuexiaokaoshi").FirstOrDefault();
                    if (lu2 == null)
                    {
                        link_url l2 = new link_url();
                        l2.name = "xuexiaokaoshi";
                        l2.deleted = 0;
                        l2.note = "学校考试";
                        l2.url = url2;
                        db.link_urls.InsertOnSubmit(l2);
                        db.SubmitChanges();

                    }
                    else
                    {
                        lu2.url = url2;
                        db.SubmitChanges();
                    }
                }
                if (url3 != null && url3 != "")
                {
                    link_url lu3 = db.link_urls.Where(a => a.name == "xuexiaokaoshi").FirstOrDefault();
                    if (lu3 == null)
                    {
                        link_url l3 = new link_url();
                        l3.name = "zhengzhaokaoshi";
                        l3.deleted = 0;
                        l3.note = "证照考试";
                        l3.url = url3;
                        db.link_urls.InsertOnSubmit(l3);
                        db.SubmitChanges();

                    }
                    else
                    {
                        lu3.url = url3;
                        db.SubmitChanges();
                    }
                }
            }
            catch (System.Exception ex)
            {
                res = ex.ToString();
            }

            return res;

        }
        internal TrueAWardInfo FindTrueAward(TrueAWardInfo list)
        {
            List<bonus_coef> coeflist = new List<bonus_coef>();
            coeflist = db.bonus_coefs.Where(m => m.deleted == 0).ToList();
            for (int i = 0; i < coeflist.Count; i++)
            {
                if (coeflist[i].name == "zuidiqianyuejia")
                {
                    list.zuidiqianyuejia = coeflist[i].value;
                }
                if (coeflist[i].name == "zongyejibili")
                {
                    list.zongyejibili = coeflist[i].value;
                }
                if (coeflist[i].name == "yingxiaobili")
                {
                    list.yingxiaobili = coeflist[i].value;
                }
                if (coeflist[i].name == "true_mudi_ticheng")
                {
                    list.true_mudi_ticheng  = coeflist[i].value;
                }
                if (coeflist[i].name == "true_jipin_ticheng")
                {
                    list.true_jipin_ticheng = coeflist[i].value;
                }
                if (coeflist[i].name == "lingdaobili")
                {
                    list.lingdaobili = coeflist[i].value;
                }
                if (coeflist[i].name == "shuilv")
                {
                    list.shuilv= coeflist[i].value;
                }
            }
            return list; 
        }

        internal FalseAWardInfo FindFalseAward(FalseAWardInfo list)
        {
            List<bonus_coef> coeflist = new List<bonus_coef>();
            coeflist = db.bonus_coefs.Where(m => m.deleted == 0).ToList();
            for (int i = 0; i < coeflist.Count; i++)
            {

                if (coeflist[i].name == "false_mudi_ticheng")
                {
                    list.false_mudi_ticheng = coeflist[i].value;
                }
                if (coeflist[i].name == "false_jipin_ticheng")
                {
                    list.false_jipin_ticheng = coeflist[i].value;
                }
            }
            return list; 
        }

        internal string EditFalseAward(string param, string leixing)
        {
            string status = "";
            try
            {
                
                if (leixing=="0")
                {
                    bonus_coef info = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "false_jipin_ticheng").FirstOrDefault();
                    info.value =int.Parse(param);
                }else if (leixing =="1")
                {
                    bonus_coef info = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "false_mudi_ticheng").FirstOrDefault();
                    info.value = int.Parse(param);
                }
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }
        internal string EditTrueAward(string param, string leixing)
        {
            string status = "";
            try
            {

                if (leixing == "0")
                {
                    bonus_coef info = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "zuidiqianyuejia").FirstOrDefault();
                    info.value = int.Parse(param);
                }
                else if (leixing == "1")
                {
                    bonus_coef info = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "true_mudi_ticheng").FirstOrDefault();
                    info.value = int.Parse(param);
                }
                else if (leixing == "2")
                {
                    bonus_coef info = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "true_jipin_ticheng").FirstOrDefault();
                    info.value = int.Parse(param);
                }
                else if (leixing == "3")
                {
                    bonus_coef info = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "yingxiaobili").FirstOrDefault();
                    info.value = int.Parse(param);
                }
                else if (leixing == "4")
                {
                    bonus_coef info = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "zongyejibili").FirstOrDefault();
                    info.value = int.Parse(param);
                }
                else if (leixing == "5")
                {
                    bonus_coef info = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "shuilv").FirstOrDefault();
                    info.value = int.Parse(param);
                }
                else if (leixing == "6")
                {
                    bonus_coef info = db.bonus_coefs.Where(m => m.deleted == 0 && m.name == "lingdaobili").FirstOrDefault();
                    info.value = int.Parse(param);
                }
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal user FindInfoByName(string name)
        {
            user info = new user();
            try
            {
            
             info=db.users.Where(m=>m.deleted==0&&m.name==name).FirstOrDefault();
            
            }
            catch (System.Exception ex)
            {

            }
            return info;
        }


        internal string EditPassword(string password, string id)
        {
            string status = "";
            try
            {
                user info = db.users.Single(m => m.deleted == 0 && m.uid == long.Parse(id));
                info.password = UserModel.GetMD5Hash(password.Trim());
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal NumberAndTime FindNumberAndTime(NumberAndTime list)
        {
            List<environ> infos = db.environs.Where(m => m.deleted == 0 && (m.name == "mudiyuliushijian" || m.name == "luozangchangcirenshu")).ToList();
            for (int i = 0; i < infos.Count;i++ )
            {
                if (infos[i].name == "mudiyuliushijian")
                {
                    list.time = infos[i].value;
                }
                if (infos[i].name == "luozangchangcirenshu")
                {
                    list.number= infos[i].value;
                }
            }
            return list;
        }

        internal List<PriceAndTime> FindPriceAndTime(List<PriceAndTime> list)
        {
            list = db.deposit_types.Where(m => m.deleted == 0).Select(s => new PriceAndTime
            {
                id=s.uid,
                kaishijiage=s.min_price,
                jieshujiage=s.max_price,
                yuliushijian=s.period
            }).ToList();
            return list;
        }

        internal PriceAndTime FindUpdateInfo(long id)
        {
            PriceAndTime list = db.deposit_types.Where(m => m.deleted == 0&&m.uid==id).Select(s => new PriceAndTime
            {
                id = s.uid,
                kaishijiage = s.min_price,
                jieshujiage = s.max_price,
                yuliushijian = s.period
            }).FirstOrDefault();
            return list;
        }

        internal string AddAdjustInfo(string kaishijiage, string jieshujiage, string yuliushijian)
        {

            string status = "";
            try
            {
                deposit_type info = new deposit_type();
                info.period = int.Parse(yuliushijian);
                info.min_price = int.Parse(kaishijiage);
                info.max_price = int.Parse(jieshujiage);
                info.deleted = 0;
                db.deposit_types.InsertOnSubmit(info);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal string UpdateAdjustInfo(string kaishijiage, string jieshujiage, string yuliushijian, string id)
        {

            string status = "";
            try
            {
                deposit_type info = db.deposit_types.Single(m => m.deleted == 0 && m.uid == long.Parse(id));
                info.period = int.Parse(yuliushijian);
                info.min_price = int.Parse(kaishijiage);
                info.max_price = int.Parse(jieshujiage);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal string DeletedAdjustInfo(long id)
        {
            string status = "";
            try
            {
                deposit_type info = db.deposit_types.Single(m => m.deleted == 0 && m.uid == id);
                info.deleted = 1;
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal string UpdateTimeInfo(string time)
        {
            string status = "";
            try
            {
                environ info = db.environs.Single(m => m.deleted == 0 && m.name == "mudiyuliushijian");
                info.value = int.Parse(time);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

        internal string UpdateNumberInfo(string number)
        {
            string status = "";
            try
            {
                environ info = db.environs.Single(m => m.deleted == 0 && m.name == "luozangchangcirenshu");
                info.value = int.Parse(number);
                db.SubmitChanges();
                status = "success";
            }
            catch (System.Exception ex)
            {
                status = "修改数据错误,请检查后重新输入";
            }
            return status;
        }

    }
}
