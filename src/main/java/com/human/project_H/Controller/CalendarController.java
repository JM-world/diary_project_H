package com.human.project_H.Controller;


import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.human.project_H.Dao.UserColorDaoOracle;
import com.human.project_H.entity.SelectCalendarTodayColor;
import com.human.project_H.entity.SelectContent;
import com.human.project_H.entity.UserSentiment;


@Controller
public class CalendarController {
	
	@Autowired
    private UserColorDaoOracle userColorDaoOracle;
	
	@GetMapping("/calendar")	// routing 정보,  localhost:8090/project_H/calendar
	public String calendar(Model model, HttpSession session) {
		model.addAttribute("menu", "home");
		String sessCustId = (String) session.getAttribute("sessCustId");
		System.out.println(sessCustId);
		
		// 세션에서 가져온 sessCustId를 모델에 추가
        model.addAttribute("sessCustId", sessCustId);
        
        // 감정 가져오기
        List<UserSentiment> userSentiments = userColorDaoOracle.searchUSER_SENTIMENT(sessCustId);
        
        Map<String, String>[] dataArray = new HashMap[userSentiments.size()];
        
        for (int i = 0; i < userSentiments.size(); i++) {
        	UserSentiment sentiment = userSentiments.get(i); // 예시를 위해 리스트에서 값을 가져옴
        	LocalDateTime modTime = sentiment.getModTime();
            String formattedModTime = modTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            
            Map<String, String> data = new HashMap<>();
        	if (sentiment.getSentiment().equals("neutral")) {
        	    // 'neutral'일 때 실행할 코드
        	    // 예시: 값을 바꾸는 작업
        	    data.put("감정" ,"중립");
        	    data.put("날짜" ,formattedModTime);
        	} else if (sentiment.getSentiment().equals("negative")) {
        		data.put("감정" ,"부정");
        		data.put("날짜" ,formattedModTime);
        	} else {
        		data.put("감정" ,"긍정");
        		data.put("날짜" ,formattedModTime);
        	}
        	dataArray[i] = data;
        }
        
        model.addAttribute("dataArray", dataArray);
        
        JSONArray jsonArray = new JSONArray();

        for (Map<String, String> data : dataArray) {
            JSONObject jsonObject = new JSONObject(data);
         // JSONObject를 문자열로 변환하여 JSONArray에 추가
            jsonArray.add(jsonObject);
        }

        // JSON 문자열로 변환
        String jsonString = jsonArray.toString();
        //감정 가져오기 끝
        
        // 가장많이쓴단어 가져오기
        List<SelectContent> searchCONTENT = userColorDaoOracle.searchCONTENT(sessCustId);
        
        
        Map<String, String>[] contentArray = new HashMap[searchCONTENT.size()];
        for (int i = 0; i < searchCONTENT.size(); i++) {
        	SelectContent content = searchCONTENT.get(i); // 예시를 위해 리스트에서 값을 가져옴
        	LocalDateTime modTime = content.getModTime();
        	String formattedModTime = modTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            String word = content.getContent();
            
            Map<String, String> data = new HashMap<>();
            try {
				String userInput = (String) word;
				userInput = URLEncoder.encode(userInput, "utf-8");
				String apiUrl = "http://192.168.0.233:5000/chatbot/word_count?userInput=" + userInput;
				
				URI uri = new URI(apiUrl);
				RestTemplate rest = new RestTemplate();
				ResponseEntity<String> response = rest.getForEntity(uri, String.class);
				
				JSONParser json = new JSONParser();
				JSONObject obj = (JSONObject) json.parse(response.getBody().toString());

				// 가장 큰 값을 저장할 변수와 그 키를 저장할 변수 초기화
				int max = Integer.MIN_VALUE;
				List<String> maxKeys = new ArrayList<>();

				// 모든 키-값 쌍을 순회하며 최대 값을 가지는 키를 찾음
				Iterator<?> keys = obj.keySet().iterator();
				while (keys.hasNext()) {
				    String key = (String) keys.next();
				    int value = ((Long) obj.get(key)).intValue();
				    if (value > max) {
				        max = value;
				        maxKeys.clear(); // 최대값이 바뀌었으므로 기존의 최대값 키들을 모두 지움
				        maxKeys.add(key); // 새로운 최대값 키 추가
				    } else if (value == max) {
				        maxKeys.add(key); // 현재 최대값과 같은 값의 키 추가
				    }
				}

				// 최대 값을 갖는 모든 키를 하나의 문자열로 합쳐서 출력
				String keysString = String.join(",", maxKeys);
				data.put("단어", keysString);
				data.put("날짜" ,formattedModTime);
				contentArray[i] = data;
				} catch (Exception e) {
					System.out.println("예외발생");
				}
            

        }
        
        for (Map<String, String> map : contentArray) {
        	//System.out.println(map);
        }
        
        JSONArray jsonArray2 = new JSONArray();
        
        for (Map<String, String> data : contentArray) {
        	JSONObject jsonObject = new JSONObject(data);
        	jsonArray2.add(jsonObject);
        }
        // 가장많이쓴단어 가져오기 끝
        
        // 선택한 색깔 가져오기
        List<SelectCalendarTodayColor> searchUserColor = userColorDaoOracle.searchCalcolor(sessCustId);
        
        Map<String, String>[] ColorArray = new HashMap[searchUserColor.size()];
        
        for (int i = 0; i < searchUserColor.size(); i++) {
        	SelectCalendarTodayColor SelectColor = searchUserColor.get(i);	// 예시를 위해 리스트에서 값을 가져옴
        	String maincolor_name = SelectColor.getMaincolor_name();
        	String maincolor = "";
        	if ("초록색".equals(maincolor_name)) {
        		maincolor = "#00FF00";
        	} else if ("보라색".equals(maincolor_name)) {
        		maincolor = "#4B0082";
        	} else if ("빨간색".equals(maincolor_name)) {
        		maincolor = "#ff0000";
        	} else if ("분홍색".equals(maincolor_name)) {
        		maincolor = "#FF1493";
        	} else if ("노란색".equals(maincolor_name)) {
        		maincolor = "#FFFF00";
        	} else if ("주황색".equals(maincolor_name)) {
        		maincolor = "#FFA500";
        	} else if ("갈색".equals(maincolor_name)) {
        		maincolor = "#A52A2A";
        	} else if ("파란색".equals(maincolor_name)) {
        		maincolor = "#00FFFF";
        	} else {
        		maincolor = SelectColor.getMaincolor_code1();
        	} 
        	String title = SelectColor.getColor_code2();
        	LocalDateTime modTime = SelectColor.getModTime();
            String formattedModTime = modTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
            Map<String, String> colordata = new HashMap<>();
            colordata.put("maincolor", maincolor);
            colordata.put("maincolor_name", maincolor_name);
            colordata.put("title", title);
            colordata.put("modtime", formattedModTime);
            ColorArray[i] = colordata;
        }
        JSONArray colors = new JSONArray();
        for (Map<String, String> data : ColorArray) {
        	JSONObject jsonObject = new JSONObject(data);
        	
        	colors.add(jsonObject);
        }
        // 선택한 색깔 가져오기끝
        String colorString = colors.toString();
        String words = jsonArray2.toString();
        //System.out.println(words);
        model.addAttribute("colorString", colorString);  // 선택한 색 모델
        model.addAttribute("words", words);  // 가장많이쓴 단어 모델
        model.addAttribute("jsonString", jsonString);  // 감정 모델
		return "calendar/calendar";				// webapp/WEB-INF/view/calendar.jsp 를 렌더링해서 보여줌
	}
	
	
	@GetMapping("/calendar/monthResult")
    public String monthResult() {
        return "calendar/monthResult";
    }

}

