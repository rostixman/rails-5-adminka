/**
 * @desc анимируем форму если валидация была завершена с ошибкой
 * @param self - кнопка-сабмит формы
 * @return объект формы - form
 */
var init_vars = function(self) {
	var form = self.parents('form'),
		l = self.ladda();

	l.ladda('start');
	return form;
};

/**
 * @desc анимируем форму если валидация была завершена с ошибкой
 * @return void
 */
var animate_form = function() {
	var body = $('body'),
		animateClass = 'animated shake',
		animatedObj = $('.state-error');

	body.addClass('animation-running');
	animatedObj.removeClass('fadeIn').addClass(animateClass);

	animatedObj.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function () {
		body.removeClass('animation-running');
		animatedObj.removeClass(animateClass);
	});
};

/**
 * @desc валидируем форму которая вне модального окна
 * @return void
 */
var jquery_validate_outside_modal_window  = function(form) {
	var valid = form.valid();

	if (valid) {
		form.find('input[type="file"]').remove();
		form.submit();
	} else {
		$(document.body).animate({
			"scrollTop": form.find('.field.state-error:first').offset().top - 160
		}, 400, "swing");
		Ladda.stopAll();
	}
};

/**
 * @desc валидируем форму которая в модальном окне
 * @return void
 */
var jquery_validate_in_modal_window  = function(form) {
	var valid = form.valid(),
		modal_response = $('#modal-response');

	if (valid) {
		form.find('input[type="file"]').remove();
		form.submit();

		/**
		 * @desc ЗЫКРЫТИЕ ОКНА
		 */
		if (modal_response.hasClass('just-close-window')) {
			form.find('.btn_modal_cancel').click();
		}

		/**
		 * @desc ОБНОВЛЕНИЕ СТРАНИЦЫ ПОСЛЕ ЗАКРЫТИЯ ОКНА
		 */
		if (modal_response.hasClass('with-reload-page')) {
			form.find('.btn_modal_cancel').click();
			Turbolinks.visit(location.toString());
		}

		/**
		 * @desc ОБНОВЛЕНИЕ ВЫПАДАЮЩЕГО СПИСКА
		 */
		if (modal_response.hasClass('with-update-select')) {
			var id = modal_response.data('id'),
				entity = modal_response.data('entity'),
				value = modal_response.data('value');

			var data = new FormData();
			data.append('select[entity]', entity);
			data.append('select[value]', value);

			// ajax запрос на редактирование в модальном окне
			$.ajax({
				url: '/admin/reload-select-data.json',
				data: data,
				dataType: 'json',
				type: 'POST',
				cache: false,
				contentType: false,
				processData: false,
				beforeSend: function (xhr) {
					xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
				}
			}).done(function (result) {

				// инициализация
				var data = [];
				var select = $('#' + id);

				// формируем данные для select2js
				for (var i in result) {
					data.push({id: result[i][1], text: result[i][0]})
				}

				// обновляем селект и открываем его, после закрываем модальное окно
				select.html('').select2({data: data}).select2("open");
				form.find('.btn_modal_cancel').click();

			}).fail(function (error) {
				console.log(error);
				Ladda.stopAll();
			});
		}
	} else {
		Ladda.stopAll();
	}
};

/**
 * @desc ОСНОВНАЯ ФУНКЦИЯ, инициализирует все события
 */
var submits = function() {

	// инициализируем переменные
	var body = $('body');


	/**
	 * матчим обычную форму без валидаций
	 **/
	body.on('click', '.like-simple-submit', function (event) {
		event.preventDefault();

		var _this = $(this);

		setTimeout(function () { _this.parents('form').submit() }, 300);
	});


	/**
	 * матчим кнопку формы c jquery валидацией (не в модальном окне)
	 **/
	body.on('click', '.like-jquery-validate-submit', function(event){
		event.preventDefault();

		var form = init_vars( $(this) ); // инициализируем переменные

		setTimeout(function() {
			animate_form(); // инициализируем анимацию
			jquery_validate_outside_modal_window(form); // валидируем форму которая вне модального окна
		}, 400);
	});


	/**
	 * матчим кнопку формы c jquery валидацией (в модальном окне)
	 **/
	body.on('click', '.like-jquery-validate-submit-modal', function(event){
		event.preventDefault();

		var form = init_vars( $(this) ); // инициализируем переменные

		setTimeout(function() {
			animate_form(); // инициализируем анимацию
			jquery_validate_in_modal_window(form);
		}, 400);
	});


	/**
	 * матчим нажатие на ENTER в полях с классом gui-input
	 **/
	body.on('keydown', 'form .gui-input', function(event) {

		if (event.which == 13) { // если ENTER
			event.preventDefault();

			// инициализируем переменные
			var self = $(this),
				form = self.parents('form'),
				btn = form.find('.like-simple-submit, .like-jquery-validate-submit, .like-jquery-validate-submit-modal'),
				l = btn.ladda();

			// запускаем лоадер и submit у формы
			l.ladda('start');
			btn.click();
		}
	});
};

$(document).ready(submits);