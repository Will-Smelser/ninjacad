
<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <div class="product-info">
    <?php if ($thumb || $images) { ?>
    <div class="left">
      <?php if ($thumb) { ?>
      <div class="image"><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div>
      <?php } ?>
      <?php if ($images) { ?>
      <div class="image-additional">
        <?php foreach ($images as $image) { ?>
        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        <?php } ?>
      </div>
      <?php } ?>
    </div>
    <?php } ?>
    <div class="right">
      <div class="description">
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
        <?php } ?>
        <!-- <span><?php echo $text_model; ?></span> <?php echo $model; ?><br />-->
        <?php if ($reward) { ?>
        <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
        <?php } ?>
        <!-- <span><?php echo $text_stock; ?></span> <?php echo $stock; ?></div> -->
      <?php if ($price) { ?>
      <div class="price"><?php echo $text_price; ?>
        <?php if (!$special) { ?>
        <?php echo $price; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
        <?php } ?>
        <br />
        <?php if ($tax) { ?>
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
        <?php } ?>
        <?php if ($points) { ?>
        <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
        <?php } ?>
        <?php if ($discounts) { ?>
        <br />
        <div class="discount">
          <?php foreach ($discounts as $discount) { ?>
          <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
          <?php } ?>
        </div>
        <?php } ?>
      </div>
      <?php } ?>
      
      <div id="report-info"  class="htabs">
		    <a href="#tabs-1">Enter Address</a>
		    <a href="#tabs-2" id="mapTab">Select Roof</a>
		    <?php if ($options) { ?>
		    	<a href="#tabs-3">Select Options</a>
		    <?php } ?>
	  </div>
	  <div class="tab-content">
	      <!-- STEP 1 - Address or Lat / Lng -->
	      <div id="tabs-1">
	      	<?php
	      		$page = str_replace('/index.php?','',$_SERVER['REQUEST_URI']);
	      		$showWrapper = false; 
	      		$searchId = 'button-report-step1';
	      		include 'catalog/view/theme/default/template/module/address.tpl'; 
	      	?>
	      </div>
	      
	      <!-- STEP 2 - MAP -->
	      <div id="tabs-2">
	      	<div class="mapbase">
	      		<div id="mapDiv" class="mapbase" ></div>
	      	</div>
	      	<div style="padding-top:20px">
	      	<input type="button" value="Back" id="button-report-step2a" class="button" />
	      	<input type="button" value="Next" id="button-report-step2b" class="button" />
	      	</div>
	      </div>
	      
	      <?php if ($options) { ?>
	      <!-- STEP 3 - OPTIONS -->
	      <div id="tabs-3">
	            <div class="options">
		        <h2><?php echo $text_option; ?></h2>
		        <br />
		        <?php foreach ($options as $option) { ?>
		        <?php if ($option['type'] == 'select') { ?>
		        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
		          <?php if ($option['required']) { ?>
		          <span class="required">*</span>
		          <?php } ?>
		          <b><?php echo $option['name']; ?>:</b><br />
		          <select name="option[<?php echo $option['product_option_id']; ?>]">
		            <option value=""><?php echo $text_select; ?></option>
		            <?php foreach ($option['option_value'] as $option_value) { ?>
		            <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
		            <?php if ($option_value['price']) { ?>
		            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
		            <?php } ?>
		            </option>
		            <?php } ?>
		          </select>
		        </div>
		        <br />
		        <?php } ?>
		        <?php if ($option['type'] == 'radio') { ?>
		        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
		          <?php if ($option['required']) { ?>
		          <span class="required">*</span>
		          <?php } ?>
		          <b><?php echo $option['name']; ?>:</b><br />
		          <?php foreach ($option['option_value'] as $option_value) { ?>
		          <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
		          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
		            <?php if ($option_value['price']) { ?>
		            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
		            <?php } ?>
		          </label>
		          <br />
		          <?php } ?>
		        </div>
		        <br />
		        <?php } ?>
		        <?php if ($option['type'] == 'checkbox') { ?>
		        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
		          <?php if ($option['required']) { ?>
		          <span class="required">*</span>
		          <?php } ?>
		          <b><?php echo $option['name']; ?>:</b><br />
		          <?php foreach ($option['option_value'] as $option_value) { ?>
		          <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
		          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
		            <?php if ($option_value['price']) { ?>
		            (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
		            <?php } ?>
		          </label>
		          <br />
		          <?php } ?>
		        </div>
		        <br />
		        <?php } ?>
		        <?php if ($option['type'] == 'image') { ?>
		        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
		          <?php if ($option['required']) { ?>
		          <span class="required">*</span>
		          <?php } ?>
		          <b><?php echo $option['name']; ?>:</b><br />
		          <table class="option-image">
		            <?php foreach ($option['option_value'] as $option_value) { ?>
		            <tr>
		              <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
		              <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
		              <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
		                  <?php if ($option_value['price']) { ?>
		                  (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
		                  <?php } ?>
		                </label></td>
		            </tr>
		            <?php } ?>
		          </table>
		        </div>
		        <br />
		        <?php } ?>
		        <?php if ($option['type'] == 'text') { ?>
		        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
		          <?php if ($option['required']) { ?>
		          <span class="required">*</span>
		          <?php } ?>
		          <b><?php echo $option['name']; ?>:</b><br />
		          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
		        </div>
		        <br />
		        <?php } ?>
		        <?php if ($option['type'] == 'decimal') { ?>
		        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
		          <?php if ($option['required']) { ?>
		          <span class="required">*</span>
		          <?php } ?>
		          <b><?php echo $option['name']; ?>:</b><br />
		          <input type="text" class="decimal" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
		        </div>
		        <br />
		        <?php } ?>
		        <?php if ($option['type'] == 'textarea') { ?>
		        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
		          <?php if ($option['required']) { ?>
		          <span class="required">*</span>
		          <?php } ?>
		          <b><?php echo $option['name']; ?>:</b><br />
				  <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php 
          		  if(isset($_POST['geotype']) && $_POST['geotype'] == 'addr'){
					echo "{$_POST['addr_line']}\n{$_POST['addr_city']}\n{$_POST['addr_state']}\n{$_POST['addr_zip']}";
				  }else{
          			echo $option['option_value'];
          		  } 
          		  ?></textarea>
		        </div>
		        <br />
		        <?php } ?>
		        <?php if ($option['type'] == 'file') { ?>
		        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
		          <?php if ($option['required']) { ?>
		          <span class="required">*</span>
		          <?php } ?>
		          <b><?php echo $option['name']; ?>:</b><br />
		          <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
		          <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
		        </div>
		        <br />
		        <?php } ?>
		        <?php if ($option['type'] == 'date') { ?>
		        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
		          <?php if ($option['required']) { ?>
		          <span class="required">*</span>
		          <?php } ?>
		          <b><?php echo $option['name']; ?>:</b><br />
		          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
		        </div>
		        <br />
		        <?php } ?>
		        <?php if ($option['type'] == 'datetime') { ?>
		        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
		          <?php if ($option['required']) { ?>
		          <span class="required">*</span>
		          <?php } ?>
		          <b><?php echo $option['name']; ?>:</b><br />
		          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
		        </div>
		        <br />
		        <?php } ?>
		        <?php if ($option['type'] == 'time') { ?>
		        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
		          <?php if ($option['required']) { ?>
		          <span class="required">*</span>
		          <?php } ?>
		          <b><?php echo $option['name']; ?>:</b><br />
		          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
		        </div>
		        <br />
		        <?php } ?>
		        <?php } ?>
		      </div>
			      
	      
	      
	      <div class="cart">
		        <div><?php echo $text_qty; ?>
		          <input type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
		          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
		          &nbsp;
		          <input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" />
		          <span>&nbsp;&nbsp;<?php echo $text_or; ?>&nbsp;&nbsp;</span>
		          <span class="links"><a onclick="addToWishList('<?php echo $product_id; ?>');"><?php echo $button_wishlist; ?></a><br />
		            <a onclick="addToCompare('<?php echo $product_id; ?>');"><?php echo $button_compare; ?></a></span>
		        </div>
		        <?php if ($minimum > 1) { ?>
		        <div class="minimum"><?php echo $text_minimum; ?></div>
		        <?php } ?>
		      </div>
		      </div>
	      <?php } ?>
      </div>
      
      
      <?php if ($review_status) { ?>
      <div class="review">
        <div><img src="catalog/view/theme/default/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>
        <div class="share"><!-- AddThis Button BEGIN -->
          <div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
          <script type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js"></script> 
          <!-- AddThis Button END --> 
        </div>
      </div>
      <?php } ?>
    </div>
  </div>
  <div id="tabs" class="htabs">
  	<a href="#tab-description"><?php echo $tab_description; ?></a>
    <?php if ($attribute_groups) { ?>
    <a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
    <?php } ?>
    <?php if ($review_status) { ?>
    <a href="#tab-review"><?php echo $tab_review; ?></a>
    <?php } ?>
    <?php if ($products) { ?>
    <a href="#tab-related"><?php echo $tab_related; ?> (<?php echo count($products); ?>)</a>
    <?php } ?>
  </div>
  <div id="tab-description" class="tab-content"><?php echo $description; ?></div>
  <?php if ($attribute_groups) { ?>
  <div id="tab-attribute" class="tab-content">
    <table class="attribute">
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <thead>
        <tr>
          <td colspan="2"><?php echo $attribute_group['name']; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
  </div>
  <?php } ?>
  <?php if ($review_status) { ?>
  <div id="tab-review" class="tab-content">
    <div id="review"></div>
    <h2 id="review-title"><?php echo $text_write; ?></h2>
    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="" />
    <br />
    <br />
    <b><?php echo $entry_review; ?></b>
    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
    <br />
    <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
    <input type="radio" name="rating" value="1" />
    &nbsp;
    <input type="radio" name="rating" value="2" />
    &nbsp;
    <input type="radio" name="rating" value="3" />
    &nbsp;
    <input type="radio" name="rating" value="4" />
    &nbsp;
    <input type="radio" name="rating" value="5" />
    &nbsp;<span><?php echo $entry_good; ?></span><br />
    <br />
    <b><?php echo $entry_captcha; ?></b><br />
    <input type="text" name="captcha" value="" />
    <br />
    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
    <br />
    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
    </div>
  </div>
  <?php } ?>
  <?php if ($products) { ?>
  <div id="tab-related" class="tab-content">
    <div class="box-product">
      <?php foreach ($products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
        <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  <?php if ($tags) { ?>
  <div class="tags"><b><?php echo $text_tags; ?></b>
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
  
  <div id="dialog" >
  	<h2>Update your address to?</h2>
  	<div id="dcontent">
  	</div>
  	<input id="d_addr_line" type="hidden" />
  	<input id="d_addr_city" type="hidden" />
  	<input id="d_addr_state" type="hidden" />
  	<input id="d_addr_zip" type="hidden" />
  </div>
  
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		rel: "colorbox"
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'decimal\'], .product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();
			
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			} 
			
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
				$('.success').fadeIn('slow');
					
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
		
		$('.error').remove();
		
		if (json['success']) {
			alert(json['success']);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
		}
		
		if (json['error']) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
		}
		
		$('.loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').fadeOut('slow');
		
	$('#review').load(this.href);
	
	$('#review').fadeIn('slow');
	
	return false;
});			

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}
			
			if (data['success']) {
				$('#review-title').after('<div class="success">' + data['success'] + '</div>');
								
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
$mytabs = $("#report-info a").tabs();
//--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 

<script type="text/javascript" src="catalog/view/javascript/jquery/address.js"></script>
<script type="text/javascript"><!--
$(document).ready(function() {
	if ($.browser.msie && $.browser.version == 6) {
		$('.date, .datetime, .time').bgIframe();
	}

	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
	$('.datetime').datetimepicker({
		dateFormat: 'yy-mm-dd',
		timeFormat: 'h:m'
	});
	$('.time').timepicker({timeFormat: 'h:m'});


	//map stuff
	function isNumber(n) {
		  return !isNaN(parseFloat(n)) && isFinite(n);
	}

	var formMap = {
			'addr_line':'Enter Your Address',
			'addr_city':'City',
			'addr_state':'State',
			'addr_zip':'Zip',
			'addr_lat' :'Latitude',
			'addr_long' : 'Longitude'
		};
	
	map.init("mapDiv",null);

	//IE fix
	$('#mapTab').click(function(){
		var $mapDiv = $(document.getElementById(map.mapContainer));
		map.map.setOptions({ height: $mapDiv.height(), width: $mapDiv.width() });
	});
	
	map.pushpin.userfunc = function(latitude,longitude){
		console.log('userfunc called');
		console.log(latitude,longitude);
		$('#tabs-3 input[class=\'decimal\']').first().val(latitude);
		$('#tabs-3 input[class=\'decimal\']').last().val(longitude);
		$('#addr_lat').val(latitude).removeClass('bgtext');
		$('#addr_long').val(longitude).removeClass('bgtext');
	};

	//setup dialog
	$( "#dialog" ).dialog({
		autoOpen: false,
		modal: true,
		buttons: {
			"Ok": function() {
				//copy the address over
				$("#addr_line").val($("#d_addr_line").val());
				$("#addr_city").val($("#d_addr_city").val());
				$("#addr_state").val($("#d_addr_state").val());
				$("#addr_zip").val($("#d_addr_zip").val());
				
				var address = $("#addr_line").val()+", "+
				$("#addr_city").val()+", "+$("#addr_state").val()+", "+$("#addr_zip").val();

				$('#tabs-3 textarea').first().val(address.replace(/\,\s/g,'\n'));
				
				$( this ).dialog( "close" );
			},
			Cancel: function() {
            	$( this ).dialog( "close" );
          	}
		}
	});
	
	//override this
	map.geocode.reverseGoal = function(data){
		//parse the address
		try{
			var addr = data.resourceSets[0].resources[0].address;

			$("#d_addr_line").val(addr.addressLine);
			$("#d_addr_city").val(addr.locality);
			$("#d_addr_state").val(addr.adminDistrict);
			$("#d_addr_zip").val(addr.postalCode);
			
			var address = $("#addr_line").val()+", "+
			$("#addr_city").val()+", "+$("#addr_state").val()+" "+$("#addr_zip").val();
			
			if(address != addr.formattedAddress){
				$('#dialog').dialog("open");
				$("#dcontent").html("<p>"+addr.formattedAddress+"</p>"); 
			}

			
			
		}catch(e){
			console.log('error on parsing address');
		}
	};
	
	$("#button-report-step1").click(function(){
		//validate the form
		if($('#long-lat').is(':checked')){
			var lat = $('#addr_lat').val();
			var lon = $('#addr_long').val();
			if(!isNumber(lat) || !isNumber(lon)){
				$('#addr-form-warning').html('Please enter valid latitude and longitude.').show();
				return false;
			}

			map.geocode.reverseGeocode(lat, lon, 
				function(data){
					//do sometihng with the address

					//update everything
					map.pushpin.update(new Microsoft.Maps.Location(lat, lon));
				}
			);
			
		}else{
			for(var entry in formMap){
				console.log(entry);
				if(' Enter Your Address City State Zip'.indexOf($('#'+entry).val()) >= 0){
					$('#addr-form-warning').html('Please complete the address form.').show();
					return false;
				}
			}
			var address = $("#addr_line").val()+", "+
			$("#addr_city").val()+", "+$("#addr_state").val()+", "+$("#addr_zip").val();
			map.geocode.geocode(address);

			$('#tabs-3 textarea').first().val(address.replace(/\,\s/g,'\n'));
		}
		
		$mytabs[1].click();
	});

	$("#button-report-step2a").click(function(){
		$mytabs[0].click();
	});

	$("#button-report-step2b").click(function(){
		$mytabs[2].click();
	});
		
	<?php if(!empty($_POST)){ ?>
	

	function loadAddrMap(){
		console.log('here');
		if(map.search.loaded){
			$("#button-report-step1").trigger("click");
			return;
		}
		setTimeout(loadAddrMap,100);
	}
	loadAddrMap();
	
	<?php } ?>
});
//--></script>  
<?php echo $footer; ?>