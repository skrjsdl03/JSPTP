<!-- payProc.jsp -->
<%@page contentType="text/html; charset=UTF-8"%>
<%
		request.setCharacterEncoding("UTF-8");
		String P_INI_PAYMENT = request.getParameter("P_INI_PAYMENT");
		String ONum = request.getParameter("ONum");
		String priceS = request.getParameter("Price");
		int price = Integer.parseInt(priceS);
		String products = request.getParameter("Products");
		String P_NEXT_URL = request.getParameter("P_NEXT_URL");
		String pName = request.getParameter("PName");
		String pZipcode = request.getParameter("PZipcode");
		String pAddress1 = request.getParameter("PAddress1");
		String pAddress2 = request.getParameter("PAddress2");
		String pAlias = request.getParameter("PAddress3");
		if(pAlias == null || pAlias.equals(""))
			pAlias = pAddress1;
		String pPhone = request.getParameter("PPhone");
		String pEmail = request.getParameter("PEmail");
		String mileage = request.getParameter("psm");
		String pdPrice = request.getParameter("pdPrice");
		String deliFee = request.getParameter("deliFee");
		String dc = request.getParameter("dc");
		String[] fIds = request.getParameterValues("f_ids");
/* 		String[] quantities = request.getParameterValues("PQty");
		String[] pd_ids = request.getParameterValues("PPd_id"); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제시스템</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
    <script>
    $(function(){
        var IMP = window.IMP; // 생략가능
        IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'inicis',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '<%=products%>',
            amount : <%=price%>,
            buyer_email : '<%=pEmail%>',
            buyer_name : '<%=pName%>',
            buyer_tel : '<%=pPhone%>',
            buyer_addr : '<%=pZipcode%>' + ' <%=pAddress1%>' + '<%=pAddress2 != null && !pAddress2.equals("") ? pAddress2 : ""%>',
            buyer_postcode : '123-456',
            //m_redirect_url : 'http://www.naver.com' //결제후 리디렉션 될 URL
        }, function(rsp) {
            if (rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        alert(msg);
                        
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //성공시 이동할 페이지
			   // JSP에서 받은 배열을 JavaScript 배열로 출력 (서버에서 출력해주는 방식)
			    const pd_ids = [<% 
			        String[] pd_ids = request.getParameterValues("PPd_id");
			        for(int i = 0; i < pd_ids.length; i++) {
			            out.print("'" + pd_ids[i] + "'");
			            if (i < pd_ids.length - 1) out.print(",");
			        }
			    %>];
			
			    const quantities = [<% 
			        String[] quantities = request.getParameterValues("PQty");
			        for(int i = 0; i < quantities.length; i++) {
			            out.print("'" + quantities[i] + "'");
			            if (i < quantities.length - 1) out.print(",");
			        }
			    %>];
						
			    let params = new URLSearchParams();
			    params.append("imp_uid", encodeURIComponent(rsp.imp_uid));
			    params.append("apply_num", encodeURIComponent(rsp.apply_num));
			    params.append("card_name", encodeURIComponent(rsp.card_name));
			    params.append("o_num", encodeURIComponent("<%=ONum%>"));
			    params.append("o_name", encodeURIComponent("<%=pName%>"));
			    params.append("o_phone", encodeURIComponent("<%=pPhone%>"));
			    params.append("paid_amount", encodeURIComponent(rsp.paid_amount));
			    params.append("zipcode", encodeURIComponent("<%=pZipcode%>"));
			    params.append("address1", encodeURIComponent("<%=pAddress1%>"));
			    params.append("address2", encodeURIComponent("<%=pAddress2%>"));
			    params.append("alias", encodeURIComponent("<%=pAlias%>"));
			    
			    // 배열로 pd_id[] 와 quantity[] 추가
			    for (let i = 0; i < pd_ids.length; i++) {
			        params.append("pd_id[]", encodeURIComponent(pd_ids[i]));
			        params.append("quantity[]", encodeURIComponent(quantities[i]));
			    }
			    
			    fetch("payInsert.jsp?" + params.toString())
		        .then(res => res.json())
		        .then(data => {
		            if (data.result === "success") {
		                // 성공 처리
		            	let url = "<%=P_NEXT_URL%>?zipcode=" + encodeURIComponent("<%=pZipcode%>") + 
		                "&address1=" + encodeURIComponent("<%=pAddress1%>") + 
		                "&address2=" + encodeURIComponent("<%=pAddress2%>") + 
		                "&o_name=" + encodeURIComponent("<%=pName%>") +
		                "&o_phone=" + encodeURIComponent("<%=pPhone%>") + 
		                "&o_email=" + encodeURIComponent("<%=pEmail%>") + 
		                "&price=" + encodeURIComponent("<%=price%>") + 
		                "&o_num=" + encodeURIComponent("<%=ONum%>") + 
		                "&pdPrice=" + encodeURIComponent("<%=pdPrice%>") + 
		                "&deliFee=" + encodeURIComponent("<%=deliFee%>");

		            if ("<%=mileage != null && !mileage.equals("")%>" === "true") {
		                url += "&mileage=" + encodeURIComponent("<%=mileage%>");
		            }
		            
		            if ("<%=dc != null && !dc.equals("")%>" === "true") {
		                url += "&dc=" + encodeURIComponent("<%=dc%>");
		            }
		            
		            if("<%=fIds.length != 0%>" === "true"){
		            	for (let i = 0; i < fIds.length; i++) {
			            	url += "&f_id=" + encodeURIComponent(fIds[i]);
			            }
		            }
		            
		            for (let i = 0; i < pd_ids.length; i++) {
		            	url += "&pd_id=" + encodeURIComponent(pd_ids[i]);
		            	url += "&quantity=" + encodeURIComponent(quantities[i]);
		            }
		            console.log("결제 완료 이동 URL:", url);
		            location.href = url;
		            	
		            } else {
		                // 실패 처리
       	                if (document.referrer) {
		                    window.location.href = document.referrer;
		                } else {
		                    window.history.back();
		                }
		            }
		        });
               <%-- location.href="<%=P_NEXT_URL%>"; --%>
            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                alert(msg);
                //실패시 이동할 페이지
                if (document.referrer) {
                    window.location.href = document.referrer;
                } else {
                    window.history.back();
                }

            }
        });
    });
    </script> 
</body>
</html>