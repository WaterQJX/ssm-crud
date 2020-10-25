<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>


<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="1" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>







<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@123.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="1" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="0"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>



<!-- 搭建显示页面 -->
<div class="container">
    <!-- 标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_modal_btn">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">

                <thead>
                    <tr>

                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>

                    </tr>
                </thead>
                <tbody>

<%--                显示员工信息--%>
                </tbody>

            </table>
        </div>
    </div>

    <!-- 显示分页信息 -->
    <div class="row">
        <!--分页文字信息  -->
        <div class="col-md-6" id="page_info">
<%--            当前第 页，共 页，共 条记录--%>
<%--            利用json解析--%>
        </div>
        <!-- 分页条信息 -->
        <div class="col-md-6" id="page_nav">


        </div>
    </div>

</div>

<script type="text/javascript">

    var totalRecord, currentPage;
    $(function () {

        to_page(1);

    });


    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {

        //清除样式
        reset_form("#empAddModal form");

        getDepts("#empAddModal select");

        $("#empAddModal").modal({
            backdrop:"static"
        });
    });

    //验证员工姓名是否重复
    $("#empName_add_input").change(function () {
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkUser",
            type:"POST",
            data:"empName="+empName,
            success:function (result) {
                if(result.code == 100){
                    show_validate_msg("#empName_add_input", "success", "");
                    $("#emp_save_btn").attr("ajax-va", "success");
                }else{
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }

            }
        })

    })

    //保存员工信息
    $("#emp_save_btn").click(function () {


        // if(!validate_add_form()){
        //     return false;
        // }
        //
        // if($(this).attr("ajax-va")=="error"){
        //     return false;
        // }

        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {

                if(result.code == 100){
                    $("#empAddModal").modal("hide");

                    to_page(totalRecord);
                }else{
                    if(undefined != result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error",  result.extend.errorFields.email);
                    }
                    if(undefined != result.extend.errorFields.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }


            }
        })
    });

    //校验表单
    function validate_add_form(){
        //验证姓名
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        }else{
            show_validate_msg("#empName_add_input", "success", "");
        }
        //验证邮箱
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_add_input", "success", "");
        }

        return true;

    }

    //去第几页
    function to_page(pageNumber) {

        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pageNumber=" + pageNumber,
            type:"GET",
            success:function (result) {
                build_emps_table(result);

                build_page_info(result);

                build_page_nav(result);

            }
        });
    }
    //解析显示数据
    function build_emps_table(result) {

        //清空数据
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;

        $.each(emps, function (index, item) {

            var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>")

            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=="1"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            /**
             <button class="btn btn-primary btn-sm">
             <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
             编辑
             </button>
             <button class="btn btn-danger btn-sm">
             <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
             删除
             </button>
              @type {void | jQuery}
             */
            var editTd = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
             .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");

            //获取员工ID
            editTd.attr("edit-id", item.empId);

            var delTd = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
             .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");

            //获取员工ID
            delTd.attr("del-id", item.empId);

            var btnTd = $("<td></td>").append(editTd).append(" ").append(delTd);

            $("<tr></tr>").append(checkboxTd).append(empIdTd).append(empNameTd).append(genderTd).append(" ").append(emailTd)
                .append(deptNameTd).append(btnTd).appendTo("#emps_table tbody");

        })


    }
    //解析显示分页信息
    function build_page_info(result) {
        //清空数据
        $("#page_info").empty();

        $("#page_info").append("当前第"+ result.extend.pageInfo.pageNum +"页，共"+ result.extend.pageInfo.pages +"页，共"+ result.extend.pageInfo.total +"条记录")

        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
    }
    //解释显示分页条
    function build_page_nav(result) {
        //清空数据
        $("#page_nav").empty();

        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{

            firstPageLi.click(function () {
                to_page(1);
            })

            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            })
        }

        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item){

            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            })

            ul.append(numLi);
        });

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));
        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{

            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            })

            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
        }
        //添加下一页和末页 的提示
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav
        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav");
        //$("#page_nav").append(navEle);
    }

    //清空表单样式及内容
    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //查出所有的部门信息并显示在下拉列表中
    function getDepts(ele) {

        $(ele).empty();

        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                $.each(result.extend.depts, function () {
                    var options = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    options.appendTo(ele);
                })
            }
        });
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele, status, msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success" == status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //1、我们是按钮创建之前就绑定了click，所以绑定不上。
    //1）、可以在创建按钮的时候绑定。    2）、绑定点击.live()
    //jquery新版没有live，使用on进行替代
    //点击修改按钮弹出模态框
    $(document).on("click", ".edit_btn", function () {

        reset_form("#empUpdateModal form");

        getDepts("#empUpdateModal select");

        getEmp($(this).attr("edit-id"));

        //传给更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));

        $("#empUpdateModal").modal({
            backdrop:"static"
        })



    })

    //查询员工信息
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/" + id,
            type:"GET",
            success:function (result) {
                $("#empName_update_static").text(result.extend.emp.empName);
                $("#email_update_input").val(result.extend.emp.email);
                $("#empUpdateModal input[name=gender]").val([result.extend.emp.gender]);
                $("#empUpdateModal select").val([result.extend.emp.dId]);
            }
        })

    }

    //更新员工信息
    $("#emp_update_btn").click(function () {

        //检验邮箱
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_add_input", "success", "");
        }

        //发送ajax请求保存
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {

                //关闭模态框
                $("#empUpdateModal").modal("hide");
                //回到本页面
                to_page(currentPage);
            }
        })

    })

    //单个删除
    $(document).on("click", ".delete_btn", function () {
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");

        if(confirm("确认删除【"+empName+"】吗？")){
           $.ajax({
               url:"${APP_PATH}/emp/"+empId,
               type:"DELETE",
               success:function (result) {

                    alert(result.msg);
                    to_page(currentPage);
               }

           })
        }
    })

    //全选/全不选
    $("#check_all").click(function () {

        $(".check_item").prop("checked", $(this).prop("checked"));
    })
    $(document).on("click", ".check_item", function () {
        var flag = $(".check_item:checked").length == $(".check_item").length;

        $("#check_all").prop("checked", flag);
    })

    //点击全部删除
    $("#emp_delete_modal_btn").click(function () {

        var empNames = "";
        var del_idstr = "";

        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";

        })
        empNames = empNames.substring(0, empNames.length-1);
        del_idstr = del_idstr.substring(0, del_idstr.length-1);

        if(confirm("确认删除【"+empNames+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {

                    alert(result.msg);
                    to_page(currentPage);
                }
            })

        }

    })


</script>
</body>
</html>