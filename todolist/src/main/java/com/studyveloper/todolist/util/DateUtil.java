package com.studyveloper.todolist.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

public class DateUtil {
	public String getCurrentDate(String format, String currentTimeZone) {
		Date currentDate = new Date();
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
		
		TimeZone timeZone = TimeZone.getTimeZone(currentTimeZone);
		
		simpleDateFormat.setTimeZone(timeZone);
		
		return simpleDateFormat.format(currentDate);
	}
	
	public String getDate(String format, String currentTimeZone, int plusDate) {
		Calendar calendar = Calendar.getInstance();
		
		calendar.setTime(new Date());
		calendar.add(Calendar.DATE, plusDate);
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(format);
		
		TimeZone timeZone = TimeZone.getTimeZone(currentTimeZone);
		
		simpleDateFormat.setTimeZone(timeZone);
		
		return simpleDateFormat.format(calendar.getTime());
	}
}
