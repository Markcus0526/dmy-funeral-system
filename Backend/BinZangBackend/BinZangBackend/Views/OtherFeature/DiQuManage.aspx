<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="example t-vista" style="margin-top:20px">
     <div class="portlet box green" >
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-pencil-square-o"></i>地区管理
							</div>
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#portlet_tab2_1" data-toggle="tab">
									市管理 </a>
								</li>
								<li>
									<a href="#portlet_tab2_2" data-toggle="tab">
									区域管理 </a>
								</li>
							</ul>
						</div>
						<div class="portlet-body">
							<div class="tab-content">
								<div class="tab-pane active" id="portlet_tab2_1">
                                 <Button id="edit2"  data-toggle="modal" href="#responsive3" style=" display:none" ></Button>
							                   
                                 <a  class="btn btn-success loading-btn"  data-toggle="modal" href="#responsive" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-plus-square "></i>
								                    添加市
							                    </a>
		                            <div class="row">
				                        <div class="col-md-12">
					                    <div class="portlet box green-haze" style=" margin-top:2%">
						                    <div class="portlet-title">
							                    <div class="caption">
								                    <i class="fa  fa-university"></i>市管理
							                    </div>
							
						                    </div>
						                    <div class="portlet-body">
							                    <table class="table table-striped table-bordered table-hover" id="Table2">
							                    <thead>
							                    <tr>
								                    <th>城市名称</th>
                                                    <th>操作</th>
							                    </tr></thead>
							                    </table>
						                    </div>
                                              
                                                
                                                <div id="responsive" class="modal fade" tabindex="-1" data-width="760">
								                <div class="modal-header">
									                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									                <h4 class="modal-title">添加市</h4>
								                </div>
								                <div class="modal-body">
									                <div class="row">
										                <div class="col-md-6" style="margin-left:200px">

												                市名称: <input id="city" class="form-control" type="text">
                                                               
											                    </div>
										                        </div>
                                         
									                </div>
								
								                <div class="modal-footer">
									                <button type="button" id="closeemp" data-dismiss="modal" class="btn btn-default">关闭</button>
									                <button type="button" onclick="addcity()" class="btn blue">保存</button>
								                </div>
							                </div>
                                            <div id="responsive3" class="modal fade" tabindex="-1" data-width="760px">
								                <div class="modal-header">
									                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									                <h4 class="modal-title">修改市</h4>
								                </div>
								                <div class="modal-body">
									                <div class="row">
										                <div class="col-md-6" style="margin-left:200px">
                                                   
												                市名称: <input id="city1" class="form-control" type="text"/>
                                                                 <input id="city_id" style=" display:none" />
                                                                   </div>
										                        </div>
                                         
									                </div>
								
								                <div class="modal-footer">
									                <button type="button" id="Button2"data-dismiss="modal" class="btn btn-default">关闭</button>
									                <button type="button" onclick="editoffice()" class="btn blue">保存</button>
								                </div>
							                </div>
					                    </div>
				                    </div>
	
    		                    </div>
                        
								</div>
                                      <a id="edit1"  data-toggle="modal" href="#responsive4" style=" display:none" ></a>
							                   
								<div class="tab-pane" id="portlet_tab2_2">
                                <a  class="btn btn-success loading-btn"  data-toggle="modal" href="#responsive2" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-plus-square "></i>
								                    添加区域
							                    </a>
								  <div class="row">
				                        <div class="col-md-12">
					                    <div class="portlet box green-haze" style=" margin-top:2%">
						                    <div class="portlet-title">
							                    <div class="caption">
								                    <i class="fa  fa-university"></i>区域管理
							                    </div>
							
						                    </div>
						                    <div class="portlet-body">
                                            <input id="office_id" style=" display:none" />
                                                <table class="table table-striped table-bordered table-hover" id="Table1">
							                        <thead><tr>
								                        <th> 区域名称</th>
                                                        <th> 所在城市</th>						
								                        <th>操作</th>
							                        </tr></thead>
							                        <!--tbody>
							                        <tr>
								                        <td> 和平办事处</td>
								                        <td> 5000000</td>
                                                        <td>  <a  data-toggle="modal" href="#responsive2">修改</a>
								                        </td>
							                        </tr></tbody-->
							                    </table>
						                    </div>
                                                
                                                <div id="responsive2" class="modal fade" tabindex="-1" data-width="760px">
								                <div class="modal-header">
									                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									                <h4 class="modal-title">添加区域</h4>
								                </div>
								                <div class="modal-body">
									                <div class="row">
										                <div class="col-md-6" style="margin-left:200px">
                                                   
												                区域名称: <input id="quyu" class="form-control" type="text">
                                                                 所在市名称: <select id="belongcity" class="select2">
                                                                 <%
                                                                      for (int i = 0; i < ViewBag.citylist.Count; i++)
                                                                      {%>
                                                                                <option value="<%=ViewBag.citylist[i].uid %>">
                                                                                    <%=ViewBag.citylist[i].name %>
                                                                                    </option>
                                                                       <% }%>
                                                                 </select>
                                                                
                                                                   </div>
										                        </div>
                                         
									                </div>
								
								                <div class="modal-footer">
									                <button type="button" id="closeoffice"data-dismiss="modal" class="btn btn-default">关闭</button>
									                <button type="button" onclick="addquyu()" class="btn blue">保存</button>
								                </div>
							                </div>
                                            <div id="responsive4" class="modal fade" tabindex="-1" data-width="760px">
								                <div class="modal-header">
									                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									                <h4 class="modal-title">修改区域</h4>
								                </div>
								                <div class="modal-body">
									                <div class="row">
										                <div class="col-md-6" style="margin-left:200px">
                                                   
												                区域名称: <input id="quyu1" class="form-control" type="text">
                                                                 所在市名称: <select id="name_city1" class="select2">
                                                                 <%
                                                                      for (int i = 0; i < ViewBag.citylist.Count; i++)
                                                                      {%>
                                                                                <option value="<%=ViewBag.citylist[i].uid %>">
                                                                                    <%=ViewBag.citylist[i].name %>
                                                                                    </option>
                                                                       <% }%>
                                                                 </select>
                                                                <input id="quyu_id" style=" display:none" />
                                                                   </div>
										                        </div>
                                         
									                </div>
								
								                <div class="modal-footer">
									                <button type="button" id="Button1"data-dismiss="modal" class="btn btn-default">关闭</button>
									                <button type="button" onclick="editquyu()" class="btn blue">保存</button>
								                </div>
							                </div>
					                    </div>
				                        </div>
	
    		                        </div>
								</div>
					
                              
								</div>
							</div>
						</div>
					</div>

<div class="corner rc-bottomleft"></div>
<div class="corner rc-bottomright"></div>
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
        jQuery(function ($) {  
              $(".select2").css('width', '120px').select2({ allowClear:true,minimumResultsForSearch: -1 });
        });
    var oTable1;
    var oTable2;
    var initTable2;
    var initTableA;
     jQuery(document).ready(function () {
        //QuickSidebar.init(); // init quick sidebar
        initTableA = function () {
            var table = $('#Table2');

             oTable1 = table.dataTable({
                
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
                "sAjaxSource": "<%= ViewData["rootUri"] %>OtherFeature/FindCity",
                "aoColumns": [
                        {"mDataProp": "name","bSortable": false },	
                        {"mDataProp": "id","bSortable": false },
				     ],
                "columnDefs": [
				      
				        {
				            "targets": 1,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				                return '<a href="javascript:updateshiqu('+data+')">修改</a> &nbsp;<a href="javascript:deletedshiqu('+data+')">删除</a> &nbsp;  ';
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
         initTableA();
           
    });
     jQuery(document).ready(function () {
        //QuickSidebar.init(); // init quick sidebar
         initTable2 = function () {
            var table = $('#Table1');

             oTable2 = table.dataTable({
                
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
                "sAjaxSource": "<%= ViewData["rootUri"] %>OtherFeature/FindQuYu",
                "aoColumns": [	
					    {"mDataProp": "name","bSortable": false },	
                       {"mDataProp": "city_name","bSortable": false },	
                        {"mDataProp": "id","bSortable": false },
				     ],
                "columnDefs": [
				      
				        {
				            "targets": 2,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				                   return '<a href="javascript:updatediqu('+data+')">修改</a> &nbsp; <a href="javascript:deleteddiqu('+data+')">删除</a> &nbsp; ';
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

            var tableWrapper = $('#Table1_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable2();
           
    });
    function updateshiqu(id){
         $("#edit2").click();
    $("#city_id").val(id);
    $.ajax({
            url: "<%= ViewData["rootUri"] %>OtherFeature/FindShiById",
            data:{"id":id},
            success: function (data) {
               $("#city1").val(data.name);
            }
        }); 
    }
    function updatediqu(id){
        $("#edit1").click();
    $("#quyu_id").val(id);
      $.ajax({
            url: "<%= ViewData["rootUri"] %>OtherFeature/FindQuyuById",
            data:{"id":id},
            success: function (data) {
               $("#quyu1").val(data.name);
                 $("#name_city1").val(data.chengshi_id);
                 $("#name_city1").css('width', '120px').select2({ allowClear:true,minimumResultsForSearch: -1 });
            }
        });
    }
      function addcity(){
         var city=$("#city").val();
         $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/AddOffice",
                data:{"city":city},
                success: function (data) {
                     if (data=="success") {
                     $("#closeemp").click();
                    toas1("修改成功");
                     setTimeout(function(){
                     location.reload();
//                    oTable1.fnDestroy();  
//                    initTableA();
                      },3000);
                    
                    }else{
                    toas2(data);
                    } 
                }
            }); 
         }
        function editquyu(){
           var name=$("#quyu1").val();
           var chengshi=$("#name_city1").val();
           var id=$("#quyu_id").val();
           if(name!=""&&name!=null)
           {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>OtherFeature/EditQuyu",
                    data:{"id":id,"name":name,"chengshi":chengshi},
                    success: function (data) {
                          if (data=="success") {
                             $("#Button1").click();
                            toas1("修改成功");
                             setTimeout(function(){
                             oTable2.fnDestroy();  
                                initTable2();
                                 },3000);
                        
                            }else{
                            toas2(data);
                            }
                    }
                });
            }
            else{
             toas2("区域名称不能为空！");
            }
        }
        function addquyu(){
          var city=$("#belongcity").val();
          var quyu=$("#quyu").val();
        $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/AddQuyu",
                data:{"quyu":quyu,"city":city},
                success: function (data) {
                  if (data=="success") {
                     $("#closeoffice").click();
                    toas1("修改成功");
                     setTimeout(function(){
                        oTable2.fnDestroy();  
                       initTable2();
                             },3000);
 
                    }else{
                    toas2(data);
                    }
                }
            }); 
        }
        function editoffice( ){
            var city= $("#city1").val();
             var id=$("#city_id").val();
          if(city!=""&&city!=null)
          {
            $.ajax({
                url: "<%= ViewData["rootUri"] %>OtherFeature/EditOffice",
                data:{"id":id,"city":city},
                success: function (data) {
                    if (data=="success") {
                      $("#Button2").click();
                     toas1("修改成功");
                      setTimeout(function(){
                            oTable1.fnDestroy();  
                             initTableA();
                             },3000);
                     
                    }else{
                     toas2(data);
                    }
                    
                }
            });
          }
          else{
          toas2("城市名称不能为空！");
          }
          
        }

        function deleteddiqu(id){
         var gnl=confirm("你真的确定要删除吗?");
            if (gnl==true){
                $.ajax({
                        url: "<%= ViewData["rootUri"] %>OtherFeature/DeletedQuyu",
                        data:{"id":id},
                        success: function (data) {
                          if (data=="success") {
                            toas1("修改成功");
                             setTimeout(function(){
                             oTable2.fnDestroy();  
                            initTable2();
                             },3000);
                           
                            }else{
                            toas2(data);
                            }
                        }
                    }); 
             }else{

            }
        }

        function deletedshiqu(id){
          var gnl=confirm("你真的确定要删除吗?");
            if (gnl==true){
                 $.ajax({
                        url: "<%= ViewData["rootUri"] %>OtherFeature/DeletedOffice",
                        data:{"id":id},
                        success: function (data) {
                            if (data=="success") {
                             toas1("修改成功");
                             setTimeout(function(){
                            location.reload();
                             },3000);
                             
                            }else{
                            toas2(data);
                            }
                    
                        }
                    });
            }else{

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


    

    