<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css" />
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css" />
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css" />
    <link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css" />
    <div class="row" style=" min-width:1000px">
        <div class="col-md-12">
            <!-- BEGIN EXAMPLE TABLE PORTLET-->
         <div style=" height:60px; margin-top:4%; border:1px solid #3B9C96">
                        <div style="margin-top:1%; margin-left:1%">
                <label>
                    客户姓名：</label><input style="height:28px" id="cname"/><lable style="margin-left: 2%">联系电话：</lable><input  style="height:28px;" id="phone"/>
                <label style="margin-left: 2%">
                    园区：</label><select class="select2" id="yuanqu">
                    <% for (int i = 0; i < ViewBag.ylist.Count; i++){  %>
                         <option value="<%=ViewBag.ylist[i].uid %>"><%=ViewBag.ylist[i].name %></option>
                     <% }%>
                     
                    </select><label style="margin-left: 2%">编号：</label><input style="height:28px" id="muwei" />
                <a id="searchdata" class="btn btn-sm btn-success" onclick="SearchM()" style="margin-left: 2%">
                    <i class="fa fa-search"></i>搜索</a>
            </div>
            </div>
            <div class="portlet box green-haze" style="margin-top: 5%">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa  fa-university"></i>陵墓预约管理
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
                                   截止时间
                                </th>
                                <th>
                                    园区
                                </th>
                                <th>
                                    墓位
                                </th>
                                <th>
                                    办事处
                                </th>
                                <th>
                                    员工
                                </th>
                                <th>
                                    操作人
                                </th>
                                <th>
                                    下单次数
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
            var cname=$('#cname').val();
            var phone = $('#phone').val();
            var yuanid= $('#yuanqu').val();
            var muwei = $('#muwei').val();
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
                "sAjaxSource": url+"LingMuOrder/GetLingMuOrder",
                "aoColumns": [
                        {"mDataProp": "cname","bSortable": false },	
					    {"mDataProp": "phone","bSortable": false },	
                        {"mDataProp": "endtime","bSortable": true },	
                        {"mDataProp": "yuanqu","bSortable": false},
                        {"mDataProp": "muwei","bSortable": false },
                        {"mDataProp": "officename","bSortable": false },
                        {"mDataProp": "onwername","bSortable": false },
                        {"mDataProp": "uname","bSortable": false },
                         {"mDataProp": "cishu","bSortable": false },
                        {"mDataProp": "uid","bSortable": false },
				     ],
                      "fnServerData": function(sSource, aoData, fnCallback){
                                      $.ajax({
                                          "dataType": 'json',
                                          "type": "POST",
                                          "url": sSource,
                                          "data":{"cname":cname,"phone":phone,"yuanid":yuanid,"muwei":muwei} ,
                                           "success": fnCallback
                                             } );
                      },
                        "columnDefs": [
                            {
				            "targets":8,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				                    if (data<5)
				                      {
                                        return '<span class="label label-md label-success">'+data+'次'+'</span>';
				                        }
                                    if (data==5)
                                       {
                                        return '<span class="label label-sm label-danger">'+data+'次'+'</span>';
                                        }
                                    if (data>5)
                                        {
                                        return '<span class="label label-sm label-danger">'+data+'次'+'</span>';
                                        }
                                },
				            sClass: 'center'
				        },
                            {
				            "targets":9,    // Column number which needs to be modified
				            "render": function(data, type, row) {   // o, v contains the object and value for the column
				      return '<a onclick="DelLingmu('+data+')">取消</a>';
                                },
				            sClass: 'center'
				        },
				       
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
   function SearchM(){

     oTable.fnDestroy();
     initTable1();
    }
    function DelLingmu(uid){
     var rootUri ="<%= ViewData["rootUri"] %>";
                         $.ajax({

                            url: rootUri + "LingMuOrder/DelLing",
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
    </script>
</asp:Content>
