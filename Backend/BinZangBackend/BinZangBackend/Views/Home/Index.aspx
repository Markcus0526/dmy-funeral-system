<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


<div class="row">
    <div class="col-md-12">
        <iframe name="weather_inc" src="http://tianqi.xixik.com/cframe/9" width="500" height="60" frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe><br />
       <div style=" width:100%">
       <img src="../../Content/d.jpg"  style=" width:100%"/>
       </div> 
    </div>
</div>

</asp:Content>
