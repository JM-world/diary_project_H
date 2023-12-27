package com.human.project_H.Controller;

import java.net.URI;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.human.project_H.entity.TodayColor;
import com.human.project_H.entity.UserColor;
import com.human.project_H.service.TodayColorService;
import com.human.project_H.service.UserColorService;

@Controller
@RequestMapping("/diary")
public class UserColorController {

	@Autowired
	private TodayColorService todayColorService;

	// 오늘 날짜 변수
	LocalDate today = LocalDate.now();

	@GetMapping("/color")
	public String getAllColors(Model model) {
		List<TodayColor> todayColors = todayColorService.getAllColors();
		model.addAttribute("todayColors", todayColors);
		return "diary/selectColor";
	}

	@PostMapping("/color")
	public String getAllColors(String color, HttpSession session, Model model) {
//		String sessCustId = (String) session.getAttribute("sessCustId");
		String sessCustId = (String) session.getAttribute("sessCustId");
		System.out.println(sessCustId);
		UserColor userColor = userColorService.searchUserColor(sessCustId, today.toString());

		if (userColor == null) {
			TodayColor todayColor = todayColorService.choiceTodayColor(color);
			userColorService.insertUserColorSave(sessCustId, todayColor.getCid(), " ");
			//userColorService.insertUserSentimentSave(sessCustId," "," "," "," ");
			
			session.setAttribute("todayColor",
					new TodayColor(todayColor.getMainColor_code1(), todayColor.getColor_code2(), todayColor.getTitle(),
							todayColor.getSubTitle(), todayColor.getExplan(), todayColor.getQuestion(),
							todayColor.getOneWord()));
			session.setAttribute("content", " ");

			model.addAttribute("msg", "오늘의 색은 " + todayColor.getTitle() + "이에요 :)");

			return "diary/diaryWrite";

		} else if (userColor.getCommitFlag() == false) {
			TodayColor todayColor = todayColorService.searchTodayColor(userColor.getCid());

			session.setAttribute("todayColor",
					new TodayColor(todayColor.getMainColor_code1(), todayColor.getColor_code2(), todayColor.getTitle(),
							todayColor.getSubTitle(), todayColor.getExplan(), todayColor.getQuestion(),
							todayColor.getOneWord()));

			session.setAttribute("content", userColor.getContent());
			model.addAttribute("msg", "저장된 일기를 불러올게요.");

			return "diary/diaryWrite";

		} else {
			model.addAttribute("msg", "오늘은 일기를 더 적을 수 없어요.");
			model.addAttribute("url", "/project_H/calendar");
			return "common/alertMsg";
		}
	}

	// 임시저장 기능을 위해 선언된 변수
	private String buffer;

	@Autowired
	private UserColorService userColorService;

	@GetMapping("/list/{page}")
	public String list(@PathVariable int page, HttpSession session, Model model) {
	    String sessCustId = (String) session.getAttribute("sessCustId");
	    System.out.println(sessCustId);
	    List<UserColor> list = userColorService.getUserColorList(page);
	    
	    
	    model.addAttribute("userColorList", list);

	    list.forEach(x -> System.out.println(x));

	    int totalusers = userColorService.getPageCount();  
	    int totalPages = (int) Math.ceil((double) totalusers / UserColorService.RECORDS_PER_PAGE);
	    List<String> pageList = new ArrayList<>();
	    for (int i = 1; i <= totalPages; i++)
	        pageList.add(String.valueOf(i));
	    model.addAttribute("pageList", pageList);
	    session.setAttribute("currentUserPage", page);
	    System.out.println(pageList);
	    return "diary/diaryboard";
	}



	// 사용자 일기 목록
	@GetMapping("/diarylist") 
	public String diarylist(HttpSession session, Model model) {
		String sessCustId = (String) session.getAttribute("sessCustId");
		System.out.println(sessCustId);
		
		
		// 사용자가 작성한 일기 목록을 가져옴
		List<UserColor> userdiaryList = userColorService.getUserColorListByCustId(sessCustId);
		
		
		Collections.sort(userdiaryList, Comparator.comparing(UserColor::getModTime).reversed());

		// 가져온 일기 목록을 뷰에 전달
		model.addAttribute("userDiaryList", userdiaryList);
		System.out.println(userdiaryList);

		// 뷰 이름을 반환 (WEB-INF/views/ 하위의 경로를 사용)
		return "diary/diaryList";
	}

	// 일기 선택 화면
	@GetMapping("/home")
	public String diarySelect() {
		return "ho";
	}

	@GetMapping("/diaryWrite") // routing 정보, localhost:8090/project_H/diary/diaryWrite
	public String diaryWrite() {
		return "diary/diaryWrite"; // webapp/WEB-INF/view/diaryWrite.jsp 를 렌더링해서 보여줄 것
	}

		// 일기 쓰기 화면 POST
	@PostMapping("/diaryWrite")
	public String boardWriteProc(String content, boolean commit, boolean share, HttpSession session, Model model) {
	    // 공백을 제외한 글자 수가 30자 이상이고 900자 이하일 때 제출 가능
	    if (content.replaceAll("\\s", "").length() >= 30 && content.replaceAll("\\s", "").length() <= 900) {
	        commit = true;
	        content = content.trim();
	        String sessCustId = (String) session.getAttribute("sessCustId");
	        UserColor userColor = userColorService.searchUserColor(sessCustId, today.toString());
	        
	        // 중복 저장 방지를 위해 userColor가 null이 아닌 경우에만 저장
	        if (userColor != null && !userColor.getCommitFlag()) {
                // 중복 저장 방지를 위해 userColor가 null이 아닌 경우에만 저장
                userColorService.updateUserColorCommit(userColor.getUcid(), content, commit, share);
	            
	        	try {
	                // 추가한 부분
	                String userInput = URLEncoder.encode(content, "utf-8");
	                String apiUrl = "http://192.168.0.233:5000/chatbot/sentiment?userInput=" + userInput;

	                URI uri = new URI(apiUrl);
	                RestTemplate rest = new RestTemplate();
	                ResponseEntity<String> response = rest.getForEntity(uri, String.class);

	                // Rest api 데이터 파서
	                JSONParser json = new JSONParser();
	                JSONObject obj = (JSONObject) json.parse(response.getBody().toString());
	                String sentiment = (String) obj.get("sentiment");
	                // Rest api 데이터 파서

	                // 감정 점수 만들기
	                double negative_score = (double) obj.get("negative_score");
	                double positive_score = (double) obj.get("positive_score");
	                double neutral_score = (double) obj.get("neutral_score");

	                System.out.println(sentiment);
	                System.out.println(positive_score);
	                System.out.println(neutral_score);
	                System.out.println(negative_score);

	                // 서비스에 있는 insertSentiment 함수로 user_sentiment 테이블에 전송
	                // 업데이트로 바꾸기 color페이지에서 빈값으로 인서트 해놨음
	                userColorService.insertSentiment(sessCustId, sentiment, positive_score, neutral_score, negative_score);
	                // 추가한 부분 끝
		        }
	            catch (Exception e) {
	                e.printStackTrace();
	                model.addAttribute("msg", "예외 발생으로 작성에 실패했어요.");
	                return "common/alertMsg";
	            }


	                model.addAttribute("msg", "작성 완료되었어요.");
	                if (share) {
	                    // 공유 여부가 true일 때 공유 게시판으로 이동
	                    return "redirect:/diary/list/1";
	                } else {
	                    // 공유하지 않는 경우에는 다른 경로로 이동하도록 수정 (원하는 경로로 변경)
	                    return "redirect:/diary/diarylist";
	                }
	            
	        } else {
	            model.addAttribute("msg", "이미 저장된 일기이거나 조건을 만족하지 않습니다.");
	            return "common/alertMsg";
	        }
	    } else {
	        model.addAttribute("msg", "일기 내용이 충분하지 않아요.");
	        return "common/alertMsg";
	    }
	}


//		else {
//			String sessCustId = (String) session.getAttribute("sessCustId");
//			UserColor userColor = userColorService.searchUserColor(sessCustId, today.toString());		
//			session.setAttribute("content", userColor.getContent());
//			model.addAttribute("msg", "일기 내용이 충분하지 않아요.");
//			
//			return "redirect:/diary/diaryWrite";
//		}
			


	// 임시 저장 기능
	// 10글자 마다 해당 UCID content 컬럼에 update됨
	@ResponseBody
	@GetMapping("/write_in")
	public String writeIn(String contentIn, HttpSession session) {
		buffer = contentIn;
		System.out.println(buffer);
		String sessCustId = (String) session.getAttribute("sessCustId");
		UserColor userColor = userColorService.searchUserColor(sessCustId, today.toString());
		try {

			if (buffer.isEmpty()) {
				userColorService.updateUserColorSave(userColor.getUcid(), " ", today.toString());
			} else {
				userColorService.updateUserColorSave(userColor.getUcid(), buffer, today.toString());
			}
		} catch (Exception e) {

		}
		return "";
	}


	@GetMapping("/view/{ucid}")
	public String viewBoard(@PathVariable int ucid, HttpSession session, Model model) {
	    String sessCustId = (String) session.getAttribute("sessCustId");
	    System.out.println(sessCustId);

	    UserColor usercolor = userColorService.getUserColor(ucid);

	    // 본인 글인지 여부를 확인
	    if (!usercolor.getCustId().equals(sessCustId)) {
	        // 본인 글이 아니라면 조회수 증가
	        userColorService.increaseViewCount(ucid);
	    }

	    model.addAttribute("userColor", usercolor);
	    System.out.println(usercolor);

	    return "diary/detaildiary";
	}


	
	  // 수정 페이지로 이동
    @GetMapping("/update/{ucid}")
    public String updateDiaryForm(@PathVariable("ucid") int ucid, Model model) {
        UserColor userColor = userColorService.getUserColor(ucid);
        model.addAttribute("userColor", userColor);
        return "diary/diaryUpdate";
    }
    
    
    @PostMapping("/update")
    public String updateDiary(@RequestParam("ucid") int ucid, @RequestParam("content") String content) {
        userColorService.updateUserColorContent(ucid, content);
        return "redirect:/diary/list/1";
    }
    
    
    // 삭제 기능
    @GetMapping("/delete/{ucid}")
    public String deleteDiary(@PathVariable("ucid") int ucid) {
        userColorService.deleteUserColor(ucid);
        return "redirect:/diary/list/1";
    }
    
 
    @GetMapping("/like/{ucid}")
    @ResponseBody
    public ResponseEntity<String> likeDiary(@PathVariable int ucid, HttpSession session) {
        String custId = (String) session.getAttribute("sessCustId");

        // 게시물의 작성자 정보를 가져오는 메서드를 UserColorService에 추가한다고 가정
        String authorCustId = userColorService.getAuthorCustId(ucid);

        // 자신이 작성한 게시물에는 공감할 수 없도록 체크
        if (custId != null && custId.equals(authorCustId)) {
            // 자신이 작성한 게시물에는 공감할 수 없음
            // 원하는 처리를 수행하거나 에러 메시지를 반환할 수 있음
            return ResponseEntity.badRequest().body("자신이 작성한 게시물에는 공감할 수 없습니다.");
        }

        Set<Integer> likedPost = (Set<Integer>) session.getAttribute("likedPost");
        if (likedPost == null) {
            likedPost = new HashSet<>();
        }

        // 이미 공감한 게시물인지 확인
        if (!likedPost.contains(ucid)) {
            // 사용자가 공감하지 않은 경우에만 공감 처리
            userColorService.increaseHitCount(ucid);

            // 세션에 공감한 게시물 ID 추가
            likedPost.add(ucid);
            session.setAttribute("likedPost", likedPost);
        }

        // 성공적으로 처리된 경우의 응답
        return ResponseEntity.ok("공감이 성공적으로 처리되었습니다.");
    }

}