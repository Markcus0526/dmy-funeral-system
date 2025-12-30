package com.damytech.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-03-17
 * Time : 15:31
 * File Name : StringUtility
 */
public class StringUtility {
	/**
	 * Method to remove all the space characters in the string
	 *
	 * @param szText	String to remove spaces
	 * @return			String without space characters
	 */
	public static String eatSpaces(String szText) {
		return szText.replaceAll(" ", "");
	}


	/**
	 * Method to remove '.' characters in the string
	 *
	 * @param szText	String to remove fullstops
	 * @return			String without fullstops
	 */
	public static String eatFullStops(String szText) {
		return szText.replaceAll(".", "");
	}


	/**
	 * Method to remove @replacement string part in the specified string
	 *
	 * @return			String without fullstops
	 */
	public static String eatString(String szText, String replacement) {
		return szText.replaceAll(replacement, "");
	}



	/**
	 * Method to remove chinese punctuations in the string
	 *
	 * @param szText	String to remove Chinese punctuations
	 * @return			String without Chinese punctuations
	 */
	public static String eatChinesePunctuations(String szText) {
		String szResult = szText;
		String szPuncs = "。？！，、；：“”‘’（）-·《》〈〉";
		String szPuncs2 = "——";
		String szPuncs3 = "……";

		szResult = szResult.replaceAll(szPuncs2, "");
		szResult = szResult.replaceAll(szPuncs3, "");

		for (int i = 0; i < szPuncs.length(); i++) {
			char chrItem = szPuncs.charAt(i);
			String szItem = "" + chrItem;
			szResult = szResult.replaceAll(szItem, "");
		}

		return szResult;
	}


	/**
	 * Method to convert int value to character
	 *
	 * @param iCol		number to convert.
	 * @return			Corresponding character
	 */
	public static String convertToLetter(int iCol) {
		String szResult = "";
		int iAlpha;
		int iRemainder = 0;

		iAlpha = iCol / 27;
		iRemainder = iCol - (iAlpha * 26);

		if (iAlpha > 0)
			szResult = Character.toString((char) (iAlpha + 64));

		if (iRemainder > 0)
			szResult += Character.toString((char) (iRemainder + 64));

		return szResult;
	}


	/**
	 * Method to validate if the string is email format.
	 *
	 * @param email
	 * @return
	 */
	public static boolean validateEmail(String email) {
		boolean isValid = false;

		String expression = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{2,4}$";
		CharSequence inputStr = email;

		Pattern pattern = Pattern.compile(expression, Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(inputStr);
		if (matcher.matches())
			isValid = true;

		return isValid;
	}


	/**
	 * Validate if the string is numeric
	 *
	 * @param phone
	 * @return
	 */
	public static boolean isNumeric(String phone) {
		boolean isValid = false;

		String expression = "\\d+";
		CharSequence inputStr = phone;

		Pattern pattern = Pattern.compile(expression, Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(inputStr);
		if (matcher.matches())
			isValid = true;

		return isValid;
	}


	/**
	 * Method to encode string using UTF8 charset
	 *
	 * @param str
	 * @return
	 */
	public static String encodeToUTF8(String str) {
		String tmp;

		try {
			tmp = URLEncoder.encode(str, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			tmp = str;
		}

		return tmp;
	}


	/**
	 * Method to convert double to string without unnecessary zeroes
	 */
	public static String formatDouble(double d) {
		d = (int)(d * 1000) / 1000.0;

		if (d == (long)d) {
			return "" + (long)d;
		} else {
			return String.format("%s", d);
		}
	}


	/**
	 * Method to create MD5 hash
	 */
	public static String MD5Hash(String value) {
		final String MD5 = "MD5";
		String result = "";

		try {
			// Create MD5 Hash
			MessageDigest digest = java.security.MessageDigest.getInstance(MD5);
			digest.update(value.getBytes());
			byte messageDigest[] = digest.digest();

			// Create Hex String
			StringBuilder hexString = new StringBuilder();
			for (byte aMessageDigest : messageDigest) {
				String h = Integer.toHexString(0xFF & aMessageDigest);
				while (h.length() < 2)
					h = "0" + h;
				hexString.append(h);
			}

			result = hexString.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return result;
	}

}
