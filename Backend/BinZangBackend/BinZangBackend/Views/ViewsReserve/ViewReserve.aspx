<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="row" style=" min-width:1000px">
				<div class="col-md-12">
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
                   <div style=" height:90px; margin-top:4%; border:1px solid #3B9C96">
                        <div style="margin-top:1%; margin-left:1%">
                        <label style=" font-size; small">客户姓名：</label><input style=" height:28px"  id="name"/><label style=" margin-left:2%">联系电话：</label><input style=" height:28px" id="phone"/><label style="margin-left:3%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 时间：</label>
                        <input class="date-picker" id="stime" name="stime" type="text" data-date-format="yyyy-mm-dd"  style="width:140px; height:28px" /><label>~</label>
                        <input class="date-picker" id="etime" name="etime" type="text" data-date-format="yyyy-mm-dd" style="width:140px; height:28px" /> <div style=" margin-top:1%"><label style="">办事处：</label><select class="select2" style=" width:30px" id="banshichu"><% for (int i = 0; i < ViewBag.vlist.Count; i++)
                        {  %>
                             <option value="<%=ViewBag.vlist[i].uid %>"><%=ViewBag.vlist[i].name %></option>
                                            <% }%></select><label style="margin-left:2%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 预约状态：</label><input type="checkbox" checked="checked" name="sta0" id="sta0"/>未处理<input type="checkbox" checked="checked" name="sta1" id="sta1"/>已处理<input type="checkbox" checked="checked" name="sta2" id="sta2"/>已取消 <a id="searchdata" class="btn btn-sm btn-success" onclick="SearchVisit()" style=" margin-left:2%"><i class="fa fa-search"> &nbsp;</i>搜索</a></div>
                        </div>
                   </div>
					<div class="portlet box green-haze" style=" margin-top:5%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-tree"></i>参观预约
							</div>
							
						</div>
						<div class="portlet-body">
                      
							<table class="table table-striped table-bordered table-hover" id="visittable">
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
									办事处
								</th>
								<th>
									 预约状态
								</th>
                              <th>
									 经办人
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
<script type="text/javascript">
  var oTable;
   var initTable1;
    jQuery(document).ready(function () {
     
   
         $(".select2").css('width', '100px').select2({ minimumResultsForSearch: -1 });
        //QuickSidebar.init(); // init quick sidebar
    initTable1 = function () {
             var table = $('#visittable');
             var url ="<%= ViewData["rootUri"] %>";
             var name = $('#name').val();
            //alert(name);
             var phone = $('#phone').val();
    var stime = $('#stime').val();
    var etime = $('#etime').val();
    var banid = $('#banshichu').val();
    var sta0 = document.getElementById("sta0").checked==true?1:0;
    var sta1=document.getElementById("sta1").checked==true?2:0;
    var sta2=document.getElementById("sta1").checked==true?3:0;
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

              // "bServerSide": true,  
        "sServerMethod": "POST", 
                "sAjaxSource": url+"ViewsReserve/GetJsonTable",
                "aoColumns": [
                        {"mDataProp": "name","bSortable": false },	
					    {"mDataProp": "phone","bSortable": false },	
                        {"mDataProp": "reservatimestr","bSortable": true},
                        {"mDataProp": "officename","bSortable": false },
                        {"mDataProp": "status","bSortable": false },
                        {"mDataProp": "handlename","bSortable": false },
				     ],
                      "fnServerData": function(sSource, aoData, fnCallback){
                                      $.ajax({
                                          "dataType": 'json',
                                          "type": "POST",
                                          "url": sSource,
                                          "data":{"name":name, "phone":phone,"stime":stime,"etime":etime,"banid":banid,"sta0":sta0,"sta1":sta1,"sta2":sta2} ,
                                           "success": fnCallback
                                             } );
                      },     
                         "columnDefs": [
                       
				        {
				            "targets": 4,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				               if (data==0)
				               {
                               return "未处理";
				               }
                               if (data==1)
                               {
                               return "已处理";
                               }
                               if (data==2)
                               {
                                return "已取消";
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

            var tableWrapper = $('#visittable_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable1();
           
    });
      function SearchVisit(){

    oTable.fnDestroy();
   initTable1();


    }
      jQuery(function ($) {
            $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
        });
</script>

</asp:Content>
