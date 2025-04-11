<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String user_id = request.getParameter("user_id");
String user_type = request.getParameter("user_type");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CRM - 고객 상세 관리</title>
<style>
.crm-layout {
	display: flex;
	gap: 20px;
}

.crm-sidebar {
	width: 180px;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.crm-sidebar button {
	padding: 10px;
	border: 1px solid #ccc;
	background-color: #f4f4f4;
	cursor: pointer;
}

.crm-sidebar button:hover {
	background-color: #eaeaea;
}

.crm-content {
	flex: 1;
	border: 1px solid #ddd;
	padding: 20px;
	background: #fff;
}
</style>
<!-- userCRM.jsp -->
<script>

// 비밀번호 ↔ 비밀번호 확인 일치검사 메소드로 detail.jsp에서 호출해서 사용함
function setupPasswordCheck() {
  const pw = document.getElementById("password");
  const confirm = document.getElementById("confirmPassword");
  const msg = document.getElementById("pwCheckMsg");

  if (!pw || !confirm || !msg) return;

  function check() {
    const a = pw.value;
    const b = confirm.value;

    if (!a && !b) {
      msg.textContent = "";
      msg.className = "";
    } else if (a === b) {
      msg.textContent = "비밀번호가 일치합니다.";
      msg.className = "match";
    } else {
      msg.textContent = "비밀번호가 일치하지 않습니다.";
      msg.className = "not-match";
    }
  }

  pw.addEventListener("input", check);
  confirm.addEventListener("input", check);
}

function setupAccountStateSync() {
	  const stateSelect = document.getElementById("accountState");
	  const lockSelect = document.getElementById("lockState");

	  if (!stateSelect || !lockSelect) return;

	  stateSelect.addEventListener("change", function () {
	    const selected = stateSelect.value.trim();

	    if (selected === "정상") {
	      lockSelect.value = "N";
	    } else {
	      lockSelect.value = "Y";
	    }
	  });
	}
	
// 생년월일 빡센 유효성 검사
function setupBirthValidation() {
	  const birthY = document.getElementById("birth_y");
	  const birthM = document.getElementById("birth_m");
	  const birthD = document.getElementById("birth_d");

	  function resetBirth() {
	    birthY.value = "";
	    birthM.value = "";
	    birthD.value = "";
	  }

	  function isLeapYear(year) {
	    return (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
	  }

	  function validateDate() {
		  const y = parseInt(birthY.value, 10);
		  const m = parseInt(birthM.value, 10);
		  const d = parseInt(birthD.value, 10);

		  if (!birthY.value || !birthM.value || !birthD.value) return;

		  if (isNaN(y) || isNaN(m) || isNaN(d)) {
		    alert("숫자만 입력해주세요.");
		    resetBirth();
		    return;
		  }

		  const today = new Date();
		  const currentYear = today.getFullYear();

		  if (y < 1900 || y > currentYear) {
		    alert("연도는 1900년부터 "+currentYear+"년까지 입력 가능합니다.");
		    resetBirth();
		    return;
		  }

		  if (m < 1 || m > 12) {
		    alert("월은 1~12 사이의 숫자여야 합니다.");
		    resetBirth();
		    return;
		  }

		  const daysInMonth = [31, isLeapYear(y) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

		  if (d < 1 || d > daysInMonth[m - 1]) {
		    alert(y+"년 "+m+"월은 "+daysInMonth[m - 1]+"일까지 있습니다.");
		    resetBirth();
		    return;
		  }

		  // 👇 오늘 이후 날짜면 안 됨
		  const inputDate = new Date(y, m - 1, d); // JS는 월이 0부터 시작
		  const now = new Date();

		  if (inputDate > now) {
		    alert("생년월일은 오늘 이전 날짜까지만 입력 가능합니다.");
		    resetBirth();
		    return;
		  }
		}

	  // 각 칸에서 다른 칸으로 포커스를 이동할 때 validate
	  birthY.addEventListener("blur", validateDate);
	  birthM.addEventListener("blur", validateDate);
	  birthD.addEventListener("blur", validateDate);
	}



function loadTab(tab) {
  let url = "";
  if (tab === 'basic') {
    url = `basic.jsp?user_id=<%=user_id%>&user_type=<%=user_type%>`;
  } else if (tab === 'detail') {
    url = `detail.jsp?user_id=<%=user_id%>&user_type=<%=user_type%>`;
  }

  fetch(url)
    .then(res => res.text())
    .then(html => {
      document.getElementById("content-area").innerHTML = html;

      // detail.jsp가 로드된 후 setupPasswordCheck, setupAccountStateStnc, setupBirthValidation 호출
      if (tab === 'detail') {
    	  setTimeout(() => {
    	    setupPasswordCheck();      // 비밀번호 확인
    	    setupAccountStateSync();   // 계정상태-잠금 연동
    	    setupBirthValidation();	   // 생년월일 유효성 검사
    	  }, 100);
    	}
    });
}

window.onload = function () {
  loadTab('basic');
}
</script>

</head>
<body>
	<div style="text-align: right; margin-bottom: 10px;">
		<button onclick="window.close()" style="padding: 5px 10px;">닫기
			✖</button>
	</div>
	<h2>EVERYWEAR 고객 관리</h2>
	<div class="crm-layout">
		<div class="crm-sidebar">
			<button onclick="loadTab('basic')">CRM 홈</button>
			<button onclick="loadTab('detail')">회원 정보 수정</button>
			<!-- 추후 확장: 배송지, 게시글, 포인트 등 -->
		</div>

		<div id="content-area" class="crm-content">
			<!-- AJAX로 탭 내용이 여기에 삽입됨 -->
		</div>
	</div>
</body>
</html>