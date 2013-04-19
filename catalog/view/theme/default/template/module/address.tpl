<?php 
//normalize the post data if it exists
$addressData = array(
		'addr_line'=>'Enter Your Address', 
		'addr_city'=>'City', 
		'addr_state'=>'State', 
		'addr_zip'=>'Zip', 
		'addr_lat'=>'Latitude', 
		'addr_long'=>'Longitude'
);

$formData = array();
foreach($addressData as $key=>$val)
	if(!isset($_POST[$key]) || empty($_POST[$key]))
		$formData[$key] = $val;
	else
		$formData[$key] = $_POST[$key];

if(!isset($showWrapper))
	$showWrapper = true; 

if(!isset($searchId))
	$searchId = 'searchAddr';

$class = '';
if($formData['addr_line'] == $addressData['addr_line'])
	$class = 'bgtext';

$class2 = '';
if($formData['addr_lat'] == $addressData['addr_lat'])
	$class2 = 'bgtext';
?>

<?php if($showWrapper){ ?>
<div class="box">
  <div class="box-heading">Request a Report</div>
  <div class="box-content">
<?php } ?>
  	<div id="addr-form-warning" style="diplay:hidden"></div>
  	
  	<form id="address_form" action="index.php?<?php echo $page; ?>" method="post" >
  	<div>
  		<span>Search By: </span>
  		<label for="addr"><input type="radio" id="addr" name="geotype" value="addr" checked="true" />Address</label>
  		<label for="long-lat"><input type="radio" id="long-lat" name="geotype" value="latlong" />Latitude / Longitude</label>
  	</div>
  	<div style="float:left" id="" class="forms addr-search-wrapper">
	    <div id="addr-wrapper" style="margin-right: 10px" class="bgtext">
	    	<input name="addr_line"  id="addr_line" type="text" value="<?php echo $formData['addr_line']?>" class="<?php echo $class; ?>" />
	    	<input name="addr_city"  id="addr_city" type="text" value="<?php echo $formData['addr_city']?>" class="<?php echo $class; ?>" />
	    	<input name="addr_state" id="addr_state" type="text" value="<?php echo $formData['addr_state']?>" class="<?php echo $class; ?>" />
	    	<input name="addr_zip"   id="addr_zip" type="text" value="<?php echo $formData['addr_zip']?>" class="<?php echo $class; ?>" />
	    </div>
	    
	    <div id="longlat-wrapper" style="display:none; margin-right:10px">
	    	<input name="addr_lat"  id="addr_lat" type="text" value="<?php echo $formData['addr_lat']?>" class="<?php echo $class2; ?> decimal" />
	    	<input name="addr_long" id="addr_long" type="text" value="<?php echo $formData['addr_long']?>" class="<?php echo $class2; ?> decimal" />
	    </div>
	 </div>
	 <div style="float:left" >
	 	<input type="button" value="Search" id="<?php echo $searchId; ?>" class="button">
	 </div>
	 <div style="clear:both"></div>
	 </form>
<?php if($showWrapper){ ?>	 
  </div>
</div>
<?php } ?>