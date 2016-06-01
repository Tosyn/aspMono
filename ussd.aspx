<%@ Page Language="VB" %>

<%
' Line below shows how to set the required header and body in VB
Response.AppendHeader("Content-Type", "text/plain")
Response.Write("status=CONTINUE&reply=Some Message")
%>
