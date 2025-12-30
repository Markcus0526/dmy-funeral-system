<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="example t-vista" style="margin-top:20px">
     <div class="portlet box green" >
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-pencil-square-o"></i>真奖金计算公式
							</div>
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#portlet_tab2_1" data-toggle="tab">
									墓地预留时间</a>
								</li>
								<li>
									<a href="#portlet_tab2_2" data-toggle="tab">
									落葬场次人数 </a>
								</li>
                                <li>
									<a href="#portlet_tab2_3" data-toggle="tab">
									定金金额和时间 </a>
								</li>
							</ul>
						</div>
						<div class="portlet-body">
							<div class="tab-content">
								<div class="tab-pane active" id="portlet_tab2_1">
                                <div class="row">
				<div class="col-md-12">
				
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>墓地预留时间
							</div>
							
						</div>
						<div class="portlet-body">
                           <table style="width:700px; height:50px;">
                       <tr><td align="right" style="width:200px;">墓地预留时间调整：</td>
                       <td style="width:200px;"><input id="time" style="width:100px; height:30px;"/>(单位:小时)</td>
                       <td align="left" style="width:200px;"> <button class="btn btn-success loading-btn" id="Button3" onclick="edittime()" style="margin-top:10px;margin-left:50px;">
								    <i class="ace-icon fa fa-check bigger-110"></i>
								    保存修改
							    </button></td></tr>
                        </table>
						</div>
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<!-- END EXAMPLE TABLE PORTLET-->
				</div>
	
    		</div>
                        
								</div>
				<div class="tab-pane" id="portlet_tab2_2">
                <div class="row">
				<div class="col-md-12">
				
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>落葬场次人数
							</div>
							
						</div>
						<div class="portlet-body">
                            <table style="width:700px; height:50px;">
                       <tr><td align="right" style="width:200px;">落葬场次人数调整：</td>
                       <td style="width:200px;"><input id="number" style="width:100px; height:30px;"/>(单位:人)</td>
                       <td style="width:200px;" align="left">  
                       <button class="btn btn-success loading-btn" id="sub" onclick="editnumber()" style="margin-top:10px;margin-left:50px;">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    保存修改
							                    </button></td>  </tr>
                        </table>
						</div>
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<!-- END EXAMPLE TABLE PORTLET-->
				</div>
	
    		</div>
								 
								</div>
						<div class="tab-pane" id="portlet_tab2_3">
                <div class="row">
				<div class="col-md-12">
				 <a  class="btn btn-success loading-btn"  data-toggle="modal" href="#responsive2" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-plus-square "></i>
								                    添加信息
							                    </a>
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>定金金额与时间调整
							</div>
							
						</div>
						<div class="portlet-body">
                          <table class="table table-striped table-bordered table-hover" id="Table2">
							<thead>
							<tr>
                            <th>
								   起始价格
								</th>
								<th>
								   终止价格
								</th>
								<th>
									保留天数
								</th>
								<th>
									 操作
								</th>
							</tr>
							</thead>
							</table>
						</div>
                            <div id="responsive2" class="modal fade" tabindex="-1" data-width="760px">
							    <div class="modal-header">
								    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
								    <h4 class="modal-title">添加信息</h4>
							    </div>
							    <div class="modal-body">
								    <div class="row">
									    <div class="col-md-6" style="margin-left:100px">
                                               <table style=" border:0px; width:600px;">
                                               <tr><td>价格区间</td>
                                               <td style=" width:100px;"><input id="min" style=" width:100px;" />
                                               </td><td>-</td>
                                               <td><input id="max" style=" width:100px;"  />(单位:￥)</td>
                                               <td>预留时间</td>
                                               <td><input id="shijian" style=" width:100px;" />(单位:天)</td></tr>
                                               </table>
                                                                
                                                    </div>
										        </div>
                                         
								    </div>
								
							    <div class="modal-footer">
								    <button type="button" id="Button2"data-dismiss="modal" class="btn btn-default">关闭</button>
								    <button type="button" onclick="addinfo()" class="btn blue">保存</button>
							    </div>
						    </div>
                            <a  class="btn btn-success loading-btn" id="mo" data-toggle="modal" href="#responsive" style=" display:none; margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-plus-square "></i>
								                    
							                    </a>
                                <div id="responsive" class="modal fade" tabindex="-1" data-width="760px">
							    <div class="modal-header">
								    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
								    <h4 class="modal-title">修改信息</h4>
							    </div>
							    <div class="modal-body">
								    <div class="row">
									    <div class="col-md-6" style="margin-left:100px">
                                              <table style=" border:0px;width:600px;" >
                                               <tr><td>价格区间</td><td><input id="min1" style=" width:100px;" /></td><td>-</td>
                                               <td><input id="max1" style=" width:100px;" /></td><td>预留时间</td><td><input id="shijian1" style=" width:100px;" /></td></tr>
                                               </table>    
                                                    </div>
										        </div>
                                         
								    </div>
								<input id="ad_id" style=" display:none" />
							    <div class="modal-footer">
								    <button type="button" id="Button1"data-dismiss="modal" class="btn btn-default">关闭</button>
								    <button type="button" onclick="updateinfo()" class="btn blue">保存</button>
							    </div>
						    </div>
					</div>
					<!-- END EXAMPLE TABLE PORTLET-->
					<!-- BEGIN EXAMPLE TABLE PORTLET-->
					<!-- END EXAMPLE TABLE PORTLET-->
				</div>
	
    		</div>
								 
								</div>
                              
								</div>
							</div>
						</div>
					</div>
 <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>  

    <script src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>  
                <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
        <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/kindeditor.js"></script>
        <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/lang/zh_CN.js"></script>
        <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.js"></script>
    
<script type="text/javascript">
   var oTable;
  var initTable1;

      jQuery(document).ready(function () {
        //QuickSidebar.init(); // init quick sidebar
        initTable1 = function () {
            var table = $('#Table2');

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
                'bPaginate': true,  //是否分页。
                "bProcessing": true, //当datatable获取数据时候是否显示正在处理提示信息。 
                "bServerSide": false,
                "sAjaxSource": "<%= ViewData["rootUri"] %>OtherFeature/FindPriceAndTime",
                "aoColumns": [
                        {"mDataProp": "kaishijiage","bSortable": false },	
					        {"mDataProp": "jieshujiage","bSortable": false },	
                            {"mDataProp": "yuliushijian","bSortable": false },
                            {"mDataProp": "id","bSortable": false },
				     ],
                "columnDefs": [
				      
				        {
				            "targets": 3,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				                       return '<a href="javascript:editadjust('+data+');">修改</a> &nbsp;  <a href="javascript:deletedadjuct('+data+');">删除</a>';
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

            var tableWrapper = $('#Table2_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable1();
           
    });
    jQuery(function ($) {
            findinfo();
    });
    function findinfo(){
            $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/FindNumberAndTime",
                success: function (data) {
                    $("#time").val(data.time);
                    $("#number").val(data.number);
                }
            });
    }

    function editadjust(id){
        $("#mo").click();
        $("#ad_id").val(id);
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>OtherFeature/FindUpdateInfo",
                    data:{"id":id},
                    success: function (data) {
                        $("#min1").val(data.kaishijiage);
                        $("#max1").val(data.jieshujiage);
                        $("#shijian1").val(data.yuliushijian);
                    }
                });
        }

    function updateinfo(){
        var id= $("#ad_id").val();
        var kaishijiage= $("#min1").val();
        var jieshujiage= $("#max1").val();
        var yuliushijian= $("#shijian1").val();
          $.ajax({
                    url: "<%= ViewData["rootUri"] %>OtherFeature/UpdateAdjustInfo",
                     data:{"id":id,"kaishijiage":kaishijiage,"jieshujiage":jieshujiage,"yuliushijian":yuliushijian},
                    success: function (data) {
                      if (data=="success") {
                      $("#Button1").click();
                    toas1("修改成功");
                    setTimeout(function (){
                    oTable.fnDestroy();
                         initTable1();
                    },3000);
                      
                    }else{
                    toas2(data);
                    }
                    }
                });
        }
     function addinfo(){
        var kaishijiage= $("#min").val();
        var jieshujiage= $("#max").val();
        var yuliushijian= $("#shijian").val();
          $.ajax({
                    url: "<%= ViewData["rootUri"] %>OtherFeature/AddAdjustInfo",
                    data:{"kaishijiage":kaishijiage,"jieshujiage":jieshujiage,"yuliushijian":yuliushijian},
                    success: function (data) {
                    if (data=="success") {
                    $("#Button2").click();
                
                    toas1("添加成功");
                     setTimeout(function (){
                        oTable.fnDestroy();
                         initTable1();
                    },3000);
                  
                    }else{
                    toas2(data);
                    }
                    }
                });
        }
      function editnumber(){
              $.ajax({
                        url: "<%= ViewData["rootUri"] %>OtherFeature/UpdateNumberInfo",
                         data:{"number":$("#number").val()},
                        success: function (data) {
                          if (data=="success") {
                        toas1("修改成功");
                         setTimeout(function (){
                           location.href="<%= ViewData["rootUri"] %>OtherFeature/DataAdjust";
                             },3000);
                      
                        }else{
                        toas2(data);
                        }
                        }
                    });
            }
       function edittime(){
              $.ajax({
                        url: "<%= ViewData["rootUri"] %>OtherFeature/UpdateTimeInfo",
                         data:{"time":$("#time").val()},
                        success: function (data) {
                          if (data=="success") {
                        toas1("修改成功");
                         setTimeout(function (){
                        location.href="<%= ViewData["rootUri"] %>OtherFeature/DataAdjust";
                         },3000);
                       
                        }else{
                        toas2(data);
                        }
                        }
                    });
            }

     function deletedadjuct(id){
          var gnl=confirm("你真的确定要删除吗?");
          if (gnl==true){
              $.ajax({
                        url: "<%= ViewData["rootUri"] %>OtherFeature/DeletedAdjustInfo",
                         data:{"id":id},
                        success: function (data) {
                          if (data=="success") {
                          toas1("删除成功");
                           setTimeout(function (){
                           oTable.fnDestroy();
                          initTable1();
                             },3000);
                          
                        }else{
                        toas2(data);
                        }
                        }
             });
             }
            else{
            
            } 
    }
     function toas1(massage) {
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
          toastr["success"](massage, "温馨提示");
      }
      function toas2(massage) {
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

          toastr["error"](massage, "温馨提示");
      }
</script>

</asp:Content>
