<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
<div class="example t-vista" style="marg-toinp:20px">
     <div class="portlet box green" >
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-plus"></i>活动通知详情
							</div>
						</div>
						<div class="portlet-body">
	
                                <div>
                                    <textarea id="contents" name="contents" style="width:77%;height:600px; resize:none;" rows="8"></textarea>
                                </div>
                                <div style="float: right;margin-top:-600px;margin-left:220px">
                                     
                                   
                                   <div style="margin-left:40px">
                                   <img src="<%=ViewData["rootUri"] %><%=ViewData["activityurl"] %>" id = "picture" height="150px" width="156px"/>	
                                   <input type="hidden" id="img" class="img"  name="img" value="<% if (ViewData["activityurl"] != null) { %><%= ViewData["activityurl"] %><% } %>" />
                                   <br />
                                   <br />
                                   <%if( Convert.ToInt32(ViewData["makeid"])==2) {%>
                                   <input type="file" class="upfiles"  id="uploadify" name="carImg2" />
                                    
                                     <span style="color:red">**温馨提示:请选择文件大小</span><br />
                                     <span style="color:red">在500kb以内的图片**</span>
                                     <%} %>
                                     </div>
                                     <br />
                                   <br />
                                   通知类型：<select class="select2" style="width:150px" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%>disabled=disabled<%} %> id="activitytype" onchange="settime(this.value)">
                                            <option value="0" >普通活动</option>
                                            <option value="1" >业务制度</option>
                                            <option value="2" >业务奖励</option>
                                            <option value="3" >法会活动</option>           
                                            </select>
                                   <br />
                                   <br />
                                   <div id="noticetime" style="display:none">
                                      活动时间：<% string times = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day; %>
							                <input class="date-picker" readonly id="starttime" name="starttime" type="text" data-date-format="yyyy-mm-dd" value="<%=times %>" style="width:170px;"/><i class="fa fa-calendar" style="margin-left:-17px"></i>
                                            <br /><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;至：&nbsp;<input class="date-picker" readonly id="endtime"  name="endtime" type="text" data-date-format="yyyy-mm-dd" value="<%=times %>" style="width:170px;"/><i class="fa fa-calendar" style="margin-left:-17px"></i><br /><br />
                                   
                                   </div>
                                   <br />
                                   <br />
                                     活动名称：<input type="text" <%if( Convert.ToInt32(ViewData["makeid"])==1) {%>readonly<%} %> id="activityname" value="<%=ViewData["activityname"] %>"/>
                                    <br />
                                   <br />
                                   <div style="margin-left:0px">
                  <input id="text1" readonly="readonly" style="margin-top:10px;text-align:center;width:50%;height:20px; border-style:none;display:none;margin-left:50px;color: Red" />
                </div>         
                                    <%if( Convert.ToInt32(ViewData["makeid"])==2) {%>
                                    <button class="btn btn-success loading-btn" id="add" onclick="OnSubmit();" style="margin-top:10px;margin-left:40px">
								                    <i class="ace-icon fa fa-check bigger-110"></i>
								                    保存
							                    </button>
                                                <%} %>
                                                &nbsp;
                                                           <button id="sett" class="btn" type="reset" onclick="javascript:history.go(-1);" style="margin-top:10px;margin-left:40px">
								                    <i class="ace-icon fa fa-undo bigger-110"></i>
								                    返回
							                    </button>
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
    <script src="../../assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="../../assets/global/plugins/bootstrap-datepicker/js/locales/bootstrap-datepicker.zh-CN.js" type="text/javascript"></script>
    <script src="<%= ViewData["rootUri"] %>Content/js/bootstrap-toastr/toastr.js"></script>    
<script type="text/javascript">
var noticetype="<%=ViewData["noticetype"] %>";
var makeid="<%=ViewData["makeid"] %>";
var success;
if(makeid==1)
{
  success=true;
}
else{
   success=false;
}
 $("#activitytype option[value='"+noticetype+"']").attr("selected", "selected"); 
if(noticetype==3)
{
  settime(noticetype);
 
  $("#starttime").val("<%=ViewData["starttime"] %>");
  $("#endtime").val("<%=ViewData["endtime"] %>");
}
 function settime(id)
    {
      if(id==3)
      {
        $("#noticetime").show();
        if(makeid==2)
        {
         $('.date-picker').datepicker({ autoclose: true, todayHighlight: true, language: "zh-CN" });
         }
      }
      else{
      $("#noticetime").hide();
      }
    }
 var rootUri = "<%= ViewData["rootUri"] %>";
    var editor;
    KindEditor.ready(function (K) {
        editor = K.create('#contents', {
            cssPath: '<%= ViewData["rootUri"] %>Content/kindeditor/plugins/code/prettify.css',
            uploadJson: '<%= ViewData["rootUri"] %>ZoneInformation/UploadKindEditorImageT',
            fileManagerJson: '<%= ViewData["rootUri"] %>ZoneInformation/ProcessKindEditorRequestT',
            allowFileManager: true,
            urlType : 'domain',
            readonlyMode:success,
            afterCreate: function () {
                var self = this;
                K.ctrl(document, 13, function () {
                    self.sync();
                    //K('form[name=profileform]')[0].submit();
                });
                K.ctrl(self.edit.doc, 13, function () {
                    self.sync();
                   // K('form[name=profileform]')[0].submit();
                });
            }
        });
    });
   $(document).ready(function () {
    
    $(".select2").css('width', '150px').select2({ minimumResultsForSearch: -1 });
   
    
            var recvcontents =  "<%= ViewData["content"] %>";
            var conthtml = unescape(recvcontents);
            $("#contents").html(conthtml);
            if (editor != undefined) {
             editor.html(conthtml);
                editor.sync();
            }
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
         function check1(id){

         
                var notename=$("#activityname").val();
              if (notename!=null&&notename!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请填写活动名称！");
                return false;
              }
         
       
           
      }
      function check3(id){
     if(id==3)
         {
            starttime=$("#starttime").val();
            endtime=$("#endtime").val();
                if (starttime!=null&&starttime!=""&&endtime!=null&&endtime!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请选择活动起止时间！");
                return false;
              }
          }
          else{return true;  }
     
      }
      function check2(){
             var imageurl=$("#img").val();
                if (imageurl!=null&&imageurl!="") {
               document.getElementById("text1").style.display="none";
               return true;
              }
              else{
               document.getElementById("text1").style.display="block";
                $('#text1').val("请上传活动图片！");
                return false;
          }

     
      }
        function OnSubmit() {
            editor.sync(); 
            var activitytype=$("#activitytype").val();;
            var starttime;
            var endtime;
            var notename=$("#activityname").val();
            var imgurl=$("#img").val();
            var introduce=$("#contents").val();
            if(activitytype!=3)
            { 
            starttime="";
            endtime="";
            }
             if(activitytype==3)
            { 
            starttime=$("#starttime").val();
            endtime=$("#endtime").val();
            }            
            if(check1()==true&&check2()==true&&check3(activitytype)==true)
            {
              $.ajax({
                type: "POST",
                url: rootUri + "ZoneInformation/UpdateNote",
                dataType: "json",
                data: {
                   notename:notename,
                   uid:"<%=ViewData["uid"] %>",
                   imgurl:imgurl,
                   activitytype:activitytype,
                   starttime:starttime,
                   endtime:endtime,
                   introduce:escape(introduce)
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
                         setTimeout(function () {
                               window.location.href=rootUri+"ZoneInformation/ActivityNotice";
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

				        toastr["error"]("操作失败!", "温馨敬告");
                        
                     }
                   }
            });
            }
            
        }

        function htmlencode(str) {
            return str.replace(/[&<>"']/g, function($0) {
                return "&" + {"&":"amp", "<":"lt", ">":"gt", '"':"quot", "'":"#39"}[$0] + ";";
            });
        }


</script>


</asp:Content>


    

    