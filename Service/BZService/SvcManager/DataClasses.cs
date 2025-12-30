using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace BZService.SvcManager
{
	public class DataClasses {}


	[DataContract]
	public class STAdvertImage
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "image_url", Order = 2)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}
	}



	[DataContract]
	public class STAreaPoint
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "contents", Order = 3)]
		private String _contents = String.Empty;
		public String contents
		{
			get { return _contents; }
			set { _contents = value; }
		}


		[DataMember(Name = "x_rate", Order = 4)]
		private double _x_rate = 0;
		public double x_rate
		{
			get { return _x_rate; }
			set { _x_rate = value; }
		}


		[DataMember(Name = "y_rate", Order = 5)]
		private double _y_rate = 0;
		public double y_rate
		{
			get { return _y_rate; }
			set { _y_rate = value; }
		}

        [DataMember(Name = "row_count", Order = 6)]
        private int _row_count = 0;
        public int row_count
        {
            get { return _row_count; }
            set { _row_count = value; }
        }

        [DataMember(Name = "column_count", Order = 7)]
        private int _column_count = 0;
        public int column_count
        {
            get { return _column_count; }
            set { _column_count = value; }
        }

        [DataMember(Name = "type", Order = 8)]
        private int _type = 0;
        public int type
        {
            get { return _type; }
            set { _type = value; }
        }

		[DataMember(Name = "products", Order = 9)]
		private List<STProduct> _products = new List<STProduct>();
		public List<STProduct> products
		{
			get { return _products; }
			set { _products = value; }
		}

        [DataMember(Name = "image_url", Order = 10)]
        private String _image_url = String.Empty;
        public String image_url
        {
            get { return _image_url; }
            set { _image_url = value; }
        }
	}


	[DataContract]
	public class STDragonService
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "image_url", Order = 2)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}


		[DataMember(Name = "name", Order = 3)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "intro", Order = 4)]
		private String _intro = String.Empty;
		public String intro
		{
			get { return _intro; }
			set { _intro = value; }
		}


		[DataMember(Name = "price", Order = 5)]
		private double _price = 0;
		public double price
		{
			get { return _price; }
			set { _price = value; }
		}


		[DataMember(Name = "price_desc", Order = 6)]
		private String _price_desc = String.Empty;
		public String price_desc
		{
			get { return _price_desc; }
			set { _price_desc = value; }
		}


		[DataMember(Name = "user_agree_rate", Order = 7)]
		private int _user_agree_rate = 0;
		public int user_agree_rate
		{
			get { return _user_agree_rate; }
			set { _user_agree_rate = value; }
		}


		[DataMember(Name = "product_intro", Order = 8)]
		private String _product_intro = String.Empty;
		public String product_intro
		{
			get { return _product_intro; }
			set { _product_intro = value; }
		}


		[DataMember(Name = "service_contents", Order = 9)]
		private String _service_contents = String.Empty;
		public String service_contents
		{
			get { return _service_contents; }
			set { _service_contents = value; }
		}
	}



	[DataContract]
	public class STDragonServiceArea
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "services", Order = 3)]
		private List<STDragonService> _services = new List<STDragonService>();
		public List<STDragonService> services
		{
			get { return _services; }
			set { _services = value; }
		}
	}


	[DataContract]
	public class STDragonServiceCity
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "areas", Order = 3)]
		private List<STDragonServiceArea> _areas = new List<STDragonServiceArea>();
		public List<STDragonServiceArea> areas
		{
			get { return _areas; }
			set { _areas = value; }
		}
	}


	[DataContract]
	public class STTombKnowledge
	{
		[DataMember(Name = "buy_tomb_flow", Order = 1)]
		private String _buy_tomb_flow = String.Empty;
		public String buy_tomb_flow
		{
			get { return _buy_tomb_flow; }
			set { _buy_tomb_flow = value; }
		}


		[DataMember(Name = "precaution", Order = 2)]
		private String _precaution = String.Empty;
		public String precaution
		{
			get { return _precaution; }
			set { _precaution = value; }
		}


		[DataMember(Name = "bury_custom", Order = 3)]
		private String _bury_custom = String.Empty;
		public String bury_custom
		{
			get { return _bury_custom; }
			set { _bury_custom = value; }
		}


		[DataMember(Name = "bury_news_url", Order = 4)]
		private String _bury_news_url = String.Empty;
		public String bury_news_url
		{
			get { return _bury_news_url; }
			set { _bury_news_url = value; }
		}
	}



	[DataContract]
	public class STBuryService
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "title", Order = 2)]
		private String _title = String.Empty;
		public String title
		{
			get { return _title; }
			set { _title = value; }
		}


		[DataMember(Name = "splash_image_url", Order = 3)]
		private String _splash_image_url = String.Empty;
		public String splash_image_url
		{
			get { return _splash_image_url; }
			set { _splash_image_url = value; }
		}


		[DataMember(Name = "video_url", Order = 4)]
		private String _video_url = String.Empty;
		public String video_url
		{
			get { return _video_url; }
			set { _video_url = value; }
		}


		[DataMember(Name = "contents", Order = 5)]
		private String _contents = String.Empty;
		public String contents
		{
			get { return _contents; }
			set { _contents = value; }
		}


		[DataMember(Name = "price", Order = 6)]
		private double _price = 0;
		public double price
		{
			get { return _price; }
			set { _price = value; }
		}


		[DataMember(Name = "price_desc", Order = 7)]
		private String _price_desc = String.Empty;
		public String price_desc
		{
			get { return _price_desc; }
			set { _price_desc = value; }
		}

	}



	[DataContract]
	public class STDeputyService
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "image_url", Order = 2)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}

        [DataMember(Name = "title", Order = 3)]
        private String _title = String.Empty;
        public String title
        {
            get { return _title; }
            set { _title = value; }
        }

		[DataMember(Name = "contents", Order = 3)]
		private String _contents = String.Empty;
		public String contents
		{
			get { return _contents; }
			set { _contents = value; }
		}
	}


	[DataContract]
	public class STAfterService
	{
		[DataMember(Name = "bury_services", Order = 1)]
		private List<STBuryService> _bury_services = new List<STBuryService>();
		public List<STBuryService> bury_services
		{
			get { return _bury_services; }
			set { _bury_services = value; }
		}


		[DataMember(Name = "deputy_services", Order = 2)]
		private List<STDeputyService> _deputy_services = new List<STDeputyService>();
		public List<STDeputyService> deputy_services
		{
            get { return _deputy_services; }
            set { _deputy_services = value; }
		}
	}



	[DataContract]
	public class ST36View
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "title", Order = 2)]
		private String _title = String.Empty;
		public String title
		{
			get { return _title; }
			set { _title = value; }
		}


		[DataMember(Name = "image_url", Order = 3)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}


		[DataMember(Name = "contents", Order = 4)]
		private String _contents = String.Empty;
		public String contents
		{
			get { return _contents; }
			set { _contents = value; }
		}
	}



	[DataContract]
	public class STOffice
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "address", Order = 3)]
		private String _address = String.Empty;
		public String address
		{
			get { return _address; }
			set { _address = value; }
		}


		[DataMember(Name = "phone", Order = 4)]
		private String _phone = String.Empty;
		public String phone
		{
			get { return _phone; }
			set { _phone = value; }
		}

        [DataMember(Name = "chief", Order = 3)]
        private String _chief = String.Empty;
        public String chief
        {
            get { return _chief; }
            set { _chief = value; }
        }

        [DataMember(Name = "subchief", Order = 3)]
        private String _subchief = String.Empty;
        public String subchief
        {
            get { return _subchief; }
            set { _subchief = value; }
        }

		[DataMember(Name = "image_url", Order = 5)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}


		[DataMember(Name = "lat", Order = 6)]
		private double _lat = 0;
		public double lat
		{
			get { return _lat; }
			set { _lat = value; }
		}


		[DataMember(Name = "lng", Order = 7)]
		private double _lng = 0;
		public double lng
		{
			get { return _lng; }
			set { _lng = value; }
		}


		[DataMember(Name = "employees", Order = 8)]
		private List<STEmployee> _employees = new List<STEmployee>();
		public List<STEmployee> employees
		{
			get { return _employees; }
			set { _employees = value; }
		}

	}


	[DataContract]
	public class STEmployee
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "description", Order = 2)]
		private String _description = String.Empty;
		public String description
		{
			get { return _description; }
			set { _description = value; }
		}

		[DataMember(Name = "name", Order = 3)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}

		[DataMember(Name = "photo_url", Order = 4)]
		private String _photo_url = String.Empty;
		public String photo_url
		{
			get { return _photo_url; }
			set { _photo_url = value; }
		}


		[DataMember(Name = "phone", Order = 5)]
		private String _phone = String.Empty;
		public String phone
		{
			get { return _phone; }
			set { _phone = value; }
		}


		[DataMember(Name = "office", Order = 6)]
		private String _office = String.Empty;
		public String office
		{
			get { return _office; }
			set { _office = value; }
		}


		[DataMember(Name = "address", Order = 7)]
		private String _address = String.Empty;
		public String address
		{
			get { return _address; }
			set { _address = value; }
		}


		[DataMember(Name = "qq", Order = 8)]
		private String _qq = String.Empty;
		public String qq
		{
			get { return _qq; }
			set { _qq = value; }
		}


		[DataMember(Name = "wechat", Order = 9)]
		private String _wechat = String.Empty;
		public String wechat
		{
			get { return _wechat; }
			set { _wechat = value; }
		}
	}



	[DataContract]
	public class STMtQiPanView
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "title", Order = 2)]
		private String _title = String.Empty;
		public String title
		{
			get { return _title; }
			set { _title = value; }
		}


		[DataMember(Name = "image_url", Order = 3)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}


		[DataMember(Name = "address", Order = 4)]
		private String _address = String.Empty;
		public String address
		{
			get { return _address; }
			set { _address = value; }
		}


		[DataMember(Name = "phone", Order = 5)]
		private String _phone = String.Empty;
		public String phone
		{
			get { return _phone; }
			set { _phone = value; }
		}


		[DataMember(Name = "contents", Order = 6)]
		private String _contents = String.Empty;
		public String contents
		{
			get { return _contents; }
			set { _contents = value; }
		}


		[DataMember(Name = "lat", Order = 7)]
		private double _lat = 0;
		public double lat
		{
			get { return _lat; }
			set { _lat = value; }
		}


		[DataMember(Name = "lng", Order = 8)]
		private double _lng = 0;
		public double lng
		{
			get { return _lng; }
			set { _lng = value; }
		}
	}



	[DataContract]
	public class STUser
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "phone", Order = 3)]
		private String _phone = String.Empty;
		public String phone
		{
			get { return _phone; }
			set { _phone = value; }
		}


		[DataMember(Name = "type", Order = 4)]
		private int _type = 0;
		public int type
		{
			get { return _type; }
			set { _type = value; }
		}


		[DataMember(Name = "access_token", Order = 5)]
		private String _access_token = String.Empty;
		public String access_token
		{
			get { return _access_token; }
			set { _access_token = value; }
		}
	}



	[DataContract]
	public class STRelative
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "relative", Order = 3)]
		private String _relative = String.Empty;
		public String relative
		{
			get { return _relative; }
			set { _relative = value; }
		}


		[DataMember(Name = "area_no", Order = 4)]
		private String _area_no = String.Empty;
		public String area_no
		{
			get { return _area_no; }
			set { _area_no = value; }
		}


		[DataMember(Name = "birthday", Order = 5)]
		private String _birthday = String.Empty;
		public String birthday
		{
			get { return _birthday; }
			set { _birthday = value; }
		}


		[DataMember(Name = "deathday", Order = 6)]
		private String _deathday = String.Empty;
		public String deathday
		{
			get { return _deathday; }
			set { _deathday = value; }
		}
	}


	[DataContract]
	public class STActivity
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "activity_type", Order = 2)]
		private String _notify_type = String.Empty;
		public String notify_type
		{
			get { return _notify_type; }
			set { _notify_type = value; }
		}


		[DataMember(Name = "title", Order = 3)]
		private String _title = String.Empty;
		public String title
		{
			get { return _title; }
			set { _title = value; }
		}


		[DataMember(Name = "image_url", Order = 4)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}


		[DataMember(Name = "add_time", Order = 5)]
		private String _add_time = String.Empty;
		public String add_time
		{
			get { return _add_time; }
			set { _add_time = value; }
		}


		[DataMember(Name = "act_time", Order = 6)]
		private String _act_time = String.Empty;
		public String act_time
		{
			get { return _act_time; }
			set { _act_time = value; }
		}


		[DataMember(Name = "act_contents", Order = 7)]
		private String _act_contents = String.Empty;
		public String act_contents
		{
			get { return _act_contents; }
			set { _act_contents = value; }
		}


		[DataMember(Name = "is_oblation", Order = 8)]
		private int _is_oblation = 0;
		public int is_oblation
		{
			get { return _is_oblation; }
			set { _is_oblation = value; }
		}


		[DataMember(Name = "is_read", Order = 9)]
		private int _is_read = 0;
		public int is_read
		{
			get { return _is_read; }
			set { _is_read = value; }
		}
	}


	[DataContract]
	public class STProduct
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "type", Order = 2)]
		private int _type = 0;
		public int type
		{
			get { return _type; }
			set { _type = value; }
		}


		[DataMember(Name = "type_desc", Order = 3)]
		private String _type_desc = String.Empty;
		public String type_desc
		{
			get { return _type_desc; }
			set { _type_desc = value; }
		}


		[DataMember(Name = "title", Order = 4)]
		private String _title = String.Empty;
		public String title
		{
			get { return _title; }
			set { _title = value; }
		}


		[DataMember(Name = "image_url", Order = 5)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}
		

		[DataMember(Name = "amount", Order = 6)]
		private int _amount = 0;
		public int amount
		{
			get { return _amount; }
			set { _amount = value; }
		}


		[DataMember(Name = "amount_desc", Order = 7)]
		private String _amount_desc = String.Empty;
		public String amount_desc
		{
			get { return _amount_desc; }
			set { _amount_desc = value; }
		}


		[DataMember(Name = "product_origin", Order = 8)]
		private String _product_origin = String.Empty;
		public String product_origin
		{
			get { return _product_origin; }
			set { _product_origin = value; }
		}


		[DataMember(Name = "price", Order = 9)]
		private double _price = 0;
		public double price
		{
			get { return _price; }
			set { _price = value; }
		}


		[DataMember(Name = "price_desc", Order = 10)]
		private String _price_desc = String.Empty;
		public String price_desc
		{
			get { return _price_desc; }
			set { _price_desc = value; }
		}


		[DataMember(Name = "max_amount", Order = 11)]
		private int _max_amount = 0;
		public int max_amount
		{
			get { return _max_amount; }
			set { _max_amount = value; }
		}


		[DataMember(Name = "max_amount_desc", Order = 12)]
		private String _max_amount_desc = String.Empty;
		public String max_amount_desc
		{
			get { return _max_amount_desc; }
			set { _max_amount_desc = value; }
		}


		[DataMember(Name = "is_acting", Order = 13)]
		private int _is_acting = 0;
		public int is_acting
		{
			get { return _is_acting; }
			set { _is_acting = value; }
		}


		[DataMember(Name = "act_start_time", Order = 14)]
		private String _act_start_time = String.Empty;
		public String act_start_time
		{
			get { return _act_start_time; }
			set { _act_start_time = value; }
		}


		[DataMember(Name = "act_end_time", Order = 15)]
		private String _act_end_time = String.Empty;
		public String act_end_time
		{
			get { return _act_end_time; }
			set { _act_end_time = value; }
		}
	}


	[DataContract]
	public class STBill
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "type", Order = 3)]
		private String _type = String.Empty;
		public String type
		{
			get { return _type; }
			set { _type = value; }
		}


		[DataMember(Name = "buy_time", Order = 4)]
		private String _buy_time = String.Empty;
		public String buy_time
		{
			get { return _buy_time; }
			set { _buy_time = value; }
		}


		[DataMember(Name = "service_type", Order = 5)]
		private String _service_type = String.Empty;
		public String service_type
		{
			get { return _service_type; }
			set { _service_type = value; }
		}


		[DataMember(Name = "service_price", Order = 6)]
		private double _service_price = 0;
		public double service_price
		{
			get { return _service_price; }
			set { _service_price = value; }
		}


		[DataMember(Name = "service_price_desc", Order = 7)]
		private String _service_price_desc = String.Empty;
		public String service_price_desc
		{
			get { return _service_price_desc; }
			set { _service_price_desc = value; }
		}


		[DataMember(Name = "consume_time", Order = 8)]
		private String _consume_time = String.Empty;
		public String consume_time
		{
			get { return _consume_time; }
			set { _consume_time = value; }
		}


		[DataMember(Name = "state", Order = 9)]
		private int _state = 0;
		public int state
		{
			get { return _state; }
			set { _state = value; }
		}


		[DataMember(Name = "state_desc", Order = 10)]
		private String _state_desc = String.Empty;
		public String state_desc
		{
			get { return _state_desc; }
			set { _state_desc = value; }
		}


		[DataMember(Name = "remark", Order = 11)]
		private String _remark = String.Empty;
		public String remark
		{
			get { return _remark; }
			set { _remark = value; }
		}


		[DataMember(Name = "total_amount", Order = 12)]
		private double _total_amount = 0;
		public double total_amount
		{
			get { return _total_amount; }
			set { _total_amount = value; }
		}


		[DataMember(Name = "total_amount_desc", Order = 13)]
		private String _total_amount_desc = String.Empty;
		public String total_amount_desc
		{
			get { return _total_amount_desc; }
			set { _total_amount_desc = value; }
		}


		[DataMember(Name = "products", Order = 14)]
		private List<STProduct> _products = new List<STProduct>();
		public List<STProduct> products
		{
			get { return _products; }
			set { _products = value; }
		}
	}


	[DataContract]
	public class STDeputyLog
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "time", Order = 2)]
		private String _time = String.Empty;
		public String time
		{
			get { return _time; }
			set { _time = value; }
		}


		[DataMember(Name = "image_url", Order = 3)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}


		[DataMember(Name = "service_people", Order = 4)]
		private String _service_people = String.Empty;
		public String service_people
		{
			get { return _service_people; }
			set { _service_people = value; }
		}


		[DataMember(Name = "detail_images", Order = 5)]
		private List<STDeputyDetailImage> _detail_images = new List<STDeputyDetailImage>();
		public List<STDeputyDetailImage> detail_images
		{
			get { return _detail_images; }
			set { _detail_images = value; }
		}
	}


	[DataContract]
	public class STDeputyDetailImage
	{
		[DataMember(Name = "image_url", Order = 1)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}
	}



	[DataContract]
	public class STOfficeCity
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "offices", Order = 3)]
		private List<STOffice> _offices = new List<STOffice>();
		public List<STOffice> offices
		{
			get { return _offices; }
			set { _offices = value; }
		}
	}


	[DataContract]
	public class STBonusLog
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "user_name", Order = 2)]
		private String _user_name = String.Empty;
		public String user_name
		{
			get { return _user_name; }
			set { _user_name = value; }
		}


		[DataMember(Name = "tomb_no", Order = 3)]
		private String _tomb_no = String.Empty;
		public String tomb_no
		{
			get { return _tomb_no; }
			set { _tomb_no = value; }
		}


		[DataMember(Name = "buy_time", Order = 4)]
		private String _buy_time = String.Empty;
		public String buy_time
		{
			get { return _buy_time; }
			set { _buy_time = value; }
		}


		[DataMember(Name = "bonus", Order = 5)]
		private double _bonus = 0;
		public double bonus
		{
			get { return _bonus; }
			set { _bonus = value; }
		}


		[DataMember(Name = "bonus_desc", Order = 6)]
		private String _bonus_desc = String.Empty;
		public String bonus_desc
		{
			get { return _bonus_desc; }
			set { _bonus_desc = value; }
		}
	}


	[DataContract]
	public class STDepositLog
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "start_time", Order = 2)]
		private String _start_time = String.Empty;
		public String start_time
		{
			get { return _start_time; }
			set { _start_time = value; }
		}


		[DataMember(Name = "end_time", Order = 3)]
		private String _end_time = String.Empty;
		public String end_time
		{
			get { return _end_time; }
			set { _end_time = value; }
		}


		[DataMember(Name = "name", Order = 4)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "tomb_no", Order = 5)]
		private String _tomb_no = String.Empty;
		public String tomb_no
		{
			get { return _tomb_no; }
			set { _tomb_no = value; }
		}


		[DataMember(Name = "receiver", Order = 6)]
		private String _receiver = String.Empty;
		public String receiver
		{
			get { return _receiver; }
			set { _receiver = value; }
		}


		[DataMember(Name = "price", Order = 7)]
		private double _price = 0;
		public double price
		{
			get { return _price; }
			set { _price = value; }
		}


		[DataMember(Name = "price_desc", Order = 8)]
		private String _price_desc = String.Empty;
		public String price_desc
		{
			get { return _price_desc; }
			set { _price_desc = value; }
		}
	}


	[DataContract]
	public class STCustomer
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "phone", Order = 3)]
		private String _phone = String.Empty;
		public String phone
		{
			get { return _phone; }
			set { _phone = value; }
		}


		[DataMember(Name = "tombs", Order = 4)]
		private List<STTomb> _tombs = new List<STTomb>();
		public List<STTomb> tombs
		{
			get { return _tombs; }
			set { _tombs = value; }
		}
	}



	[DataContract]
	public class STTomb
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "image_url", Order = 2)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}


		[DataMember(Name = "tomb_no", Order = 3)]
		private String _tomb_no = String.Empty;
		public String tomb_no
		{
			get { return _tomb_no; }
			set { _tomb_no = value; }
		}

        [DataMember(Name = "area", Order = 4)]
        private int _area = 0;
        public int area
        {
            get { return _area; }
            set { _area = value; }
        }

		[DataMember(Name = "row", Order = 5)]
		private int _row = 0;
		public int row
		{
			get { return _row; }
			set { _row = value; }
		}


		[DataMember(Name = "col", Order = 6)]
		private int _col = 0;
		public int col
		{
			get { return _col; }
			set { _col = value; }
		}


		[DataMember(Name = "desc", Order = 7)]
		private String _desc = String.Empty;
		public String desc
		{
			get { return _desc; }
			set { _desc = value; }
		}


		[DataMember(Name = "price", Order = 8)]
		private double _price = 0;
		public double price
		{
			get { return _price; }
			set { _price = value; }
		}


		[DataMember(Name = "price_desc", Order = 9)]
		private String _price_desc = String.Empty;
		public String price_desc
		{
			get { return _price_desc; }
			set { _price_desc = value; }
		}


		[DataMember(Name = "state", Order = 10)]
		private int _state = 0;
		public int state
		{
			get { return _state; }
			set { _state = value; }
		}

		[DataMember(Name = "state_desc", Order = 11)]
		private String _state_desc = String.Empty;
		public String state_desc
		{
			get { return _state_desc; }
			set { _state_desc = value; }
		}
	}


	[DataContract]
	public class STTombStoneIndex
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}

        [DataMember(Name = "tablet_id", Order = 1)]
        private long _tablet_id = 0;
        public long tablet_id
        {
            get { return _tablet_id; }
            set { _tablet_id = value; }
        }
	}


	[DataContract]
	public class STTombStoneRow
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "indexes", Order = 2)]
		private List<STTombStoneIndex> _indexes = new List<STTombStoneIndex>();
		public List<STTombStoneIndex> indexes
		{
			get { return _indexes; }
			set { _indexes = value; }
		}
	}



	[DataContract]
	public class STTombStonePart
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "rows", Order = 3)]
		private List<STTombStoneRow> _rows = new List<STTombStoneRow>();
		public List<STTombStoneRow> rows
		{
			get { return _rows; }
			set { _rows = value; }
		}
	}


	[DataContract]
	public class STTombStoneArea
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "image_url", Order = 3)]
		private String _image_url = String.Empty;
		public String image_url
		{
			get { return _image_url; }
			set { _image_url = value; }
		}


		[DataMember(Name = "parts", Order = 4)]
		private List<STTombStonePart> _parts = new List<STTombStonePart>();
		public List<STTombStonePart> parts
		{
			get { return _parts; }
			set { _parts = value; }
		}
	}


	[DataContract]
	public class STAgent
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "name", Order = 2)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}


		[DataMember(Name = "phone", Order = 3)]
		private String _phone = String.Empty;
		public String phone
		{
			get { return _phone; }
			set { _phone = value; }
		}


		[DataMember(Name = "month_score", Order = 4)]
		private double _month_score = 0;
		public double month_score
		{
			get { return _month_score; }
			set { _month_score = value; }
		}


		[DataMember(Name = "month_score_desc", Order = 5)]
		private String _month_score_desc = String.Empty;
		public String month_score_desc
		{
			get { return _month_score_desc; }
			set { _month_score_desc = value; }
		}


		[DataMember(Name = "halfyear_score", Order = 6)]
		private double _halfyear_score = 0;
		public double halfyear_score
		{
			get { return _halfyear_score; }
			set { _halfyear_score = value; }
		}


		[DataMember(Name = "halfyear_score_desc", Order = 7)]
		private String _halfyear_score_desc = String.Empty;
		public String halfyear_score_desc
		{
			get { return _halfyear_score_desc; }
			set { _halfyear_score_desc = value; }
		}


		[DataMember(Name = "year_score", Order = 8)]
		private double _year_score = 0;
		public double year_score
		{
			get { return _year_score; }
			set { _year_score = value; }
		}


		[DataMember(Name = "year_score_desc", Order = 9)]
		private String _year_score_desc = String.Empty;
		public String year_score_desc
		{
			get { return _year_score_desc; }
			set { _year_score_desc = value; }
		}
	}


	[DataContract]
	public class STBuyProductLog
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "customer", Order = 2)]
		private String _customer = String.Empty;
		public String customer
		{
			get { return _customer; }
			set { _customer = value; }
		}


		[DataMember(Name = "phone", Order = 3)]
		private String _phone = String.Empty;
		public String phone
		{
			get { return _phone; }
			set { _phone = value; }
		}


		[DataMember(Name = "agent", Order = 4)]
		private String _agent = String.Empty;
		public String agent
		{
			get { return _agent; }
			set { _agent = value; }
		}


		[DataMember(Name = "reserve_date", Order = 5)]
		private String _reserve_date = String.Empty;
		public String reserve_date
		{
			get { return _reserve_date; }
			set { _reserve_date = value; }
		}


		[DataMember(Name = "service_type", Order = 6)]
		private String _service_type = String.Empty;
		public String service_type
		{
			get { return _service_type; }
			set { _service_type = value; }
		}


		[DataMember(Name = "state", Order = 7)]
		private int _state = 0;
		public int state
		{
			get { return _state; }
			set { _state = value; }
		}


		[DataMember(Name = "state_desc", Order = 8)]
		private String _state_desc = String.Empty;
		public String state_desc
		{
			get { return _state_desc; }
			set { _state_desc = value; }
		}


		[DataMember(Name = "is_read", Order = 9)]
		private int _is_read = 0;
		public int is_read
		{
			get { return _is_read; }
			set { _is_read = value; }
		}


		[DataMember(Name = "products", Order = 10)]
		private List<STProduct> _products = new List<STProduct>();
		public List<STProduct> products
		{
			get { return _products; }
			set { _products = value; }
		}
	}


	[DataContract]
	public class STVocation
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "user_id", Order = 2)]
		private long _user_id = 0;
		public long user_id
		{
			get { return _user_id; }
			set { _user_id = value; }
		}


		[DataMember(Name = "user_name", Order = 3)]
		private String _user_name = String.Empty;
		public String user_name
		{
			get { return _user_name; }
			set { _user_name = value; }
		}


		[DataMember(Name = "user_desc", Order = 4)]
		private String _user_desc = String.Empty;
		public String user_desc
		{
			get { return _user_desc; }
			set { _user_desc = value; }
		}


		[DataMember(Name = "date", Order = 5)]
		private String _date = String.Empty;
		public String date
		{
			get { return _date; }
			set { _date = value; }
		}


		[DataMember(Name = "reason", Order = 6)]
		private int _reason = 0;
		public int reason
		{
			get { return _reason; }
			set { _reason = value; }
		}


		[DataMember(Name = "reason_desc", Order = 7)]
		private String _reason_desc = String.Empty;
		public String reason_desc
		{
			get { return _reason_desc; }
			set { _reason_desc = value; }
		}


		[DataMember(Name = "state", Order = 8)]
		private int _state = 0;
		public int state
		{
			get { return _state; }
			set { _state = value; }
		}


		[DataMember(Name = "state_desc", Order = 9)]
		private String _state_desc = String.Empty;
		public String state_desc
		{
			get { return _state_desc; }
			set { _state_desc = value; }
		}
	}


    [DataContract]
    public class STVocationStatistic
    {        
        [DataMember(Name = "user_id", Order = 2)]
        private long _user_id = 0;
        public long user_id
        {
            get { return _user_id; }
            set { _user_id = value; }
        }


        [DataMember(Name = "user_name", Order = 3)]
        private String _user_name = String.Empty;
        public String user_name
        {
            get { return _user_name; }
            set { _user_name = value; }
        }


        [DataMember(Name = "user_desc", Order = 4)]
        private String _user_desc = String.Empty;
        public String user_desc
        {
            get { return _user_desc; }
            set { _user_desc = value; }
        }

        [DataMember(Name = "month_count", Order = 4)]
        private int _month_count = 0;
        public int month_count
        {
            get { return _month_count; }
            set { _month_count = value; }
        }

        [DataMember(Name = "year_count", Order = 4)]
        private int _year_count = 0;
        public int year_count
        {
            get { return _year_count; }
            set { _year_count = value; }
        }
    }


	[DataContract]
	public class STMonthlyScore
	{
		[DataMember(Name = "office_id", Order = 1)]
		private long _office_id = 0;
		public long office_id
		{
			get { return _office_id; }
			set { _office_id = value; }
		}


		[DataMember(Name = "office_name", Order = 2)]
		private String _office_name = String.Empty;
		public String office_name
		{
			get { return _office_name; }
			set { _office_name = value; }
		}


		[DataMember(Name = "order", Order = 3)]
		private String _order = String.Empty;
		public String order
		{
			get { return _order; }
			set { _order = value; }
		}


		[DataMember(Name = "agent", Order = 4)]
		private double _agent = 0;
		public double agent
		{
			get { return _agent; }
			set { _agent = value; }
		}


		[DataMember(Name = "employee", Order = 5)]
		private double _employee = 0;
		public double employee
		{
			get { return _employee; }
			set { _employee = value; }
		}


		[DataMember(Name = "self_rate", Order = 6)]
		private double _self_rate = 0;
		public double self_rate
		{
			get { return _self_rate; }
			set { _self_rate = value; }
		}


		[DataMember(Name = "response_value", Order = 7)]
		private double _response_value = 0;
		public double response_value
		{
			get { return _response_value; }
			set { _response_value = value; }
		}


		[DataMember(Name = "total", Order = 8)]
		private double _total = 0;
		public double total
		{
			get { return _total; }
			set { _total = value; }
		}


		[DataMember(Name = "success_rate", Order = 9)]
		private double _success_rate = 0;
		public double success_rate
		{
			get { return _success_rate; }
			set { _success_rate = value; }
		}


		[DataMember(Name = "office_income", Order = 10)]
		private double _office_income = 0;
		public double office_income
		{
			get { return _office_income; }
			set { _office_income = value; }
		}
	}



	[DataContract]
	public class STDailyScore
	{
		[DataMember(Name = "name", Order = 1)]
		private String _name = String.Empty;
		public String name
		{
			get { return _name; }
			set { _name = value; }
		}
        

		[DataMember(Name = "agent", Order = 2)]
		private String _agent = String.Empty;
        public String agent
		{
			get { return _agent; }
			set { _agent = value; }
		}


		[DataMember(Name = "price", Order = 3)]
        private double _price = 0;
        public double price
		{
            get { return _price; }
            set { _price = value; }
		}


		[DataMember(Name = "actual", Order = 4)]
		private double _actual = 0;
		public double actual
		{
			get { return _actual; }
			set { _actual = value; }
		}


        [DataMember(Name = "employee_score", Order = 2)]
        private Double _employee_score = 0;
        public Double employee_score
        {
            get { return _employee_score; }
            set { _employee_score = value; }
        }


        [DataMember(Name = "agent_score", Order = 2)]
        private Double _agent_score = 0;
        public Double agent_score
        {
            get { return _agent_score; }
            set { _agent_score = value; }
        }

		[DataMember(Name = "daily_total", Order = 5)]
		private double _daily_total = 0;
		public double daily_total
		{
			get { return _daily_total; }
			set { _daily_total = value; }
		}
	}




	[DataContract]
	public class STPersonalScore_Boss
	{
		[DataMember(Name = "office_id", Order = 1)]
		private long _office_id = 0;
		public long office_id
		{
			get { return _office_id; }
			set { _office_id = value; }
		}


		[DataMember(Name = "office_name", Order = 2)]
		private String _office_name = String.Empty;
		public String office_name
		{
			get { return _office_name; }
			set { _office_name = value; }
		}


		[DataMember(Name = "user_id", Order = 3)]
		private long _user_id = 0;
		public long user_id
		{
			get { return _user_id; }
			set { _user_id = value; }
		}


		[DataMember(Name = "user_name", Order = 4)]
		private String _user_name = String.Empty;
		public String user_name
		{
			get { return _user_name; }
			set { _user_name = value; }
		}


		[DataMember(Name = "score", Order = 5)]
		private double _score = 0;
		public double score
		{
			get { return _score; }
			set { _score = value; }
		}
	}


	[DataContract]
	public class STOfficeDepositLog
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "office_id", Order = 2)]
		private long _office_id = 0;
		public long office_id
		{
			get { return _office_id; }
			set { _office_id = value; }
		}


		[DataMember(Name = "office_name", Order = 3)]
		private String _office_name = String.Empty;
		public String office_name
		{
			get { return _office_name; }
			set { _office_name = value; }
		}


		[DataMember(Name = "employee", Order = 4)]
		private double _employee = 0;
		public double employee
		{
			get { return _employee; }
			set { _employee = value; }
		}


		[DataMember(Name = "agent", Order = 5)]
		private double _agent = 0;
		public double agent
		{
			get { return _agent; }
			set { _agent = value; }
		}


		[DataMember(Name = "total", Order = 6)]
		private double _total = 0;
		public double total
		{
			get { return _total; }
			set { _total = value; }
		}
	}


	[DataContract]
	public class STAgentScore_Mgr
	{
		[DataMember(Name = "user_id", Order = 1)]
		private long _user_id = 0;
		public long user_id
		{
			get { return _user_id; }
			set { _user_id = value; }
		}


		[DataMember(Name = "user_name", Order = 2)]
		private String _user_name = String.Empty;
		public String user_name
		{
			get { return _user_name; }
			set { _user_name = value; }
		}


		[DataMember(Name = "score", Order = 3)]
		private double _score = 0;
		public double score
		{
			get { return _score; }
			set { _score = value; }
		}
	}


	[DataContract]
	public class STReserveLog
	{
		[DataMember(Name = "uid", Order = 1)]
		private long _uid = 0;
		public long uid
		{
			get { return _uid; }
			set { _uid = value; }
		}


		[DataMember(Name = "customer_name", Order = 2)]
		private String _customer_name = String.Empty;
		public String customer_name
		{
			get { return _customer_name; }
			set { _customer_name = value; }
		}


		[DataMember(Name = "customer_phone", Order = 3)]
		private String _customer_phone = String.Empty;
		public String customer_phone
		{
			get { return _customer_phone; }
			set { _customer_phone = value; }
		}


		[DataMember(Name = "reserve_date", Order = 4)]
		private String _reserve_date = String.Empty;
		public String reserve_date
		{
			get { return _reserve_date; }
			set { _reserve_date = value; }
		}


		[DataMember(Name = "state", Order = 5)]
		private int _state = 0;
		public int state
		{
			get { return _state; }
			set { _state = value; }
		}


		[DataMember(Name = "state_desc", Order = 6)]
		private String _state_desc = String.Empty;
		public String state_desc
		{
			get { return _state_desc; }
			set { _state_desc = value; }
		}
	}


	[DataContract]
	public class STScore_Manager
	{
		[DataMember(Name = "month", Order = 1)]
		private int _month = 0;
		public int month
		{
			get { return _month; }
			set { _month = value; }
		}


		[DataMember(Name = "agent", Order = 2)]
		private double _agent = 0;
		public double agent
		{
			get { return _agent; }
			set { _agent = value; }
		}


		[DataMember(Name = "employee", Order = 3)]
		private double _employee = 0;
		public double employee
		{
			get { return _employee; }
			set { _employee = value; }
		}


		[DataMember(Name = "self_rate", Order = 4)]
		private double _self_rate = 0;
		public double self_rate
		{
			get { return _self_rate; }
			set { _self_rate = value; }
		}


		[DataMember(Name = "response_value", Order = 5)]
		private double _response_value = 0;
		public double response_value
		{
			get { return _response_value; }
			set { _response_value = value; }
		}


		[DataMember(Name = "monthly_total", Order = 6)]
		private double _monthly_total = 0;
		public double monthly_total
		{
			get { return _monthly_total; }
			set { _monthly_total = value; }
		}


		[DataMember(Name = "success_rate", Order = 7)]
		private double _success_rate = 0;
		public double success_rate
		{
			get { return _success_rate; }
			set { _success_rate = value; }
		}
	}


	[DataContract]
	public class STEmpScore_Manager
	{
		[DataMember(Name = "user_id", Order = 1)]
		private long _user_id = 0;
		public long user_id
		{
			get { return _user_id; }
			set { _user_id = value; }
		}


		[DataMember(Name = "user_name", Order = 2)]
		private String _user_name = String.Empty;
		public String user_name
		{
			get { return _user_name; }
			set { _user_name = value; }
		}


		[DataMember(Name = "scores", Order = 3)]
		private List<STScore_Manager> _scores = new List<STScore_Manager>();
		public List<STScore_Manager> scores
		{
			get { return _scores; }
			set { _scores = value; }
		}
	}

    [DataContract]
    public class STPushNotification
    {
        [DataMember(Name = "user_id", Order = 1)]
        private long _user_id = 0;
        public long user_id
        {
            get { return _user_id; }
            set { _user_id = value; }
        }

        [DataMember(Name = "content", Order = 2)]
        private String _content = String.Empty;
        public String content
        {
            get { return _content; }
            set { _content = value; }
        }
    }

    [DataContract]
    public class STParentBirthNotify
    {        
        [DataMember(Name = "tomb_no", Order = 2)]
        private String _tomb_no = String.Empty;
        public String tomb_no
        {
            get { return _tomb_no; }
            set { _tomb_no = value; }
        }

        [DataMember(Name = "desc", Order = 3)]
        private String _desc = String.Empty;
        public String desc
        {
            get { return _desc; }
            set { _desc = value; }
        }

        [DataMember(Name = "date", Order = 4)]
        private String _date = String.Empty;
        public String date
        {
            get { return _date; }
            set { _date = value; }
        }
    }
}