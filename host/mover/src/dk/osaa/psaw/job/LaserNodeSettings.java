package dk.osaa.psaw.job;

import lombok.Getter;

/**
 * This class wraps the parameters needed when firing the laser
 * @author Flemming Frandsen <dren.dk@gmail.com> <http://dren.dk>
 */
public class LaserNodeSettings {
	@Getter
	double intensity;

	@Getter
	double maxSpeed;
	
	@Getter
	int passes;
	
	@Getter
	boolean assistAir;
	
	@Getter
	int pulsesPermm; 
	
	@Getter
	int pulseDuration; // In us
	
	@Getter
	double rasterLinePitch; // In mm
	
	public LaserNodeSettings(double intensity, double maxSpeed, int passes, boolean assistAir, int pulsesPermm, int pulseDuration, double rasterLinePitch) {
		this.intensity=intensity;
		this.maxSpeed=maxSpeed;
		this.passes=passes;
		this.assistAir = assistAir;		
		this.pulsesPermm = pulsesPermm; 
		this.pulseDuration = pulseDuration;
		this.rasterLinePitch = rasterLinePitch;
	}
	
	public boolean equalsRaster(LaserNodeSettings other) {
		return other.assistAir == assistAir 
				&& other.intensity == intensity 
				&& other.maxSpeed == maxSpeed
				&& other.rasterLinePitch == rasterLinePitch
				&& other.passes == passes;
	}
}
