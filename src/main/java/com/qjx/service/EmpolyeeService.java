package com.qjx.service;

import com.qjx.dao.EmployeeMapper;
import com.qjx.pojo.Employee;
import com.qjx.pojo.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @PackageName: com.qjx.service
 * @ClassName: EmpolyeeService
 * @Author: qjx
 * @Date: 2020/10/21 13:47
 * @Description:
 */

@Service
public class EmpolyeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    //检验用户名是否可用
    public boolean checkUser(String empName){

        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);

        long l = employeeMapper.countByExample(employeeExample);

        return 0 == l;
    }

    //查询所有员工
    public List<Employee> getAllEmps() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    //插入员工数据
    public void saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);
    }

    //根据Id查询员工
    public Employee getEmpById(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }
    //修改员工属性
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    //删除员工
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    //批量删除
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();

        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample);

    }
}
