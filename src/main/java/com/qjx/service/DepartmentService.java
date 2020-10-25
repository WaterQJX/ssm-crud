package com.qjx.service;

import com.qjx.dao.DepartmentMapper;
import com.qjx.pojo.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @PackageName: com.qjx.service
 * @ClassName: DepartmentService
 * @Author: qjx
 * @Date: 2020/10/22 17:41
 * @Description:
 */
@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    //查询所有部门
    public List<Department>  getAllDepts(){
        return departmentMapper.selectByExample(null);
    }
}
