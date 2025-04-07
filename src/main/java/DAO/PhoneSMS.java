package DAO;

import java.util.HashMap;

import org.json.simple.JSONObject;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

public class PhoneSMS {

	public static String sendSMS(String phoneNumber) {
		
        //발급받은 key, secret 작성
        String api_key = "NCSTTZTXXEAAU823";
	String api_secret = "S46JYZXLNURBVNA9KVUMAW3L6QXLTRPW";
	
		
        //인증 번호 출력 코드
		String code = "";
		for(int i=0; i<6; i++) {
			code += (int)(Math.random()*9+1);
		}
	
		System.out.println(code);
		
		Message coolsms = new Message(api_key, api_secret);
		
		HashMap<String, String> params = new HashMap<String, String>();
		
		params.put("to", phoneNumber);			//송신자 번호('-' 없이 작성)
		params.put("from", "01033989352");			//발송자 번호('-' 작성)
		params.put("type", "SMS");
        
        //보낼 메세지 작성
		params.put("text", "인증번호는 [" + code + "]입니다.");
		params.put("app_version", "test app 1.2");
		
		try {
            JSONObject obj =(JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		}
        catch(CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		return code;
	}
}