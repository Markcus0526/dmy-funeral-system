<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
     <link rel="stylesheet" href="<%= ViewData["rootUri"] %>Content/js/uploadify/uploadify.css" /> 
<div class="row" style=" width:auto; min-width:980px;">
				<div class="col-md-12">
				<div>
                                   <div style=" height:90px; margin-top:4%; width:auto; min-width:980px; border:1px solid #3B9C96">
                        <div style="margin-top:1%; margin-left:1%">
                        <label style=" font-size; small">
                        旧客户姓名：</label><input style=" width:150px;height:28px" id="name"/>
                        <label style=" margin-left:2%">
                        电话号码：</label><input  style="width:150px;height:28px" id="phone"/>
                       <a id="searchdata" class="btn btn-sm btn-success" onclick="Searchlingdao()" style=" margin-left:2%"><i class="fa fa-search"> &nbsp;</i>搜索</a>
                     
                       </div>
                 
                </div>
					<div class="portlet box green-haze" style=" margin-top:2%">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa  fa-university"></i>旧客户
							</div>
							<div class="tools" style=" margin-top:-15px;">
                              <Button class="btn btn-success loading-btn" onclick="addold()" style="margin-top:10px;margin-left:10px">
							<i class="ace-icon fa fa-plus-square "></i>
							添加旧客户
						</Button>
                            </div>
						</div>
						<div class="portlet-body">
                      
							<table class="table table-striped table-bordered table-hover" id="sample_1">
							<thead>
							<tr>
                            <th>
								   旧客户名称

								</th>
								<th>
									所属员工
								</th>
                                <th>
									真实姓名
								</th>
                                <th>
									电话号码
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
            </div>
        <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
        <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>   
        <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/uploadify/jquery.uploadify.js"></script>
        <script type="text/javascript" src="<%= ViewData["rootUri"] %>Content/js/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
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
                'bPaginate': true,  //是否分页。
                "bProcessing": true, //当datatable获取数据时候是否显示正在处理提示信息。 
                "bServerSide": false,
                "sServerMethod": "POST", 
                "sAjaxSource": "<%= ViewData["rootUri"] %>ManagePerson/FindAllOldCustom",
                "aoColumns": [
                        {"mDataProp": "name","bSortable": false },	
                        {"mDataProp": "owner_name","bSortable": false },
                        {"mDataProp": "realname","bSortable": false },
                        {"mDataProp": "phone","bSortable": false },
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
                                          } ,
                                           "success": fnCallback
                                             } );
                      },   
                "columnDefs": [
				      
				        {
				            "targets": 4,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				                   return '<a href="<%=ViewData["rootUri"] %>ManagePerson/FindOldCustom?id='+data+'">查看详情</a> &nbsp; '  
                                   + '<a  data-toggle="modal" href="<%=ViewData["rootUri"] %>ManagePerson/EditOldCustom?id='+data+'" >修改</a>&nbsp; <a href="javascript:deletedold('+data+')">删除</a>';
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

   jQuery(function ($) {  
              $(".select2").css('width', '150px').select2({ allowClear:true,minimumResultsForSearch: -1 });
        });
      jQuery(function ($) {

            $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" })
			.on('change', function () { });
        });
       
       function deletedspots(id){
       var gnl=confirm("你真的确定要删除吗?");
            if (gnl==true){
             $.ajax({
                    url: "<%= ViewData["rootUri"] %>ManagePerson/DeletedDaiXiaoShang",
                    data:{"id":id},
                    success: function (data) {
                     if (data=="success")
                     {
                     toas1("删除成功");
                     setTimeout(function(){
                      oTable.fnDestroy();
                     initTable1();
                     },3000);
                    
                     }else
                     {
                     toas2(data);
                     }
                    }
                });
            }
            else{
            
            } 
               
       }

       function deletedold(id){
               var gnl=confirm("你真的确定要删除吗?");
                if (gnl==true){
                    $.ajax({
                        url: "<%= ViewData["rootUri"] %>ManagePerson/DeletedOldCustom",
                        data:{"id":id},
                        success: function (data) {
                         if (data=="success")
                         {
                         toas1("删除成功");
                         setTimeout(function(){
                          oTable.fnDestroy();
                         initTable1();
                         },3000);
                    
                         }else
                         {
                         toas2(data);
                         }
                        }
                    });
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

      function Searchlingdao(){
      oTable.fnDestroy();
      initTable1();
      }

      function addold(){
      location.href="<%=ViewData["rootUri"] %>ManagePerson/AddOldCustom";
      }
</script>

</asp:Content>
