<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="row" >
				<div class="col-md-12">
				<!-- BEGIN EXAMPLE TABLE PORTLET-->
                     <div style =" margin-top:5%"><span style=" color:#3B9C96;font-weight:bold; font-size:medium;">客户姓名：<%=ViewData["cname"]%></span><span style="color:#3B9C96;font-weight:bold; font-size:medium;margin-left:30%">商品金额总计：<%= ViewData["zongjia"]%></span>
                        
                     </div>
					<div class="portlet box green-haze" style=" margin-top:5%;">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-send"></i>订单详情
							</div>
                        <div class="tools" style="margin-top:-10px">
                        <a id="A1" class="btn btn-sm btn-success" onclick="Ex()"  ><i class="fa fa-mail-forward"> </i>导出祭品购买单</a>
                        </div>
							
						</div>
						<div class="portlet-body" >
                      
							<table class="table table-striped table-bordered table-hover" id="sample_1">					
							
                        <thead>
                            <tr>
                                <th>
                                   商品名称
                                </th>
                                <th>
                                    单价
                                </th>
                                <th>
                                    数量
                                </th>
                                <th>
                                    总价
                                </th>
                                 <th>
                                    状态
                                </th>
                                 <th>
                                    操作
                                </th>
                                
                               
                            </tr>
                        </thead>
                        
                    </table>
						</div>
				
				</div>
            
	
    		</div>
</div>
            <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<script type="text/javascript">
 var url ="<%= ViewData["rootUri"] %>";
 function DelOrder(uid) {

 // alert(uid);
    var rootUri ="<%= ViewData["rootUri"] %>";
          $.ajax({

                 url: rootUri + "ShangPinOrder/DelShangPin",
                        data:{  "uid":uid  },
                        type: "post",
                        success: function (message) {

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
                        if (message == "ok") {
                            toastr["success"]("操作成功！");
                        } else { toastr["error"](message); }
                          setTimeout(' window.location.reload()',3000);
                        }



                    });

 }
    jQuery(document).ready(function () {
        //QuickSidebar.init(); // init quick sidebar
        var initTable1 = function () {
            var table = $('#sample_1');
            var sid =<%=ViewData["sid"] %>;
            var oTable = table.dataTable({
                
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
                    "zeroRecords": "没有发现"
                },
                 "sServerMethod": "POST", 
                "sAjaxSource": url+"ShangPinOrder/GetOrderInfo?sid="+sid,
                "aoColumns": [
                        {"mDataProp": "name","bSortable": false },	
					    {"mDataProp": "price","bSortable": false },	
                        {"mDataProp": "num","bSortable": false},
                        {"mDataProp": "total","bSortable": false },
                        {"mDataProp": "deleted","bSortable": false },
                        {"mDataProp": "uid","bSortable": false },
				     ],
                     "columnDefs": [
                            {
				            "targets": 4,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				         if (data==0)
				         {
                         return "正常";
				         }
                         if(data==1){

                         return "已取消";
                         }
                                },
				            sClass: 'center'
				        },
				        {
				            "targets": 5,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				           if (row.deleted==0)
				           {
                        return '<a onclick="DelOrder('+data+')">取消</a>';
				           }
                            if (row.deleted==1)
				           {
                        return '';
				           }
                                },
				            sClass: 'center'
				        }
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

              
            });

            var tableWrapper = $('#sample_1_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable1();
           
    });
      jQuery(function ($) {
            $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
        });
        function Ex() {
        var sid =<%=ViewData["sid"] %>;
        var rootUri ="<%= ViewData["rootUri"] %>";
         location.href= rootUri + "ShangPinOrder/Daochu?sid="+sid
        }
</script>

</asp:Content>
