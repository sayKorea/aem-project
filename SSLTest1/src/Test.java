/**
/Library/Java/Home/lib/security
--> java InstallCert url:port
--> copy jss file to here 
 */
import java.io.*;
import java.net.URL;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;

import javax.net.ssl.*;

public class Test {
	public static void main(String[] args) throws Exception {
		final String TEST_URL = "https://210.127.39.181:7799/em/cloud";
		//final String TEST_URL = "https://192.168.56.100:7799/em/cloud";
		// final String
		// TEST_URL="https://210.127.39.181:7799/em/websvcs/restful/extws/cloudservices/service/v0/ssa/em/cloud/jaas/zone/D3F3FA2D72CCAA67325FB428A34F30D3";
		URL url = new URL(TEST_URL);
		HttpsURLConnection httpsCon = (HttpsURLConnection) url.openConnection();
		httpsCon.setRequestProperty("Authorization", "basic c3lzbWFuOmRwd21kbnBmZW0=");
		httpsCon.setHostnameVerifier(new HostnameVerifier() { public boolean verify(String hostname, SSLSession session) { return true; } });
		httpsCon.connect();
		//httpsCon.setRequestProperty("Set-Cookie", httpsCon.getHeaderField("Set-Cookie"));
		InputStream in = httpsCon.getInputStream();
		BufferedReader isr = new BufferedReader(new InputStreamReader(in));
		StringBuffer sb = new StringBuffer();
		int nread = 0;
		byte[] buf = new byte[8192];
		
//		while ((nread = in.read(buf)) != -1) {
//			System.out.write(buf, 0, nread);
//			
//		}
		
		System.out.println( getStringFromInputStream(httpsCon.getInputStream()));
//		while ((nread = isr.read()) != -1) { 
//			sb.append( isr.readLine() );
//		}
//		
		//System.out.print(sb);
	}
	
	private static String getStringFromInputStream(InputStream is) {
		 
		BufferedReader br = null;
		StringBuilder sb = new StringBuilder();
 
		String line;
		try {
 
			br = new BufferedReader(new InputStreamReader(is));
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
 
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
 
		return sb.toString();
 
	}
	
}
