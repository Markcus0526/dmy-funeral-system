<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<div class="example t-vista" style="margin-top:20px">
     <div class="portlet box green" >
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-pencil-square-o"></i>园区信息修改
							</div>
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#portlet_tab2_1" data-toggle="tab">
									公司简介 </a>
								</li>
								<li>
									<a href="#portlet_tab2_2" data-toggle="tab">
									购墓流程 </a>
								</li>
								<li class="">
									<a href="#portlet_tab2_3" data-toggle="tab">
									购墓注意事项 </a>
								</li>
                                <li class="">
									<a href="#portlet_tab2_4" data-toggle="tab">
									落葬习俗 </a>
								</li>
                                <li class="">
									<a href="#portlet_tab2_5" data-toggle="tab">
								殡葬新闻 </a>
								</li>
							</ul>
						</div>
						<div class="portlet-body">
							<div class="tab-content">
								<div class="tab-pane active" id="portlet_tab2_1">
		                         
                                <div>
                                    <textarea id="contents" name="contents" style="width:77%;height:600px; resize:none;" rows="8"></textarea>
                                </div>
                                 
                                <div style="float: right;margin-top:-600px;margin-left:10px">
                                    <div style="margin-left:10px" >
                                     服务热线：
                                     <br />
                                     <br />
                                     <input id="servicephone" type="text" value="<%=ViewData["phone"] %>" />
                                     </div>
                                    
                                   <br />
                                   <div style="margin-left:30px">
                                   <img src="<%=ViewData["rootUri"] %><%=ViewData["curl"] %>" id = "picture" style="margin-left:-20px" height="150px" width="156px"/>	
                                   <input type="hidden" id="img" class="img"  name="img" value="<% if (ViewData["curl"] != null) { %><%= ViewData["curl"] %><% } %>" />
                                   <br />
                                   <br />
                                   <input type="file" class="upfiles" id="uploadify" name="carImg2" />
                                   
                                    <span style="color:red">**温馨提示:请选择文件大小</span><br />
                                     <span style="color:red">在500kb以内的图片**</span>
                                     </div>
                                    <input id="text1" readonly="readonly" style="margin-top:10px;text-align:center;width:50%;height:20px; border-style:none;display:none;margin-left:50px;color: Red" />
                                    <button class="btn btn-success loading-btn" id="subcompany" onclick="return CompanyOnSubmit();" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    保存
							                    </button>
                                                &nbsp;
                                                           <button id="sett" class="btn" type="reset" onclick="location.href='<%= ViewData["rootUri"] %>Home/Index'" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    返回
							                    </button>
                                </div>   
                        
								</div>
								<div class="tab-pane" id="portlet_tab2_2">
									
                                <div>
                                    <textarea id="contents1" name="contents" style="width:80%;height:600px; resize:none;" rows="8"></textarea>
                                </div>
                                <div style="float: right;margin-top:-600px;margin-left:10px">
                             
                                    <button class="btn btn-success loading-btn" onclick="return FlowOnSubmit();"  style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    保存
							                    </button>
                                                &nbsp;
                                                           <button id="sett" class="btn" type="reset" onclick="location.href='<%= ViewData["rootUri"] %>Home/Index'" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    返回
							                    </button>
                                </div>   
                      
								</div>
								<div class="tab-pane" id="portlet_tab2_3">
									
                                <div>
                                    <textarea id="contents2" name="contents" style="width:80%;height:600px; resize:none;" rows="8"></textarea>
                                </div>
                                <div style="float: right;margin-top:-600px;margin-left:10px">
                                   
                                    <button class="btn btn-success loading-btn" onclick="return MattersOnSubmit();" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    保存
							                    </button>
                                                &nbsp;
                                                           <button id="sett" class="btn" type="reset" onclick="location.href='<%= ViewData["rootUri"] %>Home/Index'" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    返回
							                    </button>
                                </div>   
                        
								</div>
                                <div class="tab-pane" id="portlet_tab2_4">
									 <div>
                                      <textarea id="contents3" name="contents" style="width:80%;height:600px; resize:none;" rows="8"></textarea>
                                     </div>
                                <div style="float: right;margin-top:-600px;margin-left:10px">
                                   <div style="display:none;margin-top:50px;" id="caozuo">
                                     习俗名称:<input type="text" id="xisuname" style="width:150px;"/>
                                     <br />
                                     <br />
                                     <input type="hidden" id="uid" style="width:150px;" value="0"/>
                                    <button class="btn btn-success loading-btn" onclick="return XisuOnSubmit();" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    保存
							                    </button>
                                                &nbsp;
                                                           <button id="lzset" class="btn" type="reset" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    返回
							                    </button>
                                    </div>
                                    
					<!-- BEGIN ALERTS PORTLET-->
					<div class="portlet green box" id="notes" style="width:200px;height:600px">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-cogs"></i>落葬习俗
							</div>
							<div class="tools">
                                <select class="select2" style="width:100px" onchange="setxisu(this.value)">
                                             <option value="0" >全部</option>
                               <%
                                   for (int i = 0; i < ViewBag.allxisu.Count; i++)
                              {   
                                   %>
                               <option value="<%=ViewBag.allxisu[i].uid %>_<%=ViewBag.allxisu[i].note %>" ><%=ViewBag.allxisu[i].note %></option>
                               <% }%> 
                                       </select>
                                <button class="btn btn-success btn-sm" id="add" style="margin-top:5px;margin-left:0px">
								                   <i class="fa fa-plus"></i> 新增
							    </button>
							</div>
                           
						</div>
						<div class="portlet-body">
							<%--<div class="note note-success">
								
							</div>
							<div class="note note-info">
								
							</div>
                            <div class="note note-warning">
								
							</div>--%>
                             
                            <div style="height:400px;overflow-y:auto;">
							    <div class="alert alert-warning" id="xisuxiangqing">
                                <%
                                   for (int i = 0; i < ViewBag.allxisu.Count; i++)
                              {   
                                   %>
                                    <a class="btn green btn-block" id="<%=ViewBag.allxisu[i].uid %>" onclick="getonexisu(this.id)"  href="#" style="margin-top:5px;margin-left:0px">
								                  <%=ViewBag.allxisu[i].note%>
							                    </a>
                               <% }%> 
                                            
								    
                                              
							    </div>

							</div>
						
					</div>
					<!-- END ALERTS PORTLET-->
				</div>

                                </div>
								</div>
                                <div class="tab-pane" id="portlet_tab2_5">
                                <div style="margin-left:200px">
                                
                                落葬信息连接&nbsp;<input type="text" id="link_url" style="width:250px" value="<%=ViewData["bingzanglink"] %>" />

									 <button class="btn btn-success loading-btn" onclick="return ();" style="margin-top:10px;margin-left:50px">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    保存
							                    </button>
                                                &nbsp;
                                                           <button id="lzset" class="btn" type="reset" onclick="location.href='<%= ViewData["rootUri"] %>Home/Index'" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    返回
							                    </button>
                                                </div>
                                    </div>
								</div>
							</div>
						</div>
					</div>
    
</div>

<div class="corner rc-bottomleft"></div>
<div class="corner rc-bottomright"></div>
<script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
<script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/kindeditor.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/lang/zh_CN.js"></script>
    <script charset="utf-8" src="<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.js"></script>
    <script src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>    
<script type="text/javascript">
    var editor;
    var editor1;
    var editor2;
    var editor3;
    var rootUri = "<%= ViewData["rootUri"] %>";

    KindEditor.ready(function (K) {
        editor = K.create('#contents', {
            cssPath: '<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.css',
            uploadJson: '<%= ViewData["rootUri"] %>ZoneInformation/UploadKindEditorImageT',
            fileManagerJson: '<%= ViewData["rootUri"] %>ZoneInformation/ProcessKindEditorRequestT',
            allowFileManager: true,
            urlType : 'domain',
            afterCreate: function () {
                var self = this;
                K.ctrl(document, 13, function () {
                    self.sync();
                    //K('form[name=profileform]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                    //K('form[name=profileform]')[0].submit();
                });
            }
        });
    });
    KindEditor.ready(function (K) {
        editor1 = K.create('#contents1', {
            cssPath: '<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.css',
            uploadJson: '<%= ViewData["rootUri"] %>ZoneInformation/UploadKindEditorImageT',
            fileManagerJson: '<%= ViewData["rootUri"] %>ZoneInformation/ProcessKindEditorRequestT',
            allowFileManager: true,
            urlType : 'domain',
            afterCreate: function () {
                var self = this;
                K.ctrl(document, 13, function () {
                    self.sync();
                   // K('form[name=profileform]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                    //K('form[name=profileform]')[0].submit();
                });
            }
        });
    });
    KindEditor.ready(function (K) {
        editor2 = K.create('#contents2', {
            cssPath: '<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.css',
            uploadJson: '<%= ViewData["rootUri"] %>ZoneInformation/UploadKindEditorImageT',
            fileManagerJson: '<%= ViewData["rootUri"] %>ZoneInformation/ProcessKindEditorRequestT',
            allowFileManager: true,
            urlType : 'domain',
            afterCreate: function () {
                var self = this;
                K.ctrl(document, 13, function () {
                    self.sync();
                   // K('form[name=profileform]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                   // K('form[name=profileform]')[0].submit();
                });
            }
        });
    });
    KindEditor.ready(function (K) {
        editor3 = K.create('#contents3', {
            cssPath: '<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.css',
            uploadJson: '<%= ViewData["rootUri"] %>ZoneInformation/UploadKindEditorImageT',
            fileManagerJson: '<%= ViewData["rootUri"] %>ZoneInformation/ProcessKindEditorRequestT',
            allowFileManager: true,
            urlType : 'domain',
            afterCreate: function () {
                var self = this;
                K.ctrl(document, 13, function () {
                    self.sync();
                   // K('form[name=profileform]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                   // K('form[name=profileform]')[0].submit();
                });
            }
        });
    });

   $(document).ready(function () {
            $(".select2").css('width', '150px').select2();

            var recvcontents =  "<%= ViewData["gongsijianjie"] %>";
            var conthtml = unescape(recvcontents);
            $("#contents").html(conthtml);
            if (editor != undefined) {
             editor.html(conthtml);
                editor.sync();
            }
            var recvcontents1 =  "<%= ViewData["goumuliucheng"] %>";
            var conthtml1 = unescape(recvcontents1);
            $("#contents1").html(conthtml1);
            if (editor1 != undefined) {
             editor1.html(conthtml1);
                editor1.sync();
            }
            var recvcontents2 =  "<%= ViewData["goumuzhuyishixiang"] %>";
            var conthtml2 = unescape(recvcontents2);
            $("#contents2").html(conthtml2);
            if (editor2 != undefined) {
             editor2.html(conthtml2);
                editor2.sync();
            }
            var recvcontents3 =  "<%= ViewData["luozangxisu"] %>";
            var conthtml3 = unescape(recvcontents3);
            $("#contents3").html(conthtml3);
            if (editor3 != undefined) {
            //editor3.readonly(true);
             editor3.html(conthtml3);
             
                editor3.sync();
            }

          $("#add").click(function(){
             $("#notes").hide();
             $("#caozuo").show();
             editor3.html("");
             editor3.sync();


         });
          $("#lzset").click(function(){
             $("#notes").show();
             $("#caozuo").hide();
             $("#uid").val("0");
             $("#xisuname").val("");
            var conthtml3 = unescape(recvcontents3);
            $("#contents3").html(conthtml3);
            if (editor3 != undefined) {
            //editor3.readonly(true);
             editor3.html(conthtml3);
             
                editor3.sync();
            }
         });
         $('#uploadify').uploadify({
                'buttonText': "<i class='ace-icon fa fa-book'></i> &nbsp;选择图片",
                'queueSizeLimit': 999,  //设置上传队列中同时允许的上传文件数量，默认为999
                'uploadLimit': 999,   //设置允许上传的文件数量，默认为999
                'swf': rootUri + 'Content/js/uploadify/uploadify.swf',
                 //'auto': false,
	            'fileTypeExts': '*.jpg;*.png;*.jpeg',
	            'fileTypeDesc': 'Image Files (.jpg,.png,*.jpeg)',
	            'fileSizeLimit': '500KB',
                'onSelectError' : function (file, errorCode, errorMsg) {
                          if(errorCode=="-110")
                          {
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

				        toastr["error"]("超过文件上传大小限制（500kb）!", "温馨敬告");
                          }
                      },
                'uploader': rootUri + 'ZoneInformation/UploadifyActivityImage',
                'onUploadComplete': function (file) {   //单个文件上传完成时触发事件
                    //alert('The file ' + file.name + ' finished processing.');
                },
                'onQueueComplete': function (queueData) {   //队列中全部文件上传完成时触发事件
                    //   alert(queueData.uploadsSuccessful + ' files were successfully uploaded.');
                },
                'onUploadSuccess': function (file, data, response) {    //单个文件上传成功后触发事件                                     
                    //alert('文件 ' + file.name + ' 已经上传成功，并返回 ' + response + ' 保存文件名称为 ' + data.SaveName);
                    data = data.replace(/\"/,"");
                    data = data.replace(/\"/,"");
                    $("#img").val(data);
                    $("#picture").attr("src", "<%= ViewData["rootUri"] %>"+ data);
                    
                }
            });
        });
        function setxisu(id) {
           if(id!=0)
           {
           var id1 = document.getElementById("xisuxiangqing");
              id1.innerHTML="";
             var a=new Array();
             a=id.split('_');
             var b="";
             for(var i=1;i<a.length;i++)
             {
               b+=a[i];
             }
             $("#xisuxiangqing").append( '<a class="btn green btn-block" id="'+a[0]+'" onclick="getonexisu(this.id)"  href="#" style="margin-top:5px;margin-left:0px">'+b+'</a>');
           }else{
           $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/GetAllxisu",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                    if(data!=null&&data!="")
                    {
                       for(var i=1;i<data.length;i++)
                         {
                          $("#xisuxiangqing").append( '<a class="btn green btn-block" id="'+data[i].uid+'" onclick="getonexisu(this.id)"  href="#" style="margin-top:5px;margin-left:0px">'+data[i].note+'</a>');
                         }
                         
                     }
                    else
                    {
                        toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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

				        toastr["error"]("这个习俗没有添加详情!", "温馨敬告");
                    }
                    }
                });
            }
         
        }
        function getonexisu(id){
              $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/Getonexisu",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                    if(data!=null&&data!="")
                    {
                      $("#uid").val(data.uid);
                      $("#xisuname").val(data.note);
                       var conthtml4 = unescape(data.html_content);
                        $("#contents3").html(conthtml4);
                        if (editor3 != undefined) {
                        //editor3.readonly(true);
                         editor3.html(conthtml4);
             
                                editor3.sync();
                            }
                      $("#notes").hide();
                      $("#caozuo").show();
                    }
                    else
                    {
                        toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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

				        toastr["error"]("这个习俗没有添加详情!", "温馨敬告");
                    }
                    }
                });
             
         };
         function check1(){
           var imageurl=$("#img").val();
                if (imageurl!=null&&imageurl!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请上传公司图片！");
                return false;
              }
      }
      function check2(){
           var phone=$("#servicephone").val();
               if (phone!=null&&phone!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
                document.getElementById("text1").style.display="block";
                $('#text1').val("请填写公司热线电话！");
                return false;
              }
      }
        function CompanyOnSubmit() {
        if(check1()==true)
        {
            editor.sync();            

            $.ajax({
                type: "POST",
                url: rootUri + "ZoneInformation/UpdateProfile",
                dataType: "json",
                data: {
                    img:$("#img").val(),
                    phone:$("#servicephone").val(),
                    introduce: escape($("#contents").val())
                },
                success: function (str) {
                      if (str==true) {    
                             toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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
				            "positionClass": "toast-bottom-right",
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
            }
        }

        function FlowOnSubmit() {
            editor1.sync();            

            $.ajax({
                type: "POST",
                url: rootUri + "ZoneInformation/UpdateFlow",
                dataType: "json",
                data: {
                    introduce: escape($("#contents1").val())
                },
                success: function (str) {
                      if (str==true) {    
                             toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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
				            "positionClass": "toast-bottom-right",
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


        }
        function MattersOnSubmit() {
            editor2.sync();            

            $.ajax({
                type: "POST",
                url: rootUri + "ZoneInformation/UpdateMatters",
                dataType: "json",
                data: {
                    introduce: escape($("#contents2").val())
                },
                success: function (str) {
                      if (str==true) {    
                             toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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
				            "positionClass": "toast-bottom-right",
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


        }
        function XisuOnSubmit() {
            editor3.sync();            

            $.ajax({
                type: "POST",
                url: rootUri + "ZoneInformation/UpdateXisu",
                dataType: "json",
                data: {
                    xisuname:$("#xisuname").val(),
                    uid: $("#uid").val(),
                    introduce: escape($("#contents3").val())
                },
                success: function (str) {
                      if (str==true) {    
                             toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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
                          setTimeout(function () {
                               window.location.reload();
                          }, 2500);
                        }
                     else{
                        
                        toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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


        }
        function LuozangLink() {           

            $.ajax({
                type: "POST",
                url: rootUri + "ZoneInformation/UpdateXisu",
                dataType: "json",
                data: {
                    link: escape($("#link_url").val())
                },
                success: function (str) {
                      if (str==true) {    
                             toastr.options = {
				            "closeButton": false,
				            "debug": true,
				            "positionClass": "toast-bottom-right",
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
				            "positionClass": "toast-bottom-right",
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


        }
        function htmlencode(str) {
            return str.replace(/[&<>"']/g, function($0) {
                return "&" + {"&":"amp", "<":"lt", ">":"gt", '"':"quot", "'":"#39"}[$0] + ";";
            });
        }

</script>


</asp:Content>


    

    