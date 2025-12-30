<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="row" style=" min-width:1000px">
                <div id="responsive" class="modal fade" tabindex="-1" data-width="760">
                     <div class="modal-header">
							 <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
							 <h4 class="modal-title">落葬仪式行事历导出</h4>
					 </div>
                     <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6" style="margin-left:200px">
                            <label>选择日期：</label> <input class="date-picker" id="extime" name="extime" type="text" data-date-format="yyyy-mm-dd"  style="width:140px; height:28px" />
                            </div>
                        </div>
                     </div>
                     <div class="modal-footer">
						<button type="button" data-dismiss="modal" class="btn btn-default">关闭</button>
						<button type="button" class="btn blue" onclick="exportdetail()">确认</button>
					 </div>
                </div>
				<div class="col-md-12">
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
                  <div style=" height:90px; margin-top:4%; border:1px solid #3B9C96">
                        <div style="margin-top:1%; margin-left:1%">
                        <label style="">客户姓名：</label><input style=" height:28px" id="name"/><label style=" margin-left:2%">联系电话：</label><input id="phone" style=" height:28px"/><label style="margin-left:3%">时间:</label>
                        <input class="date-picker" id="stime" name="stime" type="text" data-date-format="yyyy-mm-dd"  style="width:140px; height:28px" /><label>~</label>
                        <input class="date-picker" id="etime" name="etime" type="text" data-date-format="yyyy-mm-dd" style="width:140px; height:28px" /> <div style=" margin-top:1%"><label style="">仪式类型：</label><select class="select2" id="stype" style=" width:30px"><% for (int i = 0; i < ViewBag.llist.Count; i++)
                        {  %>
                             <option value="<%=ViewBag.llist[i].uid %>"><%=ViewBag.llist[i].name %></option>
                                            <% }%></select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label style="">是否取消：</label><input type="checkbox" checked="checked" id="sta1"/>未取消<input type="checkbox" checked="checked" id="sta2"/>已取消 <a id="searchdata" class="btn btn-sm btn-success" onclick="SearchLuo()" style=" margin-left:2%"><i class="fa fa-search"> </i>搜索</a><a class="btn btn-success btn-sm" data-toggle="modal" onclick="exportluo()" style=" margin-left:2%"><i class="fa fa-mail-forward"> </i>导出落葬预约</a><a class="btn btn-success btn-sm" data-toggle="modal" href="#responsive" style=" margin-left:2%"><i class="fa  fa-tasks"> </i>导出行事历</a></div>
                        </div>
                 </div>
					<div class="portlet box green-haze" style=" margin-top:5%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>落葬仪式预约
							</div>
							
						</div>
						<div class="portlet-body">
                      
							<table class="table table-striped table-bordered table-hover" id="sample_1">
							<thead>
							<tr>
								<th>
									客户姓名
								</th>
								<th>
									 联系电话
								</th>
								<th>
									 预约日期
								</th>
								<th>
									仪式名称
								</th>
							
                                <th>
									 是否取消
								</th>
                                <th>
									 操作
                                   
								</th>
							</tr>
							</thead>
							
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
  var oTable;
   var initTable1;
   var url ="<%= ViewData["rootUri"] %>";
    jQuery(document).ready(function () {
     $(".select2").css('width', '100px').select2({ minimumResultsForSearch: -1 });
        //QuickSidebar.init(); // init quick sidebar
       initTable1 = function () {
            var table = $('#sample_1');
            var clientname = $('#name').val();
            //alert(name);
            var clientphone = $('#phone').val();
            var stime = $('#stime').val();
            var etime = $('#etime').val();
            var stype = $('#stype').val();
            var sta1=document.getElementById("sta1").checked==true?1:0;
            var sta2=document.getElementById("sta2").checked==true?2:0;
            var status = sta1+sta2;
           oTable = table.dataTable({
                
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
                "sAjaxSource": url+"LuoZangReserve/GetLuoBy",
                "aoColumns": [
                        {"mDataProp": "client_name","bSortable": false },	
					    {"mDataProp": "client_phone","bSortable": false },	
                        {"mDataProp": "reservetimestr","bSortable": true},
                        {"mDataProp": "service_name","bSortable": false },
                        {"mDataProp": "status","bSortable": false },
                        {"mDataProp": "uid","bSortable": false },
				     ],
                      "fnServerData": function(sSource, aoData, fnCallback){
                                      $.ajax({
                                          "dataType": 'json',
                                          "type": "POST",
                                          "url": sSource,
                                          "data":{"clientname":clientname, "clientphone":clientphone,"stime":stime,"etime":etime,"serviceid":stype,"status":status} ,
                                           "success": fnCallback
                                             } );
                      },     
                         "columnDefs": [
                            {
				            "targets": 4,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				         if (data==0)
				         {
                         return "已预约";
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
				           if (row.status==0)
				           {
                        return '<a onclick="ViewInfo('+data+')">商品订单</a> &nbsp;'+' <a onclick="DelLuoZang('+data+')">取消</a>';
				           }
                            if (row.status==1)
				           {
                        return '<a onclick="ViewInfo('+data+')">商品订单</a>';
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
            function SearchLuo(){

                     oTable.fnDestroy();
                      initTable1();
                       }
                            
            function DelLuoZang(uid){
                   // alert(uid);
                      var rootUri ="<%= ViewData["rootUri"] %>";
                         $.ajax({

                            url: rootUri + "LuoZangReserve/DelLuoZang",
                            data: {
                                "uid": uid

                            },
                          
                          dataType:'json', 
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
                                setTimeout(' window.location.reload()', 3000);
                          
                            }



                        }); 
            }
        function ViewInfo(uid){
         var rootUri ="<%= ViewData["rootUri"] %>";
     		window.location.href=rootUri+"ShangPinOrder/OrderInfo?sid="+uid;


        }
        function exportdetail(){
          var rootUri ="<%= ViewData["rootUri"] %>";
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
        var extime = $('#extime').val();
        if(extime==null||extime==""){
        toastr["error"]("请输入具体日期！");
        }else{

                location.href= rootUri + "LuoZangReserve/ExportLuoZang?extime="+extime;
                   }

        }
        function exportluo(){
        var rootUri ="<%= ViewData["rootUri"] %>";
         var clientname = $('#name').val();
            //alert(name);
            var clientphone = $('#phone').val();
            var stime = $('#stime').val();
            var etime = $('#etime').val();
            var stype = $('#stype').val();
            var sta1=document.getElementById("sta1").checked==true?1:0;
            var sta2=document.getElementById("sta2").checked==true?2:0;
            var status = sta1+sta2;
            location.href= rootUri + "LuoZangReserve/ExportLuo?cname="+clientname+"&&phone="+clientphone+"&&stime="+stime+"&&etime="+etime+"&&stype="+stype+"&status="+status;

        }
</script>

</asp:Content>
