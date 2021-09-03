<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bean.MemberDTO"%>
<%@page import="bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("utf-8"); %>
    <%
String id = (String)session.getAttribute("id");
String account = request.getParameter("account");
MemberDTO dto = new MemberDTO();
dto.setId(id);
MemberDAO dao = new MemberDAO();
ArrayList<Object> list = dao.acccount(dto);
String[] accountNameList = String.valueOf(list.get(0)).split(",");
ArrayList<String> list2 = new ArrayList<>(Arrays.asList(accountNameList));

int result = 0;
if (account.length() != 1 && account.charAt(account.length() - 1) == '1'){
	while (list2.indexOf("") != -1) {
		list2.remove("");
	}
	if (account != null) {
		if (list2.size() < Integer.parseInt(list.get(1).toString())) {
			String newAccount = "";
			for (String s : list2) {
				newAccount = newAccount + "," + s;
			}
			newAccount = newAccount + "," + account.substring(0, account.length() - 1);
			dto.setAccount(newAccount);
			result = dao.update(dto);
		} else {
			result = 2;
		}
	}
	
} else if (account.length() != 1 && account.charAt(account.length() - 1) == '2') {
	if (account != null) {
		list2.remove(account.substring(0, account.length() - 1));
		
		String newAccount = "";
		for (String s : list2) {
			newAccount = newAccount + "," + s.toString();
		}
		dto.setAccount(newAccount);
		result = dao.update(dto);
		result = 3;
	}
}
%><%= result %>
