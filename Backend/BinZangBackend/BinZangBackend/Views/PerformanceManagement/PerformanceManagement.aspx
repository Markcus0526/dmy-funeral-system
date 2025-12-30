<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="example t-vista" style="margin-top:20px">
     <div class="portlet box green" >
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-pencil-square-o"></i>业绩管理
							</div>
                             <div class="tools">
                            <button class="btn btn-success btn-sm" id="add" onclick="addp()" style="margin-top:-6.5px;margin-left:0px"/>
								                   <i class="fa fa-plus"></i> 新增
                            </div>
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#portlet_tab2_1" data-toggle="tab">
									办事处业绩 </a>
								</li>
								<li>
									<a href="#portlet_tab2_2" data-toggle="tab">
									个人业绩</a>
								</li>
								<li class="">
									<a href="#portlet_tab2_3" data-toggle="tab">
									代销商业绩</a>
								</li>
							</ul>
						</div>
						<div class="portlet-body">
							<div class="tab-content">
								
								<div class="tab-pane active" id="portlet_tab2_1">
									     <div class="row" style="margin-top:20px">
                                        <div class="col-xs-12">
                                            <div class="widget-box">
			                                    <div class="widget-body">
				                                    <div class="widget-main" style="border:1px solid #3B9C96">
                                                        <div class="searchbar" >
                                                            <form class="form-horizontal" role="form" id="validation-form" >
                                                                <!-- 第一行-->
                                                                <br />
                                                                <div class="form-group">  
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:10px;width:100px" for="">办事处名称</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">
                                    
                      
                                                                      <select class="select2" id="offname" style="width:150px;">
                                                                               <option value="0" >请选择</option> 
                                                                                       <%
                                                                                           for (int i = 0; i < ViewBag.office.Count; i++)
                                                                                      {   
                                                                                           %>
                                                                                       <option value="<%=ViewBag.office[i].uid %>" ><%=ViewBag.office[i].name%></option>
                                                                                       <% }%>
                                                                           </select>
                    
						                
                                                                        </div>
				                                                    </div>                                                                    
                                                                    
                                                            <% string times = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day; %>
                                                            <label class="col-sm-1 control-label no-padding-right" style="margin-left:65px" for="">时间段</label>
				                                                    <div class="col-sm-1" style="margin-left:-30px">
                                                                        <div class="clearfix">
                                                                        <div class="col-sm-1">
											                                <div class="input-group input-medium">
                                                                             
												                                <input type="text" id="ostarttime" class="date date-picker" data-date-format="yyyy-mm-dd" style="height:28px;width:207px"  value="<%=times %>">
												                                <span class="input-group-btn ">
												                                <button class="btn default btn-sm" type="button"><i class="fa fa-calendar"></i></button>
												                                </span>
											                                </div>
											                              
										                                </div>
                      
                                                                        </div>
				                                                    </div>
                                                                    <label class="col-sm-1 control-label" style="margin-left:150px" for="">至</label>
                                                                    
				                                                    <div class="col-sm-1" style="margin-left:-20px">
                                                                        <div class="clearfix">
                                                                        <div class="col-sm-1">
											                                <div class="input-group input-medium">
                                                                             
												                                <input type="text" id="oendtime" class="date date-picker" data-date-format="yyyy-mm-dd" style="height:28px;width:207px"  value="<%=times %>">
												                                <span class="input-group-btn ">
												                                <button class="btn default btn-sm" type="button"><i class="fa fa-calendar"></i></button>
												                                </span>
											                                </div>
											                              
										                                </div>
                      
                                                                        </div>
				                                                    </div>
                                                                        <div class="col-sm-1" style="margin-left:170px">
						                                                    <a class="btn  btn-success" id="A3" onclick="search_data3()"><i class="fa fa-search"></i> 搜索</a>
                                  
                                                                    </div> 
                                                                    <div class="col-sm-1" style="margin-left:-10px">
						                                                    <a class="btn  btn-success" href="<%= ViewData["rootUri"] %>PerformanceManagement/GetPgExcel/?offname=0&ostarttime=<%=times %>&oendtime=<%=times %>" id="download"><i class="fa fa-sign-out"></i> 导出总业绩</a>
                                  
                                                                    </div> 
                                 
                                                                </div>
                                                  
                                                </form>
                                            </div>
                     
				                        </div>
			                        </div>
                                    </div>
			                        </div>
		                        </div>
                                    <div class="row" style="margin-top:10px">
				                                    <div class="col-md-12">
					                                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
					                                    <div class="portlet box green-haze">
						                                    <div class="portlet-title">
							                                    <div class="caption">
								                                    <i class="fa fa-server"></i>办事处业绩
							                                    </div>
							                                    <div class="tools">
								                                   <a class="btn  purple" id="A4" style="margin-top:0px;height:35px" onclick="sendmanageoffice()" ><i class="fa fa-share-square-o"></i> 推送办事处</a>
                                                                   <a class="btn  purple" id="A5" style="margin-top:0px;height:35px" onclick="sendmanagehead()" ><i class="fa fa-share-square-o"></i> 推送领导</a> 
							                                    </div>
						                                    </div>
						                                    <div class="portlet-body">
							                                    <table class="table table-striped table-bordered table-hover" id="sample_1" style="text-align:center">
							                                    <thead>
							                                    <tr>
								                                    <th style="text-align:center;">
									                                    办事出名称
								                                    </th>
								                                    <th style="text-align:center">
									                                     代销商业绩累计
								                                    </th>
								                                    <th style="text-align:center">
									                                     员工业绩累计
								                                    </th>
								                                    <th style="text-align:center">
									                                     自营比例
								                                    </th>
								                                    <th style="text-align:center">
									                                     责任额
								                                    </th>
                                                                    <th style="text-align:center">
									                                     总业绩
								                                    </th>
								                                    <th style="text-align:center">
									                                     达成比例
								                                    </th>
                                                                    <th style="text-align:center">
									                                     办事处营余累计
								                                    </th>
							                                    </tr>
							                                    </thead>
							                                    <tbody>
							                                    
							                                    </tbody>
							                                    </table>
						                                    </div>
					                                    
					                                    <!-- END EXAMPLE TABLE PORTLET-->
					                                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
					                                    <!-- END EXAMPLE TABLE PORTLET-->
                                                        </div>
                                                        
				                                    </div>
                                                    
                            
	
    		                                  </div>
                               
								</div>
								<div class="tab-pane" id="portlet_tab2_2">
									   <div class="row" style="margin-top:20px">
                                        <div class="col-xs-12">
                                            <div class="widget-box">
			                                    <div class="widget-body">
				                                    <div class="widget-main" style="border:1px solid #3B9C96">
                                                        <div class="searchbar" >
                                                            <form class="form-horizontal" role="form" id="Form1" >
                                                                <!-- 第一行-->
                                                                <br />
                                                                <div class="form-group">  
                                                                    <label class="col-sm-2 control-label no-padding-right" style="margin-left:50px;width:100px" for="">办事处名称</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">
                                    
                      
                                                                      <select class="select2" id="yofficename" style="width:150px;" onchange="setyyname(this.value)">
                                                                                <option value="0" >请选择</option> 
                                                                                       <%
                                                                                           for (int i = 0; i < ViewBag.office.Count; i++)
                                                                                      {   
                                                                                           %>
                                                                                       <option value="<%=ViewBag.office[i].uid %>" ><%=ViewBag.office[i].name%></option>
                                                                                       <% }%>
                                                                           </select>
                    
						                
                                                                        </div>
				                                                    </div> 
                                                                    
                                                                    <label class="col-sm-2 control-label no-padding-right" style="margin-left:90px;width:150px" for="">员工姓名</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">
                                    
                      
                                                                      <select class="select2" id="yyname" style="width:150px;">
                                                                                <option value="0" >全部</option> 
                                                                           </select>
                    
						                
                                                                        </div>
				                                                    </div> 
                                                                    </div>
                                                                     <div class="form-group">                                                                   
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:45px" for="">时间段</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix">
                                                                        <div class="col-sm-1">
											                                <div class="input-group input-medium">
                                                                             
												                                <input id="ystarttime" type="text" class="date date-picker" data-date-format="yyyy-mm-dd" style="height:28px;width:207px" value="<%=times %>">
												                                <span class="input-group-btn ">
												                                <button class="btn default btn-sm" type="button"><i class="fa fa-calendar"></i></button>
												                                </span>
											                                </div>
											                              
										                                </div>
                      
                                                                        </div>
				                                                    </div>
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:140px" for="">至</label>
				                                                    <div class="col-sm-1" style="margin-left:-20px">
                                                                        <div class="clearfix">
                                                                        <div class="col-sm-1">
											                                <div class="input-group input-medium">
                                                                             
												                                <input id="yendtime" type="text" class="date date-picker" data-date-format="yyyy-mm-dd" style="height:28px;width:207px"   value="<%=times %>">
												                                <span class="input-group-btn ">
												                                <button class="btn default btn-sm" type="button"><i class="fa fa-calendar"></i></button>
												                                </span>
											                                </div>
											                              
										                                </div>
                      
                                                                        </div>
				                                                    </div>
                                                                        <div class="col-sm-1" style="margin-left:250px">
						                                                    <a class="btn  btn-success" id="A1" onclick="search_data2()"><i class="fa fa-search"></i> 搜索</a>
                                  
                                                                    </div> 
                                                                     <div class="col-sm-1" style="margin-left:0px">
						                                                    <a class="btn  btn-success" href="<%= ViewData["rootUri"] %>PerformanceManagement/YPgExcel/?yofficename=0&yyname=0&ystarttime=<%=times %>&yendtime=<%=times %>" id="downexcel"><i class="fa fa-sign-out"></i> 导出员工业绩</a>
                                  
                                                                    </div> 
                                 
                                                                </div>
                                                  
                                                </form>
                                            </div>
                     
				                        </div>
			                        </div>
                                    </div>
			                        </div>
		                        </div>
                                    <div class="row" style="margin-top:10px">
				                                    <div class="col-md-12">
					                                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
					                                    <div class="portlet box green-haze">
						                                    <div class="portlet-title">
							                                    <div class="caption">
								                                    <i class="fa fa-server"></i>员工业绩
							                                    </div>
							
						                                    </div>
						                                    <div class="portlet-body">
							                                    <table class="table table-striped table-bordered table-hover" id="sample_2" style="text-align:center">
							                                    <thead>
							                                    <tr>
								                                    <th style="text-align:center">
									                                    员工姓名
								                                    </th>
								                                    <th style="text-align:center">
									                                     代销商业绩
								                                    </th>
								                                    <th style="text-align:center">
									                                     员工业绩
								                                    </th>
								                                    <th style="text-align:center">
									                                     自营比例
								                                    </th>
								                                    <th style="text-align:center">
									                                     当月责任额
								                                    </th>
                                                                     <th style="text-align:center">
									                                     总业绩
								                                    </th>
								                                    <th style="text-align:center">
									                                     达成比例
								                                    </th>
								                                    
							                                    </tr>
							                                    </thead>
							                                    <tbody>
							                                    
							                                    </tbody>
							                                    </table>
						                                    </div>
					                                    
					                                    <!-- END EXAMPLE TABLE PORTLET-->
					                                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
					                                    <!-- END EXAMPLE TABLE PORTLET-->
                                                        </div>
                                                        
				                                    </div>
                                                    
                            
	
    		                                  </div>
                                
                        
								</div>
                                <div class="tab-pane" id="portlet_tab2_3">
									     <div class="row" style="margin-top:20px">
                                        <div class="col-xs-12">
                                            <div class="widget-box">
			                                    <div class="widget-body">
				                                    <div class="widget-main" style="border:1px solid #3B9C96">
                                                        <div class="searchbar" >
                                                            <form class="form-horizontal" role="form" id="Form2" >
                                                                <!-- 第一行-->
                                                                <br />
                                                                <div class="form-group">  
                                                                    <label class="col-sm-2 control-label no-padding-right" style="margin-left:50px;width:100px" for="">办事处名称</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">
                                    
                      
                                                                      <select class="select2" id="officename" style="width:150px;" onchange="setyname(this.value)">
                                                                                       <option value="0" >请选择</option> 
                                                                                       <%
                                                                                           for (int i = 0; i < ViewBag.office.Count; i++)
                                                                                      {   
                                                                                           %>
                                                                                       <option value="<%=ViewBag.office[i].uid %>" ><%=ViewBag.office[i].name%></option>
                                                                                       <% }%>
                                                                           </select>
                    
						                
                                                                        </div>
				                                                    </div> 
                                                                    
                                                                    <label class="col-sm-2 control-label no-padding-right" style="margin-left:90px;width:150px" for="">员工姓名</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">
                                    
                      
                                                                      <select class="select2" id="yname" style="width:150px;" onchange="setdname(this.value)">
                                                                                <option value="0" >请选择</option> 
                                                                           </select>
                    
						                
                                                                        </div>
				                                                    </div> 
                                                                    <label class="col-sm-2 control-label no-padding-right" style="margin-left:90px;width:150px" for="">代销商名称</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">
                                    
                      
                                                                      <select class="select2" id="dname" style="width:150px;">
                                                                                <option value="0" >请选择</option> 
                                                                           </select>
                    
						                
                                                                        </div>
				                                                    </div> 
                                                                    </div>
                                                                     <div class="form-group">                                                                   
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:45px" for="">时间段</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix">
                                                                        <div class="col-sm-1">
											                                <div class="input-group input-medium">
                                                                             
												                                <input id="dstarttime" type="text" class="date date-picker" data-date-format="yyyy-mm-dd" style="height:28px;width:207px"  value="<%=times %>">
												                                <span class="input-group-btn ">
												                                <button class="btn default btn-sm" type="button"><i class="fa fa-calendar"></i></button>
												                                </span>
											                                </div>
											                              
										                                </div>
                      
                                                                        </div>
				                                                    </div>
                                                                    <label class="col-sm-1 control-label no-padding-right" style="margin-left:140px" for="">至</label>
				                                                    <div class="col-sm-1" style="margin-left:-20px">
                                                                        <div class="clearfix">
                                                                        <div class="col-sm-1">
											                                <div class="input-group input-medium">
                                                                             
												                                <input id="dendtime" type="text" class="date date-picker" data-date-format="yyyy-mm-dd" style="height:28px;width:207px" value="<%=times %>">
												                                <span class="input-group-btn ">
												                                <button class="btn default btn-sm" type="button"><i class="fa fa-calendar"></i></button>
												                                </span>
											                                </div>
											                              
										                                </div>
                                                                         
                                                                        </div>
				                                                    </div>
                                                                        <div class="col-sm-2" style="margin-left:250px">
						                                                    <a class="btn  btn-success" id="A2" onclick="search_data()"><i class="fa fa-search"></i> 搜索</a>
                                  
                                                                    </div> 
                                 
                                                                </div>
                                                  
                                                </form>
                                            </div>
                     
				                        </div>
			                        </div>
                                    </div>
			                        </div>
		                        </div>
                                    <div class="row" style="margin-top:10px">
				                                    <div class="col-md-12">
					                                    <!-- BEGIN EXAMPLE TABLE PORTLET-->
					                                    <div class="portlet box green-haze">
						                                    <div class="portlet-title">
							                                    <div class="caption">
								                                    <i class="fa fa-server"></i>代销商业绩
							                                    </div>
							
						                                    </div>
						                                    <div class="portlet-body">
							                                    <table class="table table-striped table-bordered table-hover" id="sample_3" style="text-align:center">
							                                    <thead>
							                                    <tr>
								                                    <th style="text-align:center">
									                                   代销商名称
								                                    </th>
								                                    <th style="text-align:center">
									                                   代销商业绩
								                                    </th>
								                                    
							                                    </tr>
							                                    </thead>
							                                    <tbody>
							                                    
							                                    </tbody>
							                                    </table>
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
					<!-- END ALERTS PORTLET-->
				</div>
                
   </div>

    


<div class="corner rc-bottomleft"></div>
<div class="corner rc-bottomright"></div>
    <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <script>
    var rootUri = "<%= ViewData["rootUri"] %>";
    var oTable1;
    var initTable1;
    var oTable2;
    var initTable2;
    var oTable3;
    var initTable3;
    jQuery(document).ready(function () {
            $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
            $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" }).on('change', function () { });
        //QuickSidebar.init(); // init quick sidebar
       
        initTable1();
        initTable2(); 
        initTable3();  
    });
    function addp()
    {
      location.href="<%= ViewData["rootUri"] %>PerformanceManagement/PerformanceDetail";
    }
   
function setyname(id)
{
    document.getElementById("yname").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>PerformanceManagement/GetallUser",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                      
                                         $("#yname").append("<option value=" + "0" + ">" + "全部" + "</option>");
                                   for (var s in data) {
                                    if (s == 0) {
                                        $("#yname").append("<option value=" + data[s].uid + ">" + data[s].realname + "</option>");
                                    } else {
                                        $("#yname").append("<option value=" + data[s].uid + ">" + data[s].realname + "</option>");
                                    }
                                }
                        $("#yname").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
                $("#yname").append("<option value=" + "0" + ">" + "全部" + "</option>");
                 $("#yname").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
            }
            setdname(0);
}
 function setdname(id)
{
    document.getElementById("dname").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>PerformanceManagement/GetallDUser",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                      
                                         $("#dname").append("<option value=" + "0" + ">" + "全部" + "</option>");
                                   for (var s in data) {
                                    if (s == 0) {
                                        $("#dname").append("<option value=" + data[s].uid + ">" + data[s].realname + "</option>");
                                    } else {
                                        $("#dname").append("<option value=" + data[s].uid + ">" + data[s].realname + "</option>");
                                    }
                                }
                        $("#dname").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
                $("#dname").append("<option value=" + "0" + ">" + "全部" + "</option>");
                 $("#dname").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
            }
}
function setyyname(id)
{
    document.getElementById("yyname").options.length = 0;
            if (id != 0) {
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>PerformanceManagement/GetallUser",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                      
                                         $("#yyname").append("<option value=" + "0" + ">" + "全部" + "</option>");
                                   for (var s in data) {
                                    if (s == 0) {
                                        $("#yyname").append("<option value=" + data[s].uid + ">" + data[s].realname + "</option>");
                                    } else {
                                        $("#yyname").append("<option value=" + data[s].uid + ">" + data[s].realname + "</option>");
                                    }
                                }
                        $("#yyname").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
                    }
                });
            } else {
                $("#yyname").append("<option value=" + "0" + ">" + "全部" + "</option>");
                 $("#yyname").css('width', '150px').select2({allowClear:true, minimumResultsForSearch: -1 });
            }
            //setdname(0);
}
 initTable1 = function () {
            var table = $('#sample_1');

            oTable1 = table.dataTable({
                //"bServerSide": true,
			    "bProcessing": true,
			    "sAjaxSource": rootUri + "PerformanceManagement/SerchOfficeperformance",
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
                    "zeroRecords": "没有发现",
                    "sProcessing":"正在搜索......"
                },
                "aoColumns": [
					 {"mDataProp": "officename","bSortable": false },	
                     {"mDataProp": "dperformance","bSortable": false },
                     {"mDataProp": "yperformance","bSortable": false },	
                     {"mDataProp": "ownsale","bSortable": false },
                     {"mDataProp": "cover","bSortable": false },
                     {"mDataProp": "allperformance","bSortable": false },	
                     {"mDataProp": "reachratio","bSortable": false },
                     {"mDataProp": "officesurplus","bSortable": false }  
				],
                "fnServerData": function(sSource, aoData, fnCallback){
                                      $.ajax({
                                          "dataType": 'json',
                                          "type": "POST",
                                          "url": sSource,
                                          "data":{"offname":$("#offname").val(), "ostarttime":$("#ostarttime").val(),"oendtime":$("#oendtime").val()} ,
                                           "success": fnCallback
                                     });
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
            "columnDefs": [
				        {
				            "targets" : 0,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                return data;
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 1,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"元";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 2,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"元";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 3,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"%";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 4,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"元";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 5,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"元";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 6,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"%";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 7,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"元";
				            }
				            //sClass: 'center'
				        }
                        
                    ],
              
            });

            var tableWrapper = $('#sample_1_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable2 = function () {
            var table = $('#sample_2');

            oTable2 = table.dataTable({
                //"bServerSide": true,
			    "bProcessing": true,
			    "sAjaxSource": rootUri + "PerformanceManagement/Serchdyperformance",
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
                    "zeroRecords": "没有发现",
                    "sProcessing":"正在搜索......"
                },
                "aoColumns": [
					 {"mDataProp": "yyname","bSortable": false },	
                     {"mDataProp": "dperformance","bSortable": false },
                     {"mDataProp": "yperformance","bSortable": false },	
                     {"mDataProp": "ownsale","bSortable": false },
                     {"mDataProp": "cover","bSortable": false },
                     {"mDataProp": "allperformance","bSortable": false },	
                     {"mDataProp": "reachratio","bSortable": false } 
				],
                "fnServerData": function(sSource, aoData, fnCallback){
                                      $.ajax({
                                          "dataType": 'json',
                                          "type": "POST",
                                          "url": sSource,
                                          "data":{"yofficename":$("#yofficename").val(), "yyname":$("#yyname").val(),"ystarttime":$("#ystarttime").val(),"yendtime":$("#yendtime").val()} ,
                                           "success": fnCallback
                                     });
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
            "columnDefs": [
				        {
				            "targets" : 0,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                return data;
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 1,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"元";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 2,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"元";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 3,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"%";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 4,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"元";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 5,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"元";
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 6,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data+"%";
				            }
				            //sClass: 'center'
				        }
                        
                    ],
              
            });

            var tableWrapper = $('#sample_2_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
       initTable3 = function () {
            var table = $('#sample_3');

            oTable3 = table.dataTable({
                //"bServerSide": true,
			    "bProcessing": true,
			    "sAjaxSource": rootUri + "PerformanceManagement/SerchdPerforance",
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
                    "zeroRecords": "没有发现",
                    "sProcessing":"正在搜索......"
                },
                "aoColumns": [
					 {"mDataProp": "dname","bSortable": false },	
                     {"mDataProp": "dperformance","bSortable": false } 
				],
                "fnServerData": function(sSource, aoData, fnCallback){
                                      $.ajax({
                                          "dataType": 'json',
                                          "type": "POST",
                                          "url": sSource,
                                          "data":{"officename":$("#officename").val(), "yname":$("#yname").val(),"dname":$("#dname").val(),"dstarttime":$("#dstarttime").val(),"dendtime":$("#dendtime").val()} ,
                                           "success": fnCallback
                                     });
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
            "columnDefs": [
				        {
				            "targets" : 0,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				                return data;
				            }
				            //sClass: 'center'
				        },
                        {
				            "targets" : 1,    // Column number which needs to be modified
				            "render" : function(data, type, row) {   // o, v contains the object and value for the column
				               return data;
				            }
				            //sClass: 'center'
				        }
                        
                    ],
              
            });

            var tableWrapper = $('#sample_3_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
    
    function search_data() {
     
         oTable3.fnDestroy();  
            initTable3();
           
            }
    function search_data2() {
     
         oTable2.fnDestroy();  
            initTable2();
            $("#downexcel").attr("href",rootUri + "PerformanceManagement/YPgExcel/?yofficename="+$("#yofficename").val()+"&yyname="+$("#yyname").val()+"&ystarttime="+$("#ystarttime").val()+"&yendtime="+$("#yendtime").val()); 
            }
    function search_data3() {
     
         oTable1.fnDestroy();  
            initTable1();
           $("#download").attr("href",rootUri + "PerformanceManagement/GetPgExcel/?offname="+$("#offname").val()+"&ostarttime="+$("#ostarttime").val()+"&oendtime="+$("#oendtime").val()); 
            }
function sendmanageoffice()
{

                $.ajax({
                    url: "<%= ViewData["rootUri"] %>PerformanceManagement/SendManageOffice",
                    method: 'post',
                    success: function (data) {
                      if (data==true) {    
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
				            toastr["success"]("推送成功!", "恭喜您");
                             setTimeout(function () {
                                   oTable.fnDestroy();  
                                   initTable1();
                              }, 2500);
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

				            toastr["error"]("推送失败,请仔细查看相关办事处主任用户是否存在!", "温馨敬告");
                        
                         }
                    }
                });

}
function sendmanagehead()
{
                $.ajax({
                    url: "<%= ViewData["rootUri"] %>PerformanceManagement/SendManageHead",
                    method: 'post',
                    success: function (data) {
                      if (data==true) {    
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
				            toastr["success"]("推送成功!", "恭喜您");
                             setTimeout(function () {
                                   oTable.fnDestroy();  
                                   initTable1();
                              }, 2500);
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

				            toastr["error"]("推送失败!", "温馨敬告");
                        
                         }
                    }
                });

}
    </script>


</asp:Content>


    

    
