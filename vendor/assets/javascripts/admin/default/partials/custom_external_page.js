var ready = function() {
	"use strict";

	// init vars
	var body = $('body'),
		ladda = Ladda;

	// Init Ladda Plugin on buttons
	ladda.bind('.ladda-button');

	// Init Theme Core
	Core.init();

	// Init CanvasBG and pass target starting location
	CanvasBG.init({
		Loc: {
			x: window.innerWidth / 2,
			y: window.innerHeight / 3.3
		}
	});

	// ********************
	// loader js [::START]
	// ********************
	NProgress.configure({
		showSpinner: false,
		ease: 'linear',
		speed: 700,
		minimum: 0.55
	});
	// loader js [::END]
};

$(document).ready(ready);
$(document).on('page:restore', function() { Ladda.stopAll()         });
$(document).on('page:change', function()  { $.magnificPopup.close() });