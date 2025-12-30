<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="row" style="margin-top:20px">
    <div class="col-xs-12">
        <div class="widget-box">
			<div class="widget-body">
				<div class="widget-main" style="border:1px solid #3B9C96">
                    <div class="searchbar" >
                        <form class="form-horizontal" role="form" id="validation-form" >
                            <!-- 第一行-->
                            <br />
                            <div class="form-group" >
                                <label class="col-sm-1 control-label no-padding-right" style="margin-left:10px"  for="">公司名称</label>
				                <div class="col-sm-1" style="margin-left:-10px">
                                    <div class="clearfix" style="width:150px">
						                <input  id="cname" value="" style="height:28px;margin-top:1px" placeholder="请输入关键字"/>
                                    </div>
				                </div>  
                                <label class="col-sm-1 control-label no-padding-right" style="margin-left:70px" for="">城市</label>
				                <div class="col-sm-1" style="margin-left:-10px">
                                    <div class="clearfix" style="width:150px">
                                    
                      
                                  <select class="select2" id="chengshi"   style="width:150px" onchange="setarea(this.value)">
                                             <option value="0" >全部</option>
                                             <%
                                               for (int i = 0; i < ViewBag.chengshi.Count; i++)
                                          {   
                                               %>
                                           <option value="<%=ViewBag.chengshi[i].uid %>" ><%=ViewBag.chengshi[i].name%></option>
                                           <% }%>
                                       </select>
                    
						                
                                    </div>
				                </div>  
                                <label class="col-sm-1 control-label no-padding-right" style="margin-left:90px" for="">地区</label>
				                <div class="col-sm-1" style="margin-left:-10px">
                                    <div class="clearfix" style="width:150px">

                                      <select class="select2" id="area" style="width:150px" >
                                               <option value="0" >全部</option>    
                                            </select>
                      
                                    </div>
				                </div> 
                                <div class="col-sm-1" style="margin-left:150px"">
						                <a class="btn  btn-success" id="find" onclick="search_data()"><i class="fa fa-search"></i> 搜索</a>
                                  
                                </div> 
                                <div class="col-sm-1" style="margin-left:20px"">
						                <a class="btn  btn-success" href="<%=ViewData["rootUri"] %>ZoneInformation/AddADragon"><i class="fa fa-plus"></i> 增加</a>
                                  
                                </div>   
                                </div>
                               
                        </form>
                    </div>
                     
				</div>
			</div>
            </div>
			</div>
		</div>
<div class="row" style="margin-top:20px">
				<div class="col-md-12">
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<div class="portlet box green-haze">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-server"></i>一条龙服务
							</div>
							
						</div>
						<div class="portlet-body">
							<table class="table table-striped table-bordered table-hover" id="sample_1" style="text-align:center">
							<thead>
							<tr>
								<th style="text-align:center">
									服务图片 
								</th>
								<th style="text-align:center">
									 公司名称
								</th>
								<th style="text-align:center">
									 公司地址
								</th>
								<th style="text-align:center">
									 套服价格
								</th>
								<th style="text-align:center">
									 客户认同度
								</th>
                                
								<th style="text-align:center">
									 操作
								</th>
							</tr>
							</thead>
							<tbody>
							
							</tbody>
							</table>
						</div>
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<!-- END EXAMPLE TABLE PORTLET-->
				</div>
	
    		</div>
            <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<script>
function setarea(id)
{
    document.getElementById("area").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/Getarea",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                      
                                         $("#area").append("<option value=" + "0" + ">" + "全部" + "</option>");
                                   for (var s in data) {
                                    if (s == 0) {
                                        $("#area").append("<option value=" + data[s].uid + ">" + data[s].name + "</option>");
                                    } else {
                                        $("#area").append("<option value=" + data[s].uid + ">" + data[s].name + "</option>");
                                    }
                                }
                        $("#area").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
                $("#area").append("<option value=" + "0" + ">" + "全部" + "</option>");
                 $("#area").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
            }
}
var rootUri = "<%= ViewData["rootUri"] %>";
var oTable;
var initTable1;
    jQuery(document).ready(function () {
            $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
        //QuickSidebar.init(); // init quick sidebar
        initTable1 = function () {
            var table = $('#sample_1');

            oTable = table.dataTable({
                //"bServerSide": true,
			    "bProcessing": true,
			    "sAjaxSource":  rootUri + "ZoneInformation/SerchADagon/?area="+$("#area").val()+"&cname="+$("#cname").val()+"&chengshi="+$("#chengshi").val(),
                "language": {
                    "aria": {
                        "sortAscending": ": activate to sort column ascending",
                        "sortDescending": ": activate to sort column descending"
                    },
                    "emptyTable": "没有相关数据",
                    "info": "显示 _START_ 到 _END_ 共 _TOTAL_ 条",
                    "infoEmpty": "没有相关数据",
                    "infoFiltered": "(共_MAX_ 条数据)",
                    "lengthMenu": "显示 _MENU_ 条",
                    "search": "快速搜索:",
                    "zeroRecords": "没有发现",
                    "sProcessing":"正在搜索......"
                },
                "aoColumns": [
					 {"mDataProp": "imgurl","bSortable": false },	
                     {"mDataProp": "cname","bSortable": false },
                     {"mDataProp": "address","bSortable": false },
                     {"mDataProp": "price","bSortable": false },
                     {"mDataProp": "approve","bSortable": false },
                     {"mDataProp": "id","bSortable": false }
				],
                "order": [
                [0, 'asc']
            ],

                "lengthMenu": [
                [10, 15, 20, -1],
                [10, 15, 20, "All"] // change per page values here
            ],
                "pageLength": 10,

                "dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // horizobtal scrollable datatable
            "columnDefs": [
				        {
				            "targets" : 0,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return '<img src="'+rootUri+data+'" style="width:100;height:100px;">';
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 1,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return '<br/><br/>'+data;
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 2,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                return '<br/><br/>'+data;
                                
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 3,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                return '<br/><br/>'+data+"元";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 4,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return '<br/><br/>'+data; 
                                
				            }
				            //sClass: 'center'
				        },
				        {
				            "targets": 5,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				                var rst = '<br/><br/><a  href="' + rootUri + 'ZoneInformation/SeeADragon/?makeid=1&uid=' + data + '" style="font-size:13px">' +
                                    '查看</a>&nbsp;&nbsp;';
				                rst += '<a href="' + rootUri + 'ZoneInformation/SeeADragon/?makeid=2&uid=' + data + '" style="font-size:13px">' +
                                    '修改</a>&nbsp;&nbsp;';
                                rst += '<a href="#" onclick="DelNotice(' + data + ')" style="font-size:13px">' +
                                    '删除</a>';
				                return rst;
				            }
				            //sClass: 'center'
				        }
                    ],
              
            });

            var tableWrapper = $('#sample_1_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable1();
           
    });
     function DelNotice(uid)
   {
      var conf=confirm("您确定要删除该数据吗?");
     if(conf==true)
     {
        $.ajax({
                    type: "POST",
                    url: rootUri + "ZoneInformation/DelADragon",
                    dataType: "json",
                    data: {
                       
                        uid: uid
                    },
                    success: function (str) {
                          if (str==true) {    
                                 toastr.options = {
				                "closeButton": false,
				                "debug": true,
				                "positionClass": "toast-bottom-left",
				                "onclick": null,
				                "showDuration": "3",
				                "hideDuration": "3",
				                "timeOut": "2000",
				                "extendedTimeOut": "2000",
				                "showEasing": "swing",
				                "hideEasing": "linear",
				                "showMethod": "fadeIn",
				                "hideMethod": "fadeOut"
				            };
				            toastr["success"]("操作成功!", "恭喜您");
                             setTimeout(function () {
                                   oTable.fnDestroy();  
                                   initTable1();
                              }, 2500);
                            }
                         else{
                        
                            toastr.options = {
				                "closeButton": false,
				                "debug": true,
				                "positionClass": "toast-bottom-left",
				                "onclick": null,
				                "showDuration": "3",
				                "hideDuration": "3",
				                "timeOut": "1500",
				                "extendedTimeOut": "1000",
				                "showEasing": "swing",
				                "hideEasing": "linear",
				                "showMethod": "fadeIn",
				                "hideMethod": "fadeOut"
				            };

				            toastr["error"]("操作失败!", "温馨敬告");
                        
                         }
                       }
                });
         }
    }
    function search_data() {
         oTable.fnDestroy();  
            initTable1();
//            if (oTable != null) {
//		    var oSettings = oTable.fnSettings();
//            oSettings.bServerSide=true;
//		    oSettings.sAjaxSource = rootUri + "ZoneInformation/SerchActivity/?activityname="+$("#acyivityname").val();
//            oTable.fnClearTable(0);
//            oTable.fnDraw(oSettings);
//            }
           
            }
</script>

</asp:Content>
