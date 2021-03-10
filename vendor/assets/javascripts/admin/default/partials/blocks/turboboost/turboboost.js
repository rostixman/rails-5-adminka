/*var pnotify_default__init = function(messages) {

	//console.log(messages);

	var Stacks = {
		stack_top_right:    { "dir1": "down",   "dir2": "left",     "push": "top", "spacing1": 10, "spacing2": 10 },
		stack_top_left:     { "dir1": "down",   "dir2": "right",    "push": "top", "spacing1": 10, "spacing2": 10 },
		stack_bottom_left:  { "dir1": "right",  "dir2": "up",       "push": "top", "spacing1": 10, "spacing2": 10 },
		stack_bottom_right: { "dir1": "left",   "dir2": "up",       "push": "top", "spacing1": 10, "spacing2": 10 },
		stack_bar_top:      { "dir1": "down",   "dir2": "right",    "push": "top", "spacing1": 0,  "spacing2": 0 },
		stack_bar_bottom:   { "dir1": "up",     "dir2": "right",    "spacing1": 0, "spacing2": 0},
		stack_context:      { "dir1": "down",   "dir2": "left",     "context": $("#stack-context") }
	};


	for(var i in messages) {

		//setTimeout(function(e){


			var message = messages[i];
			console.log(message);

			// Create new Notification
			new PNotify({
				title: message.title,
				text: message.text,
				icon: message.icon,
				shadow: true,
				opacity: 0.9,
				stack: Stacks[message.stack],
				addclass: message.stack,
				type: message.type,
				width: '400px',
				delay: 1000,
				buttons: {
					closer: true,
					closer_hover: true,
					sticker: true,
					sticker_hover: true
				}
			});
		//}, 1500);
	}
};*/

/*

$(document).on("turboboost:success turboboost:error", function(e, flash) {
	var messages = [];
	if (flash.notice) {
		messages.push({
			title: 'Информация',
			text: decodeURIComponent(escape(flash.notice)),
			icon: 'glyphicon glyphicon-ok-sign',
			stack: 'stack_bar_top',
			type: 'success'
		});
	}
	if (flash.alert) {
		messages.push({
			title: 'Внимание',
			text: decodeURIComponent(escape(flash.alert)),
			icon: 'fa fa-info-circle',
			stack: 'stack_bar_top',
			type: 'info'
		});
	}
	if (flash.error) {
		messages.push({
			title: 'Ошибка',
			text: decodeURIComponent(escape(flash.error)),
			icon: 'fa fa-warning',
			stack: 'stack_bar_top',
			type: 'error'
		});
	}

	pnotify_default__init(messages);
});
*/



/*
flashHandler = function(e, params) {
	//alert('Received flash message '+params.message+' with type '+params.type);


	var messages = [];
	if (params.type == 'notice') {
		messages.push({
			title: 'Информация',
			text: params.message,
			icon: 'glyphicon glyphicon-ok-sign',
			stack: 'stack_bar_top',
			type: params.type
		});
	}
	if (params.type == 'alert') {
		messages.push({
			title: 'Внимание',
			text: params.message,
			icon: 'fa fa-info-circle',
			stack: 'stack_bar_top',
			type: 'info'
		});
	}
	if (params.type == 'error') {
		messages.push({
			title: 'Ошибка',
			text: params.message,
			icon: 'fa fa-warning',
			stack: 'stack_bar_top',
			type: params.type
		});
	}
	pnotify_default__init(messages);
};

$(document).on('page:update', function(){
	$(window).bind('rails:flash', flashHandler);
});*/
