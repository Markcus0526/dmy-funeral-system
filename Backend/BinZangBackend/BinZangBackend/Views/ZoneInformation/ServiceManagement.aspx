<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<div class="example t-vista" style="margin-top:20px">
     <div class="portlet box green" >
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-pencil-square-o"></i>服务类商品
							</div>
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#portlet_tab2_1" data-toggle="tab">
									落葬服务 </a>
								</li>
								<li>
									<a href="#portlet_tab2_2" data-toggle="tab">
									代祭拜服务 </a>
								</li>
								<li class="">
									<a href="#portlet_tab2_3" data-toggle="tab">
									祭品代购服务 </a>
								</li>
							</ul>
						</div>
						<div class="portlet-body">
							<div class="tab-content">
								
								<div class="tab-pane" id="portlet_tab2_2">
									
                                <div>
                                    <textarea id="contents1" name="contents1" style="width:83%;height:600px; resize:none;" rows="8"></textarea>
                                </div>
                                <div style="float: right;margin-top:-600px;margin-left:10px">
                             
                                    <button class="btn btn-success loading-btn" onclick="DOnSubmit();" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    保存
							                    </button>
                                                &nbsp;
                                                           <button id="sett" class="btn" type="reset" onclick="javascript:history.go(-1);" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    返回
							                    </button>
                                </div>   
                      
								</div>
								<div class="tab-pane" id="portlet_tab2_3">
									
                                <div>
                                    <textarea id="contents2" name="contents2" style="width:83%;height:600px; resize:none;" rows="8"></textarea>
                                </div>
                                <div style="float: right;margin-top:-600px;margin-left:10px">
                                   
                                    <button class="btn btn-success loading-btn" onclick="JOnSubmit();" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    保存
							                    </button>
                                                &nbsp;
                                                           <button id="sett" class="btn" type="reset" onclick="javascript:history.go(-1);" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    返回
							                    </button>
                                </div>   
                        
								</div>
                                <div class="tab-pane active" id="portlet_tab2_1">
                                <form class="form-horizontal" role="form" id="validation-form">
                                     <div id="xuanze" style="width:80%;height:700px;border:1px solid #3B9C96">
                                     <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
                                       <span style="margin-top:150px;font-size:35px;margin-left:18%">请在右边选择要编辑的落葬服务或增加！</span>
                                     </div>
									 <div id="luoznagdetail" style="display:none;">
                                     
                                      <table cellpadding="0" style="margin-top:20px;" cellspacing="0"width="77%" class="editDlg" class="table table-striped table-bordered table-hover no-margin-bottom no-border-top">
                                <tr>
                                    <td style="width:200px;text-align:right;" >
                                        <label>服务名称：</label>
                                    </td>
                                    <td>
                                        <div>
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td>
                                                         <div class="form-group" style="margin-left:10px">   
                                                         <div class="clearfix">                                             	  
                                                          <input id="sname" type="text" class="activityname" name="sname"/>
                                                          <input type="hidden" id="uid" name="uid">
                                                          </div>
                                                         </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                               
                                <tr>
                                    <td style="text-align:right">
                                        <label style="width:100px">服务价格：</label>
                                        
                                    </td>
                                    <td>
                                     <div class="form-group" style="margin-left:10px">
                                     <div class="clearfix">  
                                           <input id="price" name="price" type="text"  /> 
                                           </div>
                                      </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:right;">
                                        <label>服务图片：</label>

                                    </td>
                                    <td style="text-align:right;">
                                        <div style="margin-top:0px;margin-left:20px">
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td align="left">
                                                    <div class="form-group" style="margin-left:10px">
                                                       <div class="clearfix">  
                                                        <div id="advertCarImg" class="form-group" style="width:160px; border:2px solid #BBB;">
                                                         <img src="" id = "picture" height="150px" width="156px"/>	
                                                         <input type="hidden" id="img2" class="img2"  name="img2" value="" />
                                                         </div>
                                                         </div>
                                                      </div>
                                                    </td>
                                                    <td style="text-align:left;">
                                                    <div class="form-group" style="margin-left:60px">
                                                        <input type="file" class="upfiles" id="uploadify2" name="carImg2" />
                                                   </div>
                                                   <span style="color:red;margin-left:30px">**提示:请选择小于500kb的图片**</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                 <tr>
                                    <td style="text-align:right;">
                                        <label>服务视频：</label>

                                    </td>
                                    <td style="text-align:right;">
                                        <div style="margin-top:-10px;">
                                            <table cellpadding=0 cellspacing=0 width="100%">
                                                <tr>
                                                    <td align="left">
                                                    <div class="form-group" style="margin-left:10px">
                                                    
                                                     <video id="video" src="#" width="300" height="240" controls>
                                                         
                                                           
                                                     </video>
                                                         	
                                                         <input type="hidden" id="img" class="img"  name="img" value="" />
                                                         
                                                      </div>
                                                    </td>
                                                    <td style="text-align:left;">
                                                    <div class="form-group" style="margin-left:10px">
                                                        <input type="file" class="upfiles" id="uploadify" name="carImg2" />
                                                        
                                                   </div>
                                                   <div style="margin-left:0px">
                                                       <span style="color:red" >**提示:请选择文件小于50MB的MP4视频**</span>
                                                   </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                
                                <tr>
                                
                                    <td style="text-align:right;">
                                        <label>服务详情：</label>
                                    </td>
                                    <td>
                                    <div class="form-group" style="margin-top:0px;margin-left:10px">
                                    <div class="clearfix">  
                                      <textarea id="servicedetail" class="servicedetail"  name="servicedetail" style="width:350px;height:200px;" rows="8"></textarea>
                                   </div>
                                   </div>
                                   </td>
                                </tr>
                                
                            </table>
                           
                           </div>
                                <div style="float: right;margin-top:-700px;margin-left:10px;">
                                   <div style="display:none;" id="caozuo">
                                    <input id="text1" readonly="readonly" style="margin-top:-8px;text-align:center;width:50%;height:20px; border-style:none;display:none;margin-left:200px;color: Red" />
                                    <button class="btn btn-success loading-btn" id="sub" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    保存
							                    </button>
                                                &nbsp;
                                                           <button id="lzset" class="btn" type="reset" style="margin-top:10px;margin-left:10px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    返回
							                    </button>
                                    </div>
                           </form>          
					<!-- BEGIN ALERTS PORTLET-->
					<div class="portlet green box" id="notes" style="width:200px;height:600px;">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-cogs"></i>落葬服务
							</div>
							<div class="tools">
                                <select class="select2" style="width:100px" onchange="setluozang(this.value)">
                                             <option value="0" >全部</option>
                               <%
                                   for (int i = 0; i < ViewBag.allluozang.Count; i++)
                                  {   
                                   %>
                               <option value="<%=ViewBag.allluozang[i].uid %>_<%=ViewBag.allluozang[i].name %>" ><%=ViewBag.allluozang[i].name%></option>
                               <% }
                                   %> 
                                       </select>
                                       
                                <button class="btn btn-success btn-sm" type="reset" id="add" style="margin-top:5px;margin-left:0px">
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
							    <div class="alert alert-warning" id="luozangfuwu">
                                <%

                                    for (int i = 0; i < ViewBag.allluozang.Count; i++)
                              {   
                                   %>
                                    <a class="btn green btn-block" id="<%=ViewBag.allluozang[i].uid %>" onclick="Getoneluozang(this.id)"  href="#" style="margin-top:5px;margin-left:0px">
								                  <%=ViewBag.allluozang[i].name%>
							                    </a>
                               <% }
                                    %> 
                                            
								    
                                              
							    </div>

							</div>
						
					</div>
					<!-- END ALERTS PORTLET-->
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
    var editor1;
    var editor2;
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
                    K('form[name=profileform]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                    K('form[name=profileform]')[0].submit();
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
                    K('form[name=profileform]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                    K('form[name=profileform]')[0].submit();
                });
            }
        });
    });
 var rootUri="<%=ViewData["rootUri"] %>";
 function setluozang(id) {
           if(id!=0)
           {
           var id1 = document.getElementById("luozangfuwu");
              id1.innerHTML="";
             var a=new Array();
             a=id.split('_');
             var b="";
             for(var i=1;i<a.length;i++)
             {
               b+=a[i];
             }
             $("#luozangfuwu").append( '<a class="btn green btn-block" id="'+a[0]+'" onclick="Getoneluozang(this.id)"  href="#" style="margin-top:5px;margin-left:0px">'+b+'</a>');
           }else{
           $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/GetAllluozang",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                    if(data!=null&&data!="")
                    {
                       for(var i=1;i<data.length;i++)
                         {
                          $("#luozangfuwu").append( '<a class="btn green btn-block" id="'+data[i].uid+'" onclick="Getoneluozang(this.id)"  href="#" style="margin-top:5px;margin-left:0px">'+data[i].name+'</a>');
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

				        toastr["error"]("这个落葬服务没有添加详情!", "温馨敬告");
                    }
                    }
                });
            }
         
        }
  function Getoneluozang(id){
              $.ajax({
                    url: "<%= ViewData["rootUri"] %>ZoneInformation/Getoneluozang",
                    data: { "uid": id },
                    method: 'post',
                    success: function (data) {
                    if(data!=null&&data!="")
                    {
                      $("#xuanze").hide();
                      $("#luoznagdetail").show();
                      $("#uid").val(data.uid);
                      $("#sname").val(data.name);
                      $("#price").val(data.price);
                      $("#img").val(data.videourl);
                      $("#img2").val(data.imgurl);
                      $("#servicedetail").val(data.description);
                      $("#picture").attr("src", "<%= ViewData["rootUri"] %>"+ data.imgurl);
                       $("#video").attr("src", "<%= ViewData["rootUri"] %>"+ data.videourl);
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
   $(document).ready(function () {
   var rootUri="<%=ViewData["rootUri"] %>";
    $(".select2").css('width', '150px').select2();
           var recvcontents1 =  "<%= ViewData["daijibai"] %>";
            var conthtml1 = unescape(recvcontents1);
            $("#contents1").html(conthtml1);
            if (editor1 != undefined) {
             editor1.html(conthtml1);
                editor1.sync();
            }
            var recvcontents2 =  "<%= ViewData["jipindaigou"] %>";
            var conthtml2 = unescape(recvcontents2);
            $("#contents2").html(conthtml2);
            if (editor2 != undefined) {
             editor2.html(conthtml2);
                editor2.sync();
            }
      $('#uploadify2').uploadify({
                'buttonText': "<i class='ace-icon fa fa-book'></i> &nbsp;选择图片",
                'queueSizeLimit': 9999,  //设置上传队列中同时允许的上传文件数量，默认为999
                'uploadLimit': 99999,   //设置允许上传的文件数量，默认为999
                'swf': rootUri + 'Content/js/uploadify/uploadify.swf',
                 //'auto': false,
	            'fileTypeExts': '*.jpg;*.png;*.jpeg',
	            'fileTypeDesc':  'Image Files (.jpg,.png,*.jpeg)',
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
                'uploader': rootUri + 'ZoneInformation/UploadifyServiceImage',
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
                    $("#img2").val(data);
                    $("#picture").attr("src", "<%= ViewData["rootUri"] %>"+ data);
                    
                }
            });      
   $('#uploadify').uploadify({
                'buttonText': "<i class='ace-icon fa fa-book'></i> &nbsp;选择视频",
                'queueSizeLimit': 9999,  //设置上传队列中同时允许的上传文件数量，默认为999
                'uploadLimit': 9999,   //设置允许上传的文件数量，默认为999
                'swf': rootUri + 'Content/js/uploadify/uploadify.swf',
                 //'auto': false,
	            'fileTypeExts': '*.mp4',
	            'fileTypeDesc': 'Video Files (.mp4)',
	            'fileSizeLimit': '50MB',
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

				        toastr["error"]("超过文件上传大小限制（50MB）!", "温馨敬告");
                          }
                      },
                'uploader': rootUri + 'ZoneInformation/UploadifyServiceImage',
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
                    $("#video").attr("src", "<%= ViewData["rootUri"] %>"+ data);
                    
                }
            });
        $("#add").click(function(){
             $("#notes").hide();
             $("#caozuo").show();
             $("#luoznagdetail").show();
             $("#xuanze").hide();
         });
          $("#lzset").click(function(){
             $("#luoznagdetail").hide();
             $("#xuanze").show();
             $("#notes").show();
             $("#caozuo").hide();
             $("#uid").val("");
             $("#sname").val("");
             $("#price").val("");
             $("#img").val("");
             $("#img2").val("");
             $("#servicedetail").val("");
             $("#picture").attr("src", "");
             $("#video").attr("src", "<%= ViewData["rootUri"] %>");
         });

        });

         jQuery(function ($) {
            $.validator.messages.remote = "这个办事处可能已经存在！";
	        $.validator.messages.required = "必须要填写";
            $('#validation-form').validate({
	            errorElement: 'span',
	            errorClass: 'help-block',
	            //focusInvalid: false,
	            rules: {
	                sname: {
	                    required: true
	                },
                    img: {
	                    required: true
	                },
                    img2: {
	                    required: true
	                },
                    price: {
	                    required: true
	                },
                    servicedetail: {
	                    required: true
	                }
                    
                    
	            },
	            highlight: function (e) {
	                $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
	            },

	            success: function (e) {
	                $(e).closest('.form-group').removeClass('has-error'); //.addClass('has-info');
	                $(e).remove();
	            },

	            errorPlacement: function (error, element) {
	                if (element.is(':checkbox') || element.is(':radio')) {
	                    var controls = element.closest('div[class*="col-"]');
	                    if (controls.find(':checkbox,:radio').length > 1) controls.append(error);
	                    else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
	                }
	                else if (element.is('.select2')) {
	                    error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
	                }
	                else if (element.is('.chosen-select')) {
	                    error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
	                }
	                else error.insertAfter(element.parent());
	            },

	            submitHandler: function (form) {
	                submitform();
	                return false;
	            },
	            invalidHandler: function (form) {
	               
	            }
          });
	        
    });
    function check1(){
           var img2=$("#img2").val();
                if (img2!=null&&img2!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请选择上传图片！");
                return false;
              }
      }
      function check3(){
           var img=$("#img").val();
                if (img!=null&&img!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请选择视频！");
                return false;
              }
      }
       function check2(){
           var re = /^[1-9]+[0-9]*]*$/;
           var price=$("#price").val();
                if (re.test(price)) {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请输入整数金额！");
                return false;
              }
      }
        function submitform() {
        if(check1()==true&&check2()==true&&check3()==true)
        {
			$.ajax({
				type: "POST",
				url: "<%= ViewData["rootUri"] %>ZoneInformation/Operateluozang/?uid="+$("#uid").val(),
				dataType: "json",
				data: $('#validation-form').serialize(),
				success: function (data) {
				    if (data == true) {
                            toas1();
                            setTimeout(function(){
                                window.location.reload();
                            }, 2500);

				    } else {
				        toas2();
				    }
				}
			});
        }
        }
        function toas1() {
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
         function toas2() {
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
        function DOnSubmit() {
            editor1.sync();            

            $.ajax({
                type: "POST",
                url: rootUri + "ZoneInformation/UpdateDaiJiBai",
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
        function JOnSubmit() {
            editor2.sync();            

            $.ajax({
                type: "POST",
                url: rootUri + "ZoneInformation/UpdateJiPinDaiGou",
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

        function htmlencode(str) {
            return str.replace(/[&<>"']/g, function($0) {
                return "&" + {"&":"amp", "<":"lt", ">":"gt", '"':"quot", "'":"#39"}[$0] + ";";
            });
        }

</script>


</asp:Content>


    

    