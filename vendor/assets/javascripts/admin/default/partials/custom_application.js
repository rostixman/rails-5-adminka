/**
 * @desc ОСНОВНАЯ ФУНКЦИЯ, инициализирует все события
 */
var ready = function() {

	// ****************
	// *** initial vars
	// ****************
	var body = $('body');
	var ladda = Ladda;


	// ****************
	// *** ladda button
	// ****************
	ladda.bind('.ladda-button');


	// ***********************
	// *** dataTable functions
	// ***********************
	var save_dt_view = function(oSettings, oData, table) {localStorage.setItem( table.prop('id') + '_' + window.location.pathname, JSON.stringify(oData) );};
	var load_dt_view = function (oSettings, table) {return JSON.parse( localStorage.getItem( table.prop('id') + '_' + window.location.pathname) );};


	// ***********************
	// *** dataTable [::START]
	// ***********************
	var tables = body.find('.data-table');
	tables.each(function() {
		var table = $(this);

		if (table.length > 0) {
			window.data_table = table.DataTable({
				"aoColumnDefs": [
					{'bSortable': false, 'aTargets': table.data('sort_disable')}
				],
				"aaSorting": [[table.data('sort_column'), table.data('sort_default')]],
				"oLanguage": {
					"sSearch": "<span>Поиск:</span>",
					"sLengthMenu": "<span>_MENU_</span>",
					"sProcessing": "Подождите...",
					"lengthMenu": "Показать _MENU_ записей",
					"sInfo": "Записи с _START_ до _END_ из _TOTAL_ записей",
					"sInfoEmpty": "Записи с 0 до 0 из 0 записей",
					"sInfoFiltered": "(отфильтровано из _MAX_ записей)",
					"sInfoPostFix": "",
					"sLoadingRecords": "Загрузка записей...",
					"sZeroRecords": "Записи отсутствуют.",
					"sEmptyTable": "В таблице отсутствуют данные",
					"oPaginate": {
						"sFirst": "Первая",
						"sPrevious": "Предыдущая",
						"sNext": "Следующая",
						"sLast": "Последняя"
					},
					"aria": {
						"sortAscending": ": активировать для сортировки столбца по возрастанию",
						"sortDescending": ": активировать для сортировки столбца по убыванию"
					}
				},
				"iDisplayLength": table.data('display_length'),
				"aLengthMenu": [
					[5, 10, 25, 50, -1],
					[5, 10, 25, 50, "Все"]
				],
				"sDom": '<"dt-panelmenu clearfix"lfr><"data-table-wrapper"t><"dt-panelfooter clearfix"ip>',
				"bStateSave": true,
				"fnStateSave": function(oSettings, oData) {
					save_dt_view(oSettings, oData, table);
				},
				"fnStateLoad": function(oSettings) {
					return load_dt_view(oSettings, table);
				}
			});
		}
	});
	// dataTable [::end]

	// ************************
	// *** select for dataTable
	// ************************
	$(".dataTables_length select").select2({minimumResultsForSearch: Infinity});


	// ************************
	// *** th checker [::START]
	// ************************
	var th_checker_class = '.th-checker';
	body.on('change', th_checker_class, function(e){

		// init
		var _this = $(this);
		var table = _this.parents('.table');
		var val = _this.prop('checked');
		var checkbox_class = '.checker input[type="checkbox"]';
		var btn_checker_class = '.btn-checker';
		var row_checked_class = 'row-checked';
		var btn_checker = $(btn_checker_class);

		table.find(checkbox_class)
				.prop('checked', val)
				.parents('tr')
				.addClass(row_checked_class);

		if ( table.find(checkbox_class + ':checked').length > 0 ) {
			btn_checker.show();
		} else {
			btn_checker.hide();
		}
	});
	// th checker [::END]


	// ************************
	// *** td checker [::START]
	// ************************
	var checkbox_class = 'table td.checker input[type="checkbox"]';
	body.on('change', checkbox_class, function(e){

		// init
		var _this = $(this);
		var _tr = _this.parents('tr');
		var row_checked_class = 'row-checked';
		var btn_checker_class = '.btn-checker';

		// проверяем состояние
		if (_this.prop('checked')) {
			_tr.addClass(row_checked_class);
		} else {
			_tr.removeClass(row_checked_class);
		}

		// поведение кнопки checker
		var btn_checker = $(btn_checker_class);
		if ( $(checkbox_class + ':checked').length > 0 ) {
			btn_checker.show();
		} else {
			btn_checker.hide();
		}
	});
	// td checker [::END]


	// ***************************
	// *** remove button [::START]
	// ***************************
	body.on('click', '.btn-remove-in-modal:not([disabled="disabled"])', function(e){
		e.preventDefault();
		e.stopPropagation();

		var _this = $(this);
		var tr = $(this).parents('tr');
		var href = _this.prop('href');

		$.ajax({
			url: href + '?modal=true',
			type: _this.data('method'),
			beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
		}).done(function(result) {

			var modal_response = body.find('#modal-response');
			modal_response.html(result);

			Ladda.stopAll();

			// magnificPopup init
			$.magnificPopup.open({
				removalDelay: 500, //delay removal by X to allow out-animation,
				items: { src: '#main-modal' },
				overflowY: 'hidden', //
				callbacks: {
					beforeOpen: function(e) {
						this.st.mainClass = _this.attr('data-effect');
					},
					afterClose: function(e) {
						modal_response.html('');
					}
				},
				midClick: true
			});

		}).fail(function(error){
			console.log(error);
			_this.hide();
			alert('Произошла ошибка, обратитесь к системному администратору');
			Ladda.stopAll();
		});
	});
	// remove button [::END]


	// ****************************
	// close modal window [::START]
	// ****************************
	body.on('click', '.btn_modal_cancel', function(){
		var _this = $(this);
		$.magnificPopup.close({ items: { src: _this.data('modal-target') } });
	});
	// close modal window [::END]


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

var keypress = function(e) {
	if(e.which == 13) {
		var button_delete_success = $('.mfp-ready .button_delete_success');
		var button_delete_success_all = $('.mfp-ready .action_success');

		if (button_delete_success.length > 0) {
			var l = button_delete_success.ladda();
			button_delete_success.click();
			l.ladda('start');
		}

		if (button_delete_success_all.length > 0) {
			var l = button_delete_success_all.ladda();
			button_delete_success_all.click();
			l.ladda('start');
		}
	}
};


$(document).ready(ready);
$(document).keypress(keypress);
$(document).on('page:restore', function() { Ladda.stopAll()         });
$(document).on('page:change', function()  { $.magnificPopup.close() });
