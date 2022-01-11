<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
If Len(Session("IdUser")) = 0 or Session("user") = "client"  Then
Session("err") = "Veuillez vous identifier"
Response.redirect "../Login.asp"
End If
prio = Session("Priority")
%>