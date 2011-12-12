package co.pipapo.util{

	import flash.external.ExternalInterface;
	import flash.utils.getQualifiedClassName;

  public class ExternalLogger {
      
    private static var logLevelInternal:int;
    
    public static const DEBUG:int = 0;
    public static const INFO:int = 1;
    public static const WARN:int = 2;
    public static const ERROR:int = 3;
    
    public static function set logLevel(level:int):void {
      logLevelInternal = level;
    }
    
    private var className:String;
    
    public static function getLogger(object:Object):ExternalLogger {
      return new ExternalLogger(object);
    }
    
    public function ExternalLogger(object:Object):void {
      this.className = getQualifiedClassName(object);
    }
    
    public function debug(message:Object):void {
      if (logLevelInternal <= DEBUG){
        log('[DEBUG]', message);
      }
    }
    
    public function info(message:Object):void {
      if (logLevelInternal <= INFO){
        log('[INFO ]', message);
      }
    }
    
    public function warn(message:Object):void {
      if (logLevelInternal <= WARN){
        log('[WARN ]', message);
      }
    }
    
    public function error(message:Object):void {
      log('[ERROR]', message);
    }
      
    public function isDebug():Boolean {
      return logLevelInternal <= DEBUG;        
    }
      
  	/**
	  * TODO move into its own package and or provide it on github
		*/
		private function log(logLevelInternal:String, message:Object):void {
	    var output:String = getFormattedDate() + " " + logLevelInternal + ": "+ message.toString() + " (" + className + ")";
       
      // log in flash console 
	    trace(output);

      // log in javascript console
	    if (ExternalInterface.available) {
	      ExternalInterface.call("console.log('"+output+"')");
      }
		}
		
		private function getFormattedDate():String {
		  var localTime = new Date();
	    var formattedDate = localTime.getFullYear() + "-" + localTime.getMonth() + "-" + localTime.getDate() + " " + localTime.getHours() + ":" + localTime.getMinutes() + ":" +  localTime.getSeconds(); 
      
		  return formattedDate;
		}
  }
}