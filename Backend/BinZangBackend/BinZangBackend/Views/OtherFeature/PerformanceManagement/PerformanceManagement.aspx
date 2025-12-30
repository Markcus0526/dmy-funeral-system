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
                            <button class="btn btn-success btn-sm" id="add" onclick="addp()" style="margin-top:-7px;margin-left:0px"/>
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
                                    
                      
                                                                      <select class="select2" style="width:150px;">
                                                                                <option value="0" >全部</option> 
                                                                           </select>
                    
						                
                                                                        </div>
				                                                    </div>                                                                    
                                                                    
                                                            <% string times = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day; %>
                                                            <label class="col-sm-1 control-label no-padding-right" style="margin-left:65px" for="">时间段</label>
				                                                    <div class="col-sm-1" style="margin-left:-30px">
                                                                        <div class="clearfix">
                                                                        <div class="col-sm-1">
											                                <div class="input-group input-medium">
                                                                             
												                                <input type="text" class="date date-picker" data-date-format="dd-mm-yyyy" style="height:28px;width:207px"  data-date-start-date="+0d" value="<%=times %>">
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
                                                                             
												                                <input type="text" class="date date-picker" data-date-format="dd-mm-yyyy" style="height:28px;width:207px"  data-date-start-date="+0d" value="<%=times %>">
												                                <span class="input-group-btn ">
												                                <button class="btn default btn-sm" type="button"><i class="fa fa-calendar"></i></button>
												                                </span>
											                                </div>
											                              
										                                </div>
                      
                                                                        </div>
				                                                    </div>
                                                                        <div class="col-sm-2" style="margin-left:190px">
						                                                    <a class="btn  btn-success" id="A3" onclick=""><i class="fa fa-search"></i> 搜索</a>
                                  
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
							
						                                    </div>
						                                    <div class="portlet-body">
							                                    <table class="table table-striped table-bordered table-hover" id="sample_1" style="text-align:center">
							                                    <thead>
							                                    <tr>
								                                    <th style="text-align:center">
									                                    墓地编号 
								                                    </th>
								                                    <th style="text-align:center">
									                                     墓地价格
								                                    </th>
								                                    <th>
									                                     墓地位置
								                                    </th>
								                                    <th style="text-align:center">
									                                     墓地图片
								                                    </th>
								                                    <th style="text-align:center">
									                                     购买状态
								                                    </th>
                                
								                                    <th style="text-align:center">
									                                     操作
								                                    </th>
							                                    </tr>
							                                    </thead>
							                                    <tbody>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href=""><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
								
							                                    </tr>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href="#responsive"><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
							                                    </tr>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href="#responsive"><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
							                                    </tr>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href="#responsive"><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
							                                    </tr>
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
                                    
                      
                                                                      <select class="select2" style="width:150px;">
                                                                                <option value="0" >全部</option> 
                                                                           </select>
                    
						                
                                                                        </div>
				                                                    </div> 
                                                                    
                                                                    <label class="col-sm-2 control-label no-padding-right" style="margin-left:90px;width:150px" for="">员工姓名</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">
                                    
                      
                                                                      <select class="select2" style="width:150px;">
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
                                                                             
												                                <input type="text" class="date date-picker" data-date-format="dd-mm-yyyy" style="height:28px;width:207px"  data-date-start-date="+0d" value="<%=times %>">
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
                                                                             
												                                <input type="text" class="date date-picker" data-date-format="dd-mm-yyyy" style="height:28px;width:207px"  data-date-start-date="+0d" value="<%=times %>">
												                                <span class="input-group-btn ">
												                                <button class="btn default btn-sm" type="button"><i class="fa fa-calendar"></i></button>
												                                </span>
											                                </div>
											                              
										                                </div>
                      
                                                                        </div>
				                                                    </div>
                                                                        <div class="col-sm-2" style="margin-left:250px">
						                                                    <a class="btn  btn-success" id="A1" onclick=""><i class="fa fa-search"></i> 搜索</a>
                                  
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
									                                    墓地编号 
								                                    </th>
								                                    <th style="text-align:center">
									                                     墓地价格
								                                    </th>
								                                    <th>
									                                     墓地位置
								                                    </th>
								                                    <th style="text-align:center">
									                                     墓地图片
								                                    </th>
								                                    <th style="text-align:center">
									                                     购买状态
								                                    </th>
                                
								                                    <th style="text-align:center">
									                                     操作
								                                    </th>
							                                    </tr>
							                                    </thead>
							                                    <tbody>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href=""><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
								
							                                    </tr>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href="#responsive"><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
							                                    </tr>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href="#responsive"><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
							                                    </tr>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href="#responsive"><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
							                                    </tr>
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
                                    
                      
                                                                      <select class="select2" style="width:150px;">
                                                                                <option value="0" >全部</option> 
                                                                           </select>
                    
						                
                                                                        </div>
				                                                    </div> 
                                                                    
                                                                    <label class="col-sm-2 control-label no-padding-right" style="margin-left:90px;width:150px" for="">员工姓名</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">
                                    
                      
                                                                      <select class="select2" style="width:150px;">
                                                                                <option value="0" >全部</option> 
                                                                           </select>
                    
						                
                                                                        </div>
				                                                    </div> 
                                                                    <label class="col-sm-2 control-label no-padding-right" style="margin-left:90px;width:150px" for="">办事处名称</label>
				                                                    <div class="col-sm-1" style="margin-left:-10px">
                                                                        <div class="clearfix" style="width:150px">
                                    
                      
                                                                      <select class="select2" style="width:150px;">
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
                                                                             
												                                <input type="text" class="date date-picker" data-date-format="dd-mm-yyyy" style="height:28px;width:207px"  data-date-start-date="+0d" value="<%=times %>">
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
                                                                             
												                                <input type="text" class="date date-picker" data-date-format="dd-mm-yyyy" style="height:28px;width:207px"  data-date-start-date="+0d" value="<%=times %>">
												                                <span class="input-group-btn ">
												                                <button class="btn default btn-sm" type="button"><i class="fa fa-calendar"></i></button>
												                                </span>
											                                </div>
											                              
										                                </div>
                      
                                                                        </div>
				                                                    </div>
                                                                        <div class="col-sm-2" style="margin-left:250px">
						                                                    <a class="btn  btn-success" id="A2" onclick=""><i class="fa fa-search"></i> 搜索</a>
                                  
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
							                                    <table class="table table-striped table-bordered table-hover" id="sample_3" style="text-align:center">
							                                    <thead>
							                                    <tr>
								                                    <th style="text-align:center">
									                                    墓地编号 
								                                    </th>
								                                    <th style="text-align:center">
									                                     墓地价格
								                                    </th>
								                                    <th>
									                                     墓地位置
								                                    </th>
								                                    <th style="text-align:center">
									                                     墓地图片
								                                    </th>
								                                    <th style="text-align:center">
									                                     购买状态
								                                    </th>
                                
								                                    <th style="text-align:center">
									                                     操作
								                                    </th>
							                                    </tr>
							                                    </thead>
							                                    <tbody>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href=""><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
								
							                                    </tr>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href="#responsive"><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
							                                    </tr>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href="#responsive"><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
							                                    </tr>
							                                    <tr>
								                                    <td>
									                                    10排10号
								                                    </td>
								                                    <td>
									                                     50000元
								                                    </td>
								                                    <td>
									                                     A区
								                                    </td>
								                                    <td>
									                                    <img src="">
								                                    </td>
								                                    <td>
									                                    未出售
								                                    </td>
                                                                    <td>
									                                     <a class="btn btn-success btn-sm" data-toggle="modal" href="#responsive"><i class="fa fa-pencil-square-o"></i>编辑</a>
								                                    </td>
							                                    </tr>
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
    <script src="../../assets/admin/pages/scripts/ui-extended-modals.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
    <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <script>
    function addp()
    {
      location.href="<%= ViewData["rootUri"] %>PerformanceManagement/PerformanceDetail";
    }
    jQuery(document).ready(function () {
     UIExtendedModals.init();
            $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
            $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" });
        //QuickSidebar.init(); // init quick sidebar
        var initTable1 = function () {
            var table = $('#sample_1');

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

            var tableWrapper = $('#sample_1_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         var initTable2 = function () {
            var table = $('#sample_2');

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

            var tableWrapper = $('#sample_2_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
        var initTable3 = function () {
            var table = $('#sample_3');

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

            var tableWrapper = $('#sample_2_wrapper'); // datatable creates the table wrapper by adding with id {your_table_jd}_wrapper

            tableWrapper.find('.dataTables_length select').select2(); // initialize select2 dropdown
        }
         initTable1();
        initTable2(); 
        initTable3();  
    });
    
    </script>


</asp:Content>


    

    
