<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="AddBlog.aspx.cs" Inherits="BlogApp.Asp_Net_Web_Forms.Admin.AddBlog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BlankContent" runat="server">
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item active">Dashboard/Blog/Ekle</li>
    </ol>
    <div class="card mb-4">
        <div class="card-header">
            <i class="fas fa-table mr-1"></i>
            Yeni Blog
        </div>
        <div class="card-body">
            <div class="table">
                <form id="addBlog" method="post">

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
                            <textarea id="blogContent" class="form-control"></textarea>
                        </div>
                    </div>
                    <hr />
                    <input type="button" class="btn btn-primary btn-block" value="KAYDET" id="btnSave" onclick="save()" />
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.ckeditor.com/4.16.0/standard/ckeditor.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script>

        var editor = CKEDITOR.replace('blogContent');
        function showpreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#imgpreview').css('visibility', 'visible');
                    $('#imgpreview').attr('src', e.target.result);
                    $('#imgpreview').fadeIn(650);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function save() {

            var blogUserId = 1;<%-- <%Session["UserId"]%>--%>

            var selectedValue = $("#<%= ddlCategories.ClientID %>").val();
            var selectedText = $("#<%= ddlCategories.ClientID %>:selected").val();


            console.log("{blogName:'" + $("#blogName").val() + "'" + ", blogUrl: '" + $("#blogUrl").val() + "', blogContent: '" + editor.getData() + "', blogCategoryId: '" + selectedValue +
                "',blogUserId:'" + blogUserId + "'}");
            $.ajax({
                url: 'AddBlog.aspx/InsertBlog',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: "{blogName:'" + $("#blogName").val() + "'" + ", blogUrl: '" + $("#blogUrl").val() + "', blogContent: '" + editor.getData() + "', blogCategoryId: '" + selectedValue +
                    "',blogUserId:'" + blogUserId + "'}",
                success: function () {
                    alert("Insert data Successfully");
                },
                error: function (e) {
                    alert("Insert Error" + e.responseText);
                }
            });
        }
    </script>
</asp:Content>
