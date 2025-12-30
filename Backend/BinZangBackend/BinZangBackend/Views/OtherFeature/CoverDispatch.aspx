<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="example t-vista" style="margin-top:20px">
     <div class="portlet box green" >
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-pencil-square-o"></i>责任额调整
							</div>
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#portlet_tab2_1" data-toggle="tab">
									员工责任额 </a>
								</li>
								<li>
									<a href="#portlet_tab2_2" data-toggle="tab">
									办事处责任额 </a>
								</li>
							</ul>
						</div>
						<div class="portlet-body">
							<div class="tab-content">
								<div class="tab-pane active" id="portlet_tab2_1">
		                            <div class="row">
				                        <div class="col-md-12">
				                        <div>
                                          <span>办事处:<select id="banshichu" class="select2" onchange="changeoffice()" style=" width:200px; height:30px;" >
                                           <option value="0">全部</option>
                                            <%
                                              for (int i = 0; i < ViewBag.officelist.Count; i++)
                                              {%>
                                                        <option value="<%=ViewBag.officelist[i].uid %>">
                                                            <%=ViewBag.officelist[i].name %></option>
                                                        <% }%>
                                       </select> </span>
                                         </div>
					                    <div class="portlet box green-haze" style=" margin-top:2%">
						                    <div class="portlet-title">
							                    <div class="caption">
								                    <i class="fa  fa-university"></i>员工责任额
							                    </div>
							
						                    </div>
						                    <div class="portlet-body">
							                    <table class="table table-striped table-bordered table-hover" id="Table2">
							                    <thead>
							                    <tr>
                                                 <th>员工编号</th>
								                    <th>员工姓名</th>
								                   
								                    <th>月责任额</th>
                                                    <th>操作</th>
							                    </tr></thead>
							                    </table>
                                                <Button id="mo2"  data-toggle="modal" href="#responsive" style=" display:none"></Button>
						                    </div>
                                              
                                                
                                                <div id="responsive" class="modal fade" tabindex="-1" data-width="760">
								                <div class="modal-header">
									                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									                <h4 class="modal-title">员工责任额编辑</h4>
								                </div>
								                <div class="modal-body">
									                <div class="row">
										                <div class="col-md-6" style="margin-left:200px">

												                员工责任额: <input id="duty" class="form-control" type="text">
                                                                <input id="emp_id" style=" display:none" />
											                    </div>
										                        </div>
                                         
									                </div>
								
								                <div class="modal-footer">
									                <button type="button" id="closeemp" data-dismiss="modal" class="btn btn-default">关闭</button>
									                <button type="button" onclick="editemploy()" class="btn blue">保存</button>
								                </div>
							                </div>
					                    </div>
				                    </div>
	
    		                    </div>
                        
								</div>
								<div class="tab-pane" id="portlet_tab2_2">
								  <div class="row">
				                        <div class="col-md-12">
				                        <div>
                                       <span>城市:<select id="chengshi" class="select2" onchange="changecity()" style=" width:200px; height:30px; ">
                                        <option value="0">全部</option>
                                            <%
                                              for (int i = 0; i < ViewBag.citylist.Count; i++)
                                              {%>
                                                        <option value="<%=ViewBag.citylist[i].uid %>">
                                                            <%=ViewBag.citylist[i].name %>
                                                            </option>
                                               <% }%>
                                       </select> </span>
                                          </div>
					                    <div class="portlet box green-haze" style=" margin-top:2%">
						                    <div class="portlet-title">
							                    <div class="caption">
								                    <i class="fa  fa-university"></i>办事处责任额
							                    </div>
							
						                    </div>
						                    <div class="portlet-body">
                                            <input id="office_id" style=" display:none" />
                                                <table class="table table-striped table-bordered table-hover" id="Table1">
							                        <thead><tr>
								                        <th> 办事处名称</th>
								                        <th>一月</th>
                                                        <th>二月</th>
                                                        <th>三月</th>
                                                        <th>四月</th>
                                                        <th>五月</th>
                                                        <th>六月</th>
                                                        <th>七月</th>
                                                        <th>八月</th>
                                                        <th>九月</th>
                                                        <th>十月</th>
                                                        <th>十一月</th>
                                                        <th>十二月</th>
								                        <th>操作</th>
							                        </tr></thead>
                                                    <Button id="mo1"  data-toggle="modal" href="#responsive2" style=" display:none" >点击1</Button>
							                    </table>
						                    </div>
                                                
                                                <div id="responsive2" class="modal fade" tabindex="-1" data-width="1160px">
								                <div class="modal-header">
									                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
									                <h4 class="modal-title">办事处责任额编辑</h4>
								                </div>
								                <div class="modal-body">
									                <div class="row">
										                <div class="col-md-6" style="margin-left:0px">
                                                    <table  width="1100px;">
							                        <thead><tr>
								                        <th> 办事处名称</th>
								                        <th>一月责任额</th>
                                                        <th>二月责任额</th>
                                                        <th>三月责任额</th>
                                                        <th>四月责任额</th>
                                                        <th>五月责任额</th>
                                                        <th>六月责任额</th>
                                                        <th>七月责任额</th>
                                                        <th>八月责任额</th>
                                                        <th>九月责任额</th>
                                                        <th>十月责任额</th>
                                                        <th>十一月责任额</th>
                                                        <th>十二月责任额</th>
							                        </tr></thead>
							                        <tbody>
							                        <tr>
								                        <td> <input id="office" readonly="readonly" style=" border:0px solid #ffffff; width:120px;" /></td>
								                        <td>  <input id="yiyue" style="width:80px;"/></td>
                                                        <td>  <input id="eryue" style="width:80px;"/></td>		
                                                        <td>  <input id="sanyue" style="width:80px;"/></td>		
                                                        <td>  <input id="siyue" style="width:80px;"/></td>		
                                                        <td>  <input id="wuyue" style="width:80px;"/></td>		
                                                        <td>  <input id="liuyue" style="width:80px;"/></td>		
                                                        <td>  <input id="qiyue" style="width:80px;"/></td>		
                                                        <td>  <input id="bayue" style="width:80px;"/></td>		
                                                        <td>  <input id="jiuyue" style="width:80px;"/></td>		
                                                        <td>  <input id="shiyue" style="width:80px;"/></td>		
                                                        <td>  <input id="shiyiyue" style="width:80px;"/></td>		
                                                        <td>  <input id="shieryue" style="width:80px;"/></td>							                        </td>
							                        </tr>
                                                    </tbody>
							                    </table>
                                                                   </div>
										                        </div>
                                         
									                </div>
								
								                <div class="modal-footer">
									                <button type="button" id="closeoffice"data-dismiss="modal" class="btn btn-default">关闭</button>
									                <button type="button" onclick="editoffice()" class="btn blue">保存</button>
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

    var editor;
    KindEditor.ready(function (K) {
        editor = K.create('#contents', {
            cssPath: '<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.css',
            uploadJson: '<%= ViewData["rootUri"] %>ZoneInformation/UploadKindEditorImageT',
            fileManagerJson: '<%= ViewData["rootUri"] %>ZoneInformation/ProcessKindEditorRequestT',
            allowFileManager: true,
            afterCreate: function () {
                var self = this;
                K.ctrl(document, 13, function () {
                    self.sync();
                    K('form[name=profileform]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                    K('form[name=profileform]')[0].submit();
                });
            }
        });
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
                "sAjaxSource": "<%= ViewData["rootUri"] %>OtherFeature/FindEmpCover?office="+$("#banshichu").val(),
                "aoColumns": [
                        {"mDataProp": "name","bSortable": false },	
					    {"mDataProp": "emp_code","bSortable": false },	
                        {"mDataProp": "duty","bSortable": false },
                        {"mDataProp": "id","bSortable": false },
				     ],
                "columnDefs": [
				      
				        {
				            "targets": 3,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				                return '<a href="javascript:updatemploy('+data+')">修改</a> &nbsp; ';
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
                "sAjaxSource": "<%= ViewData["rootUri"] %>OtherFeature/FindStationCover?city="+$("#chengshi").val(),
                "aoColumns": [	
					    {"mDataProp": "name","bSortable": false },	
                        {"mDataProp": "yiyue","bSortable": false },
                        {"mDataProp": "eryue","bSortable": false },
                        {"mDataProp": "sanyue","bSortable": false },
                        {"mDataProp": "siyue","bSortable": false },
                        {"mDataProp": "wuyue","bSortable": false },
                        {"mDataProp": "liuyue","bSortable": false },
                        {"mDataProp": "qiyue","bSortable": false },
                        {"mDataProp": "bayue","bSortable": false },
                        {"mDataProp": "jiuyue","bSortable": false },
                        {"mDataProp": "shiyue","bSortable": false },
                        {"mDataProp": "shiyiyue","bSortable": false },
                        {"mDataProp": "shieryue","bSortable": false },
                        {"mDataProp": "id","bSortable": false },
				     ],
                "columnDefs": [
				      
				        {
				            "targets": 13,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				                   return '<a href="javascript:updatoffice('+data+')">修改</a> &nbsp; ';
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

    function updatoffice(id){
     $("#mo1").click();
     $("#office_id").val(id);
        $.ajax({
            url: "<%= ViewData["rootUri"] %>OtherFeature/FindOfficeById",
            data:{"id":id},
            success: function (data) {
              $("#office").val(data.name);
              $("#yiyue").val(data.yiyue);
              $("#eryue").val(data.eryue);
              $("#sanyue").val(data.sanyue);
              $("#siyue").val(data.siyue);
              $("#wuyue").val(data.wuyue);
              $("#liuyue").val(data.liuyue);
              $("#qiyue").val(data.qiyue);
              $("#bayue").val(data.bayue);
              $("#jiuyue").val(data.jiuyue);
              $("#shiyue").val(data.shiyue);
              $("#shiyiyue").val(data.shiyiyue);
              $("#shieryue").val(data.shieryue); 
            }
        });
    }
    function updatemploy(id){
    $("#mo2").click();
    $("#emp_id").val(id);
       $.ajax({
            url: "<%= ViewData["rootUri"] %>OtherFeature/FindEmployeById",
            data:{"id":id},
            success: function (data) {
               $("#duty").val(data.duty);
            }
        }); 
    }

    function editoffice(){

    $.ajax({
            url: "<%= ViewData["rootUri"] %>OtherFeature/EditOfficeById",
            data:{
            "id":$("#office_id").val(),
            "yiyue":$("#yiyue").val(),
            "eryue":$("#eryue").val(),
            "sanyue":$("#sanyue").val(),
            "siyue":$("#siyue").val(),
            "wuyue":$("#wuyue").val(),
            "liuyue":$("#liuyue").val(),
            "qiyue":$("#qiyue").val(),
            "bayue":$("#bayue").val(),
            "jiuyue":$("#jiuyue").val(),
            "shiyue":$("#shiyue").val(),
            "shiyiyue":$("#shiyiyue").val(),
            "shieryue":$("#shieryue").val()
            },
            success: function (data) {
            if (data=="success") {
             var table = $('#Table2');
            $("#closeoffice").click();
             toas1("修改成功");
             setTimeout(function(){
               oTable2.fnDestroy();  
            initTable2();
             },3000)
          
            }else{
            toas2(data);
            }
            }
        }); 
    }

    function editemploy(){
       $.ajax({
            url: "<%= ViewData["rootUri"] %>OtherFeature/EditEmployById",
            data:{"id":$("#emp_id").val(),"duty":$("#duty").val()},
            success: function (data) {
            if (data=="success") {
                var table = $('#Table2');
            $("#closeemp").click();
            toas1("修改成功");
            
            setTimeout(function(){
               oTable1.fnDestroy();  
                initTableA();
             },3000)
            }else{
            toas2(data);
            }
            }
        }); 
    }
function  changeoffice(){
oTable1.fnDestroy();  
  initTableA();
} 
function changecity(){
 oTable2.fnDestroy();  
            initTable2();
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
<script type="text/javascript">
jQuery(function ($) {  
              $(".select2").css('width', '120px').select2({ minimumResultsForSearch: -1 });
              $("#Select1").css('width', '120px').select2({ allowClear:true});
        });
   $(document).ready(function () {

            var rootUri = "<%= ViewData["rootUri"] %>";
            var recvcontents =  "<%= ViewData["content"] %>";
            var conthtml = unescape(recvcontents);
            $("#contents").html(conthtml);
            if (editor != undefined) {
             editor.html(conthtml);
                editor.sync();
            }
        
         $(".btn-block").click(function(){
             $("#notes").hide();
             $("#caozuo").show();



         });
          $("#lzset").click(function(){
             $("#notes").show();
             $("#caozuo").hide();



         });
        });

        function OnSubmit() {
            editor.sync();            

            $.ajax({
                type: "POST",
                url: rootUri + "CMInfoManage/UpdateProfile",
                dataType: "json",
                data: {
                    comp_imgpath: $("#img").val(),
                    introduce: escape($("#contents").val())
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

            return false;
        }

        function htmlencode(str) {
            return str.replace(/[&<>"']/g, function($0) {
                return "&" + {"&":"amp", "<":"lt", ">":"gt", '"':"quot", "'":"#39"}[$0] + ";";
            });
        }

</script>


</asp:Content>


    

    