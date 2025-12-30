<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="row">
				<div class="col-md-12">
				
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>注册用户审核
							</div>
							
						</div>
						<div class="portlet-body">
                      
							<table class="table table-striped table-bordered table-hover" id="sample1">
							<thead>
							<tr>
								<th>
								    审核姓名
								</th>
								<th>
									 联系方式
								</th>
								<th>
									 操作
								</th>
							</tr>
							</thead>
							<tbody>
							
					
                            	<tr>
								<td>
									 赵四
								</td>
								<td>
									 13912345612
								</td>
                                <td>
								 <a href="<%=ViewData["rootUri"] %>OtherFeature/RegistCheckDetails">查看详情</a>
								</td>
							</tr>
                            	<tr>
								<td>
									 王老七
								</td>
								<td>
									 13912345613
								</td>
                                <td>
							      <a href="<%=ViewData["rootUri"] %>OtherFeature/RegistCheckDetails">查看详情</a>
								</td>
							</tr>
                            	<tr>
								<td>
									 谢广坤
								</td>
								<td>
									 13512345612
								</td>
                                <td>
									 <a href="<%=ViewData["rootUri"] %>OtherFeature/RegistCheckDetails">查看详情</a>	 
								</td>
							</tr>
                                	<tr>
								<td>
									 刘能
								</td>
								<td>
									 13512345612
								</td>
                                <td>
									 <a href="<%=ViewData["rootUri"] %>OtherFeature/RegistCheckDetails">查看详情</a>	 
								</td>
							</tr>
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
    jQuery(document).ready(function () {
        //QuickSidebar.init(); // init quick sidebar
        var initTable1 = function () {
            var table = $('#sample1');

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

            var tableWrapper = $('#sample1_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable1();
           
    });
      jQuery(function ($) {
            $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
        });
</script>

</asp:Content>
