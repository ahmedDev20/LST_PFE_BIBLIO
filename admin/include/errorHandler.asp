<% if LEN(Session("msg")) <> 0 or LEN(Session("msg_emprunt")) <> 0 or LEN(Session("msg_emprunt")) <> 0 then %>
    <div class="alert">
        <span class="closebtn"
            onclick="this.parentElement.style.opacity = '0';setTimeout(function(){document.querySelector('.alert').style.display = 'none'; }, 1000);">&times;
        </span>
        <h4>
            <%=Session("msg_emprunt")%>
            <%=Session("msg")%>
            <%=Session("sign_up")%>
        </h4>
    </div>
<% end if %>