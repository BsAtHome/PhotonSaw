package dk.osaa.psaw.job;

import java.awt.Image;
import java.awt.Shape;
import java.awt.geom.Arc2D;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.PathIterator;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.Collections;
import java.util.logging.Level;

import com.kitfox.svg.RenderableElement;
import com.kitfox.svg.SVGElement;
import com.kitfox.svg.SVGException;
import com.kitfox.svg.SVGGraphics2D;
import com.kitfox.svg.SVGRoot;
import com.kitfox.svg.xml.StyleAttribute;

import lombok.Getter;
import lombok.Setter;
import lombok.val;
import lombok.extern.java.Log;

import de.erichseifert.vectorgraphics2d.VectorGraphics2D;

/**
 * A graphics context that can be passed to SVGSalamander to have it render the svg primitives into a JobNodeGroup
 * 
 * @author Flemming Frandsen <dren.dk@gmail.com> <http://dren.dk>
 */
@Log
public class Graphics2DJobNodeGroup extends VectorGraphics2D implements
		SVGGraphics2D {

	private Job job;
	private JobNodeGroup jobNodeGroup;
	private RenderableElement element;

	/**
	 * The length of lines that make up curves
	 */
	@Getter
	@Setter
	private double curveFlatness;

	/**
	 * The default power to use when cutting or engraving, when nothing is
	 * specified by the svg
	 */
	@Getter
	@Setter
	private double defaultPower;

	/**
	 * The default speed to use when cutting or engraving, when nothing is
	 * specified by the svg
	 */
	@Getter
	@Setter
	private double defaultSpeed;

	/**
	 * The maximum power available for cutting and engraving
	 */
	@Getter
	@Setter
	private double maximumPower;
	
	/**
	 * The duration of each pulse, if no photonsaw-pulse-duration is used 
	 */
	@Getter
	@Setter
	private int defaultPulseDuration;
	
	/**
	 * The number of pulses per mm, if no photonsaw-ppmm style is used 
	 */
	@Getter
	@Setter
	private int defaultPpmm;

	public Graphics2DJobNodeGroup(Job job, JobNodeGroup jobNodeGroup) {
		super(0, 0, 2000, 1000);
		this.job = job;
		this.jobNodeGroup = jobNodeGroup;
		curveFlatness = 0.1;
		defaultPower = 80;
		maximumPower = 80;
		defaultSpeed = 6;
		defaultPulseDuration = 3000; // 3 ms
		defaultPpmm = 100;
	}

	@Override
	public void startRendering(RenderableElement element) {
		this.element = element;
		log.info("Rendering SVG element: "+element.getId());
	}
	
	LaserNodeSettings getLaserNodeSettings() {
		return new LaserNodeSettings(getPower()/maximumPower, getSpeed(), getPasses(), getAssistAir(), getPulsesPermm(), getPulseDuration());
	}
	
	void addChild(JobNode newChild) {
		val stack = new ArrayList<SVGElement>();  
		
		
		SVGElement e = element;
		while ((e = e.getParent()) != null && !(e instanceof SVGRoot)) {
			if (e.getId() != null) {
				stack.add(e);
			}
		}
		
		Collections.reverse(stack);
		
		JobNodeGroup parent = jobNodeGroup;
		for (val elem : stack) {
			
			String id=elem.getId();
			String label = id;
			
			StyleAttribute labelAttr = new StyleAttribute("inkscape:label");
			try {
				elem.getPres(labelAttr);
			} catch (SVGException ex) {
			}
			if (labelAttr != null) {
				label = labelAttr.getStringValue();
			}
			
			JobNode jn = parent.getChildById(id);

			if (jn == null) {
				val np = new JobNodeGroup(id);
				np.setName(label);
				parent.addChild(np);
				parent = np;

			} else if (jn instanceof JobNodeGroup) {
				parent = (JobNodeGroup)jn; 

			} else {
				// Hmm, this is not good.
				log.severe("Found a parent item that corrosponds to a job node which is not a group: "+jn.toString());				
			}
		}
		
		parent.addChild(newChild);		
	}
	
	
	void addCutPath(ArrayList<Point2D> points) {
		ArrayList<Point2D> newPoints = new ArrayList<Point2D>();
		for (Point2D p : points) {
			Point2D np = new Point2D(p.getX(), p.getY());
			np.transform(getTransform());
			newPoints.add(np);
		}
		
		CutPath path = new CutPath(job.getNodeId(getId()), getLaserNodeSettings(), newPoints);
		log.info("Appending CutPath: "+path.getId());
		addChild(path);
	}

	@Override
	public FontRendering getFontRendering() {
		return FontRendering.VECTORS; // We don't want to handle text so get it as vectors
	}
			
	public void fill(Shape s) {
		// TODO: Add some sort of handling for filling shapes in stead of ignoring them
		log.warning("Going to cut outline of shape in stead of filling it");
		writeClosingDraw(s);
		// writeClosingFill(s);
	}

	@Override
	protected void writeClosingDraw(Shape s) {
		if (s instanceof Line2D) {
			Line2D l = (Line2D) s;
			val points = new ArrayList<Point2D>();
			points.add(new Point2D(l.getX1(), l.getY1()));
			points.add(new Point2D(l.getX2(), l.getY2()));
			addCutPath(points);
			return;

		} else if (s instanceof Rectangle2D) {
			Rectangle2D r = (Rectangle2D) s;
			val points = new ArrayList<Point2D>();
			points.add(new Point2D(r.getX(), r.getY()));
			points.add(new Point2D(r.getX() + r.getWidth(), r.getY()));
			points.add(new Point2D(r.getX() + r.getWidth(), r.getY() + r.getHeight()));
			points.add(new Point2D(r.getX(), r.getY() + r.getHeight()));
			points.add(new Point2D(r.getX(), r.getY()));
			addCutPath(points);
			return;

		} else if (s instanceof Ellipse2D) {
			/*
			 * Ellipse2D e = (Ellipse2D) s; double x = e.getX() +
			 * e.getWidth()/2.0; double y = e.getY() + e.getHeight()/2.0; double
			 * rx = e.getWidth()/2.0; double ry = e.getHeight()/2.0;
			 */
			throw new RuntimeException("Ellipse not implemented, try a path in stead, sorry");

		} else if (s instanceof Arc2D) {

			throw new RuntimeException("Arc2D not implemented, try a path in stead, sorry");

			/*
			 * Arc2D e = (Arc2D) s; double x = (e.getX() + e.getWidth()/2.0);
			 * double y = (e.getY() + e.getHeight()/2.0); double rx =
			 * e.getWidth()/2.0; double ry = e.getHeight()/2.0; double
			 * startAngle = -e.getAngleStart(); double endAngle =
			 * -(e.getAngleStart() + e.getAngleExtent()); write(x, " ", y, " ",
			 * rx, " ", ry, " ", startAngle, " ", endAngle, " ellipse"); if
			 * (e.getArcType() == Arc2D.CHORD) { write(" Z"); } else if
			 * (e.getArcType() == Arc2D.PIE) { write(" ", x, " ", y, " L Z"); }
			 * return;
			 */
			
		} else {
			PathIterator segments = s.getPathIterator(null, curveFlatness);
			double[] coordsCur = new double[6];
			double[] pointPrev = new double[2];
			ArrayList<Point2D> points = null;

			while (!segments.isDone()) {
				int segmentType = segments.currentSegment(coordsCur);

				if (segmentType == PathIterator.SEG_MOVETO) {
					pointPrev[0] = coordsCur[0];
					pointPrev[1] = coordsCur[1];

					if (points != null) {
						addCutPath(points);
					}
					points = new ArrayList<Point2D>();
					points.add(new Point2D(coordsCur[0], coordsCur[1]));

				} else if (segmentType == PathIterator.SEG_LINETO) {
					points.add(new Point2D(coordsCur[0], coordsCur[1]));
					pointPrev[0] = coordsCur[0];
					pointPrev[1] = coordsCur[1];

					// } else if (segmentType == PathIterator.SEG_CUBICTO) { //
					// Should be flattened for us
					// } else if (segmentType == PathIterator.SEG_QUADTO) { //
					// Should be flattened for us

				} else if (segmentType == PathIterator.SEG_CLOSE) {
					points.add(points.get(0));
					addCutPath(points);
					points = null;

				} else {
					throw new RuntimeException("Unimplemented segment type for path: "+ segmentType);
				}

				segments.next();
			}
			if (points != null) {
				addCutPath(points);
			}
		}
	}
	
	double getPower() {
		double power = defaultPower;
		if (element != null) {
			StyleAttribute powerAttr = new StyleAttribute("photonsaw-power");
			try {
				element.getStyle(powerAttr, true);
			} catch (SVGException e) {
				log.log(Level.WARNING, "Failed to get power attribute from svg element", e);
				powerAttr = null;
			}
			if (powerAttr != null && !powerAttr.getStringValue().equals("")) {
				power = Math.min(maximumPower,Math.max(0, powerAttr.getDoubleValue()));
			}
		}
		return power;
	}
	
	double getSpeed() {
		double speed = defaultSpeed;
		if (element != null) {
			StyleAttribute speedAttr = new StyleAttribute("photonsaw-speed");
			try {
				element.getStyle(speedAttr, true);
			} catch (SVGException e) {
				log.log(Level.WARNING, "Failed to get speed attribute from svg element", e);
				speedAttr = null;
			}			
			if (speedAttr != null && !speedAttr.getStringValue().equals("")) {
				speed = Math.min(1000, Math.max(1, speedAttr.getDoubleValue()));
			}
		}
		return speed;
	}
	
	int getPasses() {
		int passes = 1;
		if (element != null) {
			StyleAttribute passesAttr = new StyleAttribute("photonsaw-passes");
			try {
				element.getStyle(passesAttr, true);
			} catch (SVGException e) {
				log.log(Level.WARNING, "Failed to get passes attribute from svg element", e);
				passesAttr = null;
			}			
			if (passesAttr != null && !passesAttr.getStringValue().equals("")) {
				passes = Math.min(100, Math.max(1, passesAttr.getIntValue()));
			}
		}
		return passes;
	}
	
	int getPulsesPermm() {
		int ppmm = defaultPpmm;
		if (element != null) {
			StyleAttribute attr = new StyleAttribute("photonsaw-ppmm");
			try {
				element.getStyle(attr, true);
			} catch (SVGException e) {
				log.log(Level.WARNING, "Failed to get ppmm attribute from svg element", e);
				attr = null;
			}			
			if (attr != null && !attr.getStringValue().equals("")) {
				ppmm = Math.min(10000, Math.max(0, attr.getIntValue()));
			}
		}
		return ppmm;
	}
	
	int getPulseDuration() {
		int pd = defaultPulseDuration;
		if (element != null) {
			StyleAttribute attr = new StyleAttribute("photonsaw-pulse-length");
			try {
				element.getStyle(attr, true);
			} catch (SVGException e) {
				log.log(Level.WARNING, "Failed to get pulse-length attribute from svg element", e);
				attr = null;
			}			
			if (attr != null && !attr.getStringValue().equals("")) {
				pd = Math.min(100000, Math.max(1, attr.getIntValue()));
			}
		}
		return pd;
	}
	
	boolean getAssistAir() {
		boolean assistAir = true;
		if (element != null) {
			StyleAttribute aaAttr = new StyleAttribute("photonsaw-assistair");
			try {
				element.getStyle(aaAttr, true);
			} catch (SVGException e) {
				log.log(Level.WARNING, "Failed to get assistair attribute from svg element", e);
				aaAttr = null;
			}			
			if (aaAttr != null && !aaAttr.getStringValue().equals("")) {
				assistAir = isTrue(aaAttr.getStringValue());
			} else {
				assistAir = true;
			}
		}
		return assistAir;
	}
	
	static private boolean isTrue(String stringValue) {
		return stringValue.equalsIgnoreCase("true") || stringValue.equals("1") || stringValue.equalsIgnoreCase("yes")|| stringValue.equalsIgnoreCase("on");
	}

	String getId() {
		String id = "svg-node";
		if (element != null) {
			id = element.getId();
		}
		return id;		
	}
	

	@Override
	protected void writeImage(Image img, int imgWidth, int imgHeight, double x, double y, double width, double height) {

		/*
	      Rectangle2D bb = objects.getBoundingBox();
	      if (bb != null && bb.getWidth() > 0 && bb.getHeight() > 0)
	      {
	        //First render them on an empty image
	        BufferedImage scaledImg = new BufferedImage((int) bb.getWidth(), (int) bb.getHeight(), BufferedImage.TYPE_INT_RGB);
	        Graphics2D g = scaledImg.createGraphics();
	        g.setColor(Color.white);
	        g.fillRect(0, 0, scaledImg.getWidth(), scaledImg.getHeight());
	        g.setClip(0, 0, scaledImg.getWidth(), scaledImg.getHeight());
	        if (objects.getTransform() != null)
	        {
	          Rectangle2D origBB = objects.getOriginalBoundingBox();
	          Rectangle2D targetBB = new Rectangle(0, 0, scaledImg.getWidth(), scaledImg.getHeight());
	          g.setTransform(Helper.getTransform(origBB, targetBB));
	        }
	        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_OFF);
	        g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
	        for (GraphicObject o : objects)
	        {
	          o.render(g);
	        }
	        //Then dither this image
	        BufferedImageAdapter ad = new BufferedImageAdapter(scaledImg, invertColors);
	        ad.setColorShift(this.getColorShift());
	        BlackWhiteRaster bw = new BlackWhiteRaster(ad, this.getDitherAlgorithm());
	        for (LaserProperty prop : laserProperties)
	        {
	          RasterPart part = new RasterPart(bw, prop, new Point((int) bb.getX(), (int) bb.getY()));
	          job.addPart(part);
	        }
	      }
*/
		
		// Calculate the bounding box of the transformed image
		Point2D bb[] = new Point2D[4];
		bb[0] = new Point2D(0, 0);
		bb[1] = new Point2D(imgWidth-1,0);
		bb[2] = new Point2D(imgWidth-1,imgHeight-1);
		bb[3] = new Point2D(0,imgHeight-1);
		for (Point2D p : bb) {
			p.transform(getTransform());
		}
		
		// Then find the width of the smallest image that can contain the transformed image
		
		// Then create a transformation that puts the image at 
		
		// TODO: all of that shit.
		
		// Note: We do not support rotation of rasters at this point.
		Point2D pos = new Point2D(x, y);
		pos.transform(getTransform());
		width  = width *getTransform().getScaleX(); 
		height = height*getTransform().getScaleY(); 
		
		if (!(img instanceof BufferedImage)) {
			throw new RuntimeException("The Image passed to writeImage was not a BufferedImage: "+img.getClass().getName());
		}
		
		EngraveRaster engraving = new EngraveRaster(job.getNodeId(getId()), getLaserNodeSettings(), (BufferedImage) img, pos.x, pos.y, width, height);
		
		log.info("Appending EngraveRaster: "+engraving.getId());
		addChild(engraving);		
	}

	@Override
	protected void writeShape(Shape s) {
		// Do nothing.
	}

	@Override
	protected void writeString(String str, double x, double y) {
		// This never gets called.
	}

	@Override
	protected void writeHeader() {
		// Don't care.
	}

	@Override
	protected String getFooter() {
		return null; // Don't care.
	}

	@Override
	public boolean useDrawInSteadOfFillForStroke() {
		return true;
	}
}
