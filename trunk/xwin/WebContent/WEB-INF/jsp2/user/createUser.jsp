<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<form action='./createUser.aspx' method='post'>
	<table>
		<tr>
			<td>USERID</td>
			<td><input type='text' name='userId'></td>
		</tr>
		<tr>
			<td>NICKNAME</td>
			<td><input type='text' name='nickName'></td>
		</tr>
		<tr>
			<td>EMAIL</td>
			<td><input type='text' name='email'></td>
		</tr>
		<tr>
			<td>BALANCE</td>
			<td><input type='text' name='balance'></td>
		</tr>
		<tr>
			<td>SUBMIT</td>
			<td><input type='submit'></td>
		</tr>
	</table>
</form>
</body>
</html>