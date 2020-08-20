import 'package:logger/logger.dart';
import 'package:wanandroid/constants/Constant.dart';

class LogUtils {
  factory LogUtils() =>_getInstance();

  static LogUtils _logUtils;


  static Logger _logger;


  static LogUtils _getInstance(){
    if(_logUtils==null) {
      _logUtils=LogUtils._();
    }
    return _logUtils;
  }


  ///私有构造函数
   LogUtils._() {
    if(_logger==null) {
      _logger=Logger(
        filter: _MyFilter(),
        printer: PrettyPrinter(
            methodCount: 2, // number of method calls to be displayed
            errorMethodCount: 8, // number of method calls if stacktrace is provided
            lineLength: 120, // width of the output
            colors: true, // Colorful log messages
            printEmojis: true, // Print an emoji for each log message
            printTime: false // Should each log print contain a timestamp
        ),
      );
    }
  }


  static void print(String logStr) {
    if(_logger==null) LogUtils._();

    _logger.d('weibo_flutter_app- > $logStr');
  }


  static void printError(String errorStr) {
    if(_logger==null) LogUtils._();

    _logger.e(errorStr);
  }


}
class _MyFilter extends LogFilter{

  @override
  bool shouldLog(LogEvent event) {
    return Constant.IsPrintLog;
  }
}