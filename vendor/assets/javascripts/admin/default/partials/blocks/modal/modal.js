/**
 * @desc ОСНОВНАЯ ФУНКЦИЯ, инициализирует все события
 */
var modals = function() {

	// инициализируем переменные
	var body = $('body');

	/**
	 * матчимся на кнопку редактирования
	 **/
	body.on('click', '.modal__edit-btn', function (e) {
		e.preventDefault();

		// инициализируем переменные
		var _this = $(this),
			with_reload_page_class = 'with-reload-page',
			just_close_window_class = 'just-close-window',
			with_reload_page = _this.hasClass(with_reload_page_class),
			just_close_window = _this.hasClass(just_close_window_class),
			href = _this.prop('href');

		// если у кнопки есть ladda-button класс то запускаем его
		if (_this.hasClass('ladda-button')) {
			var l = _this.ladda();
			l.ladda('start');
		}

		// запускаем NProgress
		NProgress.start();

		var ajax_url = href;
		if (href.indexOf('?') > 0) {
			ajax_url += '&modal=true';
		} else {
			ajax_url += '?modal=true'
		}

		// ajax запрос на редактирование в модальном окне
		$.ajax({
			url: ajax_url,
			type: 'GET',
			beforeSend: function (xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
			}
		}).done(function (result) {

			// инициализируем переменные
			var modal_response = body.find('#modal-response');
			modal_response.html(result);

			// если перезагружать надо то добавим
			// соответствующий класс модальному окну
			if (with_reload_page) {
				modal_response.addClass(with_reload_page_class);
			} else {
				modal_response.removeClass(with_reload_page_class);
			}

			// просто закрываем окно
			if (just_close_window) {
				modal_response.addClass(just_close_window_class);
			} else {
				modal_response.removeClass(just_close_window_class);
			}

			// запускаем лоадеры
			Ladda.stopAll();
			NProgress.done();

			// magnificPopup init
			$.magnificPopup.open({
				removalDelay: 500, //delay removal by X to allow out-animation,
				items: {src: '#main-modal'},
				overflowY: 'scroll', //
				callbacks: {
					beforeOpen: function (e) {
						this.st.mainClass = 'mfp-slideDown';
						$('#main-modal').addClass('mw1000');
					},
					afterClose: function (e) {
						modal_response.html('');
						$('#main-modal').removeClass('mw1000');
					}
				},
				midClick: true
			});

		}).fail(function (error) {
			console.log(error);
			_this.hide();
			alert('Произошла ошибка, обратитесь к системному администратору');
			Ladda.stopAll();
		});
	});

	/**
	 * матчимся на кнопку создания новой записи
	 **/
	body.on('click', '.modal__new-btn', function (e) {
		e.preventDefault();

		// инициализируем переменные
		var _this = $(this),
			with_update_select_class = 'with-update-select',
			data_id = _this.data('id'),
			data_entity = _this.data('entity'),
			data_value = _this.data('value'),
			with_update_select = _this.hasClass(with_update_select_class),
			href = _this.prop('href');

		// если у кнопки есть ladda-button класс то запускаем его
		if (_this.hasClass('ladda-button')) {
			var l = _this.ladda();
			l.ladda('start');
		}

		// запускаем NProgress
		NProgress.start();

        var ajax_url = href;
        if (href.indexOf('?') > 0) {
            ajax_url += '&modal=true';
        } else {
            ajax_url += '?modal=true'
        }

		// ajax запрос на редактирование в модальном окне
		$.ajax({
			url: ajax_url,
			type: 'GET',
			beforeSend: function (xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
			}
		}).done(function (result) {

			// инициализируем переменные
			var modal_response = body.find('#modal-response');
			modal_response.html(result);

			// если перезагружать надо то добавим
			// соответствующий класс модальному окну
			if (with_update_select) {
				modal_response.addClass(with_update_select_class);
				modal_response.attr('data-id', data_id);
				modal_response.attr('data-entity', data_entity);
				modal_response.attr('data-value', data_value);
			} else {
				modal_response.removeClass(with_update_select_class);
			}

			// запускаем лоадеры
			Ladda.stopAll();
			NProgress.done();

			// magnificPopup init
			$.magnificPopup.open({
				removalDelay: 500, //delay removal by X to allow out-animation,
				items: { src: '#main-modal' },
				overflowY: 'scroll', //
				callbacks: {
					beforeOpen: function (e) {
						this.st.mainClass = 'mfp-slideDown';
						$('#main-modal').addClass('mw1000');
					},
					afterClose: function (e) {
						modal_response.html('');
						$('#main-modal').removeClass('mw1000');
					}
				},
				midClick: true
			});

		}).fail(function (error) {
			console.log(error);
			_this.hide();
			alert('Произошла ошибка, обратитесь к системному администратору');
			Ladda.stopAll();
		});
	});
};

$(document).ready(modals);