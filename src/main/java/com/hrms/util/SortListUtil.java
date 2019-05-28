package com.hrms.util;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/14  -23:52
 */
public class SortListUtil {
	/**
	 * List数组快速排序
	 * 传入值list<object>，快速排序完成后，转出List<String>依大至小的数组集合
	 */
	public static List<String> listSorting(List<Object> list) {
		double[] listNum = new double[list.size()];
		for (int i = 0; i < list.size(); i++) {//初始化数组
			listNum[i] = Double.parseDouble(list.get(i).toString());
		}
		for (int i = 0; i < listNum.length - 1; i++) {// 做第i趟排序
			int k = i;
			for (int j = k + 1; j < listNum.length; j++) {// 选最小的记录
				if (listNum[j] > listNum[k]) {
					k = j;
				}
			}
			if (i != k) {
				double temp = listNum[i];
				listNum[i] = listNum[k];
				listNum[k] = temp;
			}
		}
		List<String> resultList = new ArrayList<String>(); //double转List<String>
		for (int i = 0; i < listNum.length; i++) {
			resultList.add(String.valueOf(listNum[i]));
		}
		return resultList;
	}

	/**
	 * 数据报表计算间距
	 * 计算逻辑--数据除5/取最高位+1
	 * 传入List为-从高至低排序
	 */
	public static int getSpacing(List<Object> list) {
		double b = Double.parseDouble(list.get(0).toString());
		int yAxis = (int) b;
		int yAxis5 = yAxis / 5;
		/**将int转为String*/
		String string = String.valueOf(yAxis5);
		int strLength = string.length();
		String maxNumber = string.substring(0, 1);
		StringBuffer resultStr = new StringBuffer();
		resultStr.append(maxNumber);
		for (int i = 1; i < strLength; i++) { //i=1循环补位0
			resultStr.append(0);
		}
		int resultInt = Integer.valueOf(resultStr.toString());
		return resultInt;
	}


	/**
	 * 数据报表计算间距
	 * 计算逻辑--数据除5/取最高位+1
	 * 传入List为-从高至低排序
	 */
	public static int getSpacing(String spacing) {
		double b = Double.parseDouble(spacing);
		int yAxis = (int) b;
		int yAxis5 = yAxis / 5;
		/**将int转为String*/
		String string = String.valueOf(yAxis5);
		int strLength = string.length();
		String maxNumber = string.substring(0, 1);
		StringBuffer resultStr = new StringBuffer();
		resultStr.append(maxNumber);
		for (int i = 1; i < strLength; i++) { //i=1循环补位0
			resultStr.append(0);
		}
		int resultInt = Integer.valueOf(resultStr.toString());
		return resultInt;
	}


}
