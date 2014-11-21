package com.azwell.common.logger;

import org.apache.log4j.Logger;

/**
 * 공통 로그
 * @author ParkMoohun
 */
public class Log {
	
	private static Logger log = Logger.getRootLogger();
	/**
	 * 로그 디버깅용
	 * 
	 * @param message
	 */
	public  static void Debug(String message){ if(log.isDebugEnabled()) log.debug(message);}
	/**
	 * 로그 정보
	 * 
	 * @param message
	 */
	public static void Info (String message){ if(log.isDebugEnabled())  log.info(message);}
	/**
	 * 로그 위험 정보
	 * 
	 * @param message
	 */
	public static void Warn (String message){ log.warn(message); 							}
	/**
	 * 로그 에러 정보
	 * 
	 * @param message
	 */
	public static void Error(String message){ log.error(message); 						}
	/**
	 * 로그 치명적 결함 정보
	 * 
	 * @param message
	 */
	public static void Fatal(String message){ log.fatal(message); 						}
}
