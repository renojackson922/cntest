(function ($) {
	var session = null;
	
	var find_pw = function () {
		var email = $("input[name='email']");
		var $button = $('#find-pw-btn');

		var alert_messages = $("#goormfindpw .alert_msg");

		if (!email.val()) {
			alert_messages.hide();
			$("#warn-email").show();
			email.focus();
			return;
		}

		alert_messages.hide();
		$button.addClass('disabled');
		$('#find_pw_done').show();

		$.post('/pw/find_pw', {
			email: email.val()
		}, function(data) {
			if (data.result) {
				// $('#main_container .top, #main_container .bottom').hide();
				alert_messages.hide();
				$button.hide();
				$('#findpw_complete').show();
			} else {
				$button.removeClass('disabled');
				$('#find_pw_done').hide();
				switch (data.code) {
					case 0:
						alert_messages.hide();
						$("#warn-email").show();
						email.focus();
						break;
					case 1:
						alert_messages.hide();
						$("#warn-email-valid").show();
						email.focus();
						break;
					case 40:
						alert_messages.hide();
						$("#find_pw_wrong").show();
						break;
					case 50:
						alert_messages.hide();
						$('#find_pw_fail').show();
						break;
					default:
						alert_messages.hide();
						$('#find_pw_fail').show();
						break;
				}
			}
		});			
	};

	var set_event = function () {
		$('#find-pw-btn').click(function () {
			find_pw();
		});

		$('#goormfindpw .input_box').keydown(function(e) {
			if (e.which === 13) {
				find_pw();
			}
		});
	};

	set_event();
})(jQuery);

