package com.example.lfcFan.util;

import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


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
	
	public static String getUriEncoded(String str) {
		try {
			return URLEncoder.encode(str, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			return str;
		}
	}

	public static String getNewUriRemoved(String uri, String paramName) {
		String deleteStrStarts = paramName + "=";
		int delStartPos = uri.indexOf(deleteStrStarts);

		if (delStartPos != -1) {
			int delEndPos = uri.indexOf("&", delStartPos);

			if (delEndPos != -1) {
				delEndPos++;
				uri = uri.substring(0, delStartPos) + uri.substring(delEndPos, uri.length());
			} else {
				uri = uri.substring(0, delStartPos);
			}
		}

		if (uri.charAt(uri.length() - 1) == '?') {
			uri = uri.substring(0, uri.length() - 1);
		}

		if (uri.charAt(uri.length() - 1) == '&') {
			uri = uri.substring(0, uri.length() - 1);
		}

		return uri;
	}

	public static String getNewUri(String uri, String paramName, String paramValue) {
		uri = getNewUriRemoved(uri, paramName);

		if (uri.contains("?")) {
			uri += "&" + paramName + "=" + paramValue;
		} else {
			uri += "?" + paramName + "=" + paramValue;
		}

		uri = uri.replace("?&", "?");

		return uri;
	}

	public static String getNewUriAndEncoded(String uri, String paramName, String pramValue) {
		return getUriEncoded(getNewUri(uri, paramName, pramValue));
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
	
	public static String sha256(String base) {
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(base.getBytes("UTF-8"));
			StringBuffer hexString = new StringBuffer();

			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff & hash[i]);
				if (hex.length() == 1)
					hexString.append('0');
				hexString.append(hex);
			}

			return hexString.toString();

		} catch (Exception ex) {
			return "";
		}
	}
	
	public static String getDateStrLater(int seconds) {
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String dateStr = format1.format(System.currentTimeMillis() + seconds * 1000);

		return dateStr;
	}
	
	public static Map<String, Object> mapOf(Object... args) {
		if (args.length % 2 != 0) {
			throw new IllegalArgumentException("인자를 짝수개 입력해주세요.");
		}

		int size = args.length / 2;

		Map<String, Object> map = new LinkedHashMap<>();

		for (int i = 0; i < size; i++) {
			int keyIndex = i * 2;
			int valueIndex = keyIndex + 1;

			String key;
			Object value;

			try {
				key = (String) args[keyIndex];
			} catch (ClassCastException e) {
				throw new IllegalArgumentException("키는 String으로 입력해야 합니다. " + e.getMessage());
			}

			value = args[valueIndex];

			map.put(key, value);
		}

		return map;
	}

	public static String getFileExtTypeCodeFromFileName(String fileName) {
		String ext = getFileExtFromFileName(fileName).toLowerCase();

		switch (ext) {
		case "jpeg":
		case "jpg":
		case "gif":
		case "png":
			return "img";
		case "mp4":
		case "avi":
		case "mov":
			return "video";
		case "mp3":
			return "audio";
		}

		return "etc";
	}

	public static String getFileExtType2CodeFromFileName(String fileName) {
		String ext = getFileExtFromFileName(fileName).toLowerCase();

		switch (ext) {
		case "jpeg":
		case "jpg":
			return "jpg";
		case "gif":
			return ext;
		case "png":
			return ext;
		case "mp4":
			return ext;
		case "mov":
			return ext;
		case "avi":
			return ext;
		case "mp3":
			return ext;
		}

		return "etc";
	}

	public static String getFileExtFromFileName(String fileName) {
		int pos = fileName.lastIndexOf(".");
		String ext = fileName.substring(pos + 1);

		return ext;
	}

	public static String getNowYearMonthDateStr() {
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy_MM");

		String dateStr = format1.format(System.currentTimeMillis());

		return dateStr;
	}
	
	public static boolean isEmpty(Object data) {
		if (data == null) {
			return true;
		}

		if (data instanceof String) {
			String strData = (String) data;

			return strData.trim().length() == 0;
		} else if (data instanceof Integer) {
			Integer integerData = (Integer) data;

			return integerData != 0;
		} else if (data instanceof List) {
			List listData = (List) data;

			return listData.isEmpty();
		} else if (data instanceof Map) {
			Map mapData = (Map) data;

			return mapData.isEmpty();
		}

		return true;
	}

	
	public static <T> T ifEmpty(T data, T defaultValue) {
		if ( isEmpty(data) ) {
			return defaultValue;
		}
		
		return data;
	}
	
	public static List<Integer> getListDividedBy(String str, String divideBy) {
		return Arrays.asList(str.split(divideBy)).stream().map(s -> Integer.parseInt(s.trim())).collect(Collectors.toList());
	}
	
	public static boolean delteFile(String filePath) {
		java.io.File ioFile = new java.io.File(filePath);
		if (ioFile.exists()) {
			return ioFile.delete();
		}

		return true;
	}
	
	public static String numberFormat(int num) {
		DecimalFormat df = new DecimalFormat("###,###,###");

		return df.format(num);
	}

	public static String numberFormat(String numStr) {
		return numberFormat(Integer.parseInt(numStr));
	}

	public static int sumGame(Map<String, Object> param) {
		int win=getAsInt(param.get("win"),0);
		int draw=getAsInt(param.get("draw"),0);
		int lose=getAsInt(param.get("lose"),0);
		int game=win+draw+lose;
		return game;
	}

	public static int goalGap(Map<String, Object> param) {
		int gainGoal=getAsInt(param.get("gainGoal"),0);
		int loseGoal=getAsInt(param.get("loseGoal"),0);
		int goalGap=gainGoal-loseGoal;
		return goalGap;
	}

	public static int getPoint(Map<String, Object> param) {
		int win=getAsInt(param.get("win"),0);
		int draw=getAsInt(param.get("draw"),0);
		int point=win*3+draw*1;
		return point;
	}
	
	public static String getMonth(Map<String, Object> param) {
		String iDate =  Util.getAsStr(param.get("date"),"");
		DateFormat dateFormat = new SimpleDateFormat ("yyyy-MM-dd");
		String month="";
		try {
			Date inputDate = dateFormat.parse(iDate);

			SimpleDateFormat fm = new SimpleDateFormat("M");

			month = fm.format(inputDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return month;
	}

	public static String sumRound(Map<String, Object> param) {
		String round="";
		if(Util.getAsStr(param.get("League"),"").equals("direct")) {
			round=Util.getAsStr(param.get("other"),"")+Util.getAsStr(param.get("round"),"")+"R";
		}
		else{
			round=getAsStr(param.get("League"),"")+Util.getAsStr(param.get("round"),"")+"R";
		}
		
		return round;
	}

	public static String changeParam(Map<String, Object> param) {
		return "driect-"+Util.getAsStr(param.get("other"),"");
	}
}
