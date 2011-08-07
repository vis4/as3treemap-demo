vis4.as
=======

### DelayedTask ###

If you want to run a function with a specific delay, you usally use the flash.events.Timer class. However, passing arguments to a delayed function requires some hacking that I encapsulated in DelayedTask.

Usage:

	// dumb example, calculate Math.pow(3,5) after 2 seconds 

	new DelayedTask(
		2000, // milliseconds
		Math, // the context in which the function will be called
		Math.pow, // the function
		3, // first argument passed to the function
		5, // second argument
	);
	
You can pass as many arguments as you like.


### Color ###

Color is a class that performs all kinds of color transformations.

Examples:
	
	var color:uint;
	
	// get integer color from HSL values
	Color.fromHSL(120, .7, .3)._int;
	
	// make a color half saturated
	Color.fromInt(0xFF0000).saturation('*.5')._int;
	
	// convert from HSV to HSL
	
	var color:Color = Color.fromHSV(120, .5, .6);
	color.mode = Color.HSL;
	trace(color._hue, color._saturation, color._lightness);
	

### ColorScale ###

Helps to interpolate between colors.

Examples:

	var redGreen:ColorScale = new ColorScale([0xFF0000, 0x00FF00]);
	redGreen.getIntColor(0.7);
	

### Font & Label ###

to be continued..