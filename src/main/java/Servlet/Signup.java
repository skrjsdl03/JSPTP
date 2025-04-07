package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.GmailSend;
import DAO.UserDAO;
import DTO.UserAddrDTO;
import DTO.UserDTO;

@WebServlet("/signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		UserDAO userDao = new UserDAO();
		
		String type = "일반";
		if(session.getAttribute("userType")!=null)
			type = (String)session.getAttribute("userType");
	
		String id = null;
		if(request.getParameter("userId") == null)
			id = (String)session.getAttribute("id");
		else
			id = request.getParameter("userId");
		
		String pwd = null;
		if(request.getParameter("password") == null)
			pwd = null;
		else
			pwd = request.getParameter("password");
		
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		int point = 0;
		if(request.getParameter("referrer") != null) {
			if(userDao.idCheck(request.getParameter("referrer"))) {
				point = 3000;
				userDao.updatePoint(request.getParameter("referrer"));
			}
		}
		String zipcode = request.getParameter("zipcode");
		String road = request.getParameter("address1");
		String detail = request.getParameter("address2");
		String gender = request.getParameter("gender");
		int height = 0;
		if(request.getParameter("height") != null && request.getParameter("height") != "") {
			height = Integer.parseInt(request.getParameter("height"));
		}
		int weight = 0;
		if(request.getParameter("weight") != null && request.getParameter("weight") != "") {
			weight = Integer.parseInt(request.getParameter("weight"));
		}
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		if(month.length()==1)
			month = "0" + month;
		String birth = year + "-" + month + "-" + day;
		String phone1 = request.getParameter("phone1");
		String phone2 = request.getParameter("phone2");
		String phone3 = request.getParameter("phone3");
		String phone = phone1 + "-" + phone2 + "-" + phone3;
		String marketing = "N";
		if(request.getParameter("marketing") != null)
			marketing = "Y";

		
		UserDTO user = new UserDTO();
		user.setUser_id(id);
		user.setUser_pwd(pwd);
		user.setUser_type(type);
		user.setUser_name(name);
		user.setUser_birth(birth);
		user.setUser_gender(gender);
		user.setUser_height(height);
		user.setUser_weight(weight);
		user.setUser_email(email);
		user.setUser_phone(phone);
		user.setUser_marketing_state(marketing);
		user.setUser_point(point);
		
		UserAddrDTO userAddr = new UserAddrDTO();
		userAddr.setAddr_zipcode(zipcode);
		userAddr.setAddr_road(road);
		userAddr.setAddr_detail(detail);
		
		userDao.insertUser(user, userAddr);
		
		if(email != null && !email.trim().isEmpty()) {
		GmailSend mail = new GmailSend();
		String title = "Welcome to everyWEAR 👟";
		String content = "<html><body>"
			    + "지금, 당신의 스타일이 달라집니다.<br><br>"
			    + "<strong>everyWEAR에 오신 걸 진심으로 환영합니다 🎉</strong><br><br>"
			    + "회원가입이 완료되었어요!<br>"
			    + "앞으로 everyWEAR만의 감각적인 스타일과 특별한 혜택을<br>"
			    + "가장 먼저 만나보실 수 있습니다.<br><br>"
			    + "매주 업데이트되는 유니섹스 아이템,<br>"
			    + "회원 전용 할인과 이벤트,<br>"
			    + "그리고 당신만을 위한 스타일 큐레이션까지!<br><br>"
			    + "매일의 옷장을 더 설레게 만들 새로운 선택들.<br>"
			    + "이제, everyWEAR와 함께 시작해보세요 🖤<br><br>"
			    + "🖤 감각적인 유니섹스 신상품<br>"
			    + "🖤 전용 할인 쿠폰 및 시즌 이벤트<br>"
			    + "🖤 나만을 위한 스타일 추천 서비스<br><br>"
			    + "당신의 일상에 스타일을 더하는 브랜드,<br>"
			    + "<strong>everyWEAR</strong>가 함께하겠습니다.<br><br>"
			    + "Stay trendy,<br>"
			    + "<strong>everyWEAR</strong>"
			    + "</body></html>";
		
			mail.send(title, content, email);
		}

		
		response.sendRedirect("login.jsp");
	}

}
