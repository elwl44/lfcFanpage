<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>


var retVal = confirm("이메일 인증 후 시도해주세요. \n 인증 메일을 재발송 하시겠습니까?");

var email = '${email}';
email = email.trim();

if( retVal == true ){
   alert(email+"로 인증메일을 재발송하였습니다");
   
   location.replace("/usr/member/doReSendJoinCompleteMail?email="+email);
}else{
   history.back();
}

</script>