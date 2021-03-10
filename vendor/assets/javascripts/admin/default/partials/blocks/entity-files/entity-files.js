/**
 * @desc меняем текст поля input и запускаем валидацию
 * @param obj - объект поля файла
 * @return entity_files - массив файлов
 */
var change_entity_files__title = function(obj) {

	// инициализируем переменные
	var _this = obj,
		value = _this.val().replace('C:\\fakepath\\',''),
		entity_files = _this[0].files,
		entity_files__title = _this.parents('.entity-files').find('.entity-files__title');

	// если файлов больше 1
	if (entity_files.length > 1) {
		value = 'Загруженно файлов: ' + entity_files.length;
	}

	// устанавливаем значение и валидируем форму
	entity_files__title.val(value);
	_this.valid();

	// возвращаем массив файлов
	return entity_files
};


/**
 * @desc загружаем изображения рекурсивно
 *
 * @param files     - массив файлов
 * @param previews  - блок в котором находятся все файлы
 * @param entity    - название сущности
 * @param entity_id - ID сущности
 * @param name      - название поля
 * @param locale    - локализация
 * @param i         - индекс
 *
 * @return void
 */
var upload_to_server = function(files, previews, entity, entity_id, name, locale, i) {

	// если файл не null
	if (files[i] != null){

		// инициализируем переменные
		var preview = $('<div/>').addClass('preview-file col-md-3 mw400 ib animated fadeIn');
		var html = '';

		// шаблок лоадера
		html += '<div class="panel p6 pbn entity-file__image">';
			html += '<a class="img-wrap ib">';
				html += '<div class="progress-circle"></div>';
			html += '</a>';
			html += '<div class="row table-layout">';
				html += '<div class="col-xs-12 pln">';
					html += '<h6>' + files[i].name + '</h6>';
				html += '</div>';
			html += '</div>';
		html += '</div>';

		// вставляем превьюшку
		preview.html(html);

		// находим прогресс и инициализируем его
		var progress = preview.find('.progress-circle');
		previews.append(preview);

		progress.circleProgress({
			value: 0,
			size: 80,
			fill: {
				gradient: ["#37bc9b", "#37bc9b"]
			}
		});

		// создаем массив данных и наполняем его
		var data = new FormData();
		data.append('file', files[i]);
		data.append('entity', entity);
		data.append('entity_id', entity_id);
		data.append('name', name);
		data.append('locale', locale);

		// ajax запрос на загрузку изображений
		$.ajax({
			url: '/admin/files/upload.html',
			data: data,
			dataType: 'html',
			type: 'POST',
			cache: false,
			contentType: false,
			processData: false,
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
			}
		}).done(function(result) {

			setTimeout(function(){
				var image = $( $.parseHTML( result ) );
				image.addClass('animated fadeIn');
				preview.html(image);
			}, 300);

			// снова запускаем загрузку с следующим изображением
			upload_to_server(files, previews, entity, entity_id, name, locale, i + 1);

		}).fail(function(error){
			console.log(error);
		}).uploadProgress(function(e){

			if (e.lengthComputable) {
				var percentage = Math.round((e.loaded * 100) / e.total);
				console.log(percentage);

				progress.circleProgress('value', e.loaded / e.total);
			}
		});
	}
};


/**
 * @desc ОСНОВНАЯ ФУНКЦИЯ, инициализирует все события
 * @return void
 */
var entity_files = function() {

	// инициализируем переменные
	var body = $('body');


	/**
	 * матчимся на кнопку для удаления файлов
	 **/
	body.on('click', '.entity-file__remove-btn', function(e){
		e.preventDefault();

		// инициализируем переменные
		var _this = $(this),
			wrapper = _this.parents('.entity-files__wrapper'),
			wrapper_previews = wrapper.find('.previews__wrapper'),
			input = wrapper.find('.entity-files__input'),
			title = wrapper.find('.entity-files__title'),
			parent = _this.parents('.preview-file'),
			id = _this.data('id'),
			data = new FormData();

		// наполняем данные
		data.append('id', id);

		// ajax запрос на загрузку изображений
		$.ajax({
			url: '/admin/files/remove.json',
			data: data,
			dataType: 'json',
			type: 'POST',
			cache: false,
			contentType: false,
			processData: false,
			beforeSend: function(xhr) {
				xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
			}
		}).done(function(result) {
			parent.attr('data-animate', '["50","fadeOut"]');
			parent.addClass('animated fadeOut');
			parent.delay(600).animate({width: 0, height: 0, padding: 0, margin: 0}, 300);

			setTimeout(function(){
				parent.remove();

				var previews = wrapper.find('.preview-file');
				if (previews.length > 0) {
					title.val('Загруженно файлов:' + previews.length);
				} else {
					title.val('');
					input.val('');
				}

				title.valid();
			}, 1000);

		}).fail(function(error){
			console.log(error);
		})
	});


	/**
	 * инициализируем просмотр изображений
	 * !!! в модальном окне не инициализируем
	 **/
	body.magnificPopup({
		delegate: '.magnific_popup:not(#main-modal .magnific_popup)',
		gallery: { enabled: true },
		type: 'image',
		callbacks: {
			beforeOpen: function(e) {

				body.addClass('mfp-bg-open');

				// устанавливаем анимацию для magnific
				this.st.mainClass = 'mfp-zoomIn';

				// Inform content container there is an animation
				this.contentContainer.addClass('mfp-with-anim');
			},
			afterClose: function(e) {

				setTimeout(function() {
					body.removeClass('mfp-bg-open');
					$(window).trigger('resize');
				}, 1000)

			},
			/**
			 * добавляем класс noscroll чтобы форма
			 * не скролилась и не дергалась вверх
			 **/
			open: function()  { body.addClass('noscroll')    },
			close: function() { body.removeClass('noscroll') }
		},
		overflowY: 'hidden',
		removalDelay: 200,
		fixedContentPos: false
	});


	/**
	 * ссылки с классом magnific_popup которые находятся
	 * в модальном окне открываем в новой вкладке/окне
	 **/
	body.on('click', '#main-modal .magnific_popup', function(e){
		e.preventDefault();

		var win = window.open($(this).attr('href'), '_blank');
		win.focus();
	});
};

$(document).ready(entity_files);