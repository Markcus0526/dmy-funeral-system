package com.damytech.utils;

import android.graphics.*;
import android.media.ExifInterface;
import android.util.Base64;
import android.widget.ImageView;
import com.damytech.binzang.R;
import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.ImageLoader;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * Created by IntelliJ IDEA
 * User : KimHM
 * Date : 2015-03-17
 * Time : 15:54
 * File Name : BitmapUtility
 */
public class BitmapUtility {
	/**
	 * Method to rotate bitmap clockwise
	 *
	 * @param pathToImage
	 * @param nAngle
	 * @return
	 */
	public static Bitmap rotateImage(String pathToImage, int nAngle) {
		// 2. rotate matrix by post concatination
		Matrix matrix = new Matrix();
		matrix.postRotate(nAngle);

		// 3. create Bitmap from rotated matrix
		BitmapFactory.Options options = new BitmapFactory.Options();
		options.inJustDecodeBounds = false;
		options.inPreferredConfig = Bitmap.Config.RGB_565;
		options.inDither = true;
		Bitmap sourceBitmap = BitmapFactory.decodeFile(pathToImage, options);
		return Bitmap.createBitmap(sourceBitmap, 0, 0, sourceBitmap.getWidth(), sourceBitmap.getHeight(), matrix, true);
	}


	/**
	 * Method to create bitmap with rounded corners
	 *
	 * @param bitmap
	 * @return
	 */
	public static Bitmap getCroppedRoundBitmap(Bitmap bitmap) {
		Bitmap output = Bitmap.createBitmap(bitmap.getWidth(), bitmap.getHeight(), Bitmap.Config.ARGB_8888);
		Canvas canvas = new Canvas(output);

		final int color = 0xff424242;
		final Paint paint = new Paint();
		final Rect rect = new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight());

		paint.setAntiAlias(true);
		canvas.drawARGB(0, 0, 0, 0);
		paint.setColor(color);
//		paint.setFilterBitmap(true);
//		paint.setDither(true);

		canvas.drawOval(new RectF(0, 0, bitmap.getWidth(), bitmap.getHeight()), paint);
		paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
		canvas.drawBitmap(bitmap, rect, rect, paint);

		return output;
	}


	/**
	 * Bitmap file has its orientation internally. User cannot find it.
	 * This is the method to get the internal orientation
	 *
	 * @param imagePath
	 * @return
	 */
	public static int getImageOrientation(String imagePath) {
		int nAngle = 0;

		try {
			File imageFile = new File(imagePath);
			ExifInterface exif = new ExifInterface(imageFile.getAbsolutePath());

			int orientation = exif.getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL);

			switch (orientation) {
				case ExifInterface.ORIENTATION_ROTATE_270:
					nAngle = 270;
					break;
				case ExifInterface.ORIENTATION_ROTATE_180:
					nAngle = 180;
					break;
				case ExifInterface.ORIENTATION_ROTATE_90:
					nAngle = 90;
					break;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return nAngle;
	}


	/**
	 * Method to create round cornered bitmap
	 *
	 * @param bitmap
	 * @param cornerRadiusPx
	 * @return
	 */
	public static Bitmap getRoundedCornerBitmap(Bitmap bitmap, int cornerRadiusPx) {
		Bitmap output = Bitmap.createBitmap(bitmap.getWidth(), bitmap.getHeight(), Bitmap.Config.ARGB_8888);
		Canvas canvas = new Canvas(output);

		final int color = 0xff424242;
		final Paint paint = new Paint();
		final Rect rect = new Rect(0, 0, bitmap.getWidth(), bitmap.getHeight());
		final RectF rectF = new RectF(rect);
		final float roundPx = cornerRadiusPx;

		paint.setAntiAlias(true);
		canvas.drawARGB(0, 0, 0, 0);
		paint.setColor(color);
		canvas.drawRoundRect(rectF, roundPx, roundPx, paint);

		paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));
		canvas.drawBitmap(bitmap, rect, rect, paint);

		return output;
	}


	/**
	 * Method to encode bitmap with base64
	 *
	 * @param bitmap
	 * @return
	 */
	public static String encodeWithBase64(Bitmap bitmap) {
		if (bitmap == null)
			return "";

		ByteArrayOutputStream stream = new ByteArrayOutputStream();
		bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
		byte[] byteArray = stream.toByteArray();
		return Base64.encodeToString(byteArray, Base64.NO_WRAP);
	}



	public static Bitmap decodeJPEGFile(String path, int reqWidth, int reqHeight) {
		// First decode with inJustDecodeBounds=true to check dimensions
		final BitmapFactory.Options options = new BitmapFactory.Options();
		options.inJustDecodeBounds = true;
		BitmapFactory.decodeFile(path, options);

		// Calculate inSampleSize
		options.inSampleSize = calculateInSampleSize(options, reqWidth, reqHeight);

		// Decode bitmap with inSampleSize set
		options.inJustDecodeBounds = false;
		return BitmapFactory.decodeFile(path, options);
	}


	public static int calculateInSampleSize(
			BitmapFactory.Options options, int reqWidth, int reqHeight) {
		// Raw height and width of image
		final int height = options.outHeight;
		final int width = options.outWidth;
		int inSampleSize = 1;

		if (reqHeight < 0 || reqWidth < 0)
			return 1;

		if (height > reqHeight || width > reqWidth) {
			final int halfHeight = height / 2;
			final int halfWidth = width / 2;

			// Calculate the largest inSampleSize value that is a power of 2 and keeps both
			// height and width larger than the requested height and width.
			while ((halfHeight / inSampleSize) > reqHeight
					&& (halfWidth / inSampleSize) > reqWidth) {
				inSampleSize *= 2;
			}
		}

		return inSampleSize;
	}


	public static void correctBitmap(String szPath)
	{
		int nAngle = getImageOrientation(szPath);
		if (nAngle == 0)				// Image is correct. No need to rotate
			return;

		Bitmap bmpRot = BitmapUtility.rotateImage(szPath, nAngle);
		FileOutputStream ostream = null;

		try {
			File file = new File(szPath);
			file.deleteOnExit();

			ostream = new FileOutputStream(file);
			bmpRot.compress(Bitmap.CompressFormat.JPEG, 50, ostream);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (ostream != null) {
				try { ostream.close(); } catch (Exception ex) { ex.printStackTrace(); }
			}
		}
	}



	// Method to load image, not reloading when load the same url
	public static void setImageWithImageLoader(ImageView imgView, String imgUrl, DisplayImageOptions loader_options) {
		if (imgView == null || imgUrl == null || loader_options == null)
			return;

		try {
			boolean needLoad = false;
			Object objitem = imgView.getTag(R.string.image_loader_url);
			if (objitem == null) {
				needLoad = true;
			} else {
				String old_url = (String) objitem;
				if (!old_url.equals(imgUrl))
					needLoad = true;
			}

			if (needLoad) {
				ImageLoader.getInstance().displayImage(imgUrl, imgView, loader_options);
				imgView.setTag(R.string.image_loader_url, imgUrl);
			}

		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}


}
