package com.human.project_H.Controller;


import java.net.URI;
import java.net.URLEncoder;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.human.project_H.Dao.UserColorDaoOracle;
import com.human.project_H.Dao.UserDao;
import com.human.project_H.entity.ColorByDay;
import com.human.project_H.entity.SelectCalendarTodayColor;
import com.human.project_H.entity.SelectContent;
import com.human.project_H.entity.SentimentCount;
import com.human.project_H.entity.User;
import com.human.project_H.entity.UserColor;
import com.human.project_H.entity.UserCount;
import com.human.project_H.entity.UserSentiment;
import com.human.project_H.service.CalendarService;


@Controller
public class CalendarController {
	
	@Autowired
    private UserColorDaoOracle userColorDaoOracle;
	
	@Autowired
	private UserDao userDao;
	
	@Autowired CalendarService calService;
	
	
	@GetMapping("/calendar")	// routing 정보,  localhost:8090/project_H/calendar
	public String calendar(Model model, HttpSession session) {
		model.addAttribute("menu", "home");
		String sessCustId = (String) session.getAttribute("sessCustId");
		System.out.println(sessCustId);
		
		// 세션에서 가져온 sessCustId를 모델에 추가
        model.addAttribute("sessCustId", sessCustId);
        
        // 월간 데이터 분석의 최소 요건 = 커밋 7회
        int commitCo = userColorDaoOracle.commitCo(sessCustId, "2023-12");
        session.setAttribute("commitCo", commitCo);
        
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
	
	@ResponseBody
	@PostMapping("/calendar")
	public String calendarProc(String custId, String date) {
		// 오늘의 컬러 : colorCode, colorName
		Map<String, String> mainColor = calService.getColorCode(custId, date);
		
		// 오늘의 감정 : positive, neutral, negative > pie
		Map<String, Double> emotionScore = calService.getEmotion(custId, date);
		
		// 많이쓴 단어 3개 > Komoran에서 : pie > python OKT로 변경
		String content = calService.getContent(custId, date);
		 JSONArray wordJsonArray = new JSONArray();
		 try {
		    	String encodedInput = URLEncoder.encode(content, "utf-8");
			    String apiUrl = "http://192.168.0.233:5000/chatbot/word_count?userInput=" + encodedInput;

			    URI uri = new URI(apiUrl);
			    RestTemplate rest = new RestTemplate();
			    ResponseEntity<String> response = rest.getForEntity(uri, String.class);

			    JSONParser json = new JSONParser();
			    JSONObject obj = (JSONObject) json.parse(response.getBody().toString());

			    // 가장 큰 값을 저장할 변수와 그 키를 저장할 변수 초기화
			    Map<String, Integer> wordCounts = new HashMap<>();

			    // 모든 키-값 쌍을 순회하며 최대 값을 가지는 키를 찾음
			    Iterator<?> keys = obj.keySet().iterator();
			    while (keys.hasNext()) {
			        String key = (String) keys.next();
			        int value = ((Long) obj.get(key)).intValue();
			        wordCounts.put(key, value);
			    }
			    
			    List<Map.Entry<String, Integer>> sortedList = wordCounts.entrySet().stream()
		                .sorted((entry1, entry2) -> Integer.compare(entry2.getValue(), entry1.getValue()))
		                .limit(10)
		                .collect(Collectors.toList());
			    
		        for (Map.Entry<String, Integer> entry : sortedList) {
		        	JSONObject jsonObject = new JSONObject();
		        	jsonObject.put("word", entry.getKey());
		        	jsonObject.put("count", entry.getValue());
		        	wordJsonArray.add(jsonObject);
		        }
		        
		
		        			    
			} catch (Exception e) {
				e.printStackTrace();
			}
		 		
		// 사용자들이 선택한 색상 3개  > DB에서 : pie
		List<ColorByDay> colorList = calService.getDayColor(date);
		JSONArray cJsonArray = new JSONArray();
		Iterator<ColorByDay> it = colorList.iterator();
		while(it.hasNext()) {
			ColorByDay color = it.next();
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("colorName", color.getColorName());
			jsonObject.put("colorCode", color.getColorCode());
			jsonObject.put("colorCount", color.getColorCount());			
			cJsonArray.add(jsonObject);
		}
		
		
		JSONObject result = new JSONObject();
		result.put("mainColor", mainColor);
		result.put("emotionScore", emotionScore);
		result.put("userContent", wordJsonArray);
		result.put("usersDayColor", cJsonArray);
		System.out.println(result);
		return result.toJSONString();
	}
	
	
	@GetMapping("/calendar/monthResult")
	public String monthResult(HttpSession session, Model model) {
	    String sessCustId = (String) session.getAttribute("sessCustId");
	    
	    // 닉네임
	    User user = userDao.getUser(sessCustId);
	    
	    // 일기 제출 횟수
	    int commitCo = userColorDaoOracle.commitCo(sessCustId, "2023-12");
	    int commitPer = (int) ((double)commitCo / 31 * 100);
	    
	    // 일기 공유 횟수
	    int shareCo = userColorDaoOracle.shareCo(sessCustId, "2023-12");
	    
	    // 공감수 높은 글
	    UserColor hitContent = userColorDaoOracle.hitContent(sessCustId, "2023-12");
	    
	    // 긍정 점수 높은 글
	    UserSentiment poContent = userColorDaoOracle.poContent(sessCustId, "2023-12");
	    
	    // 부정 점수 높은 글
	    UserSentiment neContent = userColorDaoOracle.neContent(sessCustId, "2023-12");
	    
	    session.setAttribute("user", user);
	    session.setAttribute("commitCo", commitCo);
	    session.setAttribute("commitPer", commitPer);
	    session.setAttribute("shareCo", shareCo);
	    session.setAttribute("hitContent", hitContent);
	    session.setAttribute("poContent", poContent);
	    session.setAttribute("neContent", neContent);
	    
	    
	    List<UserCount> selectedColors = userColorDaoOracle.getColorCount(sessCustId);

	    // mainColor_name에 해당하는 리스트
	    List<String> mainColorNames = new ArrayList<>();
	    // colorCounts에 해당하는 리스트
	    List<Integer> colorCounts = new ArrayList<>();
	    // colors에 해당하는 리스트
	    List<String> colors = new ArrayList<>();

	    for (UserCount userCount : selectedColors) {
	        mainColorNames.add(userCount.getMainColor_name()); // 색상 이름을 가져와서 추가
	        colorCounts.add(userCount.getColor_Count()); // 색상 개수를 가져와서 추가
	        colors.add(userCount.getMainColor_code1()); // 색상 코드를 가져와서 추가
	    }
	    
	    session.setAttribute("mainColorNames", mainColorNames);
	    session.setAttribute("colorCounts", colorCounts);
	    session.setAttribute("colors", colors);
	    
	    // 수동으로 JSON 문자열 생성 
	    String jsonData = "{ \"mainColorNames\": " + convertListToJsonArray(mainColorNames)
	            + ", \"colorCounts\": " + convertListToJsonArray(colorCounts)
	            + ", \"colors\": " + convertListToJsonArray(colors) + "}";
	    session.setAttribute("chartData", jsonData);
	    
	    
	    
	    // 현재 날짜의 월을 얻기
        Date currentDate = new Date(System.currentTimeMillis());
        SimpleDateFormat monthFormat = new SimpleDateFormat("yyyy-MM");
        String currentMonth = monthFormat.format(currentDate);

        List<SentimentCount> sentimentCountList = userColorDaoOracle.getUserColorWithSentimentByUserId(sessCustId, currentMonth);

        session.setAttribute("sentimentCountList", sentimentCountList);
      

        String sentimentJsonData = "{ \"sentiments\": " + convertSentimentListToJsonArray(sentimentCountList) + "}";
        session.setAttribute("sentimentChartData", sentimentJsonData);
        
        List<SelectContent> searchCONTENT = userColorDaoOracle.searchCONTENT(sessCustId);

	    String contentStr = "";
	    for (int i = 0; i < searchCONTENT.size(); i++) {
	        SelectContent content = searchCONTENT.get(i);
	        String word = content.getContent();
	        contentStr += word;
	    }
	    
	    try {
	    	String encodedInput = URLEncoder.encode(contentStr, "utf-8");
		    String apiUrl = "http://192.168.0.233:5000/chatbot/word_count?userInput=" + encodedInput;

		    URI uri = new URI(apiUrl);
		    RestTemplate rest = new RestTemplate();
		    ResponseEntity<String> response = rest.getForEntity(uri, String.class);

		    JSONParser json = new JSONParser();
		    JSONObject obj = (JSONObject) json.parse(response.getBody().toString());

		    // 가장 큰 값을 저장할 변수와 그 키를 저장할 변수 초기화
		    Map<String, Integer> wordCounts = new HashMap<>();

		    // 모든 키-값 쌍을 순회하며 최대 값을 가지는 키를 찾음
		    Iterator<?> keys = obj.keySet().iterator();
		    while (keys.hasNext()) {
		        String key = (String) keys.next();
		        int value = ((Long) obj.get(key)).intValue();
		        wordCounts.put(key, value);
		    }
		    
		    List<Map.Entry<String, Integer>> sortedList = wordCounts.entrySet().stream()
	                .sorted((entry1, entry2) -> Integer.compare(entry2.getValue(), entry1.getValue()))
	                .limit(10)
	                .collect(Collectors.toList());
		    
		    JSONArray wordJsonArray = new JSONArray();
	        for (Map.Entry<String, Integer> entry : sortedList) {
	        	JSONObject jsonObject = new JSONObject();
	        	jsonObject.put("word", entry.getKey());
	        	jsonObject.put("count", entry.getValue());
	        	wordJsonArray.add(jsonObject);
	        }
	        
	        String words = wordJsonArray.toString();
		    System.out.println(words);
	        
		    model.addAttribute("wordsJson", words);  // 가장많이쓴 단어 모델
		    
		} catch (Exception e) {
			e.printStackTrace();
		}
        
	    return "calendar/monthResult";
	}

	// 리스트를 JSON 배열 형태의 문자열로 변환하는 함수
	private String convertListToJsonArray(List<?> list) {
	    StringBuilder jsonArr = new StringBuilder("[");
	    for (Object item : list) {
	        jsonArr.append("\"").append(item).append("\",");
	    }
	    if (jsonArr.length() > 1) {
	        jsonArr.deleteCharAt(jsonArr.length() - 1); // 마지막 콤마 제거
	    }
	    jsonArr.append("]");
	    return jsonArr.toString();
	
	
	}
	
	private String convertSentimentListToJsonArray(List<SentimentCount> sentimentList) {
        StringBuilder jsonArr = new StringBuilder("[");
        for (SentimentCount sentimentCount : sentimentList) {
            jsonArr.append("{ \"sentiment\": \"").append(sentimentCount.getSentiment()).append("\", \"count\": ")
                    .append(sentimentCount.getColor_count()).append("},");
        }
        if (jsonArr.length() > 1) {
            jsonArr.deleteCharAt(jsonArr.length() - 1);
        }
        jsonArr.append("]");
        return jsonArr.toString();
    }
}

