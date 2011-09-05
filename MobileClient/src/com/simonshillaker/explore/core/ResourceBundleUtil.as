package com.simonshillaker.explore.core
{
	import mx.resources.ResourceManager;

	public class ResourceBundleUtil
	{
		private static const MAIN_RESOURCE_BUNDLE:String = 'explore_air_mobile';
		
		//General
		public static const BACK_LABEL:String = getFromBundle('back_label');
		public static const EXIT_LABEL:String = getFromBundle('exit_label');
		public static const HOME_TITLE:String = getFromBundle('home_title');
		public static const HOME_WELCOME_TITLE:String = getFromBundle('home_welcome_title');
		public static const HOME_WELCOME_TEXT:String = getFromBundle('home_welcome_text');
		public static const BLOG_BUTTON_LABEL:String = getFromBundle('blog_button_label');
		public static const BLOG_URL:String = getFromBundle('blog_url');
		public static const SOURCE_CODE_TEXT:String = getFromBundle('source_code_text');
		public static const HOME_SOURCE_CODE_BUTTON_LABEL:String = getFromBundle('home_source_code_button_label');
		public static const SOURCE_CODE_UTL:String = getFromBundle('source_code_url');
		public static const TOUR_DE_FLEX_BUTTON_LABEL:String = getFromBundle('tour_de_flex_button_label');
		public static const TOUR_DE_FLEX_NOTE:String = getFromBundle('tour_de_flex_note');
		public static const TOUR_DE_FLEX_URL:String = getFromBundle('tour_de_flex_url');
		public static const PHONE_INTEGRATION_TITLE:String = getFromBundle('phone_integration_title');

		//Camera
		public static const CAMERA_TITLE:String = getFromBundle('camera_title');
		public static const CAMERA_ROLL_TITLE:String = getFromBundle('camera_roll_title');
		public static const DEVICE_CAMERA_TITLE:String = getFromBundle('device_camera_title');
		public static const CAMERA_NOT_SUPPORTED:String = getFromBundle('camera_not_supported');
		public static const CAMERA_ROLL_NOT_SUPPORTED:String = getFromBundle('camera_roll_not_supported');
		public static const GO_TO_CAMERA_ROLL:String = getFromBundle('go_to_camera_roll');
		
		//Email
		public static const EMAIL_TITLE:String = getFromBundle('email_title');
		public static const EMAIL_NO_RECIPIENT:String = getFromBundle('email_no_recipient_message');
		
		//GPS
		public static const GPS_TITLE:String = getFromBundle('gps_title');
		public static const GPS_NOT_SUPPORTED:String = getFromBundle('gps_not_supported');
		public static const GPS_NOT_ENABLED:String = getFromBundle('gps_not_enabled');
		public static const FIND_ME_BUTTON_LABEL:String = getFromBundle('find_me_button_label');
		public static const GPS_WARNING_LABEL:String = getFromBundle('gps_warning_label');

		//Local DB
		public static const LOCAL_DB_TITLE:String = getFromBundle('local_db_title');
		public static const LOCAL_DB_USERNAME:String = getFromBundle('local_db_username_label');
		public static const LOCAL_DB_NAME:String = getFromBundle('local_db_name_label');
		public static const LOCAL_DB_CLEAR_DATA:String = getFromBundle('local_db_clear_data_label');
		public static const LOCAL_DB_ADD_USER:String = getFromBundle('local_db_add_user_label');
		public static const LOCAL_DB_SQL_ERROR:String = getFromBundle('local_db_sql_error_message');

		//Local Network
		public static const LOCAL_NETWORK_TITLE:String = getFromBundle('local_network_title');
		public static const CHAT_TITLE:String = getFromBundle('chat_title');
		public static const LOGIN_TITLE:String = getFromBundle('login_title');
		public static const START_CHAT_LABEL:String = getFromBundle('start_chat_label');
		public static const USERNAME_PROPMT:String = getFromBundle('username_prompt');
		public static const ENTER_CHAT:String = getFromBundle('enter_chat_label');
		public static const RECEIVED_CHAT:String = getFromBundle('received_chat_label');

		//Accelerometer
		public static const ACCELEROMETER_TITLE:String = getFromBundle('accelerometer_title');
		public static const ACCELEROMETER_EXPLANATION:String = getFromBundle('accelerometer_explanation');
		public static const ACCELEROMETER_ROTATE_X:String = getFromBundle('accelerometer_rotate_x');
		public static const ACCELEROMETER_ROTATE_Y:String = getFromBundle('accelerometer_rotate_y');

		//Maps
		public static const MAPS_TITLE:String = getFromBundle('maps_title');
		public static const GOOGLE_MAPS_TITLE:String = getFromBundle('google_maps_title');
		public static const NATIVE_MAPS_TITLE:String = getFromBundle('native_maps_title');

		//Web
		public static const WEB_DEFAULT_URL:String = getFromBundle('web_default_url');
		public static const NAV_BACK_LABEL:String = getFromBundle('nav_back_label');
		public static const NAV_FORWARD_LABEL:String = getFromBundle('nav_forward_label');
		public static const WEB_TITLE:String = getFromBundle('web_title');
		public static const INTERNAL_BROWSER_NOT_SUPPORTED:String = getFromBundle('internal_browser_not_supported');
		public static const INTERNAL_BROWSER_INVALID_URL:String = getFromBundle('internal_browser_invalid_url');
		public static const INTERNAL_BROWSER_TITLE:String = getFromBundle('internal_browser_title');
		public static const NATIVE_BROWSER_TITLE:String = getFromBundle('native_browser_title');

		//Multitouch
		public static const MULTITOUCH_DISABLED:String = getFromBundle('multitouch_disabled');
		public static const MULTITOUCH_TITLE:String = getFromBundle('multitouch_title');
		
		//Info
		public static const ABOUT_BUTTON_LABEL:String = getFromBundle('about_button_label');
		public static const INFO_BUTTON_LABEL:String = getFromBundle('info_button_label');
		public static const INFO_SUFFIX:String = getFromBundle('info_suffix');
		public static const NO_INFO_AVAILABLE:String = getFromBundle('no_info_available');
		public static const ACCELEROMETER_INFO:String = getFromBundle('accelerometer_info');
		public static const DEVICE_CAMERA_INFO:String = getFromBundle('device_camera_info');
		public static const CAMERA_ROLL_INFO:String = getFromBundle('camera_roll_info');
		public static const EMAIL_INFO:String = getFromBundle('email_info');
		public static const GPS_INFO:String = getFromBundle('gps_info');
		public static const LOCAL_DB_INFO:String = getFromBundle('local_db_info');
		public static const P2P_CHAT_INFO:String = getFromBundle('p2p_chat_info');
		public static const MAPS_INFO:String = getFromBundle('maps_info');
		public static const INTERNAL_BROWSER_INFO:String = getFromBundle('internal_browser_info');
		public static const MULTITOUCH_INFO:String = getFromBundle("multitouch_info");

		//Source code
		public static const INFO_SOURCE_CODE_BUTTON_LABEL:String = getFromBundle('info_source_code_button_label');

		private static function getFromBundle(key:String):String
		{
			return ResourceManager.getInstance().getString(MAIN_RESOURCE_BUNDLE, key);
		}
	}
}