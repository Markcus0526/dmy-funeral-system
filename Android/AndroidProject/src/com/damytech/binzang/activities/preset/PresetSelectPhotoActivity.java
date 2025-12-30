package com.damytech.binzang.activities.preset;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.CursorLoader;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.*;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.DocumentsContract;
import android.provider.MediaStore;
import android.util.FloatMath;
import android.view.*;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import com.damytech.binzang.R;
import com.damytech.preset_controls.PhotoClipView;
import com.damytech.utils.BitmapUtility;
import com.damytech.utils.ToastUtility;


import java.io.*;

/**
 * Created with IntelliJ IDEA.
 * User: KimHakMin
 * Date: 13-11-29
 * Time: 上午10:59
 */
public class PresetSelectPhotoActivity extends SuperActivity {
	// Image quality constants
	public static final int IMAGE_QUALITY_NO_LIMIT = 1;
	public static final int IMAGE_QUALITY_BELOW1300 = 2;
	public static final int IMAGE_QUALITY_BELOW800 = 3;
	public static final int IMAGE_QUALITY_BELOW500 = 4;
	public static final int IMAGE_QUALITY_BELOW300 = 5;


	// Image crop variable
	private boolean needCrop = false;

	// Image quality
	private static int image_quality = IMAGE_QUALITY_BELOW1300;

	// Take photo buttons
	private Button btn_takephoto = null, btn_selimage = null, btn_cancel = null;

	// Image crop controls
	private RelativeLayout maskLayout = null;
	private PhotoClipView clipView = null;
	private ImageView imgSel = null;
	private Button btnConfirm = null;

	private static Uri fileUri = null;

	public static int REQCODE_TAKE_PHOTO = 0;
	public static int REQCODE_SELECT_GALLERY = 1;

	public static String szRetCode = "RET";
	public static String szRetPath = "PATH";

	public static int nRetSuccess = 1;
	public static int nRetCancelled = 0;
	public static int nRetFail = -1;

	private String photo_path = "";
	private Uri photo_uri = null;
	private Bitmap bmpPhoto = null;

	private boolean isFromCamera = true;
	private String resPath = "";

	private int statusBarHeight = 0;
	private int titleBarHeight = 0;

	// These matrices will be used to move and zoom image
	Matrix matrix = new Matrix();
	Matrix savedMatrix = new Matrix();

	// Remember some things for zooming
	PointF start = new PointF();
	PointF mid = new PointF();
	float oldDist = 1f;

	// We can be in one of these 3 states
	static final int NONE = 0;
	static final int DRAG = 1;
	static final int ZOOM = 2;

	int mode = NONE;


	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState, R.layout.preset_activity_selphoto);
	}

	public void initializeActivity()
	{
		btn_takephoto = null;
		btn_selimage = null;
		btn_cancel = null;

		REQCODE_TAKE_PHOTO = 0;
		REQCODE_SELECT_GALLERY = 1;

		szRetCode = "RET";
		szRetPath = "PATH";

		nRetSuccess = 1;
		nRetCancelled = 0;
		nRetFail = -1;

		photo_path = "";
		photo_uri = null;


		btn_takephoto = (Button)findViewById(R.id.btn_take_photo);
		btn_selimage = (Button)findViewById(R.id.btn_sel_image);
		btn_cancel = (Button)findViewById(R.id.btn_cancel);

		maskLayout = (RelativeLayout)findViewById(R.id.crop_layout);
		maskLayout.setVisibility(View.GONE);

		imgSel = (ImageView)findViewById(R.id.img_sel);
		imgSel.setOnTouchListener(new View.OnTouchListener() {
			@Override
			public boolean onTouch(View v, MotionEvent event) {
				ImageView view = (ImageView) v;

				// Handle touch events here...
				switch (event.getAction() & MotionEvent.ACTION_MASK)
				{
					case MotionEvent.ACTION_DOWN:
						savedMatrix.set(matrix);
						start.set(event.getX(), event.getY());

						mode = DRAG;
						break;
					case MotionEvent.ACTION_POINTER_DOWN:
						oldDist = spacing(event);

						if (oldDist > 10f)
						{
							savedMatrix.set(matrix);
							midPoint(mid, event);
							mode = ZOOM;
						}
						break;
					case MotionEvent.ACTION_UP:
					case MotionEvent.ACTION_POINTER_UP:
						mode = NONE;

						break;
					case MotionEvent.ACTION_MOVE:
						if (mode == DRAG) {
							matrix.set(savedMatrix);
							matrix.postTranslate(event.getX() - start.x, event.getY() - start.y);
						} else if (mode == ZOOM) {
							float newDist = spacing(event);
							if (newDist > 10f)
							{
								matrix.set(savedMatrix);
								float scale = newDist / oldDist;
								matrix.postScale(scale, scale, mid.x, mid.y);
							}
						}
						break;
				}

				view.setImageMatrix(matrix);
				return true;
			}
		});

		clipView = (PhotoClipView)findViewById(R.id.clipview);

		btnConfirm = (Button)findViewById(R.id.btn_confirm);
		btnConfirm.setOnClickListener(new View.OnClickListener() {
			@Override
			public void onClick(View v) {
				finishCrop();
			}
		});


		btn_takephoto.setOnClickListener(onClickTakePhoto);
		btn_selimage.setOnClickListener(onClickSelImage);
		btn_cancel.setOnClickListener(onClickCancel);
	}


	@Override
	protected void onResume()
	{
		super.onResume();	//To change body of overridden methods use File | Settings | File Templates.

		if (resPath == null || resPath.equals(""))
			return;

		if (isFromCamera)
			BitmapUtility.correctBitmap(resPath);

		if (!needCrop) {
			finishActivityWithImage();
		} else {
			try {
				BitmapFactory.Options options = new BitmapFactory.Options();

				options.inJustDecodeBounds = false;
				options.inPreferredConfig = Bitmap.Config.RGB_565;
				options.inDither = true;

				bmpPhoto = BitmapFactory.decodeFile(resPath, options);

				float scale = 0.75F * (float)screen_size.x/(float)bmpPhoto.getWidth();
				matrix.setScale(1F, 1F);
				matrix.postScale(scale, scale);
				matrix.postTranslate((float)screen_size.x / 8F,
						(float)screen_size.y * 0.25F - (float)bmpPhoto.getHeight() * scale * 0.25F);
				imgSel.setImageMatrix(matrix);
				imgSel.setImageBitmap(bmpPhoto);

			} catch (Exception ex) {
				ex.printStackTrace();
			}

			maskLayout.setVisibility(View.VISIBLE);
		}
	}


	private void finishActivityWithImage()
	{
		Intent retIntent = new Intent();
		retIntent.putExtra(szRetCode, nRetSuccess);
		retIntent.putExtra(szRetPath, resPath);
		setResult(RESULT_OK, retIntent);
		popOverCurActivityAnimated();
	}


	/** Determine the space between the first two fingers */
	private float spacing(MotionEvent event)
	{
		float x = event.getX(0) - event.getX(1);
		float y = event.getY(0) - event.getY(1);
		return FloatMath.sqrt(x * x + y * y);
	}

	/** Calculate the mid point of the first two fingers */
	private void midPoint(PointF point, MotionEvent event)
	{
		float x = event.getX(0) + event.getX(1);
		float y = event.getY(0) + event.getY(1);
		point.set(x / 2, y / 2);
	}


	private void finishCrop()
	{
		Bitmap finalBmp = getBitmap();

		// Save image
		FileOutputStream out = null;
		try {
			if (!isFromCamera) {
				File file = getOutputPhotoFile();
				if (file == null)
					ToastUtility.showToast(PresetSelectPhotoActivity.this, R.string.STR_CANNOT_TAKEPHOTO);
				else
					resPath = file.getPath();
			}

			out = new FileOutputStream(resPath);
			finalBmp.compress(Bitmap.CompressFormat.PNG, 100, out);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {
				if (out != null)
					out.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		}

		finishActivityWithImage();
	}


	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		if (keyCode == KeyEvent.KEYCODE_BACK)
		{
			if (maskLayout.getVisibility() == View.VISIBLE) {
				maskLayout.setVisibility(View.GONE);
				return true;
			}
		}

		return super.onKeyDown(keyCode, event);
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data)
	{
		super.onActivityResult(requestCode, resultCode, data);

		if (resultCode != RESULT_OK)
			return;

		if (requestCode == REQCODE_TAKE_PHOTO)
		{
			Uri photoUri = null;

			if (data == null)
				photoUri = fileUri;
			else
				photoUri = data.getData();

			try
			{
				if (photoUri != null)
				{
					String szPath = photoUri.getPath();
					if (szPath == null || szPath.equals(""))
					{
						ToastUtility.showToast(PresetSelectPhotoActivity.this, R.string.STR_LOADING_IMAGE_FAILED);
					}
					else
					{
						photo_path = szPath;
						photo_uri = null;
					}
				}
				else
				{
					photo_path = fileUri.getPath();
					photo_uri = null;
				}
			}
			catch (Exception ex)
			{
				ex.printStackTrace();
				ToastUtility.showToast(PresetSelectPhotoActivity.this, R.string.STR_TAKING_PHOTO_FAILED);
			}
		}
		else if (requestCode == REQCODE_SELECT_GALLERY)
		{
			if (resultCode == RESULT_OK && data != null)
			{
				Uri selImage = data.getData();
				if (selImage != null)
				{
					if (selImage.toString().contains("file://")) {
						photo_path = selImage.getPath();
						photo_uri = null;
					} else {
						photo_path = "";
						photo_uri = selImage;
					}
				}
				else
				{
				}
			}
			else
			{
			}
		}


		if (photo_path != null && !photo_path.equals(""))
		{
			resPath = photo_path;
			isFromCamera = true;
		}
		else if (photo_uri != null)
		{
			resPath = RealPathUtil.INSTANCE.getRealPathFromURI(PresetSelectPhotoActivity.this, photo_uri);
			isFromCamera = false;
		}
	}


	public View.OnClickListener onClickTakePhoto = new View.OnClickListener() {
		@Override
		public void onClick(View v) {
			Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
			File file = getOutputPhotoFile();
			if (file == null) {
				ToastUtility.showToast(PresetSelectPhotoActivity.this, R.string.STR_CANNOT_TAKEPHOTO);
			} else {
				fileUri = Uri.fromFile(file);
				intent.putExtra(MediaStore.EXTRA_OUTPUT, fileUri);
				startActivityForResult(intent, REQCODE_TAKE_PHOTO);
			}
		}
	};


	public View.OnClickListener onClickSelImage = new View.OnClickListener()
	{
		@Override
		public void onClick(View v)
		{
			Intent intent = new Intent();
			intent.setType("image/*");
			intent.setAction(Intent.ACTION_GET_CONTENT);
			startActivityForResult(Intent.createChooser(intent, "Select Picture"), REQCODE_SELECT_GALLERY);
		}
	};


	public View.OnClickListener onClickCancel = new View.OnClickListener()
	{
		@Override
		public void onClick(View v)
		{
			cancelWithData();
		}
	};


	private File getOutputPhotoFile()
	{
		File directory = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES), getPackageName());
		if (!directory.exists())
		{
			if (!directory.mkdirs()) {		  // No sd card.
				directory = null;
			}
		}

		if (directory == null)
		{
			directory = getDir(getPackageName(), Context.MODE_PRIVATE);
			if (!directory.exists())
			{
				if (!directory.mkdir())
					directory = null;
			}
		}

		if (directory == null)
			return null;

		String timeStamp = "userPhoto";
		return new File(directory.getPath() + File.separator + "IMG_" + timeStamp + ".jpg");
	}


	private void cancelWithData()
	{
		Intent returnIntent = new Intent();
		setResult(RESULT_CANCELED, returnIntent);
		PresetSelectPhotoActivity.this.finish();
	}



	private Bitmap getBitmap()
	{
		getBarHeight();
		Bitmap screenShoot = takeScreenShot();

		int width = clipView.getWidth();
		int height = clipView.getHeight();

		Bitmap finalBitmap = Bitmap.createBitmap(screenShoot,
				(width - height / 2) / 2, height / 4 + titleBarHeight + statusBarHeight,
				height / 2,
				height / 2);

		return finalBitmap;
	}

	private void getBarHeight()
	{
		Rect frame = new Rect();
		this.getWindow().getDecorView().getWindowVisibleDisplayFrame(frame);
		statusBarHeight = frame.top;

		int contenttop = this.getWindow().findViewById(Window.ID_ANDROID_CONTENT).getTop();
		titleBarHeight = contenttop - statusBarHeight;
	}

	private Bitmap takeScreenShot()
	{
		View view = this.getWindow().getDecorView();
		view.setDrawingCacheEnabled(true);
		view.buildDrawingCache();
		return view.getDrawingCache();
	}



	/**
	 * Static methods
	 */
	public static Bitmap setBitmapToUserView(ImageView view, Intent data, int quality)
	{
		image_quality = quality;

		if (data.getIntExtra(PresetSelectPhotoActivity.szRetCode, -999) == PresetSelectPhotoActivity.nRetSuccess)
		{
			Object objPath = data.getExtras().get(PresetSelectPhotoActivity.szRetPath);
			String szPath = "";

			if (objPath != null)
				szPath = (String)objPath;

			if (szPath != null && !szPath.equals(""))
				return setBitmapToView(view, szPath);
		}

		return null;
	}

	public static Bitmap setBitmapToView(ImageView view, String szPath)
	{
		/* Update user photo info view */
		Bitmap retbmp = BitmapUtility.decodeJPEGFile(szPath, getMaxImgSize(), getMaxImgSize());
		view.setImageBitmap(retbmp);

		return retbmp;
	}


	public static int getMaxImgSize() {
		switch (image_quality) {
			case IMAGE_QUALITY_NO_LIMIT:
				return -1;
			default:
			case IMAGE_QUALITY_BELOW1300:
				return 1300;
			case IMAGE_QUALITY_BELOW800:
				return 800;
			case IMAGE_QUALITY_BELOW500:
				return 500;
			case IMAGE_QUALITY_BELOW300:
				return 300;
		}
	}


	public enum RealPathUtil {
		INSTANCE;

		public static String getRealPathFromURI(Context context, Uri uri)
		{
			if (Build.VERSION.SDK_INT < Build.VERSION_CODES.HONEYCOMB)
			{
				return getRealPathFromURI_BelowAPI11(context, uri);
			}
			else if (Build.VERSION.SDK_INT < Build.VERSION_CODES.KITKAT)
			{
				return getRealPathFromURI_API11to18(context, uri);
			}
			else
			{
				return getRealPathFromURI_API19(context, uri);
			}
		}

		@SuppressLint("NewApi")
		public static String getRealPathFromURI_API19(Context context, Uri uri) {
			String filePath = "";
			String wholeID = "";

			try {
				wholeID = DocumentsContract.getDocumentId(uri);
			} catch (Exception ex) {
				ex.printStackTrace();			// Android 4.4.2 can occur this exception.

				return getRealPathFromURI_API11to18(context, uri);
			}

			// Split at colon, use second item in the array
			String id = wholeID.split(":")[1];

			String[] column = { MediaStore.Images.Media.DATA };

			// where id is equal to
			String sel = MediaStore.Images.Media._ID + "=?";

			Cursor cursor = context.getContentResolver().query(MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
					column,
					sel,
					new String[] { id },
					null);

			int columnIndex = cursor.getColumnIndex(column[0]);

			if (cursor.moveToFirst()) {
				filePath = cursor.getString(columnIndex);
			}

			cursor.close();
			return filePath;
		}


		@SuppressLint("NewApi")
		public static String getRealPathFromURI_API11to18(Context context, Uri contentUri) {
			String[] proj = { MediaStore.Images.Media.DATA };
			String result = null;

			CursorLoader cursorLoader = new CursorLoader(
					context,
					contentUri,
					proj,
					null,
					null,
					null);

			Cursor cursor = cursorLoader.loadInBackground();

			if (cursor != null) {
				int column_index = cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
				cursor.moveToFirst();
				result = cursor.getString(column_index);
			}

			return result;
		}

		public static String getRealPathFromURI_BelowAPI11(Context context, Uri contentUri){
			String[] proj = { MediaStore.Images.Media.DATA };
			Cursor cursor = context.getContentResolver().query(contentUri, proj, null, null, null);
			int column_index
					= cursor.getColumnIndexOrThrow(MediaStore.Images.Media.DATA);
			cursor.moveToFirst();
			return cursor.getString(column_index);
		}
	}

}
