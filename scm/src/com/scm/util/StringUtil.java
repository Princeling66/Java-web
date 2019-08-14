package com.scm.util;

public class StringUtil {
	/**
	 * 验证字符串是否为null或者为空
	 * @param str
	 * @return true(null,空白) or false 
	 */
	public static boolean isEmpty(String str){
		if(str == null || "".equals(str.trim())){
			return true;
		}
		return false;
	}
	/**
	 * 验证一个对象是否为null或者为空
	 * @param str
	 * @return true(null,空白) or false 
	 */
	public static boolean isEmpty(Object o){
		if(o == null || "".equals(o.toString())){
			return true;
		}
		return false;
	}

}
