$(document).ready(function(){
	function isNumber(n) {
		  return !isNaN(parseFloat(n)) && isFinite(n);
	}
	
	//change between address and lat/long
	$('#addr, #long-lat').change(function(){
		$('#addr-form-warning').slideUp();
		
		//map of checkbox value to div wrapper
		var map = {"addr":"addr-wrapper","latlong":"longlat-wrapper"};

		$('#'+map.addr+','+'#'+map.latlong).hide();
		
		if($(this).attr('checked'))
			$('#'+map[$(this).val()]).show();
	});

	var map = {
			'addr_line':'Enter Your Address',
			'addr_city':'City',
			'addr_state':'State',
			'addr_zip':'Zip',
			'addr_lat' :'Latitude',
			'addr_long' : 'Longitude'
		};
	
	//handle the inputs gets selected
	$('.addr-search-wrapper input')
	.focus(function(){		
		if(' Enter Your Address City State Zip Latitude Longitude'.indexOf($(this).val()) >= 0)
			$(this).val('');
		
		$(this).removeClass('bgtext');
		
		$('#addr-form-warning').slideUp();
			
	})
	.blur(function(){
		if($(this).val() == "")
			$(this).val(map[$(this).attr('id')]).addClass('bgtext');
	});
	
	$('#searchAddr').click(function(){
		//validate the form
		if($('#long-lat').is(':checked')){
			if(!isNumber($('#addr_lat').val()) || !isNumber($('#addr_long').val())){
				$('#addr-form-warning').html('Please enter valid latitude and longitude.').show();
				return false;
			}
		}else{
			for(var entry in map){
				if(' Enter Your Address City State Zip'.indexOf($('#'+entry).val()) >= 0){
					$('#addr-form-warning').html('Please complete the address form.').show();
					return false;
				}
			}
		}
		$('#address_form').submit();
	})
});