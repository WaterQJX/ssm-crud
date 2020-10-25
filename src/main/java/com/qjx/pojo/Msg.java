package com.qjx.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * @PackageName: com.qjx.pojo
 * @ClassName: Msg
 * @Author: qjx
 * @Date: 2020/10/22 12:55
 * @Description: 通用的返回的类
 */
public class Msg {
    //状态码
    private int code;
    //提示信息
    private String msg;
    //用户数据
    private Map<String, Object> extend = new HashMap<>();

    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理完成");

        return result;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败");

        return result;
    }

    public Msg add(String key, Object o){
        this.getExtend().put(key, o);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
