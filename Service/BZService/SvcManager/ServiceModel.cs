using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BZService.DBManager;
using BZService.SvcManager;
using Newtonsoft.Json.Linq;
using JpushApiClient;

namespace BZService.SvcManager
{
	public class ServiceModel
	{
		/* Test method */
		public static SVCResult Test()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = String.Empty;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getBannerImages(int category)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();


				List<STAdvertImage> arr_images = new List<STAdvertImage>();

                if (category < 0) category = 0;
                arr_images = dbConn.sceneries
                    .Where(m => m.deleted == 0)
                    .Select(m => new STAdvertImage
                    {
                        uid = m.uid,
                        image_url = Global.getAbsImgUrl(m.imgurl)
                    })
                    .ToList();
                
				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = arr_images;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getAreaPoints()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

                int mapimage_width = 1024;
                int mapimage_height = 768;

                environ widthEnviron = dbConn.environs
                    .Where(m => m.name.Equals("mapimage_width") &&
                    m.deleted == 0)
                    .FirstOrDefault();
                if (widthEnviron != null) mapimage_width = (int)widthEnviron.value;

                environ heightEnviron = dbConn.environs
                    .Where(m => m.name.Equals("mapimage_height") &&
                    m.deleted == 0)
                    .FirstOrDefault();
                if (heightEnviron != null) mapimage_height = (int)heightEnviron.value;


				List<STAreaPoint> arr_points = new List<STAreaPoint>();

                arr_points = dbConn.tomb_areas
                    .Where(m => m.deleted == 0)
                    .Select(m => new STAreaPoint
                    {
                        uid = m.uid,
                        name = m.name,
                        contents = m.description,
                        x_rate = (double)m.xpos / mapimage_width,
                        y_rate = (double)m.ypos / mapimage_height,
                        row_count = m.row_count ?? 0,
                        column_count = m.column_count ?? 0,
                        type = m.type,
                        image_url = Global.getAbsImgUrl(m.img_url)
                    })
                    .ToList();
                
				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = arr_points;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getAreaPointDetail(long area_id)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

                tomb_area tombArea = dbConn.tomb_areas
                    .Where(m => m.uid == area_id && m.deleted == 0)
                    .FirstOrDefault();

                if (tombArea == null)
                {
                    result.retcode = ErrMgr.ERRCODE_NORMAL;
                    result.retmsg = ErrMgr.ERRMSG_NORMAL;
                    return result;
                }

                int mapimage_width = 1024;
                int mapimage_height = 768;

                environ widthEnviron = dbConn.environs
                    .Where(m => m.name.Equals("mapimage_width") &&
                    m.deleted == 0)
                    .FirstOrDefault();
                if (widthEnviron != null) mapimage_width = (int)widthEnviron.value;

                environ heightEnviron = dbConn.environs
                    .Where(m => m.name.Equals("mapimage_height") &&
                    m.deleted == 0)
                    .FirstOrDefault();
                if (heightEnviron != null) mapimage_height = (int)heightEnviron.value;

                STAreaPoint area_point = new STAreaPoint();
                area_point.uid = tombArea.uid;
                area_point.name = tombArea.name;
                area_point.type = tombArea.type;
                area_point.contents = tombArea.description;
                area_point.x_rate = (double)tombArea.xpos / mapimage_width;
                area_point.y_rate = (double)tombArea.ypos / mapimage_height;
                area_point.row_count = tombArea.row_count ?? 0;
                area_point.column_count = tombArea.column_count ?? 0;

                List<STProduct> arrGraveSites = null;
                arrGraveSites = dbConn.grave_sites
                    .Where(m => m.tombarea_id == tombArea.uid)
                    .Select(m => new STProduct
                    {
                        uid = m.uid,
                        image_url = m.gravestone_imgurl,
                        title = m.number,
                        type = 0,
                        product_origin = m.gravestone_type,
                        price = m.price,
                        price_desc = m.price + "元"
                    })
                    .ToList();

                List<STProduct> arrGraveTablets = null;
                arrGraveTablets = dbConn.grave_tablets
                    .Where(m => m.tombarea_id == tombArea.uid)
                    .Select(m => new STProduct
                    {
                        uid = m.uid,
                        title = m.number,
                        type = 1,
                        price = m.price,
                        price_desc = m.price + "元"
                    })
                    .ToList();

                if (area_point.type == (int)ConstMgr.TombAreaType.MUDI)
                {
                    area_point.products = arrGraveSites;
                }
                else
                {
                    area_point.products = arrGraveTablets;
                }
                
				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = area_point;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getOneDragonAreas()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();


				List<STDragonServiceCity> arr_cities = new List<STDragonServiceCity>();

                arr_cities = dbConn.chengshis
                    .Where(m => m.deleted == 0)
                    .Select(m => new STDragonServiceCity
                    {
                        uid = m.uid,
                        name = m.name,
                        areas = dbConn.quyus
                        .Where(k => k.chengshi_id == m.uid && k.deleted == 0)
                        .Select(k => new STDragonServiceArea
                        {
                            uid = k.uid,
                            name = k.name
                        })
                        .ToList()
                    })
                    .ToList();

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = arr_cities;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}

		public static SVCResult getOneDragonAreaDetail(long area_id)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();


				STDragonServiceArea area_info = new STDragonServiceArea();

                quyu quyuItem = dbConn.quyus
                    .Where(m => m.uid == area_id && m.deleted == 0)
                    .FirstOrDefault();

                if (quyuItem == null)
                {
                    result.retcode = ErrMgr.ERRCODE_NORMAL;
                    result.retmsg = ErrMgr.ERRMSG_NORMAL;
                    return result;
                }

                area_info.uid = quyuItem.uid;
                area_info.name = quyuItem.name;
                area_info.services = dbConn.yitiaolongs
                    .Where(m => m.quyu_id == area_id && m.deleted == 0)
                    .Select(m => new STDragonService
                    {
                        uid = m.uid,
                        image_url = Global.getAbsImgUrl(m.img_url),
                        name = m.name,
                        intro = m.description,
                        product_intro = m.product_description,
                        service_contents = m.service_content,
                        price = m.price,
                        price_desc = m.price + "元",
                        user_agree_rate = (int)m.recognition_degree
                    })
                    .ToList();
                
				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = area_info;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getOneDragonCompanyDetail(long service_id)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

                STDragonService service = dbConn.yitiaolongs
                    .Where(m => m.uid == service_id && m.deleted == 0)
                    .Select(m => new STDragonService
                    {
                        uid = m.uid,
                        image_url = Global.getAbsImgUrl(m.img_url),
                        name = m.name,
                        intro = m.description,
                        product_intro = m.product_description,
                        service_contents = m.service_content,
                        price = m.price,
                        price_desc = m.price + "元",
                        user_agree_rate = (int)m.recognition_degree
                    })
                    .FirstOrDefault();

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = service;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getTombKnowledge()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();


				STTombKnowledge knowledge = new STTombKnowledge();

                knowledge.buy_tomb_flow = Global.GetHtmlContent(dbConn.informations
                    .Where(m => m.name.Equals("goumuliucheng") && m.deleted == 0)
                    .FirstOrDefault()
                    .html_content);

                knowledge.precaution = Global.GetHtmlContent(dbConn.informations
                    .Where(m => m.name.Equals("goumuzhuyishixiang") && m.deleted == 0)
                    .FirstOrDefault()
                    .html_content);
                knowledge.bury_custom = Global.GetHtmlContent(dbConn.informations
                    .Where(m => m.name.Equals("luozangxisu") && m.deleted == 0)
                    .FirstOrDefault()
                    .html_content);
                knowledge.bury_news_url = dbConn.link_urls
                    .Where(m => m.name.Equals("luozangshishi") && m.deleted == 0)
                    .FirstOrDefault()
                    .url;
                
				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = knowledge;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getAfterService()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();


				STAfterService service = new STAfterService();

                service.bury_services = dbConn.tomb_services
                    .Where(m => m.type == (byte)ConstMgr.TombServiceType.TOMB_SERVICE_TYPE_LUOZANG
                    && m.deleted == 0)
                    .Select(m => new STBuryService
                    {
                        uid = m.uid,
                        title = m.name,
                        splash_image_url = Global.getAbsImgUrl(m.imgurl),
                        video_url = Global.getAbsImgUrl(m.videourl),
                        contents = m.description,
                        price = m.price,
                        price_desc = m.price + "元"
                    })
                    .ToList();

                service.deputy_services = new List<STDeputyService>();
                service.deputy_services.Add(new STDeputyService
                {
                    title = "代祭拜服务",
                    contents = Global.GetHtmlContent(dbConn.informations.Where(m => m.name.Equals("daijibai")).FirstOrDefault().html_content)
                });

                service.deputy_services.Add(new STDeputyService
                {
                    title = "祭品代购服务",
                    contents = Global.GetHtmlContent(dbConn.informations.Where(m => m.name.Equals("jipindaigou")).FirstOrDefault().html_content)
                }); 

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = service;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getFuneralProducts()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();


				List<STProduct> arrProducts = new List<STProduct>();

                arrProducts = dbConn.sacrifices
                    .Where(m => m.deleted == 0)
                    .Select(m => new STProduct
                    {
                        uid = m.uid,
                        type = m.type,
                        type_desc = ConstMgr.getProductTypeDesc(m.type),
                        title = m.name,
                        image_url = Global.getAbsImgUrl(m.imgurl),
                        price = m.price,
                        price_desc = m.price + "元",
                        max_amount = 0,
                        max_amount_desc = ""
                    })
                    .ToList();

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = arrProducts;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult get36Views()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				List<ST36View> arrViews = new List<ST36View>();

                arrViews = dbConn.sceneries
                    .OrderByDescending(m => m.createtime)
                    .Where(m => m.deleted == 0)
                    .Select(m => new ST36View
                    {
                        uid = m.uid,
                        title = m.name,
                        image_url = Global.getAbsImgUrl(m.imgurl),
                        contents = Global.GetHtmlContent(m.html_content)
                    })
                    .ToList();

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = arrViews;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult get36ViewDetail(long view_id)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				ST36View view = new ST36View();

                view = dbConn.sceneries
                    .Where(m => m.uid == view_id && m.deleted == 0)
                    .Select(m => new ST36View
                    {
                        uid = m.uid,
                        title = m.name,
                        image_url = Global.getAbsImgUrl(m.imgurl),
                        contents = Global.GetHtmlContent(m.html_content)
                    })
                    .FirstOrDefault();

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = view;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getNavDestination()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				Dictionary<String, Object> retdata = new Dictionary<String, Object>();
                retdata.Add("lat", "42.034359");
                retdata.Add("lng", "123.836057");

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = retdata;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getOfficeIntros()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();



				List<STOfficeCity> arrCities = new List<STOfficeCity>();

                arrCities = dbConn.chengshis
                    .Where(m => m.deleted == 0)
                    .Select(m => new STOfficeCity
                    {
                        uid = m.uid,
                        name = m.name,
                        offices = dbConn.offices
                        .Where(k => k.chengshi_id == m.uid && k.deleted == 0)
                        .Select(k => new STOffice
                        {
                            uid = k.uid,
                            name = k.name,
                            address = k.address,
                            phone = k.phone,
                            image_url = Global.getAbsImgUrl(k.imgurl),
                            lat = (double)k.latitude,
                            lng = (double)k.longitude
                        })
                        .ToList()
                    })
                    .ToList();

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = arrCities;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getOfficeDetail(long office_id)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				STOffice office = new STOffice();

#if true
                office = dbConn.offices
                    .Where(m => m.uid == office_id && m.deleted == 0)
                    .Select(m => new STOffice
                    {
                        uid = m.uid,
                        name = m.name,
                        phone = m.phone,
                        image_url = Global.getAbsImgUrl(m.imgurl),
                        address = m.address,
                        lat = (double)m.latitude,
                        lng = (double)m.longitude,
                        chief = m.chief,
                        subchief = m.subchief,
                        employees = dbConn.users
                            .Where(k => k.office_id == office_id &&
                            (k.type == (byte)ConstMgr.UserType.USER_TYPE_EMPLOYEE ||
                            k.type == (byte)ConstMgr.UserType.USER_TYPE_MANAGER ||
                            k.type == (byte)ConstMgr.UserType.USER_TYPE_VICE_MANAGER) &&
                            k.deleted == 0)
                            .OrderBy(k => k.type)
                            .Select(k => new STEmployee
                            {
                                uid = k.uid,
                                description = ConstMgr.getUserTypeDesc(k.type),
                                name = k.realname,
                                photo_url = Global.getAbsImgUrl(k.imgurl),
                                phone = k.phone,
                                qq = k.qq,
                                wechat = k.weixin
                            })                            
                            .ToList()
                        
                    })
                    .FirstOrDefault();

#else
				office.uid = 6;
				office.name = "办事处6";
				office.address = "辽宁省沈阳市长白三街172-13-1门";
				office.phone = "13840030313";
				office.image_url = "http://img.ledanji.com/other/game/game/img/526/412762c566210e5a3bb8dd30acc92876_t_w520_h390.jpg";
				office.lat = 41.814011792037;
				office.lng = 123.41814773332;

				List<STEmployee> arrEmployees = new List<STEmployee>();

				STEmployee emp1 = new STEmployee();
				emp1.uid = 1;
				emp1.description = "主任";
				emp1.name = "进进进";
				emp1.photo_url = "http://pinkie.ponychan.net/chan/files/thumb/136142778613s.png";
				emp1.phone = "13800001111";
				emp1.qq = "3902387402";
				emp1.wechat = "weixin_account";
				arrEmployees.Add(emp1);

				STEmployee emp2 = new STEmployee();
				emp2.uid = 2;
				emp2.description = "副主任";
				emp2.name = "进进进";
				emp2.photo_url = "http://pinkie.ponychan.net/chan/files/thumb/136142778613s.png";
				emp2.phone = "13800001111";
				emp2.qq = "3902387402";
				emp2.wechat = "weixin_account";
				arrEmployees.Add(emp2);

				STEmployee emp3 = new STEmployee();
				emp3.uid = 3;
				emp3.description = "员工";
				emp3.name = "进进进";
				emp3.photo_url = "http://pinkie.ponychan.net/chan/files/thumb/136142778613s.png";
				emp3.phone = "13800001111";
				emp3.qq = "3902387402";
				emp3.wechat = "weixin_account";
				arrEmployees.Add(emp3);

				STEmployee emp4 = new STEmployee();
				emp4.uid = 4;
				emp4.description = "员工";
				emp4.name = "进进进";
				emp4.photo_url = "http://pinkie.ponychan.net/chan/files/thumb/136142778613s.png";
				emp4.phone = "13800001111";
				emp4.qq = "3902387402";
				emp4.wechat = "weixin_account";
				arrEmployees.Add(emp4);
                                 
                office.employees = arrEmployees;
#endif

                result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = office;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getCompanyIntro()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				Dictionary<String, Object> retdata = new Dictionary<String, Object>();

                String jianjieImage = "";
                String jianjieContents = "";
                String fuwurexian = "400-2365-545";

                link_url urlItem = dbConn.link_urls
                    .Where(m => m.name.Equals("gongsijianjie") &&
                        m.deleted == 0).FirstOrDefault();
                if (urlItem != null) jianjieImage = Global.getAbsImgUrl(urlItem.url);
                retdata.Add("image_url", jianjieImage);

                information infoItem = dbConn.informations.Where(m => m.name.Equals("gongsijianjie")).FirstOrDefault();
                if (infoItem != null) jianjieContents = Global.GetHtmlContent(infoItem.html_content);
                retdata.Add("contents", jianjieContents);

                environ envItem = dbConn.environs
                    .Where(m => m.name.Equals("fuwurexian") &&
                        m.deleted == 0).FirstOrDefault();
                if (envItem != null) fuwurexian = envItem.txt_value;
                retdata.Add("phone", fuwurexian);

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = retdata;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getFoodPageUrl()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				Dictionary<String, Object> retdata = new Dictionary<String, Object>();

                retdata.Add("page_url", dbConn.link_urls
                    .Where(m => m.name.Equals("meishi") && m.deleted == 0).FirstOrDefault().url);
				//retdata.Add("page_url", "http://m.dianping.com/shoplist/18/r/130/c/10/s/s_-1");

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = retdata;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getShopPageUrl()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				Dictionary<String, Object> retdata = new Dictionary<String, Object>();
                retdata.Add("page_url", dbConn.link_urls
                    .Where(m => m.name.Equals("dianyingshikebiao") && m.deleted == 0).FirstOrDefault().url);
				//retdata.Add("page_url", "http://www.baidu.com/");

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = retdata;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getHotelPageUrl()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				Dictionary<String, Object> retdata = new Dictionary<String, Object>();
                retdata.Add("page_url", dbConn.link_urls
                    .Where(m => m.name.Equals("jiudian") && m.deleted == 0).FirstOrDefault().url);
				//retdata.Add("page_url", "http://www.baidu.com/");

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = retdata;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getJournalPageUrl()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				Dictionary<String, Object> retdata = new Dictionary<String, Object>();
                retdata.Add("plane_page_url", dbConn.link_urls
                    .Where(m => m.name.Equals("feijipiao") && m.deleted == 0).FirstOrDefault().url);
                retdata.Add("train_page_url", dbConn.link_urls
                    .Where(m => m.name.Equals("huochepiao") && m.deleted == 0).FirstOrDefault().url);
				
				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = retdata;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getCinemaPageUrl()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				Dictionary<String, Object> retdata = new Dictionary<String, Object>();
                retdata.Add("page_url", dbConn.link_urls
                    .Where(m => m.name.Equals("dianyingshikebiao") && m.deleted == 0).FirstOrDefault().url);
				
				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = retdata;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getGamePageUrl()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				Dictionary<String, Object> retdata = new Dictionary<String, Object>();
                retdata.Add("page_url", dbConn.link_urls
                    .Where(m => m.name.Equals("android_games") && m.deleted == 0).FirstOrDefault().url);
				
				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = retdata;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getExamTimeTableImageUrl()
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				Dictionary<String, Object> retdata = new Dictionary<String, Object>();

                retdata.Add("worker_image_url", Global.getAbsImgUrl(dbConn.link_urls
                    .Where(m => m.name.Equals("gongwuyuankaoshi") && m.deleted == 0).FirstOrDefault().url));
                retdata.Add("school_image_url", Global.getAbsImgUrl(dbConn.link_urls
                    .Where(m => m.name.Equals("xuexiaokaoshi") && m.deleted == 0).FirstOrDefault().url));
                retdata.Add("photo_image_url", Global.getAbsImgUrl(dbConn.link_urls
                    .Where(m => m.name.Equals("zhengzhaokaoshi") && m.deleted == 0).FirstOrDefault().url));

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = retdata;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getMtQiPanViews(int page_no)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();


				List<STMtQiPanView> arrViews = new List<STMtQiPanView>();

                arrViews = dbConn.jingdians
                    .Where(m => m.deleted == 0)
                    .Select(m => new STMtQiPanView
                    {
                        uid = m.uid,
                        title = m.name,
                        image_url = Global.getAbsImgUrl(m.imgurl),
                        address = m.address,
                        phone = m.phone,
                        lat = (double)m.latitude,
                        lng = (double)m.longitude
                    })
                    .ToList()
                    .Skip(Global.PAGEITEM_COUNT * page_no)
                    .Take(Global.PAGEITEM_COUNT)
                    .ToList();

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = arrViews;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getMtQiPanViewDetail(long view_id)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();
                
				STMtQiPanView view = new STMtQiPanView();

                view = dbConn.jingdians
                    .Where(m => m.uid == view_id && m.deleted == 0)
                    .Select(m => new STMtQiPanView
                    {
                        uid = m.uid,
                        title = m.name,
                        image_url = Global.getAbsImgUrl(m.imgurl),
                        address = m.address,
                        phone = m.phone,
                        lat = (double)m.latitude,
                        lng = (double)m.longitude,
                        contents = Global.GetHtmlContent(m.html_content)
                    })
                    .FirstOrDefault();

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
				result.retdata = view;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


        public static SVCResult reserveVisit(String phone, String nick_name, long office_id, String reserve_time)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

                office officeItem = dbConn.offices
                    .Where(m => m.uid == office_id && m.deleted == 0)
                    .FirstOrDefault();
                if (officeItem == null)
                {
                    result.retcode = ErrMgr.ERRCODE_NORMAL;
                    result.retmsg = ErrMgr.ERRMSG_NORMAL;
                    result.retdata = String.Empty;
                    return result;
                }

                DateTime targetTime = Convert.ToDateTime(reserve_time);
                if (targetTime == null)
                {
                    result.retcode = ErrMgr.ERRCODE_NORMAL;
                    result.retmsg = "日期格式错误";
                    return result;
                }

                if ((targetTime - DateTime.Today).Days <= 0)
                {
                    result.retcode = ErrMgr.ERRCODE_NORMAL;
                    result.retmsg = "预约日期无效";
                    return result;
                }

                visit_reserve visitReserve = new visit_reserve();
                visitReserve.phone = phone;
                visitReserve.name = nick_name;
                visitReserve.office_id = office_id;
                visitReserve.reservetime = Convert.ToDateTime(reserve_time);
                visitReserve.createtime = DateTime.Now;
                visitReserve.status = 0;
                visitReserve.deleted = 0;
                dbConn.visit_reserves.InsertOnSubmit(visitReserve);
                dbConn.SubmitChanges();

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult loginUser(String user_name, String password, int platform, String device_token)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Create a token to use in this session. This token must be saved in DB
				String accessToken = SvcCommon.createAccessToken(user_name, password, platform, device_token);


				int user_type = -1;
                long user_id = 0;
                String real_name = "";
                long office_id = 0;
                String office_name = "";
                String credential_image = "";

                var clientItem = dbConn.clients
                    .Where(m => m.name.Equals(user_name) &&
                    m.password.Equals(Global.MD5Hash(password)) &&
                    m.deleted == 0)
                    .FirstOrDefault();
                if (clientItem != null)
                {
                    user_id = clientItem.uid;
                    real_name = clientItem.realname;
                    user_type = (int)ConstMgr.UserType.USER_TYPE_CUSTOMER;

                    clientItem.access_token = accessToken;
                    dbConn.SubmitChanges();
                }
                else
                {
                    var userItem = dbConn.users
                        .Where(m => m.name.Equals(user_name) &&
                            m.password.Equals(Global.MD5Hash(password)) &&
                            m.deleted == 0)
                            .FirstOrDefault();
                    if (userItem != null)
                    {
                        user_id = userItem.uid;
                        real_name = userItem.realname;
                        user_type = (int)userItem.type;
                        office_id = userItem.office_id ?? 0;
                        office officeItem = dbConn.offices.Where(m => m.uid == office_id).FirstOrDefault();
                        if(officeItem != null)
                            office_name = officeItem.name;

                        userItem.access_token = accessToken;
                        dbConn.SubmitChanges();
                    }
                }

                var envCredentialImage = dbConn.link_urls
                    .Where(m => m.name.Equals("credential_image") && m.deleted == 0)
                    .FirstOrDefault();

                if (envCredentialImage != null)
                    credential_image = Global.getAbsImgUrl(envCredentialImage.url);

				if (user_type < 0)
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = "用户名或密码错误！";
				}
				else
				{
					Dictionary<String, Object> retdata = new Dictionary<String, Object>();
					retdata.Add("user_id", user_id);
                    retdata.Add("name", real_name);
					retdata.Add("access_token", accessToken);
					retdata.Add("office_id", office_id);
                    retdata.Add("office_name", office_name);
					retdata.Add("user_type", user_type);
                    retdata.Add("credential_image", credential_image);

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = retdata;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult forgotPassword(String user_name,
			String phone,
			String new_password)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

                client clientItem = dbConn.clients
                    .Where(m => m.name.Equals(user_name) &&
                        m.phone.Equals(phone) &&
                        m.deleted == 0)
                        .FirstOrDefault();

                if (clientItem != null)
                {
                    clientItem.password = Global.MD5Hash(new_password);
                    dbConn.SubmitChanges();
                }
                else
                {
                    user userItem = dbConn.users
                        .Where(m => m.name.Equals(user_name) &&
                        m.phone.Equals(phone) &&
                        m.deleted == 0)
                        .FirstOrDefault();
                    if (userItem != null)
                    {
                        userItem.password = Global.MD5Hash(new_password);
                        dbConn.SubmitChanges();
                    }
                    else
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = ErrMgr.ERRMSG_NORMAL;
                        return result;
                    }
                }

				result.retcode = ErrMgr.ERRCODE_NONE;
				result.retmsg = ErrMgr.ERRMSG_NONE;
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getAdverts(long user_id,
			int user_type,
			String check_sum,
			String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
                    STUser userInfo = null;
                    if (user_type == (int)ConstMgr.UserType.USER_TYPE_CUSTOMER)
                    {
                        userInfo = dbConn.clients
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
                    }
                    else
                    {
                        userInfo = dbConn.users
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

                    if (userInfo == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = ErrMgr.ERRMSG_NORMAL;
                        result.retdata = String.Empty;
                        return result;
                    }

                    List<int> arrCategory = new List<int>();
                    switch (userInfo.type)
                    {
                        case (int)ConstMgr.UserType.USER_TYPE_CHAIRMAN:
                        case (int)ConstMgr.UserType.USER_TYPE_GENERALMANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_VICE_GENERALMANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_MANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_VICE_MANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_EMPLOYEE:
                            arrCategory.Add(0);
                            arrCategory.Add(1);
                            arrCategory.Add(2);
                            arrCategory.Add(3);
                            break;
                        case (int)ConstMgr.UserType.USER_TYPE_AGENT:
                        case (int)ConstMgr.UserType.USER_TYPE_CUSTOMER:
                            arrCategory.Add(0);
                            arrCategory.Add(3);
                            break;
                    }
					// Adverts
					List<STAdvertImage> arrAdverts = new List<STAdvertImage>();

                    arrAdverts = dbConn.tomb_activities
                        .Where(m => arrCategory.Contains(m.category) &&
                        m.deleted == 0)
                        .OrderByDescending(m => m.createtime)
                        .Select(m => new STAdvertImage
                        {
                            uid = m.uid,
                            image_url = m.img_url
                        })
                        .Take(4)
                        .ToList();


                    // Relative information
					List<STRelative> arrRelatives = new List<STRelative>();

					STRelative relative = new STRelative();
					relative.uid = 1;
					relative.name = "洋芋";
					relative.relative = "大爷爷";
					relative.area_no = "区号3940CE29";
					relative.birthday = "2015年3月初二";
					relative.deathday = "2015年8月19日";
					arrRelatives.Add(relative);
                    

					Dictionary<String, Object> retdata = new Dictionary<String, Object>();
					retdata.Add("adverts", arrAdverts);
					retdata.Add("relative_dates", arrRelatives);

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = retdata;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getActivities(long user_id,
			int user_type,
			String check_sum,
			String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
                    STUser userInfo = null;
                    if (user_type == (int)ConstMgr.UserType.USER_TYPE_CUSTOMER)
                    {
                        userInfo = dbConn.clients
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
                    }
                    else
                    {
                        userInfo = dbConn.users
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

                    if (userInfo == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = ErrMgr.ERRMSG_NORMAL;
                        result.retdata = String.Empty;
                        return result;
                    }

                    List<int> arrCategory = new List<int>();
                    switch (userInfo.type)
                    {
                        case (int)ConstMgr.UserType.USER_TYPE_CHAIRMAN:
                        case (int)ConstMgr.UserType.USER_TYPE_GENERALMANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_VICE_GENERALMANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_MANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_VICE_MANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_EMPLOYEE:
                            arrCategory.Add(0);
                            arrCategory.Add(1);
                            arrCategory.Add(2);
                            arrCategory.Add(3);
                            break;
                        case (int)ConstMgr.UserType.USER_TYPE_AGENT:
                        case (int)ConstMgr.UserType.USER_TYPE_CUSTOMER:
                            arrCategory.Add(0);
                            arrCategory.Add(3);
                            break;
                    }

					List<STActivity> arrNotifications = new List<STActivity>();

                    arrNotifications = dbConn.tomb_activities
                        .Where(m => arrCategory.Contains(m.category) &&
                        m.deleted == 0)
                        .OrderByDescending(m => m.createtime)
                        .AsEnumerable()
                        .Select(m => new STActivity
                        {
                            uid = m.uid,
                            notify_type = ConstMgr.getActivityCategoryDesc(m.category),
                            title = m.title,                            
                            image_url = Global.getAbsImgUrl(m.img_url),
                            add_time = Global.convertDateToString(m.createtime, "yyyy年MM月dd日"),
                            act_time = (m.starttime == null || m.endtime == null) ? 
                                "活动时间: 无限" : String.Format("{0} 到 {1}",
                                    Global.convertDateToString(m.starttime, "yyyy年MM月dd日"),
                                    Global.convertDateToString(m.endtime, "yyyy年MM月dd日")),
                            act_contents = m.contents,
                            is_oblation = (m.category == (int)ConstMgr.ActivityCategory.FAHUIHUODONG) ? 1 : 0,
                            is_read = (dbConn.activitynotice_tracks.Where(k => k.activity_id == m.uid &&
                                ((userInfo.type == (int)ConstMgr.UserType.USER_TYPE_CUSTOMER && k.client_id == user_id)
                                || (userInfo.type != (int)ConstMgr.UserType.USER_TYPE_CUSTOMER && k.user_id == user_id))).FirstOrDefault() != null) ? 1 : 0
                        })                        
                        .ToList();

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrNotifications;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getNewActivityCount(long user_id,
			int user_type,
			String check_sum,
			String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

                    List<int> arrCategory = new List<int>();
                    switch (user_type)
                    {
                        case (int)ConstMgr.UserType.USER_TYPE_CHAIRMAN:
                        case (int)ConstMgr.UserType.USER_TYPE_GENERALMANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_VICE_GENERALMANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_MANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_VICE_MANAGER:
                        case (int)ConstMgr.UserType.USER_TYPE_EMPLOYEE:
                            arrCategory.Add(0);
                            arrCategory.Add(1);
                            arrCategory.Add(2);
                            arrCategory.Add(3);
                            break;
                        case (int)ConstMgr.UserType.USER_TYPE_AGENT:
                        case (int)ConstMgr.UserType.USER_TYPE_CUSTOMER:
                            arrCategory.Add(0);
                            arrCategory.Add(3);
                            break;
                    }

                    List<STActivity> arrNotifications = new List<STActivity>();

                    arrNotifications = dbConn.tomb_activities
                        .Where(m => arrCategory.Contains(m.category) &&
                        m.deleted == 0)
                        .OrderByDescending(m => m.createtime)
                        .Select(m => new STActivity
                        {
                            uid = m.uid,
                            notify_type = ConstMgr.getActivityCategoryDesc(m.category),
                            title = m.title,
                            image_url = Global.getAbsImgUrl(m.img_url),
                            add_time = m.createtime.ToString(),
                            is_oblation = (m.category == (int)ConstMgr.ActivityCategory.FAHUIHUODONG) ? 1 : 0,
                            is_read = (dbConn.activitynotice_tracks.Where(k => k.activity_id == m.uid &&
                            ((user_type == (int)ConstMgr.UserType.USER_TYPE_CUSTOMER && k.client_id == user_id)
                            || (user_type != (int)ConstMgr.UserType.USER_TYPE_CUSTOMER && k.user_id == user_id))).FirstOrDefault() != null) ? 1 : 0
                        })
                        .Where(m => m.is_read == 0)
                        .ToList();

					Dictionary<String, Object> retdata = new Dictionary<String, Object>();
					retdata.Add("count", arrNotifications.Count());

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = retdata;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getActivityDetail(long user_id, int user_type, long activity_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					STActivity notification = new STActivity();

                    notification = dbConn.tomb_activities
                        .Where(m => m.uid == activity_id)
                        .AsEnumerable()
                        .Select(m => new STActivity
                        {
                            uid = m.uid,
                            notify_type = ConstMgr.getActivityCategoryDesc(m.category),
                            title = m.title,
                            image_url = Global.getAbsImgUrl(m.img_url),
                            add_time = Global.convertDateToString(m.createtime, "yyyy年MM月dd日"),
                            act_time = (m.starttime == null || m.endtime == null) ?
                                "无限" : String.Format("{0} 到 {1}",
                                    Global.convertDateToString(m.starttime, "yyyy年MM月dd日"),
                                    Global.convertDateToString(m.endtime, "yyyy年MM月dd日")),
                            act_contents = Global.GetHtmlContent(m.contents),
                            is_oblation = (m.category == (int)ConstMgr.ActivityCategory.FAHUIHUODONG) ? 1 : 0,
                            is_read = (dbConn.activitynotice_tracks.Where(k => k.activity_id == m.uid &&
                                ((user_type == (int)ConstMgr.UserType.USER_TYPE_CUSTOMER && k.client_id == user_id)
                                || (user_type != (int)ConstMgr.UserType.USER_TYPE_CUSTOMER && k.user_id == user_id))).FirstOrDefault() != null) ? 1 : 0
                        })                        
                        .FirstOrDefault();

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = notification;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult readActivity(long user_id, int user_type, long activity_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
                    activitynotice_track noticeTrack = new activitynotice_track();
                    noticeTrack.activity_id = activity_id;
                    noticeTrack.readtime = DateTime.Now;
                    noticeTrack.deleted = 0;
                    if (user_type == (int)ConstMgr.UserType.USER_TYPE_CUSTOMER)
                    {
                        noticeTrack.client_id = user_id;
                    }
                    else
                    {
                        noticeTrack.user_id = user_id;
                    }
                    dbConn.activitynotice_tracks.InsertOnSubmit(noticeTrack);
                    dbConn.SubmitChanges();

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getRelativeData(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success


					List<STRelative> arrRelatives = new List<STRelative>();

                    arrRelatives = dbConn.client_parents
                        .Where(m => m.client_id == user_id && m.deleted == 0)
                        .Join(dbConn.clients, m => m.client_id, k => k.uid, (m, k) => new { _parent = m, _client = k })
                        .Join(dbConn.grave_sites, m => m._parent.tombsite_id, k => k.uid, (m, k) => new { _parent = m, _tomb_site = k })
                        .Select(m => new STRelative
                        {
                            uid = m._parent._parent.uid,
                            name = m._parent._parent.name,
                            relative = m._parent._parent.relation,
                            area_no = m._tomb_site.number,
                            birthday = m._parent._parent.birthday.ToShortDateString(),
                            deathday = m._parent._parent.deathday.ToShortDateString(),
                        })
                        .ToList();

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrRelatives;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getRelativeDateCount(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success


					Dictionary<String, Object> retdata = new Dictionary<String, Object>();
					retdata.Add("count", 1);

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = retdata;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getBills(long user_id, int user_type, int page_no, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success                    

					List<STBill> arrBills = new List<STBill>();

                    if (user_type == (int)ConstMgr.UserType.USER_TYPE_CUSTOMER)
                    {
                        client clientItem = dbConn.clients
                        .Where(m => m.uid == user_id &&
                            m.deleted == 0)
                        .FirstOrDefault();

                        if (clientItem == null)
                        {
                            result.retcode = ErrMgr.ERRCODE_NORMAL;
                            result.retmsg = "旧客户信息有错误...";
                            return result;
                        }

                        arrBills = dbConn.service_reserves
                            .Where(m => m.client_id == user_id &&
                                m.deleted == 0)
                            .OrderByDescending(m => m.createtime)
                            .Select(m => new STBill
                            {
                                uid = m.uid,
                                name = clientItem.realname,
                                buy_time = Global.convertDateToString(m.createtime, "yyyy年MM月dd日 HH:mm"),
                                service_price = (dbConn.tomb_services.Where(k => k.uid == m.service_id).FirstOrDefault() != null) ?
                                    dbConn.tomb_services.Where(k => k.uid == m.service_id).FirstOrDefault().price : 0,
                                total_amount = (double)m.total_price,
                                total_amount_desc = String.Format("￥{0:0.00}", m.total_price),
                                products = dbConn.sacrifice_reserves
                                .Where(l => l.servicereserve_id == m.uid && l.deleted == 0)
                                .Join(dbConn.sacrifices, l => l.sacrifice_id, p => p.uid, (l, p) => new { _reserve = l, _sacrifice = p })
                                .Select(l => new STProduct
                                {
                                    uid = l._reserve.uid,
                                    type = l._sacrifice.type,
                                    type_desc = ConstMgr.getProductTypeDesc(l._sacrifice.type),
                                    title = l._sacrifice.name,
                                    amount = l._reserve.count,
                                    amount_desc = l._reserve.count + "",
                                    price = l._reserve.count * l._sacrifice.price,
                                    price_desc = String.Format("￥{0:0.00}", l._reserve.count * l._sacrifice.price)
                                })
                            .ToList()
                            })
                            .Select(m => new STBill
                            {
                                uid = m.uid,
                                name = m.name,
                                buy_time = m.buy_time,
                                total_amount = m.service_price + ((m.products != null && m.products.Count > 0) ? m.products.Select(k => k.price).Sum() : 0),
                                total_amount_desc = String.Format("￥{0:0.00}",
                                    m.service_price + ((m.products != null && m.products.Count > 0) ? m.products.Select(k => k.price).Sum() : 0)),
                            })
                            .Skip(Global.PAGEITEM_COUNT * page_no)
                            .Take(Global.PAGEITEM_COUNT)
                            .ToList();
                    }
                    else
                    {
                        user userItem = dbConn.users
                        .Where(m => m.uid == user_id &&
                            m.deleted == 0)
                        .FirstOrDefault();

                        if (userItem == null)
                        {
                            result.retcode = ErrMgr.ERRCODE_NORMAL;
                            result.retmsg = "用户信息有错误...";
                            return result;
                        }

                        arrBills = dbConn.service_reserves
                            .Where(m => m.user_id == user_id &&
                                m.deleted == 0)
                            .OrderByDescending(m => m.createtime)
                            .Select(m => new STBill
                            {
                                uid = m.uid,
                                name = (dbConn.clients.Where(k => k.uid == m.client_id).FirstOrDefault() != null) ?
                                    dbConn.clients.Where(k => k.uid == m.client_id).FirstOrDefault().realname : "",
                                buy_time = Global.convertDateToString(m.createtime, "yyyy年MM月dd日 HH:mm"),
                                service_price = (dbConn.tomb_services.Where(k => k.uid == m.service_id).FirstOrDefault() != null) ?
                                    dbConn.tomb_services.Where(k => k.uid == m.service_id).FirstOrDefault().price : 0,
                                total_amount = (double)m.total_price,
                                total_amount_desc = String.Format("￥{0:0.00}", m.total_price),
                                products = dbConn.sacrifice_reserves
                                .Where(l => l.servicereserve_id == m.uid && l.deleted == 0)
                                .Join(dbConn.sacrifices, l => l.sacrifice_id, p => p.uid, (l, p) => new { _reserve = l, _sacrifice = p })
                                .Select(l => new STProduct
                                {
                                    uid = l._reserve.uid,
                                    type = l._sacrifice.type,
                                    type_desc = ConstMgr.getProductTypeDesc(l._sacrifice.type),
                                    title = l._sacrifice.name,
                                    amount = l._reserve.count,
                                    amount_desc = l._reserve.count + "",
                                    price = l._reserve.count * l._sacrifice.price,
                                    price_desc = String.Format("￥{0:0.00}", l._reserve.count * l._sacrifice.price)
                                })
                            .ToList()
                            })
                            .Select(m => new STBill
                            {
                                uid = m.uid,
                                name = m.name,
                                buy_time = m.buy_time,
                                total_amount = m.service_price + ((m.products != null && m.products.Count > 0)? m.products.Select(k => k.price).Sum() : 0),
                                total_amount_desc = String.Format("￥{0:0.00}",
                                    m.service_price + ((m.products != null && m.products.Count > 0) ? m.products.Select(k => k.price).Sum() : 0)),
                            })
                            .Skip(Global.PAGEITEM_COUNT * page_no)
                            .Take(Global.PAGEITEM_COUNT)
                            .ToList();
                    }
                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrBills;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getBillDetail(long user_id, int user_type, long bill_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success


					STBill bill_info = new STBill();

                    bill_info = dbConn.service_reserves
                        .Where(m => m.uid == bill_id && m.deleted == 0)
                        .Join(dbConn.clients, m => m.client_id, k => k.uid, (m, k) => new { _reserve = m, _client = k })
                        .Select(m => new STBill
                        {
                            uid = m._reserve.uid,
                            name = m._client.realname,
                            buy_time = Global.convertDateToString(m._reserve.createtime, "yyyy年MM月dd日 HH:mm"),
                            service_type = ConstMgr.getServiceTypeDesc(m._reserve.service_type),
                            service_price = (dbConn.tomb_services.Where(k => k.uid == m._reserve.service_id).FirstOrDefault() != null) ?
                                dbConn.tomb_services.Where(k => k.uid == m._reserve.service_id).FirstOrDefault().price : 0,
                            service_price_desc = String.Format("￥{0:0.00}", (dbConn.tomb_services.Where(k => k.uid == m._reserve.service_id).FirstOrDefault() != null) ?
                                dbConn.tomb_services.Where(k => k.uid == m._reserve.service_id).FirstOrDefault().price : 0),
                            consume_time = Global.convertDateToString(m._reserve.reserve_time, "yyyy年MM月dd日 HH:mm"),
                            state = m._reserve.status,
                            state_desc = ConstMgr.getBillStateDesc(m._reserve.status),
                            remark = m._reserve.note,
                            total_amount = (double)m._reserve.total_price,
                            total_amount_desc = String.Format("￥{0:0.00}", m._reserve.total_price),
                            products = dbConn.sacrifice_reserves
                                .Where(l => l.servicereserve_id == m._reserve.uid && l.deleted == 0)
                                .Join(dbConn.sacrifices, l => l.sacrifice_id, p => p.uid, (l, p) => new { _reserve = l, _sacrifice = p })
                                .Select(l => new STProduct
                                {
                                    uid = l._reserve.uid,
                                    type = l._sacrifice.type,
                                    type_desc = ConstMgr.getProductTypeDesc(l._sacrifice.type),
                                    title = l._sacrifice.name,
                                    amount = l._reserve.count,
                                    amount_desc = l._reserve.count + "",
                                    price = l._reserve.count * l._sacrifice.price,
                                    price_desc = String.Format("￥{0:0.00}", l._reserve.count * l._sacrifice.price)
                                })
                            .ToList()
                        })
                        .Select(m => new STBill
                        {
                            uid = m.uid,
                            name = m.name,
                            buy_time = m.buy_time,
                            service_type = m.service_type,
                            service_price = m.service_price,
                            service_price_desc = m.service_price_desc,
                            consume_time = m.consume_time,
                            state = m.state,
                            state_desc = m.state_desc,
                            remark = m.remark,
                            total_amount = m.service_price + ((m.products != null && m.products.Count > 0) ? m.products.Select(k => k.price).Sum() : 0),
                            total_amount_desc = String.Format("￥{0:0.00}",
                                m.service_price + ((m.products != null && m.products.Count > 0) ? m.products.Select(k => k.price).Sum() : 0)),
                            products = m.products
                        })
                        .FirstOrDefault();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = bill_info;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getDeputyLogs(long user_id, int user_type, int page_no, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

                    client clientItem = dbConn.clients
                        .Where(m => m.uid == user_id &&
                            m.deleted == 0)
                        .FirstOrDefault();

                    if (clientItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "旧客户信息有错误";
                        return result;
                    }

					List<STDeputyLog> arrLogs = new List<STDeputyLog>();

                    arrLogs = dbConn.agentservice_results
                        .Where(m => m.client_id == user_id && m.deleted == 0)
                        .AsEnumerable()
                        .Select(m => new STDeputyLog
                        {
                            uid = m.uid,
                            time = String.Format("{0:yyyy年MM月dd日 HH:mm}", m.createtime),
                            image_url = Global.getAbsImgUrl(m.img_urls.Split(',').FirstOrDefault()),
                            detail_images = m.img_urls.Split(',').Select(k => new STDeputyDetailImage
                            {
                                image_url = Global.getAbsImgUrl(k.ToString())
                            }).ToList()
                        })
                        .OrderByDescending(m => m.time)
                        .Take(2)
                        .ToList();

                    result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrLogs;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getDeputyLogDetail(long user_id, int user_type, long log_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success


					STDeputyLog log = new STDeputyLog();

                    log = dbConn.agentservice_results
                        .Where(m => m.uid == log_id && m.deleted == 0)
                        .AsEnumerable()
                        .Select(m => new STDeputyLog
                        {
                            uid = m.uid,
                            time = String.Format("{0:yyyy年MM月dd日 HH:mm}", m.createtime),
                            image_url = Global.getAbsImgUrl(m.img_urls.Split(',').FirstOrDefault()),
                            detail_images = m.img_urls.Split(',').Select(k => new STDeputyDetailImage
                            {
                                image_url = Global.getAbsImgUrl(k.ToString())
                            }).ToList()
                        })
                        .FirstOrDefault();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = log;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getServicePeopleInfo(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success


					STEmployee emp = new STEmployee();

                    if (user_type == (int)ConstMgr.UserType.USER_TYPE_CUSTOMER)
                    {
                        client clientInfo = dbConn.clients
                        .Where(m => m.uid == user_id && m.deleted == 0)
                        .FirstOrDefault();

                        if (clientInfo == null)
                        {
                            result.retcode = ErrMgr.ERRCODE_NORMAL;
                            result.retmsg = ErrMgr.ERRMSG_NORMAL;
                            result.retdata = String.Empty;
                            return result;
                        }

                        emp = dbConn.users
                        .Where(m => m.uid == clientInfo.owner_id)
                        .Join(dbConn.offices, m => m.office_id, k => k.uid, (m, k) => new { _owner = m, _office = k })
                        .Select(m => new STEmployee
                        {
                            uid = m._owner.uid,
                            name = m._owner.realname,
                            description = ConstMgr.getUserTypeDesc(m._owner.type),
                            photo_url = Global.getAbsImgUrl(m._owner.imgurl),
                            phone = m._owner.phone,
                            office = m._office.name,
                            address = m._office.address,
                            qq = m._owner.qq,
                            wechat = m._owner.weixin
                        })
                        .FirstOrDefault();
                    }
                    else
                    {
                        user selfInfo = dbConn.users
                            .Where(m => m.uid == user_id && m.deleted == 0)
                            .FirstOrDefault();

                        if (selfInfo == null || selfInfo.owner_id == null)
                        {
                            result.retcode = ErrMgr.ERRCODE_NORMAL;
                            result.retmsg = ErrMgr.ERRMSG_NORMAL;
                            result.retdata = String.Empty;
                            return result;
                        }

                        emp = dbConn.users
                            .Where(m => m.uid == selfInfo.owner_id)
                            .Join(dbConn.offices, m => m.office_id, k => k.uid, (m, k) => new { _owner = m, _office = k })
                            .Select(m => new STEmployee
                            {
                                uid = m._owner.uid,
                                name = m._owner.realname,
                                description = ConstMgr.getUserTypeDesc(m._owner.type),
                                photo_url = Global.getAbsImgUrl(m._owner.imgurl),
                                phone = m._owner.phone,
                                office = m._office.name,
                                address = m._office.address,
                                qq = m._owner.qq,
                                wechat = m._owner.weixin
                            })
                            .FirstOrDefault();
                    }
                    
                    result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = emp;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getTombListForCustomer(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success


					List<STTomb> arrTombs = new List<STTomb>();

                    arrTombs = dbConn.grave_sites
                        .Where(m => m.client_id == user_id &&
                        m.deleted == 0)
                        .Select(m => new STTomb
                        {
                            uid = m.uid,
                            tomb_no = m.number
                        })
                        .ToList();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrTombs;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult reserveCeremony(long user_id,
			int user_type,
			long customer_id,
			String reserve_time,
			long tomb_id,
            int is_deputyservice,
			long bury_service_id,
			String products,
			String check_sum,
			String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

                    client clientItem = dbConn.clients
                        .Where(m => m.uid == customer_id && m.deleted == 0)
                        .FirstOrDefault();

                    if (clientItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "旧客户信息有错误";
                        return result;
                    }

                    List<grave_site> clientTombSites = dbConn.grave_sites
                        .Where(m => m.client_id == clientItem.uid &&
                            m.deleted == 0)
                        .ToList();

                    if (clientTombSites == null || clientTombSites.Count <= 0)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "这位客户还没购买墓地，无法预订祭品...";
                        return result;
                    }

                    String notifyContent = "ClientPurchase\n";
                    notifyContent += "旧客户" + clientItem.name + "预约了";

                    service_reserve serviceReserve = new service_reserve();
                    serviceReserve.client_id = customer_id;
                    serviceReserve.gravesite_id = tomb_id;
                    serviceReserve.user_id = user_id;
                    serviceReserve.service_id = bury_service_id;
                    serviceReserve.reserve_time = Convert.ToDateTime(reserve_time);
                    if (tomb_id <= 0)
                    {
                        serviceReserve.service_type = (byte)ConstMgr.TombServiceType.TOMB_SERVICE_TYPE_LUOZANG;
                        notifyContent += "落葬仪式\n";
                    }
                    else if (is_deputyservice == 0)
                    {
                        serviceReserve.service_type = (byte)ConstMgr.TombServiceType.TOMB_SERVICE_TYPE_JIBAI;
                        notifyContent += "祭拜\n";
                    }
                    else
                    {
                        serviceReserve.service_type = (byte)ConstMgr.TombServiceType.TOMB_SERVICE_TYPE_DAIJIBAI;
                        notifyContent += "代祭拜\n";
                    }
                    notifyContent += "日期:" + reserve_time + "\n";
                    serviceReserve.createtime = DateTime.Now;
                    serviceReserve.status = (byte)ConstMgr.ServiceReserveStatus.RESERVED;
                    serviceReserve.note = "";
                    serviceReserve.total_price = 0;
                    serviceReserve.deleted = 0;
                    dbConn.service_reserves.InsertOnSubmit(serviceReserve);
                    dbConn.SubmitChanges();

                    notifyContent += "墓位:";
                    grave_site tombSite = dbConn.grave_sites
                        .Where(m => m.uid == tomb_id && m.deleted == 0)
                        .FirstOrDefault();
                    if (tombSite != null)
                    {
                        notifyContent += tombSite.number;
                    }
                    notifyContent += "\n";
                    
					List<long> arrProductIDs = new List<long>();
					List<int> arrCounts = new List<int>();

					JArray arrProducts = JArray.Parse(products);
					int nCount = arrProducts.Count;
                    notifyContent += "预约祭品:\n";
					for (int i = 0; i < nCount; i++)
					{
						JToken token = arrProducts[i];

						long uid = (long)token.SelectToken("uid");
						int count = (int)token.SelectToken("count");

                        sacrifice sacrificeItem = dbConn.sacrifices
                            .Where(m => m.uid == uid && m.deleted == 0)
                            .FirstOrDefault();
                        if (sacrificeItem == null)
                            continue;

						arrProductIDs.Add(uid);
						arrCounts.Add(count);

                        sacrifice_reserve productReserve = new sacrifice_reserve();
                        productReserve.servicereserve_id = serviceReserve.uid;
                        productReserve.sacrifice_id = uid;
                        productReserve.count = count;
                        productReserve.deleted = 0;
                        dbConn.sacrifice_reserves.InsertOnSubmit(productReserve);
                        dbConn.SubmitChanges();

                        notifyContent += sacrificeItem.name + " " + count + "个\n";
					}

                    JPushApi.SendPushNotification(Convert.ToString(clientItem.owner_id), notifyContent);
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getActivityProducts(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success


					List<STProduct> arrProducts = new List<STProduct>();

                    arrProducts = dbConn.sacrifices
                        .Where(m => m.type == (byte)ConstMgr.ProductType.PRODUCT_TYPE_CEREMONY &&
                        m.deleted == 0)
                        .Select(m => new STProduct
                        {
                            uid = m.uid,
                            type = (int)m.type,
                            type_desc = ConstMgr.getProductTypeDesc(m.type),
                            title = m.name,
                            image_url = Global.getAbsImgUrl(m.imgurl),
                            price = m.price,
                            price_desc = String.Format("￥{0:0.00}", m.price),
                            max_amount = 0,
                            max_amount_desc = ""
                        })
                        .ToList();
                    

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrProducts;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getBonusFormula(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					Dictionary<String, Object> retdata = new Dictionary<String, Object>();

                    int discountLimit = 0;
                    int commission = 0;
                    int taxRate = 0;

                    bonus_coef bonusCoef = dbConn.bonus_coefs
                        .Where(m => m.name.Equals("zuidiqianyuejia") && m.deleted == 0)
                        .FirstOrDefault();
                    if (bonusCoef != null) discountLimit = bonusCoef.value;

                    bonusCoef = dbConn.bonus_coefs
                        .Where(m => m.name.Equals("false_mudi_ticheng") && m.deleted == 0)
                        .FirstOrDefault();
                    if (bonusCoef != null) commission = bonusCoef.value;

                    bonusCoef = dbConn.bonus_coefs
                        .Where(m => m.name.Equals("shuilv") && m.deleted == 0)
                        .FirstOrDefault();
                    if (bonusCoef != null) taxRate = bonusCoef.value;

					retdata.Add("discount_limit", discountLimit);
					retdata.Add("commission", commission);
					retdata.Add("tax_rate", (100 - taxRate) / 100.0);

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = retdata;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getBonusDetailList(long user_id, int user_type, int bonus_type, int page_no, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

                    int tichengCoef = 68;
                    int yingxiaobilv = 65;
                    int shuilv = 10;

                    bonus_coef bonusCoef = dbConn.bonus_coefs
                        .Where(m => m.name.Equals("true_mudi_ticheng") && m.deleted == 0)
                        .FirstOrDefault();
                    if (bonus_type == 1)
                    {
                        bonusCoef = dbConn.bonus_coefs
                        .Where(m => m.name.Equals("true_jipin_ticheng") && m.deleted == 0)
                        .FirstOrDefault();
                    }
                    if (bonusCoef != null) tichengCoef = bonusCoef.value;

                    bonusCoef = dbConn.bonus_coefs
                        .Where(m => m.name.Equals("shuilv") && m.deleted == 0)
                        .FirstOrDefault();
                    if (bonusCoef != null) shuilv = bonusCoef.value;

                    bonusCoef = dbConn.bonus_coefs
                        .Where(m => m.name.Equals("yingxiaobilv") && m.deleted == 0)
                        .FirstOrDefault();
                    if (bonusCoef != null) yingxiaobilv = bonusCoef.value;

					List<STBonusLog> arrLogs = new List<STBonusLog>();

                    if (bonus_type == 0)
                    {
                        arrLogs = dbConn.tomb_purchases
                        .Where(m => m.user_id == user_id &&
                            m.client_id != null &&
                            m.deleted == 0)
                        .OrderByDescending(m => m.paytime)
                        .Join(dbConn.clients, m => m.client_id, k => k.uid, (m, k) => new { _purchase = m, _client = k })
                        .Join(dbConn.grave_sites, m => m._purchase.tombsite_id, k => k.uid, (m, k) => new { _purchase = m, _tombsite = k })
                        .Select(m => new STBonusLog
                        {
                            uid = m._purchase._purchase.uid,
                            user_name = m._purchase._client.realname,
                            tomb_no = m._tombsite.number,
                            buy_time = String.Format("{0:yyyy年MM月dd日 HH:mm}", m._purchase._purchase.paytime),
                            bonus = m._purchase._purchase.paid_price *
                                (m._purchase._purchase.paid_price / (double)m._purchase._purchase.price - (1 - tichengCoef / 100.0)) *
                                (yingxiaobilv / 100.0) *
                                (1 - shuilv / 100.0)
                        })
                        .Select(m => new STBonusLog
                        {
                            uid = m.uid,
                            user_name = m.user_name,
                            tomb_no = m.tomb_no,
                            buy_time = m.buy_time,
                            bonus = m.bonus,
                            bonus_desc = String.Format("￥{0:0.00}", m.bonus)
                        })
                        .ToList();
                    }
                    else
                    {
                        List<long> arrReserveId = dbConn.service_reserves
                            .Where(m => m.user_id == user_id &&
                                m.deleted == 0)
                            .Select(m => m.uid)
                            .ToList();

                        arrLogs = dbConn.sacrifice_reserves
                            .AsEnumerable()
                            .Where(m => arrReserveId.Contains(m.servicereserve_id) &&
                                m.deleted == 0)
                            .Join(dbConn.service_reserves, m => m.servicereserve_id, k => k.uid, (m, k) => new { _purchase = m, _reserve = k })
                            .Join(dbConn.clients, m => m._reserve.client_id, k => k.uid, (m, k) => new { _purchase = m, _client = k })
                            .Join(dbConn.grave_sites, m => m._purchase._reserve.gravesite_id, k => k.uid, (m, k) => new { _purchase = m, _tombsite = k })
                            .Join(dbConn.sacrifices, m => m._purchase._purchase._purchase.sacrifice_id, k => k.uid, (m, k) => new { _purchase = m, _sacrifice = k })
                            .OrderByDescending(m => m._purchase._purchase._purchase._reserve.createtime)
                            .Select(m => new STBonusLog
                            {
                                uid = m._purchase._purchase._purchase._reserve.uid,
                                user_name = m._purchase._purchase._client.realname,
                                tomb_no = m._purchase._tombsite.number,
                                buy_time = String.Format("{0:yyyy年MM月dd日 HH:mm}", m._purchase._purchase._purchase._reserve.createtime),
                                bonus = m._sacrifice.price * m._purchase._purchase._purchase._purchase.count *
                                    (1 - tichengCoef / 100.0) *
                                    (yingxiaobilv / 100.0) *
                                    (1 - shuilv / 100.0)
                            })
                            .GroupBy(m => m.uid)
                            .Select
                            (g => new STBonusLog
                            {
                                uid = g.Key,
                                user_name = g.FirstOrDefault().user_name,
                                tomb_no = g.FirstOrDefault().tomb_no,
                                buy_time = g.FirstOrDefault().buy_time,
                                bonus = g.Select(h => h.bonus).Sum(),
                            })
                            .Select(m => new STBonusLog
                            {
                                uid = m.uid,
                                user_name = m.user_name,
                                tomb_no = m.tomb_no,
                                buy_time = m.buy_time,
                                bonus = m.bonus,
                                bonus_desc = String.Format("￥{0:0.00}", m.bonus)
                            })
                            .ToList();
                    }
                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrLogs;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getDepositLogs(long user_id, int user_type, long aim_user_id, int page_no, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STDepositLog> arrLogs = new List<STDepositLog>();

                    arrLogs = dbConn.deposits
                        .Where(m => m.receiver_id == aim_user_id && 
                            m.endtime > DateTime.Now &&
                            m.deleted == 0)
                        .Join(dbConn.users, m => m.receiver_id, k => k.uid, (m, k) => new { _deposit = m, _user = k })
                        .Join(dbConn.grave_sites, m => m._deposit.tombsite_id, k => k.uid, (m, k) => new { _deposit = m, _tombsite = k})
                        .Select(m => new STDepositLog
                        {
                            uid = m._deposit._deposit.uid,
                            start_time = String.Format("{0:yyyy年MM月dd日 HH:mm}", m._deposit._deposit.paytime),
                            end_time = String.Format("{0:yyyy年MM月dd日 HH:mm}", m._deposit._deposit.endtime),
                            name = m._deposit._deposit.name,
                            tomb_no = m._tombsite.number,
                            receiver = m._deposit._user.realname,
                            price = m._deposit._deposit.price,
                            price_desc = String.Format("￥{0:0.00}", m._deposit._deposit.price)
                        })
                        .ToList()
                        .OrderByDescending(m => m.start_time)
                        .Skip(Global.PAGEITEM_COUNT * page_no)
                        .Take(Global.PAGEITEM_COUNT)
                        .ToList();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrLogs;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getAgentDepositLogs(long user_id, int user_type, long aim_user_id, int page_no, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STDepositLog> arrLogs = new List<STDepositLog>();

                    List<long> arrAgent = dbConn.users
                        .Where(m => m.owner_id == user_id &&
                            m.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT &&
                            m.deleted == 0)
                            .Select(m => m.uid)
                            .ToList();
                    
                    arrLogs = dbConn.deposits
                        .Where(m => arrAgent.Contains(m.receiver_id) &&
                            m.endtime > DateTime.Now &&
                            m.deleted == 0)
                        .Join(dbConn.users, m => m.receiver_id, k => k.uid, (m, k) => new { _deposit = m, _user = k })
                        .Join(dbConn.grave_sites, m => m._deposit.tombsite_id, k => k.uid, (m, k) => new { _deposit = m, _tombsite = k })
                        .Select(m => new STDepositLog
                        {
                            uid = m._deposit._deposit.uid,
                            start_time = String.Format("{0:yyyy年MM月dd日 HH:mm}", m._deposit._deposit.paytime),
                            end_time = String.Format("{0:yyyy年MM月dd日 HH:mm}", m._deposit._deposit.endtime),
                            name = m._deposit._deposit.name,
                            tomb_no = m._tombsite.number,
                            receiver = m._deposit._user.realname,
                            price = m._deposit._deposit.price,
                            price_desc = String.Format("￥{0:0.00}", m._deposit._deposit.price)
                        })
                        .ToList()
                        .OrderByDescending(m => m.start_time)
                        .Skip(Global.PAGEITEM_COUNT * page_no)
                        .Take(Global.PAGEITEM_COUNT)
                        .ToList();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrLogs;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getCustomerList(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STCustomer> arrUsers = new List<STCustomer>();

                    arrUsers = dbConn.clients
                        .Where(m => m.owner_id == user_id &&
                        m.deleted == 0)
                        .Select(m => new STCustomer
                        {
                            uid = m.uid,
                            name = m.realname,
                            phone = m.phone,
                            tombs = dbConn.grave_sites
                            .Where(k => k.client_id == m.uid &&
                            k.deleted == 0)
                            .Select(k => new STTomb
                            {
                                uid = k.uid,
                                tomb_no = k.number
                            })
                            .ToList()
                        })
                        .ToList();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrUsers;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}

        public static int getTombSiteState(long tombsite_id)
        {
            BZDatabaseDataContext dbConn = null;

            try
            {
                dbConn = new BZDatabaseDataContext();
                grave_site tombSite = dbConn.grave_sites
                    .Where(m => m.uid == tombsite_id && m.deleted == 0)
                    .FirstOrDefault();
                if(tombSite == null)
                    return (int)ConstMgr.TombState.TOMB_STATE_EMPTY;

                if(tombSite.client_id != null)
                    return (int)ConstMgr.TombState.TOMB_STATE_SOLD;

                int reserveCountHour = 1;
                var countEnviron = dbConn.environs
                    .Where(m => m.name.Equals("mudiyuliushijian") && m.deleted == 0)
                    .FirstOrDefault();
                if (countEnviron != null)
                    reserveCountHour = (int)countEnviron.value;

                tomb_reserve tombReserve = dbConn.tomb_reserves
                    .Where(m => m.reserve_time < DateTime.Now &&
                        m.reserve_time.AddHours(reserveCountHour) > DateTime.Now &&
                        m.tombsite_id == tombsite_id &&
                        m.deleted == 0)
                    .FirstOrDefault();
                if (tombReserve != null)
                    return (int)ConstMgr.TombState.TOMB_STATE_RESERVED;

                deposit depositItem = dbConn.deposits
                    .Where(m => m.paytime < DateTime.Now &&
                        m.endtime > DateTime.Now && m.deleted == 0 &&
                        m.tombsite_id == tombsite_id)
                    .FirstOrDefault();
                if (depositItem != null)
                    return (int)ConstMgr.TombState.TOMB_STATE_DEPOSIT;

            }
            catch (Exception ex) { Global.logError(ex.Message); }

            return (int)ConstMgr.TombState.TOMB_STATE_EMPTY;
        }

		public static SVCResult getTombList(long user_id, int user_type, long area_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STTomb> arrTombs = new List<STTomb>();

                    arrTombs = dbConn.grave_sites
                        .Where(m => m.tombarea_id == area_id &&
                        m.deleted == 0)
                        .Select(m => new STTomb
                        {
                            uid = m.uid,
                            tomb_no = m.number,
                            row = m.row_number - 1,
                            col = m.column_number - 1,
                            state = getTombSiteState(m.uid),
                            state_desc = ConstMgr.getTombStateDesc(getTombSiteState(m.uid))
                        })
                        .ToList();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrTombs;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getTombDetail(long user_id, int user_type, long tomb_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					STTomb tomb = new STTomb();

                    tomb = dbConn.grave_sites
                        .Where(m => m.uid == tomb_id)
                        .Select(m => new STTomb
                        {
                            uid = m.uid,
                            image_url = Global.getAbsImgUrl(m.gravestone_imgurl),
                            tomb_no = m.number,
                            row = m.row_number - 1,
                            col = m.column_number - 1,
                            desc = m.gravestone_type,
                            price = m.price,
                            price_desc = String.Format("￥{0:0.00}", m.price),
                            state = getTombSiteState(m.uid),
                            state_desc = ConstMgr.getTombStateDesc(getTombSiteState(m.uid))
                        })
                        .FirstOrDefault();

                    
                    result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = tomb;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}

		public static SVCResult getTombStonePlaces(long area_id, long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
					List<STTombStoneArea> arrAreas = new List<STTombStoneArea>();
					
                    tomb_area tombArea = dbConn.tomb_areas
                        .Where(m => m.uid == area_id && 
                            m.type == (byte)ConstMgr.TombAreaType.PAIWEI &&
                            m.deleted == 0)
                        .FirstOrDefault();

                    if (tombArea == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
					    result.retmsg = "园区信息有错误。";
                        return result;
                    }

                    List<Dictionary<String, Object>> tabletAreaSize = new List<Dictionary<String, Object>>();
                    List<String> arrAreaSize = tombArea.area_size.Split(',').ToList();
                    int maxRowCount = 0, maxColumnCount = 0;
                    foreach (String itemSize in arrAreaSize)
                    {
                        String[] strSize = itemSize.Split(':');
                        if (strSize.Count() < 3) continue;
                        Dictionary<String, Object> dicItem = new Dictionary<String, Object>();
                        dicItem.Add("name", strSize[0]);
                        dicItem.Add("row_count", Convert.ToInt16(strSize[1]));
                        dicItem.Add("column_count", Convert.ToInt16(strSize[2]));
                        if (maxRowCount < Convert.ToInt16(strSize[1])) maxRowCount = Convert.ToInt16(strSize[1]);
                        if (maxColumnCount < Convert.ToInt16(strSize[2])) maxColumnCount = Convert.ToInt16(strSize[2]);
                        tabletAreaSize.Add(dicItem);
                    }

                    if (tabletAreaSize.Count <= 0)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "园区内区排列大小有错误。";
                        return result;
                    }

                    int[, ,] tabletStates = new int[tabletAreaSize.Count, maxRowCount, maxColumnCount];
                    long[, ,] tabletUids = new long[tabletAreaSize.Count, maxRowCount, maxColumnCount];

                    int i, j, k, l;
                    for (i = 0; i < tabletAreaSize.Count; i++)
                        for (j = 0; j < maxRowCount; j++)
                            for (k = 0; k < maxColumnCount; k++)
                            {
                                tabletStates[i, j, k] = (int)ConstMgr.TombState.TOMB_STATE_INVALID;
                                tabletUids[i, j, k] = 0;
                            }

                    List<grave_tablet> arrTablets = dbConn.grave_tablets
                    .Where(m => m.tombarea_id == area_id && m.deleted == 0)
                    .ToList();
                    foreach (grave_tablet tabletItem in arrTablets)
                    {
                        int area_no = 0;
                        area_no = tabletAreaSize.IndexOf(tabletAreaSize.Where(m => m["name"].Equals(tabletItem.area_number))
                            .FirstOrDefault());
                            
                        if (tabletItem.client_id != null)
                            tabletStates[area_no, tabletItem.row_number - 1, tabletItem.column_number - 1] = (int)ConstMgr.TombState.TOMB_STATE_SOLD;
                        else
                            tabletStates[area_no, tabletItem.row_number - 1, tabletItem.column_number - 1] = (int)ConstMgr.TombState.TOMB_STATE_EMPTY;

                        tabletUids[area_no, tabletItem.row_number - 1, tabletItem.column_number - 1] = tabletItem.uid;
                    }

                    int reserveCountHour = 1;
                    var countEnviron = dbConn.environs
                        .Where(m => m.name.Equals("mudiyuliushijian") && m.deleted == 0)
                        .FirstOrDefault();
                    if (countEnviron != null)
                        reserveCountHour = (int)countEnviron.value;

                    List<long> tabletIds = arrTablets.Select(m => m.uid).ToList();

                    List<grave_tablet> arrReservedTables = dbConn.grave_tablets
                        .Where(m => tabletIds.Contains(100) && m.deleted == 0 &&
                        dbConn.tomb_reserves.Where(o => o.tombtablet_id == m.uid &&
                        o.reserve_time.AddHours(reserveCountHour) > DateTime.Now).FirstOrDefault() != null)
                        .ToList();

                    foreach (grave_tablet tabletItem in arrReservedTables)
                    {
                        int area_no = 0;
                        area_no = tabletAreaSize.IndexOf(tabletAreaSize.Where(m => m["name"].Equals(tabletItem.area_number))
                            .FirstOrDefault());
                        tabletStates[area_no, tabletItem.row_number - 1, tabletItem.column_number - 1] = (int)ConstMgr.TombState.TOMB_STATE_RESERVED;
                    }

                    List<grave_tablet> arrDepositTables = dbConn.grave_tablets
                        .Where(m => tabletIds.Contains(100) && m.deleted == 0 &&
                        dbConn.deposits.Where(o => o.tombtablet_id == m.uid &&
                        o.endtime > DateTime.Now).FirstOrDefault() != null)
                        .ToList();

                    foreach (grave_tablet tabletItem in arrDepositTables)
                    {
                        int area_no = 0;
                        area_no = tabletAreaSize.IndexOf(tabletAreaSize.Where(m => m["name"].Equals(tabletItem.area_number))
                            .FirstOrDefault());
                        tabletStates[area_no, tabletItem.row_number - 1, tabletItem.column_number - 1] = (int)ConstMgr.TombState.TOMB_STATE_DEPOSIT;
                    }


					STTombStoneArea area = new STTombStoneArea();

					area.uid = tombArea.uid;
					area.name = tombArea.name;
					area.image_url = "";
                    for (j = 0; j < tabletAreaSize.Count; j++)
					{
						STTombStonePart part = new STTombStonePart();

						part.uid = j + 1;
                        part.name = tabletAreaSize.ElementAt(j)["name"] + "";
                        int areaRowCount = Convert.ToInt16(tabletAreaSize.ElementAt(j)["row_count"]);
                        int areaColumnCount = Convert.ToInt16(tabletAreaSize.ElementAt(j)["column_count"]);
                        for (k = 0; k < areaRowCount; k++)
						{
							STTombStoneRow row = new STTombStoneRow();
							row.uid = k + 1;
                            for (l = 0; l < areaColumnCount; l++)
							{
								STTombStoneIndex index = new STTombStoneIndex();
								index.uid = l + 1;
                                index.tablet_id = tabletUids[j, k, l];
                                if (tabletStates[j, k, l] == (int)ConstMgr.TombState.TOMB_STATE_EMPTY)
								    row.indexes.Add(index);
							}
                            if(row.indexes.Count > 0)
							    part.rows.Add(row);
						}
                        if(part.rows.Count > 0)
						    area.parts.Add(part);
					}
                    if(area.parts.Count > 0)
					    arrAreas.Add(area);

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrAreas;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}

		public static SVCResult reserveTombPlace(long user_id,
			int user_type,
            String customer_name,
            String customer_phone,
			String death_people1,
			String mgr_people1,
			String death_people2,
			String mgr_people2,
			long tomb_area_id,
			long tomb_site_id,
            long tomb_tablet_id,
			String check_sum,
			String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
                    grave_site tombSite = dbConn.grave_sites
                        .Where(m => m.uid == tomb_site_id && m.deleted == 0)
                        .FirstOrDefault();
                    grave_tablet tombTablet = dbConn.grave_tablets
                        .Where(m => m.uid == tomb_tablet_id && m.deleted == 0)
                        .FirstOrDefault();

                    if (tombSite == null && tombTablet == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "墓地、牌位信息错误...";
                        return result;
                    }

                    tomb_reserve tombReserve = new tomb_reserve();
                    tombReserve.user_id = user_id;
                    tombReserve.name = customer_name;
                    tombReserve.phone = customer_phone;
                    tombReserve.deadperson1 = death_people1;
                    tombReserve.sootheperson1 = mgr_people1;
                    tombReserve.deadperson2 = death_people2;
                    tombReserve.sootheperson2 = mgr_people2;
                    tombReserve.reserve_time = DateTime.Now;
                    if(tomb_site_id > 0)
                        tombReserve.tombsite_id = tomb_site_id;
                    if (tomb_tablet_id > 0)
                        tombReserve.tombtablet_id = tomb_tablet_id;
                    tombReserve.deleted = 0;

                    dbConn.tomb_reserves.InsertOnSubmit(tombReserve);
                    dbConn.SubmitChanges();

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}

        public static int getEmployeeScore(long user_id, int category, int month)
        {
            BZDatabaseDataContext dbConn = null;
            dbConn = new BZDatabaseDataContext();

            int result = 0;
            DateTime startTime = DateTime.Now;
            switch (category)
            {
                case 0: // this month
                    startTime = new DateTime(DateTime.Now.Year, month, 1, 0, 0, 0);
                    break;
                case 1: // half year
                    startTime = new DateTime(DateTime.Now.Year, (DateTime.Now.Month > 6) ? 7 : 1, 1, 0, 0, 0);
                    break;
                case 2: // a year
                    startTime = new DateTime(DateTime.Now.Year, 1, 1, 0, 0, 0);
                    break;
            }

            List<tomb_purchase> arrTombPurchase = dbConn.tomb_purchases
                .Where(m => m.user_id == user_id && m.paytime > startTime && m.deleted == 0)
                .ToList();

            result = arrTombPurchase.Select(m => m.paid_price).Sum();
            return result;
        }

		public static SVCResult getAgents(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STAgent> arrAgents = new List<STAgent>();

                    arrAgents = dbConn.users
                        .Where(m => m.owner_id == user_id &&
                        m.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT &&
                        m.deleted == 0)
                        .AsEnumerable()
                        .Select(m => new STAgent
                        {
                            uid = m.uid,
                            name = m.realname,
                            phone = m.phone,
                            month_score = getEmployeeScore(m.uid, 0, DateTime.Now.Month),
                            halfyear_score = getEmployeeScore(m.uid, 1, 0),
                            year_score = getEmployeeScore(m.uid, 2, 0),
                        })
                        .Select(m => new STAgent
                        {
                            uid = m.uid,
                            name = m.name,
                            phone = m.phone,
                            month_score = m.month_score,
                            month_score_desc = String.Format("￥{0:0.00}", m.month_score),
                            halfyear_score = m.halfyear_score,
                            halfyear_score_desc = String.Format("￥{0:0.00}", m.halfyear_score),
                            year_score = m.year_score,
                            year_score_desc = String.Format("￥{0:0.00}", m.year_score)
                        })
                        .ToList();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrAgents;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getBuyProductCount(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
                    int unreadCount = 0;
                    unreadCount = dbConn.service_reserves                        
                        .Join(dbConn.clients, m => m.client_id, k => k.uid, (m, k) => new { _reserve = m, _client = k })
                        .Where(m => m._client.owner_id == user_id &&
                            m._reserve.deleted == 0 &&
                            m._reserve.is_noticedtoemployee == 0)              
                        .Count();

					Dictionary<String, Object> retdata = new Dictionary<String, Object>();
					retdata.Add("count", unreadCount);

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = retdata;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getBuyProductLogs(long user_id, int user_type, int page_no, int state, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

                    user userItem = dbConn.users
                        .Where(m => m.uid == user_id &&
                            m.deleted == 0)
                        .FirstOrDefault();

                    if (userItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "用户信息有错误。";
                        return result;
                    }
                    
					List<STBuyProductLog> arrLogs = new List<STBuyProductLog>();

                    if (state == 0)
                    {
                        arrLogs = dbConn.service_reserves
                            .Join(dbConn.clients, m => m.client_id, k => k.uid, (m, k) => new { _reserve = m, _client = k })
                            .Where(m => m._client.owner_id == user_id &&
                                m._reserve.deleted == 0 &&
                                m._reserve.status == 0)                            
                            .OrderByDescending(m => m._reserve.createtime)
                            .Select(m => new STBuyProductLog
                            {
                                uid = m._reserve.uid,
                                customer = m._client.realname,
                                reserve_date = String.Format("{0:yyyy年MM月dd日 HH:mm}", m._reserve.reserve_time),
                                is_read = m._reserve.is_noticedtoemployee
                            })
                            .ToList()
                            .Skip(Global.PAGEITEM_COUNT * page_no)
                            .Take(Global.PAGEITEM_COUNT)
                            .ToList();
                    }
                    else
                    {
                        arrLogs = dbConn.service_reserves
                            .Join(dbConn.clients, m => m.client_id, k => k.uid, (m, k) => new { _reserve = m, _client = k })
                            .Where(m => m._client.owner_id == user_id &&
                                m._reserve.deleted == 0 &&
                                (m._reserve.status == 2 || m._reserve.status == 3))
                            .OrderByDescending(m => m._reserve.createtime)
                            .Select(m => new STBuyProductLog
                            {
                                uid = m._reserve.uid,
                                customer = m._client.realname,
                                reserve_date = String.Format("{0:yyyy年MM月dd日 HH:mm}", m._reserve.reserve_time),
                                is_read = m._reserve.is_noticedtoemployee
                            })
                            .ToList()
                            .Skip(Global.PAGEITEM_COUNT * page_no)
                            .Take(Global.PAGEITEM_COUNT)
                            .ToList();
                    }

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrLogs;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getBuyProductLogDetail(long user_id, int user_type, long log_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
                    service_reserve reserveItem = dbConn.service_reserves
                        .Where(m => m.uid == log_id && m.deleted == 0)
                        .FirstOrDefault();

                    if (reserveItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = ErrMgr.ERRMSG_NORMAL;
                        return result;
                    }

                    client clientItem = dbConn.clients
                        .Where(m => m.uid == reserveItem.client_id &&
                            m.deleted == 0)
                        .FirstOrDefault();

                    if (clientItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "旧客户信息错误";
                        return result;
                    }

                    String agentName = "无";
                    user agentItem = dbConn.users
                        .Where(m => m.uid == reserveItem.user_id &&
                            m.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT &&
                            m.deleted == 0)
                        .FirstOrDefault();

                    if (agentItem != null)
                    {
                        agentName = agentItem.realname;
                    }

					STBuyProductLog log = new STBuyProductLog();

                    log.uid = reserveItem.uid;
                    log.customer = clientItem.name;
                    log.phone = clientItem.phone;
                    log.agent = agentName;
                    log.reserve_date = String.Format("{0:yyyy年MM月dd日 HH:mm}", reserveItem.reserve_time);
                    log.service_type = "祭拜";
                    log.state = reserveItem.status;
                    log.state_desc = ConstMgr.getBuyProductStateDesc(reserveItem.status);

                    
                    log.products = dbConn.sacrifice_reserves
                        .Where(m => m.servicereserve_id == reserveItem.uid &&
                        m.deleted == 0)
                        .Join(dbConn.sacrifices, m => m.sacrifice_id, k => k.uid, (m, k) => new { _reserve = m, _sacrifice = k })
                        .Select(m => new STProduct
                        {
                            uid = m._reserve.uid,
                            type = m._sacrifice.type,
                            type_desc = ConstMgr.getProductTypeDesc(m._sacrifice.type),
                            title = m._sacrifice.name,
                            amount = m._reserve.count,
                            amount_desc = "" + m._reserve.count,
                            price = m._sacrifice.price * m._reserve.count,
                            price_desc = String.Format("￥{0:0.00}", m._sacrifice.price * m._reserve.count)
                        })
                        .ToList();

                    reserveItem.is_noticedtoemployee = 1;
                    dbConn.SubmitChanges();
                    
                    result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = log;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult readBuyProductLog(long user_id, int user_type, long log_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
                    service_reserve reserveItem = dbConn.service_reserves
                        .Where(m => m.user_id == user_id &&
                        m.uid == log_id && m.deleted == 0)
                        .FirstOrDefault();
                    if (reserveItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = ErrMgr.ERRMSG_NORMAL;
                        return result;
                    }

                    reserveItem.is_noticedtoemployee = 1;
                    dbConn.SubmitChanges();

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getVocationDates(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STVocation> arrVocations = new List<STVocation>();

                    arrVocations = dbConn.user_leaves
                        .Where(m => m.user_id == user_id &&
                        m.deleted == 0)
                        .Select(m => new STVocation
                        {
                            uid = m.uid,
                            date = String.Format("{0:yyyy-MM-dd HH:mm}", m.leavedate),
                            reason = m.excuse,
                            reason_desc = ConstMgr.getVocationTypeDesc(m.excuse),
                            state = m.status,
                            state_desc = ConstMgr.getVocationStateDesc(m.status)
                        })
                        .ToList();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrVocations;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult cancelVocation(long user_id, int user_type, long vocation_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
                    user_leave leaveItem = dbConn.user_leaves
                        .Where(m => m.user_id == user_id &&
                        m.uid == vocation_id && m.deleted == 0)
                        .FirstOrDefault();

                    if (leaveItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = ErrMgr.ERRMSG_NORMAL;
                        return result;
                    }

                    if (leaveItem.leavedate < DateTime.Today)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "您不能取消当天或者以前的休假";
                        return result;
                    }

                    leaveItem.status = 1;
                    dbConn.SubmitChanges();

					Dictionary<String, Object> retdata = new Dictionary<String, Object>();
					retdata.Add("cancelled_id", vocation_id);

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = retdata;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult submitVocation(long user_id, int user_type, int reason, String date, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
                    if(DateTime.Today.DayOfWeek == DayOfWeek.Thursday ||
                        DateTime.Today.DayOfWeek == DayOfWeek.Friday ||
                        DateTime.Today.DayOfWeek == DayOfWeek.Saturday ||
                        DateTime.Today.DayOfWeek == DayOfWeek.Sunday)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "您只能在星期一到星期三申请下一个周的休假";
                        return result;
                    }

                    DateTime targetDate = Convert.ToDateTime(date);
                    if(targetDate == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "日期格式错误";
                        return result;
                    }

                    int minDays = 4;
                    int maxDays = 11;
                    if(DateTime.Today.DayOfWeek == DayOfWeek.Monday) { minDays = 7; maxDays = 13; }
                    if(DateTime.Today.DayOfWeek == DayOfWeek.Tuesday) { minDays = 6; maxDays = 12; }
                    if(DateTime.Today.DayOfWeek == DayOfWeek.Wednesday) { minDays = 5; maxDays = 11; }

                    if((targetDate - DateTime.Today).Days < minDays ||
                        (targetDate - DateTime.Today).Days > maxDays)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "您只能申请下一个周的休假";
                        return result;
                    }

                    user_leave existLeave = dbConn.user_leaves
                        .Where(m => m.user_id == user_id &&
                            m.status == (byte)ConstMgr.VocationState.VOCATION_STATE_CREATED &&
                            m.deleted == 0 &&
                            m.leavedate.Year == targetDate.Year &&
                            m.leavedate.Month == targetDate.Month &&
                            m.leavedate.Day == targetDate.Day)
                        .FirstOrDefault();
                    if (existLeave != null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "申请休假无效，已申请过。";
                        return result;
                    }

                    long office_id = dbConn.users
                        .Where(m => m.uid == user_id && m.deleted == 0)
                        .FirstOrDefault()
                        .office_id ?? 0;

                    List<leave_restrict> arrNotPermittedRestrict = dbConn.leave_restricts
                        .Where(m => m.type == 1 &&
                            m.restrictdate.Year == targetDate.Year &&
                            m.restrictdate.Month == targetDate.Month &&
                            m.restrictdate.Day == targetDate.Day &&
                            m.office_id == office_id)
                        .ToList();
                    if (arrNotPermittedRestrict != null && arrNotPermittedRestrict.Count > 0)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "总部已设定这天不能休息...";
                        return result;
                    }

                    leave_restrict permittedRestrict = dbConn.leave_restricts
                        .Where(m => m.type == 0 &&
                            m.restrictdate.Year == targetDate.Year &&
                            m.restrictdate.Month == targetDate.Month &&
                            m.restrictdate.Day == targetDate.Day &&
                            m.office_id == office_id)
                        .FirstOrDefault();
                    if(permittedRestrict != null)
                    {
                        int existLeaveCount = dbConn.user_leaves
                            .Join(dbConn.users, m => m.user_id, k => k.uid, (m, k) => new { _leave = m, _user = k })
                            .Where(m => m._user.office_id == permittedRestrict.office_id &&
                                m._leave.leavedate.Year == targetDate.Year &&
                                m._leave.leavedate.Month == targetDate.Month &&
                                m._leave.leavedate.Day == targetDate.Day &&
                                m._leave.deleted == 0)
                            .Count();

                        if (existLeaveCount >= permittedRestrict.maxperson)
                        {
                            result.retcode = ErrMgr.ERRCODE_NORMAL;
                            result.retmsg = "这天申请的休假已经满员了，不能再申请...";
                            return result;
                        }
                    }

                    int leavesForThisMonth = dbConn.user_leaves
                        .Where(m => m.user_id == user_id &&
                            m.status == (byte)ConstMgr.VocationState.VOCATION_STATE_CREATED &&
                            m.deleted == 0 &&
                            m.leavedate.Year == targetDate.Year &&
                            m.leavedate.Month == targetDate.Month)
                        .Count();
                    if (leavesForThisMonth >= 4)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "一个月内最大能申请4次休假，您已经申请了4次";
                        return result;
                    }

                    existLeave = dbConn.user_leaves
                        .Where(m => m.user_id == user_id &&
                            m.status == (byte)ConstMgr.VocationState.VOCATION_STATE_CREATED &&
                            m.deleted == 0 &&
                            (targetDate - m.leavedate).Days == 1)
                        .FirstOrDefault();
                    if (existLeave != null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "您已经有申请上一天的休假，不能相继休息";
                        return result;
                    }

                    existLeave = dbConn.user_leaves
                        .Where(m => m.user_id == user_id &&
                            m.status == (byte)ConstMgr.VocationState.VOCATION_STATE_CREATED &&
                            m.deleted == 0 &&
                            m.status == (byte)ConstMgr.VocationState.VOCATION_STATE_CREATED &&
                            (m.leavedate - targetDate).Days == 1)
                        .FirstOrDefault();
                    if (existLeave != null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "您已经有申请下一天的休假，不能相继休息";
                        return result;
                    }

                    user_leave leaveItem = new user_leave();
                    leaveItem.user_id = user_id;
                    leaveItem.leavedate = Convert.ToDateTime(date);
                    leaveItem.createtime = DateTime.Now;
                    leaveItem.excuse = (byte)reason;
                    leaveItem.status = 0;
                    leaveItem.deleted = 0;
                    dbConn.user_leaves.InsertOnSubmit(leaveItem);
                    dbConn.SubmitChanges();

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getOfficeList(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STOfficeCity> arrCities = new List<STOfficeCity>();

                    arrCities = dbConn.chengshis
                        .Where(m => m.deleted == 0)
                        .Select(m => new STOfficeCity
                        {
                            uid = m.uid,
                            name = m.name,
                            offices = dbConn.offices
                            .Where(k => k.chengshi_id == m.uid && k.deleted == 0)
                            .Select(k => new STOffice
                            {
                                uid = k.uid,
                                name = k.name,
                                address = k.address,
                                phone = k.phone,
                                image_url = k.imgurl,
                                lat = (double)k.latitude,
                                lng = (double)k.longitude
                            })
                            .ToList()
                        })
                        .ToList();

                
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrCities;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getOfficeAttendance(long user_id, int user_type, long office_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STVocation> arrVocations = new List<STVocation>();

                    arrVocations = dbConn.user_leaves
                        .Where(m => m.deleted == 0)
                        .Join(dbConn.users, m => m.user_id, k => k.uid, (m, k) => new { _leave = m, _user = k })
                        .Where(m => m._user.office_id == office_id)
                        .Select(m => new STVocation
                        {
                            uid = m._leave.uid,
                            user_id = m._user.uid,
                            user_name = m._user.realname,
                            user_desc = ConstMgr.getUserTypeDesc(m._user.type),
                            date = String.Format("{0:yyyy-MM-dd HH:mm}", m._leave.leavedate),
                            reason = m._leave.excuse,
                            reason_desc = ConstMgr.getVocationTypeDesc(m._leave.excuse)
                        })
                        .ToList();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrVocations;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


        public static SVCResult getOfficeAttendanceList(long user_id, int user_type, long office_id, String check_sum, String method_name)
        {
            SVCResult result = new SVCResult();
            BZDatabaseDataContext dbConn = null;

            try
            {
                dbConn = new BZDatabaseDataContext();

                // Verify User
                String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
                if (verify_result.Equals(""))
                {
                    // Verify Success

                    List<STVocationStatistic> arrVocations = new List<STVocationStatistic>();

                    arrVocations = dbConn.user_leaves
                        .Where(m => m.deleted == 0)
                        .Join(dbConn.users, m => m.user_id, k => k.uid, (m, k) => new { _leave = m, _user = k })
                        .Where(m => m._user.office_id == office_id)                        
                        .GroupBy(m => m._user.uid)
                        .Select
                        (g => new STVocationStatistic
                        {
                            user_id = g.Key,
                            user_name = g.FirstOrDefault()._user.realname,
                            user_desc = ConstMgr.getUserTypeDesc(g.FirstOrDefault()._user.type),
                            month_count = g.Where(i => i._leave.leavedate.Month == DateTime.Today.Month).Count(),
                            year_count = g.Where(i => i._leave.leavedate.Year == DateTime.Today.Year).Count()
                        })
                        .ToList();

                    
                    result.retcode = ErrMgr.ERRCODE_NONE;
                    result.retmsg = ErrMgr.ERRMSG_NONE;
                    result.retdata = arrVocations;
                }
                else
                {
                    result.retcode = ErrMgr.ERRCODE_NORMAL;
                    result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
                }
            }
            catch (System.Exception ex)
            {
                Global.logError(ex.Message);

                result.retcode = ErrMgr.ERRCODE_NORMAL;
                result.retmsg = ex.Message;
                result.retdata = String.Empty;
            }

            return result;
        }

		public static SVCResult getOfficesCurMonthScore(long user_id, int user_type, int month, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

                DateTime startTime = new DateTime(DateTime.Now.Year, month, 1, 0, 0, 0);
                DateTime endTime = startTime.AddMonths(1);

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STMonthlyScore> arrScores = new List<STMonthlyScore>();

                    int yingxiaoRate = 68;
                    bonus_coef bonusCoef = dbConn.bonus_coefs
                        .Where(m => m.name.Equals("yingxiaobili") && m.deleted == 0)
                        .FirstOrDefault();
                    if (bonusCoef != null) yingxiaoRate = bonusCoef.value;
                    if (yingxiaoRate > 100) yingxiaoRate = 100;

                    int taxRate = 10;
                    bonusCoef = dbConn.bonus_coefs
                        .Where(m => m.name.Equals("shuilv") && m.deleted == 0)
                        .FirstOrDefault();
                    if (bonusCoef != null) taxRate = bonusCoef.value;
                    if (taxRate > 100) taxRate = 100;

                    arrScores = dbConn.offices
                        .Where(m => m.deleted == 0)
                        .AsEnumerable()
                        .Select(m => new STMonthlyScore
                        {
                            office_id = m.uid,
                            office_name = m.name,
                            order = m.name,                            
                            agent = (double)(dbConn.tomb_purchases.Where(k => k.deleted == 0 &&
                                k.paytime >= startTime && k.paytime < endTime)
                                .Join(dbConn.users, k => k.user_id, p => p.uid, (k, p) => new { _purchase = k, _user = p })
                                .Where(k => k._user.office_id == m.uid &&
                                    k._user.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT)
                                .Select(k => k._purchase.price)
                                .ToList()
                                .Sum()),
                            employee = (double)(dbConn.tomb_purchases.Where(k => k.deleted == 0 &&
                                k.paytime >= startTime && k.paytime < endTime)
                                .Join(dbConn.users, k => k.user_id, p => p.uid, (k, p) => new { _purchase = k, _user = p })
                                .Where(k => k._user.office_id == m.uid &&
                                    k._user.type != (byte)ConstMgr.UserType.USER_TYPE_AGENT)
                                .Select(k => k._purchase.price)
                                .ToList()
                                .Sum()),
                            response_value = Double.Parse((m.plan_amounts.Split(',').ToList().Count() > month) ? m.plan_amounts.Split(',').ToList()[month] : "50000")
                        })
                        .Select(m => new STMonthlyScore
                        {
                            office_id = m.office_id,
                            office_name = m.office_name,
                            order = m.order,
                            agent = m.agent,
                            employee = m.employee,
                            total = m.employee + m.agent,
                            self_rate = 100.0 * m.employee / (m.employee + m.agent),
                            response_value = m.response_value,
                            success_rate = 100.0 * (m.employee + m.agent) / m.response_value,
                            office_income = m.employee * 0.8 * (100 - yingxiaoRate) * 0.01 * (1 - taxRate/100.0)
                        }) 
                        .ToList();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrScores;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getOfficeMonthlyScore(long user_id, int user_type, long office_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

                    user zhurenItem = dbConn.users
                        .Where(m => m.uid == user_id &&
                            m.office_id == office_id &&
                            (m.type == (byte)ConstMgr.UserType.USER_TYPE_MANAGER ||
                            m.type == (byte)ConstMgr.UserType.USER_TYPE_VICE_MANAGER))
                        .FirstOrDefault();
                    if (zhurenItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "权限不符合";
                        return result;
                    }

                    office officeItem = dbConn.offices
                        .Where(m => m.uid == office_id &&
                            m.deleted == 0)
                        .FirstOrDefault();                    
                    if (officeItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "办事处信息有错误";
                        return result;
                    }

                    int yingxiaoRate = 68;
                    bonus_coef bonusCoef = dbConn.bonus_coefs
                        .Where(m => m.name.Equals("yingxiaobili") && m.deleted == 0)
                        .FirstOrDefault();
                    if (bonusCoef != null) yingxiaoRate = bonusCoef.value;
                    if (yingxiaoRate > 100) yingxiaoRate = 100;

                    int taxRate = 10;                    
                    bonusCoef = dbConn.bonus_coefs
                        .Where(m => m.name.Equals("shuilv") && m.deleted == 0)
                        .FirstOrDefault();
                    if (bonusCoef != null) taxRate = bonusCoef.value;

					List<STMonthlyScore> arrScores = new List<STMonthlyScore>();

					int nCurMonth = DateTime.Now.Month;
					for (int i = 0; i < nCurMonth; i++)
					{
						STMonthlyScore score_item = new STMonthlyScore();

                        DateTime startTime = new DateTime(DateTime.Now.Year, i + 1, 1, 0, 0, 0);
                        DateTime endTime = startTime.AddMonths(1);

						score_item.office_id = office_id;
						score_item.office_name = officeItem.name;
						score_item.order = (i + 1).ToString() + "月";
                        score_item.agent = (double)(dbConn.tomb_purchases.Where(k => k.deleted == 0 &&
                            k.paytime >= startTime && k.paytime < endTime)
                            .Join(dbConn.users, k => k.user_id, p => p.uid, (k, p) => new { _purchase = k, _user = p })
                            .Where(k => k._user.office_id == office_id &&
                                k._user.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT)
                            .Select(k => k._purchase.price)
                            .ToList()
                            .Sum());
                        score_item.employee = (double)(dbConn.tomb_purchases.Where(k => k.deleted == 0 &&
                            k.paytime >= startTime && k.paytime < endTime)
                            .Join(dbConn.users, k => k.user_id, p => p.uid, (k, p) => new { _purchase = k, _user = p })
                            .Where(k => k._user.office_id == office_id &&
                                k._user.type != (byte)ConstMgr.UserType.USER_TYPE_AGENT)
                            .Select(k => k._purchase.price)
                            .ToList()
                            .Sum());
						score_item.total = score_item.agent + score_item.employee;
                        if (score_item.total <= 0)
                            score_item.self_rate = 0;
                        else
						    score_item.self_rate = (int)(score_item.employee * 100 / score_item.total);
						score_item.response_value = Double.Parse((officeItem.plan_amounts.Split(',').ToList().Count() > i) ? 
                            officeItem.plan_amounts.Split(',').ToList()[i] : "50000");
						score_item.success_rate = (int)(score_item.total * 100 / score_item.response_value);
						score_item.office_income = score_item.employee * 0.8 * (100 - yingxiaoRate) * 0.01 * (1 - taxRate/100.0);

						arrScores.Add(score_item);
					}


					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrScores;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getEmployeesDailyScore(long user_id, int user_type, long office_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STDailyScore> arrScores = new List<STDailyScore>();

                    
                    arrScores = dbConn.tomb_purchases
                        .Where(m => m.deleted == 0)
                        .Join(dbConn.users, m => m.user_id, k => k.uid, (m, k) => new { _purchase = m, _user = k})
                        .Where(m => m._purchase.paytime == DateTime.Today &&
                            m._user.office_id == office_id &&
                            m._purchase.deleted == 0)
                        .Select(m => new STDailyScore
                        {
                            name = (m._user.type == (byte)ConstMgr.UserType.USER_TYPE_EMPLOYEE) ? 
                                m._user.name : (dbConn.users.Where(k => k.uid == m._user.owner_id).FirstOrDefault() != null ? 
                                    dbConn.users.Where(k => k.uid == m._user.owner_id).FirstOrDefault().realname : ""),
                            agent = (m._user.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT ?
                                m._user.realname : ""),
                            price = (dbConn.grave_sites.Where(k => k.uid == m._purchase.tombsite_id &&
                                k.deleted == 0).FirstOrDefault() != null) ? dbConn.grave_sites.Where(k => k.uid == m._purchase.tombsite_id &&
                                k.deleted == 0).FirstOrDefault().price : -1,
                            actual = m._purchase.price,
                        })
                        .ToList();

                    
					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrScores;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getOfficesDailyScore(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STDailyScore> arrScores = new List<STDailyScore>();

                    arrScores = dbConn.tomb_purchases
                        .Where(m => m.deleted == 0)
                        .Join(dbConn.users, m => m.user_id, k => k.uid, (m, k) => new { _purchase = m, _user = k })
                        .Join(dbConn.offices, m => m._user.office_id, k => k.uid, (m, k) => new { _purchase = m, _office = k })
                        .Where(m => m._purchase._purchase.paytime == DateTime.Today &&
                            m._purchase._purchase.deleted == 0)
                        .GroupBy(m => m._office.uid)
                        .Select
                        (g => new STDailyScore
                        {
                            name = g.FirstOrDefault()._office.name,
                            employee_score = g.Where(m => m._purchase._user.type == (byte)ConstMgr.UserType.USER_TYPE_EMPLOYEE).Select(m => m._purchase._purchase.price).Sum(),
                            agent_score = g.Where(m => m._purchase._user.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT).Select(m => m._purchase._purchase.price).Sum()
                        })
                        .Select(m => new STDailyScore
                        {
                            name = m.name,
                            employee_score = m.employee_score,
                            agent_score = m.agent_score,
                            daily_total = m.employee_score + m.agent_score
                        })
                        .ToList();

                    List<office> arrOffice = dbConn.offices
                        .Where(m => m.deleted == 0 && !arrScores.Select(k => k.name).ToList().Contains(m.name))
                        .ToList();
                    foreach (office officeItem in arrOffice)
                    {
                        arrScores.Add(new STDailyScore
                            {
                                name = officeItem.name                                
                            });
                    }

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrScores;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getEmployeePersonalScore(long user_id, int user_type, int page_no, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STPersonalScore_Boss> arrScores = new List<STPersonalScore_Boss>();

                    arrScores = dbConn.tomb_purchases
                        .Join(dbConn.users, m => m.user_id, k => k.uid, (m, k) => new { _purchase = m, _user = k })
                        .Join(dbConn.offices, m => m._user.office_id, k => k.uid, (m, k) => new { _purchase = m, _office = k })
                        .Where(m => m._purchase._purchase.paytime.Year == DateTime.Today.Year &&
                            m._purchase._user.type == (byte)ConstMgr.UserType.USER_TYPE_EMPLOYEE &&
                        m._purchase._purchase.deleted == 0)
                        .GroupBy(m => m._purchase._user.uid)
                        .Select
                        (m => new STPersonalScore_Boss
                        {
                            office_id = m.FirstOrDefault()._office.uid,
                            office_name = m.FirstOrDefault()._office.name,
                            user_id = m.FirstOrDefault()._purchase._user.uid,
                            user_name = m.FirstOrDefault()._purchase._user.realname,
                            score = m.Select(k => k._purchase._purchase.price).Sum()
                        })
                        .OrderByDescending(m => m.score)
                        .Skip(Global.PAGEITEM_COUNT * page_no)
                        .Take(Global.PAGEITEM_COUNT)
                        .ToList();

                    List<STPersonalScore_Boss> arrEmptyScores = dbConn.users
                        .Join(dbConn.offices, m => m.office_id, k => k.uid, (m, k) => new { _user = m, _office = k })
                        .Where(m => m._user.deleted == 0 &&
                            !arrScores.Select(k => k.user_id).ToList().Contains(m._user.uid) &&
                            m._user.type == (byte)ConstMgr.UserType.USER_TYPE_EMPLOYEE)
                        .Select(m => new STPersonalScore_Boss
                        {
                            office_id = m._office.uid,
                            office_name = m._office.name,
                            user_id = m._user.uid,
                            user_name = m._user.realname,
                            score = 0
                        })
                        .ToList();

                    foreach (STPersonalScore_Boss scoreItem in arrEmptyScores)
                    {
                        arrScores.Add(scoreItem);
                    }

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrScores;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getEmployeePersonalScoreMgr(long user_id, int user_type, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

                    user zhurenItem = dbConn.users
                        .Where(m => m.uid == user_id &&
                            (m.type == (byte)ConstMgr.UserType.USER_TYPE_MANAGER ||
                            m.type == (byte)ConstMgr.UserType.USER_TYPE_VICE_MANAGER)) 
                        .FirstOrDefault();
                    if(zhurenItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
					    result.retmsg = "权限不符合";
                        return result;
                    }

					List<STEmpScore_Manager> arrScores = new List<STEmpScore_Manager>();

                    arrScores = dbConn.users
                        .Where(m => m.type == (byte)ConstMgr.UserType.USER_TYPE_EMPLOYEE &&
                            m.office_id == zhurenItem.office_id &&
                            m.deleted == 0)
                        .Select(m => new STEmpScore_Manager
                        {
                            user_id = m.uid,
                            user_name = m.realname
                        })
                        .ToList();

					foreach (STEmpScore_Manager score_item in arrScores)
					{
						for (int j = 0; j < DateTime.Now.Month; j++)
						{
							STScore_Manager score_info = new STScore_Manager();

							score_info.month = j + 1;
                            List<int> arrPrice = dbConn.tomb_purchases
                                .Join(dbConn.users, m => m.user_id, k => k.uid, (m, k) => new { _purchase = m, _user = k })
                                .Where(m => m._purchase.paytime.Year == DateTime.Today.Year &&
                                    m._purchase.paytime.Month == j + 1 &&
                                    m._user.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT &&
                                    m._user.owner_id == score_item.user_id &&
                                    m._purchase.deleted == 0)
                                .Select(m => m._purchase.price)
                                .ToList();
                                
                            if (arrPrice != null && arrPrice.Count > 0) score_info.agent = arrPrice.Sum();
                            arrPrice = dbConn.tomb_purchases
                                .Where(m => m.paytime.Year == DateTime.Today.Year &&
                                    m.paytime.Month == j + 1 &&
                                    m.user_id == score_item.user_id &&
                                    m.deleted == 0)
                                .Select(m => m.price)
                                .ToList();
                            if (arrPrice != null && arrPrice.Count > 0) score_info.employee = arrPrice.Sum();
                            score_info.monthly_total = score_info.agent + score_info.employee;
                            if (score_info.monthly_total <= 0)
                                score_info.self_rate = 0;
                            else 
							    score_info.self_rate = (int)(score_info.employee * 100 / score_info.monthly_total);
                            score_info.response_value = 0;

                            user employeeItem = dbConn.users
                                .Where(m => m.uid == score_item.user_id)
                                .FirstOrDefault();
                            if (employeeItem != null)
                                score_info.response_value = employeeItem.planamount_permonth ?? 0;
                            if (score_info.response_value <= 0)
                                score_info.success_rate = 0;
                            else
							    score_info.success_rate = (int)(score_info.monthly_total * 100 / score_info.response_value);

							score_item.scores.Add(score_info);
						}
					}


					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrScores;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult getAgentPersonalScore(long user_id, int user_type, int page_no, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STPersonalScore_Boss> arrScores = new List<STPersonalScore_Boss>();

                    arrScores = dbConn.tomb_purchases
                        .Join(dbConn.users, m => m.user_id, k => k.uid, (m, k) => new { _purchase = m, _user = k })
                        .Join(dbConn.offices, m => m._user.office_id, k => k.uid, (m, k) => new { _purchase = m, _office = k })
                        .Where(m => m._purchase._purchase.paytime.Year == DateTime.Today.Year &&
                            m._purchase._user.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT &&
                        m._purchase._purchase.deleted == 0)
                        .GroupBy(m => m._purchase._user.uid)
                        .Select
                        (m => new STPersonalScore_Boss
                        {
                            office_id = m.FirstOrDefault()._office.uid,
                            office_name = m.FirstOrDefault()._office.name,
                            user_id = m.FirstOrDefault()._purchase._user.uid,
                            user_name = m.FirstOrDefault()._purchase._user.realname,
                            score = m.Select(k => k._purchase._purchase.price).Sum()
                        })
                        .OrderByDescending(m => m.score)
                        .ToList();

                    List<STPersonalScore_Boss> arrEmptyScores = dbConn.users
                        .Join(dbConn.offices, m => m.office_id, k => k.uid, (m, k) => new { _user = m, _office = k })
                        .Where(m => m._user.deleted == 0 &&
                            !arrScores.Select(k => k.user_id).ToList().Contains(m._user.uid) &&
                            m._user.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT)
                        .Select(m => new STPersonalScore_Boss
                        {
                            office_id = m._office.uid,
                            office_name = m._office.name,
                            user_id = m._user.uid,
                            user_name = m._user.realname,
                            score = 0
                        })
                        .ToList();

                    foreach (STPersonalScore_Boss scoreItem in arrEmptyScores)
                    {
                        arrScores.Add(scoreItem);
                    }

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrScores;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getAgentPersonalScoreMgr(long user_id, int user_type, int page_no, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

                    user zhurenItem = dbConn.users
                        .Where(m => m.uid == user_id &&
                            (m.type == (byte)ConstMgr.UserType.USER_TYPE_MANAGER ||
                            m.type == (byte)ConstMgr.UserType.USER_TYPE_VICE_MANAGER)) 
                        .FirstOrDefault();
                    if(zhurenItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
					    result.retmsg = "权限不符合";
                        return result;
                    }

					List<STAgentScore_Mgr> arrScores = new List<STAgentScore_Mgr>();

                    arrScores = dbConn.users
                        .Where(m => m.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT &&
                            m.office_id == zhurenItem.office_id &&
                            m.deleted == 0)
                        .Select(m => new STAgentScore_Mgr
                        {
                            user_id = m.uid,
                            user_name = m.realname,
                            score = (dbConn.tomb_purchases
                                .Where(k => k.user_id == m.uid &&
                                    k.paytime.Year == DateTime.Today.Year &&
                                    k.paytime.Month == DateTime.Today.Month)
                                .Select(k => k.price)
                                .Count() > 0) ?
                                dbConn.tomb_purchases
                                .Where(k => k.user_id == m.uid &&
                                    k.paytime.Year == DateTime.Today.Year &&
                                    k.paytime.Month == DateTime.Today.Month)
                                .Select(k => k.price)
                                .Sum() : 0
                        })
                        .OrderByDescending(m => m.score)
                        .Skip(Global.PAGEITEM_COUNT * page_no)
                        .Take(Global.PAGEITEM_COUNT)
                        .ToList();

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrScores;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}



		public static SVCResult getOfficesDepositLogs(long user_id, int user_type, int page_no, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

					List<STOfficeDepositLog> arrDeposits = new List<STOfficeDepositLog>();

                    arrDeposits = dbConn.offices
                        .Where(m => m.deleted == 0)
                        .Select(m => new STOfficeDepositLog
                        {
                            uid = m.uid,
                            office_id = m.uid,
                            office_name = m.name,
                            employee = (dbConn.deposits
                                .Where(k => k.endtime > DateTime.Now &&
                                    k.deleted == 0)
                                .Join(dbConn.users, k => k.receiver_id, l => l.uid, (k, l) => new { _deposite = k, _user = l })
                                .Where(k => k._user.office_id == m.uid &&
                                    k._user.type == (byte)ConstMgr.UserType.USER_TYPE_EMPLOYEE &&
                                    k._user.deleted == 0)
                                .Count() > 0) ?
                                dbConn.deposits
                                .Join(dbConn.users, k => k.receiver_id, l => l.uid, (k, l) => new { _deposite = k, _user = l })
                                .Where(k => k._user.office_id == m.uid &&
                                    k._user.type == (byte)ConstMgr.UserType.USER_TYPE_EMPLOYEE &&
                                    k._user.deleted == 0)
                                .Select(k => k._deposite.price)
                                .Sum() : 0,
                            agent = (dbConn.deposits
                                .Join(dbConn.users, k => k.receiver_id, l => l.uid, (k, l) => new { _deposite = k, _user = l })
                                .Where(k => k._user.office_id == m.uid &&
                                    k._user.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT &&
                                    k._deposite.endtime > DateTime.Now &&
                                    k._user.deleted == 0)
                                .Count() > 0) ?
                                dbConn.deposits
                                .Join(dbConn.users, k => k.receiver_id, l => l.uid, (k, l) => new { _deposite = k, _user = l })
                                .Where(k => k._user.office_id == m.uid &&
                                    k._user.type == (byte)ConstMgr.UserType.USER_TYPE_AGENT &&
                                    k._user.deleted == 0)
                                .Select(k => k._deposite.price)
                                .Sum() : 0,
                        })
                        .Select(m => new STOfficeDepositLog
                        {
                            uid = m.uid,
                            office_id = m.office_id,
                            office_name = m.office_name,
                            employee = m.employee,
                            agent = m.agent,
                            total = m.employee + m.agent
                        })
                        .ToList();

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrDeposits;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}
        

		public static SVCResult getReserveLogs(long user_id, int user_type, int page_no, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success

                    user zhurenItem = dbConn.users
                        .Where(m => m.uid == user_id &&
                            (m.type == (byte)ConstMgr.UserType.USER_TYPE_MANAGER ||
                            m.type == (byte)ConstMgr.UserType.USER_TYPE_VICE_MANAGER))
                        .FirstOrDefault();
                    if (zhurenItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "权限不符合";
                        return result;
                    }

					List<STReserveLog> arrLogs = new List<STReserveLog>();

                    arrLogs = dbConn.visit_reserves
                        .Where(m => m.office_id == zhurenItem.office_id &&
                            m.deleted == 0)
                        .Select(m => new STReserveLog
                        {
                            uid = m.uid,
                            customer_name = m.name,
                            customer_phone = m.phone,
                            reserve_date = m.reservetime.ToShortDateString(),
                            state = m.status,
                            state_desc = ConstMgr.getReserveStateDesc(m.status)
                        })
                        .Skip(Global.PAGEITEM_COUNT * page_no)
                        .Take(Global.PAGEITEM_COUNT)
                        .ToList();

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = arrLogs;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult cancelReserve(long user_id, int user_type, long log_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
                    user zhurenItem = dbConn.users
                        .Where(m => m.uid == user_id &&
                            (m.type == (byte)ConstMgr.UserType.USER_TYPE_MANAGER ||
                            m.type == (byte)ConstMgr.UserType.USER_TYPE_VICE_MANAGER))
                        .FirstOrDefault();
                    if (zhurenItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "权限不符合";
                        return result;
                    }

                    visit_reserve reserveItem = dbConn.visit_reserves
                        .Where(m => m.uid == log_id)
                        .FirstOrDefault();

                    if (reserveItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "预约信息有错误";
                        return result;
                    }

                    reserveItem.handler_id = user_id;
                    reserveItem.handletime = DateTime.Now;
                    reserveItem.status = (byte)ConstMgr.ReserveState.RESERVE_STATE_CANCELLED;
                    dbConn.SubmitChanges();

					Dictionary<String, Object> retdata = new Dictionary<String, Object>();
					retdata.Add("cancelled_id", log_id);

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = retdata;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}


		public static SVCResult confirmReserve(long user_id, int user_type, long log_id, String check_sum, String method_name)
		{
			SVCResult result = new SVCResult();
			BZDatabaseDataContext dbConn = null;

			try
			{
				dbConn = new BZDatabaseDataContext();

				// Verify User
				String verify_result = SvcCommon.verifyServiceConsumer(user_id, check_sum, method_name);
				if (verify_result.Equals(""))
				{
					// Verify Success
                    user zhurenItem = dbConn.users
                        .Where(m => m.uid == user_id &&
                            (m.type == (byte)ConstMgr.UserType.USER_TYPE_MANAGER ||
                            m.type == (byte)ConstMgr.UserType.USER_TYPE_VICE_MANAGER))
                        .FirstOrDefault();
                    if (zhurenItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "权限不符合";
                        return result;
                    }

                    visit_reserve reserveItem = dbConn.visit_reserves
                        .Where(m => m.uid == log_id)
                        .FirstOrDefault();

                    if (reserveItem == null)
                    {
                        result.retcode = ErrMgr.ERRCODE_NORMAL;
                        result.retmsg = "预约信息有错误";
                        return result;
                    }

                    reserveItem.handler_id = user_id;
                    reserveItem.handletime = DateTime.Now;
                    reserveItem.status = (byte)ConstMgr.ReserveState.RESERVE_STATE_AGREED;
                    dbConn.SubmitChanges();

					Dictionary<String, Object> retdata = new Dictionary<String, Object>();
					retdata.Add("confirmed_id", log_id);

					result.retcode = ErrMgr.ERRCODE_NONE;
					result.retmsg = ErrMgr.ERRMSG_NONE;
					result.retdata = retdata;
				}
				else
				{
					result.retcode = ErrMgr.ERRCODE_NORMAL;
					result.retmsg = ErrMgr.ERRMSG_CHECKSUM;
				}
			}
			catch (System.Exception ex)
			{
				Global.logError(ex.Message);

				result.retcode = ErrMgr.ERRCODE_NORMAL;
				result.retmsg = ex.Message;
				result.retdata = String.Empty;
			}

			return result;
		}

        public static SVCResult dailyPerformanceReport()
        {
            SVCResult result = new SVCResult();
            BZDatabaseDataContext dbConn = null;

            try
            {
                dbConn = new BZDatabaseDataContext();

                List<user> arrLingdao = dbConn.users
                    .Where(m => (m.type == (byte)ConstMgr.UserType.USER_TYPE_CHAIRMAN ||
                    m.type == (byte)ConstMgr.UserType.USER_TYPE_GENERALMANAGER ||
                    m.type == (byte)ConstMgr.UserType.USER_TYPE_VICE_GENERALMANAGER) &&
                    m.deleted == 0)
                    .ToList();
                int overallPerformance = 0;
                List<tomb_purchase> arrPurchase = dbConn.tomb_purchases
                    .Where(m => m.paytime == DateTime.Today &&
                    m.deleted == 0)                    
                    .ToList();

                if (arrPurchase != null && arrPurchase.Count > 0)
                {
                    overallPerformance = arrPurchase.Select(m => m.price).Sum();
                }

                foreach (user lingdao in arrLingdao)
                {
                    JPushApi.SendPushNotification(Convert.ToString(lingdao.uid), "Performance\n" + "今日总业绩: ￥" + overallPerformance);
                }
            }
            catch (System.Exception ex)
            {
                Global.logError(ex.Message);

                result.retcode = ErrMgr.ERRCODE_NORMAL;
                result.retmsg = ex.Message;
                result.retdata = String.Empty;
            }

            return result;
        }

        public static SVCResult clientParentBirthdayRemind()
        {
            SVCResult result = new SVCResult();
            BZDatabaseDataContext dbConn = null;
            List<STPushNotification> arrNotifications = new List<STPushNotification>();

            try
            {
                dbConn = new BZDatabaseDataContext();

                List<client_parent> arrParent = dbConn.client_parents
                    .Where(m => m.deleted == 0)
                    .ToList();
                foreach (client_parent parentItem in arrParent)
                {
                    DateTime birthday = parentItem.birthday;
                    DateTime deathday = parentItem.deathday;
                    DateTime today = DateTime.Today;
                    DateTime nextBirth = new DateTime(today.Year, birthday.Month, birthday.Day);
                    DateTime nextDeath = new DateTime(today.Year, deathday.Month, deathday.Day);
                    
                    if (nextBirth < today)
                        nextBirth = today.AddYears(1);
                    if (nextDeath < today)
                        nextDeath = today.AddYears(1);

                    int numBirthDays = (nextBirth - today).Days;
                    int numDeathDays = (nextDeath - today).Days;

                    if (numBirthDays == 7)
                    {
                        client clientItem = dbConn.clients
                            .Where(m => m.uid == parentItem.client_id)
                            .FirstOrDefault();
                        if (clientItem != null)
                        {
                            String reminndContent = "ParentBirth\n";
                            reminndContent += parentItem.relation;
                            reminndContent += "生日快要到了！\n";
                            reminndContent += "生日:";
                            reminndContent += parentItem.birthday.ToShortDateString() + "\n";
                            reminndContent += "墓位:";
                            grave_site tombSite = dbConn.grave_sites
                                .Where(m => m.uid == parentItem.tombsite_id)
                                .FirstOrDefault();
                            if(tombSite != null)
                                reminndContent += tombSite.number;

                            JPushApi.SendPushNotification(Convert.ToString(Global.getJPushTagIdForClient(clientItem.uid)), reminndContent);
                            arrNotifications.Add(new STPushNotification
                            {
                                user_id = clientItem.uid + 10000,
                                content = reminndContent
                            });
                        }
                    }

                    if (numDeathDays == 7)
                    {
                        client clientItem = dbConn.clients
                            .Where(m => m.uid == parentItem.client_id)
                            .FirstOrDefault();
                        if (clientItem != null)
                        {
                            String reminndContent = "ParentBirth\n";                            
                            reminndContent += parentItem.relation;
                            reminndContent += "末日快要到了！\n";
                            reminndContent += "末日:";
                            reminndContent += parentItem.birthday.ToShortDateString() + "\n";
                            reminndContent += "墓位:";
                            grave_site tombSite = dbConn.grave_sites
                                .Where(m => m.uid == parentItem.tombsite_id)
                                .FirstOrDefault();
                            if (tombSite != null)
                                reminndContent += tombSite.number;

                            JPushApi.SendPushNotification(Convert.ToString(Global.getJPushTagIdForClient(clientItem.uid)), reminndContent);
                            arrNotifications.Add(new STPushNotification
                            {
                                user_id = clientItem.uid + 10000,
                                content = reminndContent
                            });
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                Global.logError(ex.Message);

                result.retcode = ErrMgr.ERRCODE_NORMAL;
                result.retmsg = ex.Message;
                result.retdata = String.Empty;
            }

            result.retcode = ErrMgr.ERRCODE_NONE;
            result.retmsg = ErrMgr.ERRMSG_NONE;
            result.retdata = arrNotifications;
            return result;
        }

        public static SVCResult checkParentBirthNotify(long client_id)
        {
            SVCResult result = new SVCResult();
            BZDatabaseDataContext dbConn = null;
            List<STParentBirthNotify> arrNotify = new List<STParentBirthNotify>();

            try
            {
                dbConn = new BZDatabaseDataContext();

                client clientItem = dbConn.clients
                    .Where(m => m.uid == client_id &&
                        m.deleted == 0)
                    .FirstOrDefault();

                if (clientItem == null)
                {
                    result.retcode = ErrMgr.ERRCODE_NORMAL;
                    result.retmsg = "用户信息有错误";
                    return result;
                }

                List<client_parent> arrParent = dbConn.client_parents
                    .Where(m => m.client_id == client_id &&
                        m.deleted == 0)
                    .ToList();
                foreach (client_parent parentItem in arrParent)
                {
                    DateTime birthday = parentItem.birthday;
                    DateTime deathday = parentItem.deathday;
                    DateTime today = DateTime.Today;
                    DateTime nextBirth = new DateTime(today.Year, birthday.Month, birthday.Day);
                    DateTime nextDeath = new DateTime(today.Year, deathday.Month, deathday.Day);

                    if (nextBirth < today)
                        nextBirth = today.AddYears(1);
                    if (nextDeath < today)
                        nextDeath = today.AddYears(1);

                    int numBirthDays = (nextBirth - today).Days;
                    int numDeathDays = (nextDeath - today).Days;

                    if (numBirthDays == 7)
                    {
                        birthnotify_track trackItem = dbConn.birthnotify_tracks
                            .Where(m => m.parent_id == parentItem.uid &&
                                m.type == 0 &&
                                m.createtime.Year == DateTime.Today.Year &&
                                m.deleted == 0)
                            .FirstOrDefault();

                        if (trackItem == null)
                        {
                            grave_site tombSite = dbConn.grave_sites
                            .Where(m => m.uid == parentItem.tombsite_id &&
                                m.deleted == 0)
                            .FirstOrDefault();

                            String tombNumber = "";
                            String description = "";

                            if (tombSite != null)
                                tombNumber = tombSite.number;
                            description = String.Format("尊敬的客户，您{0}的生日({1})快要到了。",
                                parentItem.relation, Global.convertDateToString(birthday, "yyyy年MM月dd日"));

                            arrNotify.Add(new STParentBirthNotify
                            {
                                tomb_no = tombNumber,
                                desc = description,
                                date = Global.convertDateToString(birthday, "MM月dd日")
                            });

                            birthnotify_track notifyTrack = new birthnotify_track();
                            notifyTrack.parent_id = parentItem.uid;
                            notifyTrack.type = 0;
                            notifyTrack.createtime = DateTime.Now;
                            notifyTrack.deleted = 0;
                            dbConn.birthnotify_tracks.InsertOnSubmit(notifyTrack);
                            dbConn.SubmitChanges();
                        }
                    }

                    if (numDeathDays == 7)
                    {
                        birthnotify_track trackItem = dbConn.birthnotify_tracks
                            .Where(m => m.parent_id == parentItem.uid &&
                                m.type == 1 &&
                                m.createtime.Year == DateTime.Today.Year &&
                                m.deleted == 0)
                            .FirstOrDefault();

                        if (trackItem == null)
                        {
                            grave_site tombSite = dbConn.grave_sites
                                .Where(m => m.uid == parentItem.tombsite_id &&
                                    m.deleted == 0)
                                .FirstOrDefault();

                            String tombNumber = "";
                            String description = "";

                            if (tombSite != null)
                                tombNumber = tombSite.number;
                            description = String.Format("尊敬的客户，您{0}的末日({1})快要到了。",
                                parentItem.relation, Global.convertDateToString(deathday, "yyyy年MM月dd日"));

                            arrNotify.Add(new STParentBirthNotify
                            {
                                tomb_no = tombNumber,
                                desc = description,
                                date = Global.convertDateToString(deathday, "MM月dd日")
                            });

                            birthnotify_track notifyTrack = new birthnotify_track();
                            notifyTrack.parent_id = parentItem.uid;
                            notifyTrack.type = 1;
                            notifyTrack.createtime = DateTime.Now;
                            notifyTrack.deleted = 0;
                            dbConn.birthnotify_tracks.InsertOnSubmit(notifyTrack);
                            dbConn.SubmitChanges();
                        }
                    }
                }
            }
            catch (System.Exception ex)
            {
                Global.logError(ex.Message);

                result.retcode = ErrMgr.ERRCODE_NORMAL;
                result.retmsg = ex.Message;
                result.retdata = String.Empty;
            }

            result.retcode = ErrMgr.ERRCODE_NONE;
            result.retmsg = ErrMgr.ERRMSG_NONE;
            result.retdata = arrNotify;
            return result;
        }


	}
}