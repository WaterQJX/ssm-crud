package com.qjx.controller;

import com.qjx.pojo.Department;
import com.qjx.pojo.Msg;
import com.qjx.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @PackageName: com.qjx.controller
 * @ClassName: DepartmentController
 * @Author: qjx
 * @Date: 2020/10/22 17:40
 * @Description:
 */

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * @Author: qjx
     * @Date: 17:45 2020/10/22
     * @Param: []
     * @return: com.qjx.pojo.Msg
     * @Description:  返回所有部门
     **/
    @ResponseBody
    @RequestMapping("/depts")
    public Msg geDepts(){

        List<Department> depts = departmentService.getAllDepts();

        return Msg.success().add("depts", depts);
    }
}
