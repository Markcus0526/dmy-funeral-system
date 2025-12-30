<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
     <link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.css" /> 


        <div class="row" style=" width:auto; min-width:980px">
				<div class="col-md-12">
				
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>查看员工
							</div>
							
						</div>
						<div class="portlet-body">
                      <table style="width:680px; height:100px; margin-left:50px;">
                         <tr>
                         <td rowspan="2">
                           员工图片:
                            <div class="form-group">
                            <div id="advertCarImg" class="form-group" style="width:122px; border:2px solid #BBB;">
                                <img src="<%= ViewData["rootUri"] %><%= ViewData["img"] %>" id ="picture" height="120px" width="120px"/>	
                                <input type="hidden" id="img" class="img"  name="img" value="" />
                                </div>
                            </div>                     
                         </td>
                          <td align="right">
                         员工姓名&nbsp;:&nbsp;
                         </td>
                          <td align="left" style="width:120px;">
                        <%= ViewData["real_name"] %>
                         </td>
                          <td align="right">
                         联系电话&nbsp;:&nbsp;
                         </td>
                         <td align="left" style="width:120px;">
                         <%= ViewData["phone"] %>
                         </td>
                        
                            <td align="right">
                         QQ&nbsp;:&nbsp;
                         </td>
                         <td align="left" style="width:120px;">
                         <%= ViewData["qqname"] %>
                         </td>
                         </tr>
                        <tr>
                        <td align="right">
                           所属办事处&nbsp;:&nbsp;
                         </td>
                          <td align="left">
                          <%= ViewData["office"] %></td>
                        
                             <td align="right">
                         微信&nbsp;:&nbsp;
                         </td>
                         <td align="left">
                         <%= ViewData["weixin"] %>
                         </td>
                         </tr>
                      
                      </table>
                     
                             
						</div>
					</div>
`             </div>
				<div class="col-md-12">
				<div>
					<div class="portlet box green-haze" style=" margin-top:2%">
                      <div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>查看员工旧客户
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
									客户电话
								</th>
                                <th>
									客户类型
								</th>
                                <th>
									真实姓名
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
                           
                            <a id="sett" class="btn btn-success loading-btn" href="<%=ViewData["rootUri"] %>ManagePerson/Staff" style="margin-top:10px;margin-left:10px">
								<i class="ace-icon fa fa-plus-square "></i>
								返回
							</a>
    		</div>
    <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/kindeditor.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.js"></script>
    <script src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>   
     <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/uploadify/jquery.uploadify.js"></script>
    <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
 var offices="<%= ViewData["office"] %>";
 var owner="<%= ViewData["owner_name"] %>";
    jQuery(function ($) {
        $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
          
    });
    jQuery(function ($) {  

              $(".select2").css('width', '100px').select2({ minimumResultsForSearch: -1,allowClear:true });
        });

         
         var oTable;
  var initTable1;
    jQuery(document).ready(function () {
        //QuickSidebar.init(); // init quick sidebar
          initTable1= function () {

            var table = $('#sample_1');

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
                "sPaginationType": "full_numbers",
                'bPaginate': true,  //是否分页。
                "bProcessing": true, //当datatable获取数据时候是否显示正在处理提示信息。 
                "bServerSide": false,
                "sServerMethod": "POST", 
                "sAjaxSource": "<%= ViewData["rootUri"] %>ManagePerson/FindOldCustomById?id="+<%= ViewData["id"] %>,
                "aoColumns": [
                        {"mDataProp": "name","bSortable": false },	
                        {"mDataProp": "phone","bSortable": false },
                        {"mDataProp": "owner_name","bSortable": false },
                        {"mDataProp": "realname","bSortable": false },
                        {"mDataProp": "id","bSortable": false },
				     ],
                     "fnServerData": function(sSource, aoData, fnCallback){
                                      $.ajax({
                                          "dataType": 'json',
                                          "type": "POST",
                                          "url": sSource,
                                          "data":{
                                          "name":$("#name").val(), 
                                          "phone":$("#phone").val(),
                                          "banshichu":$("#banshichu").val(),
                                          } ,
                                           "success": fnCallback
                             } );
                      },   
                "columnDefs": [
				      
				        {
				            "targets": 4,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
                            if (row.owner_name=="代销商") {
                             return '<a href="<%=ViewData["rootUri"] %>ManagePerson/FindDaiXiaoShang?id='+data+'">查看详情</a> &nbsp;';
                            }
                            else{
                             return '<a href="<%=ViewData["rootUri"] %>ManagePerson/FindOldCustom?id='+data+'">查看详情</a> &nbsp;';
                            
                            }
				            },
				            sClass: 'center'
				        }
                    ],
                "order": [
                [0, 'asc']
            ],  "lengthMenu": [
                [10, 15, 20, -1],
                [10, 15, 20, "All"] 
            ],
                "pageLength": 10,

                "dom": "<'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // horizobtal scrollable datatable

              
            });

            var tableWrapper = $('#sample_1_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable1();
           
    });    
</script>

</asp:Content>
