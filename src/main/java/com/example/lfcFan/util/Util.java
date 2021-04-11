package com.example.lfcFan.util;

import java.math.BigInteger;
import java.util.Date;


public class Util {
	
	private static class TIME_MAXIMUM {

		public static final int SEC = 60;

		public static final int MIN = 60;

		public static final int HOUR = 24;

		public static final int DAY = 30;

		public static final int MONTH = 12;

	}

	public static int getAsInt(Object object) {
		return getAsInt(object, -1);
	}

	public static int getAsInt(Object object, int defaultValue) {
		if (object instanceof BigInteger) {
			return ((BigInteger) object).intValue();
		}
		else if (object instanceof String) {
			try {
				return Integer.parseInt((String) object);				
			} catch (NumberFormatException e ) {
				return defaultValue;
			}
		}
		else if (object instanceof Long) {
			return (int)((long) object);
		}
		else if (object instanceof Integer) {
			return (int)object;
		}

		return defaultValue;
	}
	
	public static String getAsStr(Object object, String defaultValue) {
		if (object == null) {
			return defaultValue;
		}

		if (object instanceof String) {
			return (String) (object);
		}

		return object.toString();
	}
	
	public static String calculateTime(Date date) {
	    long curTime = System.currentTimeMillis();
	    long regTime = date.getTime();
	    long diffTime = (curTime - regTime) / 1000;

	    String msg = null;

	    if(diffTime < TIME_MAXIMUM.SEC) {
	        // sec
	        msg = diffTime + "초전";
	    } else if ((diffTime /= TIME_MAXIMUM.SEC) < TIME_MAXIMUM.MIN) {
	        // min
	        msg = diffTime + "분전";
	    } else if ((diffTime /= TIME_MAXIMUM.MIN) < TIME_MAXIMUM.HOUR) {
	        // hour
	        msg = (diffTime ) + "시간전";
	    } else if ((diffTime /= TIME_MAXIMUM.HOUR) < TIME_MAXIMUM.DAY) {
	        // day
	        msg = (diffTime ) + "일전";
	    } else if ((diffTime /= TIME_MAXIMUM.DAY) < TIME_MAXIMUM.MONTH) {
	        // day
	        msg = (diffTime ) + "달전";
	    } else {
	        msg = (diffTime) + "년전";
	    }
	    

	    return msg;

	}
}
