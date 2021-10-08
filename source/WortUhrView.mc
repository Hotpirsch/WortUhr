import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class WortUhrView extends WatchUi.WatchFace {

	const numberString = { 1 => "EIN",
						   2 => "ZWEI",
						   3 => "DREI",
						   4 => "VIER",
						   5 => "FÜNF",
						   6 => "SECHS",
						   7 => "SIEBEN",
						   8 => "ACHT",
						   9 => "NEUN",
						   10 => "ZEHN",
						   11 => "ELF",
						   12 => "ZWÖLF" };
						   
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time
        var clockTime = System.getClockTime();
        var h = clockTime.hour;
        var m = clockTime.min;

		// create the German time string
        var t = "\nES IST" + timeString(h,m);

        // Display the time string
        var view = View.findDrawableById("WortGrid") as Text;
        view.setColor(getApp().getProperty("ForegroundColor") as Number);
        view.setText(t);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
    
    function timeString(h,m) {
    	var s = "";
    	if (m >= 58 || (m >= 28 && m < 30)) { s = s + "\nKURZ\nVOR"; }
    	if ((m > 0 && m <= 3) || (m <= 33 && m > 30)) { s += "\nKURZ\nNACH"; }
    	if ((m > 3 && m <= 7 ) || (m > 33 && m <= 37)) { s += "\nFÜNF\nNACH"; }
    	if (m > 7 && m <= 12)  { s += "\nZEHN\nNACH"; }
    	if (m > 37 && m <= 42) { s += "\nZWANZIG\nVOR"; }
    	if (m > 12 && m <= 17) { s += "\nVIERTEL\nNACH"; }
    	if (m > 42 && m <= 47) { s += "\nVIERTEL\nVOR"; }
    	if (m > 17 && m <= 22) { s += "\nZWANZIG\nNACH"; }
    	if (m > 47 && m <= 52) { s += "\nZEHN\nVOR"; }
    	if ((m > 22 && m <= 27 ) || (m > 52 && m <= 57)) { s += "\nFÜNF\nVOR"; }
    	if (m > 22 && m <= 37) { s += "\nHALB"; }
    	if (m > 22 ) { h += 1;} //
    	// reduce to 12 hour scale
        if (h > 12) {
            h = h - 12;
        }    	
    	s += "\n" + numberString[h];
    	if ( h == 1 && m != 0 ) { s += "S"; }
    	if ( m == 0 ) { s += "\nUHR"; }
    	return s;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
