<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/select2/select2.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/Scroller/css/dataTables.scroller.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/extensions/ColReorder/css/dataTables.colReorder.min.css"/>
<link rel="stylesheet" type="text/css" href="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"/>
<div class="row" style=" margin-left:10%;margin-right:10%">
				<div class="col-md-12">
				<!-- BEGIN EXAMPLE TABLE PORTLET-->
                    <div style="  margin-top:4%; border:2px solid #3B9C96">
                                   
                                    <div id="img" style="margin-left:2%;margin-top:2%">
                                     回函图片：
                                    </div>

                                    <div style=" margin-left:2%; margin-top:5%"><span>描述：</span><br /><textarea id="remark" rows="10" readonly style=" width:70%"><%=ViewData["callbackcontents"]%></textarea></div>
						            <textarea id="num"  rows="4" style=" width:70%; display:none" ></textarea>
                                   <div><a id="searchdata" class="btn btn-sm btn-success" onclick="javascript:history.go(-1);" style=" margin-left:20%;margin-top:5%; margin-bottom:2%"><i class="fa fa-search"> </i>返回</a></div>
	                </div>
    		    </div>
</div>
            <script type="text/javascript" src="../../assets/global/plugins/select2/select2.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/media/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/extensions/TableTools/js/dataTables.tableTools.min.js"></script>
        <script type="text/javascript" src="../../assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<script type="text/javascript">
    var callbackimg = "<%=ViewData["callbackimg"] %>";
    var imgs = new Array;
    imgs = callbackimg.split(',');
    if(imgs.length==1)
    {
      if(imgs[0]=="")
      {
       $("#img").append('没有上传回函图片');
      }
      else{
       $("#img").append('<img src="<%= ViewData["rootUri"]%>' + imgs[0] + '" id ="picture' + 1 + '" height="150px" width="150px" style=" margin-left:10px;margin-top:5"/>');
      }
      
    }
    else
    {
              for(var i=0;i<imgs.length-1;i++)
            {
                   $("#img").append('<img src="<%= ViewData["rootUri"]%>' + imgs[i] + '" id ="picture' + i + '" height="150px" width="150px" style=" margin-left:10px;margin-top:5"/>');
            }
    }
    
   
      

</script>

</asp:Content>
