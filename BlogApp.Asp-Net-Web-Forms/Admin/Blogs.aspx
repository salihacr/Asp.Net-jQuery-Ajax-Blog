<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="Blogs.aspx.cs" Inherits="BlogApp.Asp_Net_Web_Forms.Admin.Blogs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="BlankContent" runat="server">
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item active">Dashboard/Bloglar</li>
    </ol>
    <a href="AddBlog.aspx" class="btn btn-success mb-4">Yeni Blog</a>
    <div class="card mb-4">
        <div class="card-header">
            <i class="fas fa-table mr-1"></i>
            Blog Listesi
        </div>
        <div class="card-body">
            <div class="table">
                <form id="formUser" method="post">
                    <table id="tbl" class="table table-striped table-hover table-bordered">
                        <thead>
                            <tr>
                                <th>Blog Adı</th>
                                <th>Blog Url</th>
                                <th>Yayınlanma Tarihi</th>
                                <th>İşlemler</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </div>
    <script src="../Content/js/bootstrap/jquery-3.4.1.min.js"></script>
    <script>
        $(document).ready(function () {
            GetBlogList();
        });

        function GetBlogList() {
            $.ajax({
                url: 'Blogs.aspx/GetBlogList',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: "{}",
                success: function (_data) {
                    _data = JSON.parse(_data.d);
                    $("#tbl").find("tr:gt(0)").remove();

                    for (var i = 0; i < _data.length; i++) {
                        $("#tbl").append(
                            '<tr><td>' + _data[i].BlogName + '</td><td>' + _data[i].BlogURL + '</td>'
                            + '<td> ' + _data[i].CreateDate + '</td>'
                            + '<td><input type="button" id="btndelete" value="Sil" class="btn btn-danger mr-2" onclick="DeleteData(' + _data[i].BlogId + ')" />'
                            + '<a class="btn btn-warning ml-2" href="/Admin/EditBlog.aspx?blogId=' + _data[i].BlogId + '">Güncelle</a> </td>  </tr>');
                    }
                },
                error: function () {
                    alert("Get Error");
                }
            });
        }
        //Delete Record
        function DeleteData(blogId) {
            $.ajax({
                url: 'Blogs.aspx/Delete',
                type: 'post',
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                data: "{blogId : '" + blogId + "'}",
                success: function () {
                    alert('delete success !!');
                    GetBlogList();
                },
                error: function () {
                    alert('delete error !!');
                }
            });
        }
    </script>
</asp:Content>
