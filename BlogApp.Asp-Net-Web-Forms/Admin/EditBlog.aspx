<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="EditBlog.aspx.cs" Inherits="BlogApp.Asp_Net_Web_Forms.Admin.EditBlog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BlankContent" runat="server">
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item active">Dashboard/Blog/Düzenle</li>
    </ol>
    <div class="card mb-4">
        <div class="card-header">
            <i class="fas fa-table mr-1"></i>
            Bloğu Düzenle
        </div>
        <div class="card-body">
            <div class="table">
                <form id="editBlog" method="post">

                    <br />
                    <div class="form-row">
                        <div class="col-md-6 mb-3">
                            <div class="form-group">
                                <label>Blog Başlık</label>
                                <input type="text" id="blogName" class="form-control" placeholder="Blog Başlık" required />
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="form-group">
                                <label>Blog Url</label>
                                <input type="text" id="blogUrl" class="form-control" placeholder="Tarayıcıda görüntülenecek url" required />
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Blog Kategori</label>
                            <asp:DropDownList runat="server" ID="ddlCategories" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Blog İçerik</label>
                            <textarea id="editor" class="form-control"></textarea>
                        </div>
                    </div>
                    <hr />
                    <input type="button" class="btn btn-primary btn-block" value="KAYDET" id="btnSave" />
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script>



        var selectedValue = $("#<%= ddlCategories.ClientID %>");//.val();
        var selectedText = $("#<%= ddlCategories.ClientID %>:selected");//.val();

        var editor = CKEDITOR.replace('editor');

        $(document).ready(function () {
            GetData();
        });


        function GetData() {
            //<a class="nav-link" href="/Admin/Profile.aspx?User=<%--<%=Session["Username"] %>--%>">
            const blogId = "<%=Request.QueryString["blogId"]%>";
            console.log(blogId);
            $('#blogName').val("salih");
            $.ajax({
                url: "EditBlog.aspx/GetBlogById",
                method: "post",
                contentType: "application/json",
                data: "{blogId : '" + blogId + "'}",
                dataType: 'json',
                type: 'POST',
                success: function (data) {
                    let myData = JSON.parse(data.d);
                    $('#blogName').val(myData[0].BlogName);
                    $('#blogUrl').val(myData[0].BlogUrl);
                    $('#ddlCategories').val(myData[0].BlogUrl);
                    selectedValue.val(myData[0].BlogCategoryId);
                    selectedText.val(myData[0].CategoryName);
                    $('#editor').val(myData[0].BlogContent);
                },
                error: function (error) {
                    alert(error.responseText);
                    alert("hata get");
                }
            });
        }

        function updateData() {
            const blogId = "<%=Request.QueryString["blogId"]%>";
            console.log("{blogName:'" + $("#blogName").val() + "',blogUrl:'" + $("#blogUrl").val() + "',blogContent:'" + editor.getData() + "'}");
            $.ajax({
                url: 'EditBlog.aspx/UpdateBlog',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: "{blogId:'" + blogId + "',blogName:'" + $("#blogName").val() + "',blogUrl:'" + $("#blogUrl").val() + "',blogContent:'" + editor.getData() + "'}",
                success: function () {
                    alert("Update data Successfully");
                    GetData();
                },
                error: function () {
                    alert("Update Error");
                }
            });
        }
    </script>
</asp:Content>
