package com.hrms.util;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author 金海洋
 * @date 2019/4/13  -10:38
 */
public class DateUtil {

	/**
	 * 得到时间往前推N个月后的逐月数组
	 *
	 * @param date
	 * @param month
	 * @return yy-MM
	 */
	public static List<String> getDateForwardMonth(Date date, int month) {
		SimpleDateFormat sdf = new SimpleDateFormat("yy-MM");
		List<String> result = new ArrayList<>();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, -1 * month);
		for (int i = 0; i < month; i++) {
			calendar.add(Calendar.MONTH, 1);
			result.add(sdf.format(calendar.getTime()));
		}
		return result;
	}

	/**
	 * 得到时间往前推N日后的逐日数组
	 *
	 * @param date
	 * @param day
	 * @return MM-dd
	 */
	public static List<String> getDateForwardDay(Date date, int day) {
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
		List<String> result = new ArrayList<>();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, -1 * day);
		for (int i = 0; i < day; i++) {
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			result.add(sdf.format(calendar.getTime()));
		}
		return result;
	}

	/**
	 * 根据传入年份月份And返回当前月的数组（MM-DD）
	 *
	 * @param year  年份
	 * @param month 月份
	 * @return
	 */
	public static List<String> calculateDateAmount(String year, String month) {
		Integer years = Integer.parseInt(year);
		Integer months = Integer.parseInt(month);
		int days = 0;
		switch (months) {
			case 1:
			case 3:
			case 5:
			case 7:
			case 9:
				days = 31;
				break;
			case 4:
			case 6:
			case 8:
			case 10:
			case 11:
			case 12:
				days = 30;
				break;
			case 2://2月判断瑞平年
				if ((years % 4 == 0 && years % 100 != 0) || years % 400 == 0) {
					days = 30;
				} else {
					days = 29;
				}
				break;
		}
		List<String> dayList = new ArrayList<String>();
		String y = year.substring(2, 4);
		String m = month.substring(0, 2);
		for (int i = 0; i < days; i++) {
			List<String> list = new ArrayList<>();
			int daysIncrease = i + 1;
			String str = null;
			if (daysIncrease <= 9) {
				str = String.valueOf(daysIncrease);
				str = "0" + str;
			} else {
				str = String.valueOf(daysIncrease);
			}
			// dayList.add(m + "-" + str);
			dayList.add(str);
		}
		return dayList;
	}

	/**
	 * 根据开始结束日期,推算月份个数，以及(yyyy-mm月份数组)
	 *
	 * @param stareDate 开始时间
	 * @param endDate   结束时间
	 * @return
	 */
	public static List<String> monthNumber(String stareDate, String endDate) throws Exception {
		ArrayList<String> result = new ArrayList<String>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");//格式化为年月
		Calendar min = Calendar.getInstance();
		Calendar max = Calendar.getInstance();
		min.setTime(sdf.parse(stareDate));
		min.set(min.get(Calendar.YEAR), min.get(Calendar.MONTH), 1);
		max.setTime(sdf.parse(endDate));
		max.set(max.get(Calendar.YEAR), max.get(Calendar.MONTH), 2);
		Calendar curr = min;
		while (curr.before(max)) {
			result.add(sdf.format(curr.getTime()));
			curr.add(Calendar.MONTH, 1);
		}
		return result;
	}

	/**
	 * 将日历向前后推算N个年月日
	 *
	 * @param dateFormat 输出日期格式（"yyyy-mm-dd"）
	 * @param dateNum    推算数字（7）
	 * @param dataSymbol 推算符号（"-","+"）
	 * @param calType    推算类别（year，month，day）
	 * @return
	 * @throws Exception
	 */
	public static String calendarCalculate(String dateFormat, int dateNum, String dataSymbol, String calType) throws Exception {
		SimpleDateFormat f = new SimpleDateFormat(dateFormat);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.MONTH, Integer.parseInt((dataSymbol + dateNum)));
		Date dateMinus = calendar.getTime();
		String str = f.format(dateMinus);
		return str;
	}

	/**
	 * 往前推N天的日期数组（并日期格式）
	 *
	 * @param date     日期
	 * @param day      天数
	 * @param dataType 格式（如：yyyy-mm-dd）
	 * @return
	 */
	public static List<String> getDateForwardDay(Date date, int day, String dataType) {
		SimpleDateFormat sdf = new SimpleDateFormat(dataType);
		List<String> result = new ArrayList<>();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, -1 * day);
		for (int i = 0; i < day; i++) {
			calendar.add(Calendar.DAY_OF_MONTH, 1);
			result.add(sdf.format(calendar.getTime()));
		}
		return result;
	}

	/*
	 * 将时间戳转换为时间
	 */
	public static Date stampToDate(String s) {
		long longs = Long.valueOf(s);
		Date date = new Date(longs);
		return date;
	}

	/**
	 * 格式化日期字符串
	 */
	public static String updateDateFormat() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String dateStr = sdf.format(date);
		return dateStr;
	}


}
