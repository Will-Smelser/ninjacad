<?php  
class ControllerModuleAddress extends Controller {
	protected function index($setting) {
		static $module = 0;
		
		$this->load->model('design/banner');
		$this->load->model('tool/image');
		
		$this->document->addScript('catalog/view/javascript/jquery/address.js');
		
		/*
		$this->data['width'] = $setting['width'];
		$this->data['height'] = $setting['height'];
		
		$this->data['banners'] = array();
		*/
		
		$this->data['page'] = $setting['page'];
		
		$this->data['module'] = $module++;
						
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/address.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/address.tpl';
		} else {
			$this->template = 'default/template/module/address.tpl';
		}
		
		$this->render();
	}
}
?>