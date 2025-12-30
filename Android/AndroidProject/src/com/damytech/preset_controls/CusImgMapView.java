package com.damytech.preset_controls;

import java.util.ArrayList;
import java.util.HashMap;

import android.graphics.*;
import android.text.TextPaint;
import com.damytech.binzang.R;

import android.content.Context;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.ScaleGestureDetector;
import android.view.View;
import android.widget.ImageView;
import com.damytech.misc.ConstMgr;


/**
 * Created by IntelliJ IDEA
 * User : KimOC
 * Date : 2015-04-10
 * Time : 10:58
 * File Name : ZhengQuQuanJingActivity
 * Extends Android ImageView to include pinch zooming and panning.
 */
public class CusImgMapView extends ImageView
{
	Matrix matrix = new Matrix();

	public static final int FIT_SCREEN = 0;
	public static final int FIT_HEIGHT = 1;
	public static final int FIT_WIDTH = 2;
	int fitMode = FIT_SCREEN;

	// We can be in one of these 3 states
	static final int NONE = 0;
	static final int DRAG = 1;
	static final int ZOOM = 2;
	int mode = NONE;

	// Remember some things for zooming
	PointF last = new PointF();
	PointF start = new PointF();
	float minScale = 1f;
	float maxScale = 2f;
	float[] m;

	float redundantXSpace, redundantYSpace;

	float width, height;
	static final int CLICK = 3;
	float saveScale = 1f;
	float right, bottom, origWidth, origHeight, bmWidth, bmHeight;

	ScaleGestureDetector mScaleDetector;

	Context context;
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



	/*
	 * containers for the image map areas
	 */
	ArrayList<Area> mAreaList=new ArrayList<Area>();
	
	// click handler list
	ArrayList<OnImageMapClickedHandler> mCallbackList;

	boolean bShowArea = true;
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	// set value for first scale
	private float fScale = 0.0f;
	private float fStartX = 0.0f;
	private float fStartY = 0.0f;

	public CusImgMapView(Context context)
	{
		super(context);
		sharedConstructing(context);
	}

	public CusImgMapView(Context context, AttributeSet attrs)
	{
		super(context, attrs);
		sharedConstructing(context);
	}

	private void sharedConstructing(Context context)
	{
		super.setClickable(true);
		this.context = context;
		mScaleDetector = new ScaleGestureDetector(context, new ScaleListener());
		matrix.setTranslate(1f, 1f);
		m = new float[9];
		setImageMatrix(matrix);
		setScaleType(ScaleType.MATRIX);

		setOnTouchListener(new OnTouchListener()
		{
			@Override
			public boolean onTouch(View v, MotionEvent event)
			{
				mScaleDetector.onTouchEvent(event);

				matrix.getValues(m);
				float x = m[Matrix.MTRANS_X];
				float y = m[Matrix.MTRANS_Y];
				PointF curr = new PointF(event.getX(), event.getY());

				switch (event.getAction())
				{
					case MotionEvent.ACTION_DOWN:
						last.set(event.getX(), event.getY());
						start.set(last);
						mode = DRAG;
						break;
					case MotionEvent.ACTION_MOVE:
						if (mode == DRAG)
						{
							float deltaX = curr.x - last.x;
							float deltaY = curr.y - last.y;
							float scaleWidth = Math.round(origWidth * saveScale);
							float scaleHeight = Math.round(origHeight * saveScale);
							if (scaleWidth < width)
							{
								deltaX = 0;
								if (y + deltaY > 0)
									deltaY = -y;
								else if (y + deltaY < -bottom)
									deltaY = -(y + bottom);
							}
							else if (scaleHeight < height)
							{
								deltaY = 0;
								if (x + deltaX > 0)
									deltaX = -x;
								else if (x + deltaX < -right)
									deltaX = -(x + right);
							}
							else
							{
								if (x + deltaX > 0)
									deltaX = -x;
								else if (x + deltaX < -right)
									deltaX = -(x + right);

								if (y + deltaY > 0)
									deltaY = -y;
								else if (y + deltaY < -bottom)
									deltaY = -(y + bottom);
							}
							matrix.postTranslate(deltaX, deltaY);
							last.set(curr.x, curr.y);
						}
						break;

					case MotionEvent.ACTION_UP:
						mode = NONE;
						int xDiff = (int) Math.abs(curr.x - start.x);
						int yDiff = (int) Math.abs(curr.y - start.y);
						if (xDiff < CLICK && yDiff < CLICK)
							performClick();
						
						if (isScaleOk())
							onScreenTapped((int)event.getX(), (int)event.getY());
						
						break;

					case MotionEvent.ACTION_POINTER_UP:
						mode = NONE;
						break;
				}
				setImageMatrix(matrix);

				float offset_x = m[Matrix.MTRANS_X];
				float offset_y = m[Matrix.MTRANS_Y];
				float scale = m[Matrix.MSCALE_X];

				float bx = getMeasuredHeight();
				float by = getMeasuredWidth();

				updateAreaPos(offset_x, offset_y, scale);

				invalidate();
				return true; // indicate event was handled
			}
		});
	}

	@Override
	public void setImageBitmap(Bitmap bm)
	{
		super.setImageBitmap(bm);
		if (bm != null)
		{
			bmWidth = bm.getWidth();
			bmHeight = bm.getHeight();
		}
	}

	public void setFitMode(int mode) { fitMode = mode; }

	public void setMaxZoom(float x)
	{
		maxScale = x;
	}

	private class ScaleListener extends
			ScaleGestureDetector.SimpleOnScaleGestureListener
	{
		@Override
		public boolean onScaleBegin(ScaleGestureDetector detector)
		{
			mode = ZOOM;
			return true;
		}

		@Override
		public boolean onScale(ScaleGestureDetector detector)
		{
			float mScaleFactor = (float) Math.min(
					Math.max(.95f, detector.getScaleFactor()), 1.05);
			float origScale = saveScale;
			saveScale *= mScaleFactor;
			if (saveScale > maxScale)
			{
				saveScale = maxScale;
				mScaleFactor = maxScale / origScale;
			}
			else if (saveScale < minScale)
			{
				saveScale = minScale;
				mScaleFactor = minScale / origScale;
			}
			right = width * saveScale - width - (2 * redundantXSpace * saveScale);
			bottom = height * saveScale - height
					- (2 * redundantYSpace * saveScale);
			if (origWidth * saveScale <= width || origHeight * saveScale <= height)
			{
				matrix.postScale(mScaleFactor, mScaleFactor, width / 2, height / 2);
				if (mScaleFactor < 1)
				{
					matrix.getValues(m);
					float x = m[Matrix.MTRANS_X];
					float y = m[Matrix.MTRANS_Y];
					if (mScaleFactor < 1)
					{
						if (Math.round(origWidth * saveScale) < width)
						{
							if (y < -bottom)
								matrix.postTranslate(0, -(y + bottom));
							else if (y > 0)
								matrix.postTranslate(0, -y);
						}
						else
						{
							if (x < -right)
								matrix.postTranslate(-(x + right), 0);
							else if (x > 0)
								matrix.postTranslate(-x, 0);
						}
					}
				}
			}
			else
			{
				matrix.postScale(mScaleFactor, mScaleFactor, detector.getFocusX(),
						detector.getFocusY());
				matrix.getValues(m);
				float x = m[Matrix.MTRANS_X];
				float y = m[Matrix.MTRANS_Y];
				if (mScaleFactor < 1)
				{
					if (x < -right)
						matrix.postTranslate(-(x + right), 0);
					else if (x > 0)
						matrix.postTranslate(-x, 0);
					if (y < -bottom)
						matrix.postTranslate(0, -(y + bottom));
					else if (y > 0)
						matrix.postTranslate(0, -y);
				}
			}
			return true;
		}
	}

	@Override
	protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec)
	{
		super.onMeasure(widthMeasureSpec, heightMeasureSpec);
		width = MeasureSpec.getSize(widthMeasureSpec);
		height = MeasureSpec.getSize(heightMeasureSpec);

		float scale;

		if (fitMode == FIT_SCREEN)
		{
			// Fit to screen.
			float scaleX = (float) width / (float) bmWidth;
			float scaleY = (float) height / (float) bmHeight;
			scale = Math.min(scaleX, scaleY);
		}
		else if (fitMode == FIT_HEIGHT)
		{
			// Fit to height
			float scaleY = (float) height / (float) bmHeight;
			scale = scaleY;
		}
		else
		{
			// Fit to width
			float scaleX = (float) width / (float) bmWidth;
			scale = scaleX;
		}
		matrix.setScale(scale, scale);
		setImageMatrix(matrix);
		saveScale = 1f;

		// Center the image
		redundantYSpace = (float) height - (scale * (float) bmHeight);
		redundantXSpace = (float) width - (scale * (float) bmWidth);
		redundantYSpace /= (float) 2;
		redundantXSpace /= (float) 2;

		matrix.postTranslate(redundantXSpace, redundantYSpace);

		origWidth = width - 2 * redundantXSpace;
		origHeight = height - 2 * redundantYSpace;
		right = width * saveScale - width - (2 * redundantXSpace * saveScale);
		bottom = height * saveScale - height - (2 * redundantYSpace * saveScale);
		setImageMatrix(matrix);
		
		///////// change area position
		if (scale != Double.POSITIVE_INFINITY)
		{
			fStartX = redundantXSpace;
			fStartY = redundantYSpace;
			fScale = scale;
		}
	}
	
	
	/////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////

	private void updateAreaPos(float offset_x, float offset_y, float scale)
	{
		for (Area a : mAreaList)
		{
			float x = a.getOrgOriginX() * scale + offset_x;
			float y = a.getOrgOriginY() * scale + offset_y;
			a.setOriginX(x);
			a.setOriginY(y);
		}
	}

	/**
	 * Create a new area and add to tracking
	 * @param name
	 * @param id
	 * @return
	 */
	public Area addShape(String name, int type, float posx, float posy, float radius, long id) {
		Area area = null;
		long _id = 0;
		
		try {
			_id = id;
		}
		catch (Exception e) {
		   _id = 0;
		}
		if (_id != 0) {
			area = new CircleArea(_id, name, type, posx, posy, radius);
			if (area != null) {
				addArea(area);
			}
		}
		return area;
	}
	
	public void addArea( Area a ) {
		mAreaList.add(a);
	}	
	
	private boolean isScaleOk()
	{
		return true;

//		boolean bRet = false;
//
//		if (saveScale == minScale)
//			bRet = true;
//
//		return bRet;
	}
	
	/**
	 * Paint the view
	 *   image first, location decorations next, bubbles on top
	 */
	@Override
	protected void onDraw(Canvas canvas) {
		super.onDraw(canvas);
		
		if (isScaleOk())
		{
			drawLocations(canvas);
		}
	}
	
	protected void drawLocations(Canvas canvas) {
		for (Area a : mAreaList) {
			a.onDraw(canvas);
		}	
	}
	
	/*
	 * on clicked handler add/remove support
	 */
	public void addOnImageMapClickedHandler( OnImageMapClickedHandler h ) {
		if (h != null) {
			if (mCallbackList == null) {
				mCallbackList = new ArrayList<OnImageMapClickedHandler>();
			}
			mCallbackList.add(h);
		}
	}
	
	/*
	 * Screen tapped x, y is screen coord from upper left and does not account
	 * for scroll
	 */
	void onScreenTapped(int x, int y) {
		boolean missed = true;
		// adjust for scroll
		int testx = x;
		int testy = y;
		
		// then check for area taps
		for (Area a : mAreaList) {
			if (a.isInArea((float)testx,(float)testy)) {
				if (mCallbackList != null) {
					for (OnImageMapClickedHandler h : mCallbackList) {
						h.onImageMapClicked(a.getId());						
					}
				}
				missed=false;
				// only fire clicked for one area
				break;
			}
		}

		if (missed) {
			// managed to miss everything, clear bubbles
			//mBubbleMap.clear();
			invalidate();
		}
	}
	
	
	/*
	 * Begin map area support
	 */
	/**
	 *  Area is abstract Base for tappable map areas
	 *   descendants provide hit test and focal point
	 */
	abstract class Area {
		long _id;
		int _type;
		String _name;
		HashMap<String,String> _values;
		Bitmap _decoration = null;
		
		public Area(long id, String name, int type) {
			_id = id;
			_type = type;
			if (name != null) {
				_name = name;
			}
		}
		
		public long getId() {
			return _id;
		}			
		
		public String getName() {
			return _name;
		}
		
		// all xml values for the area are passed to the object
		// the default impl just puts them into a hashmap for
		// retrieval later
		public void addValue(String key, String value) {
			if (_values == null) {
				_values = new HashMap<String, String>();
			}
			_values.put(key, value);
		}
				
		public String getValue(String key) {
			String value = null;
			if (_values != null) {
				value = _values.get(key);
			}
			return value;
		}
		
		// a method for setting a simple decorator for the area
		public void setBitmap(Bitmap b) {
			_decoration = b;
		}
		
		// an onDraw is set up to provide an extensible way to
		// decorate an area.  When drawing remember to take the
		// scaling and translation into account
		public void onDraw(Canvas canvas) {
			if(_type == ConstMgr.AREA_TYPE_SITE)
				_decoration = BitmapFactory.decodeResource(getResources(), R.drawable.preset_imgmap_poi_site);
			else
				_decoration = BitmapFactory.decodeResource(getResources(), R.drawable.preset_imgmap_poi_tablet);

			if (_decoration != null) {
				float x = getOriginX() - _decoration.getWidth() / 2;
				float y = getOriginY() - _decoration.getHeight() / 2;
				canvas.drawBitmap(_decoration, x, y, null);

				TextPaint txtPaint = new TextPaint();
				txtPaint.setTextAlign(Paint.Align.CENTER);
				txtPaint.setTypeface(Typeface.create(Typeface.DEFAULT, Typeface.BOLD));
				txtPaint.setAntiAlias(true);
				txtPaint.setColor(Color.WHITE);
				txtPaint.setTextSize(35);

				Rect bounds = new Rect();
				txtPaint.getTextBounds(_name, 0, _name.length(), bounds);

				canvas.drawText(_name, getOriginX(), y, txtPaint);
			}
		}
		
		abstract boolean isInArea(float x, float y);
		abstract float getOriginX();
		abstract float getOriginY();
		abstract void setOriginX(float x);
		abstract void setOriginY(float y);
		abstract float getOrgOriginX();
		abstract float getOrgOriginY();
	}
	
	/**
	 * Circle Area
	 */
	class CircleArea extends Area {		
		float _x;
		float _y;
		float _radius;

		float _org_x;
		float _org_y;
						
		CircleArea(long id, String name, int type, float x, float y, float radius) {
			super(id, name, type);
			_x = x * fScale + fStartX;
			_y = y * fScale + fStartY;
//			_x = x;
//			_y = y;
			_radius = radius;
			_org_x = x;
			_org_y = y;
		}		
		
		public boolean isInArea(float x, float y) {
			boolean ret = false;
			
			float dx = _x - x;
			float dy = _y - y;
			
			// if tap is less than radius distance from the center
			float d = (float)Math.sqrt((dx * dx) + (dy * dy));
			if (d < _radius) {
				ret = true;
			}

			return ret;
		}

		public float getOriginX() {
			return _x;
		}
		
		public float getOriginY() {
			return _y;
		}
		
		public void setOriginX(float x) {
			_x = x;
		}
		
		public void setOriginY(float y) {
			_y = y;
		}

		public float getOrgOriginX() { return _org_x; }
		public float getOrgOriginY() { return _org_y; }
	}
	
	/**
	 * Map tapped callback interface
	 */
	public interface OnImageMapClickedHandler {
		/**
		 * Area with 'id' has been tapped
		 * @param id
		 */
		void onImageMapClicked(long id);
	}
	
	
	
}