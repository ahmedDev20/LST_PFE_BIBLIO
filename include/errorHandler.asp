<% If LEN(Session("msg")) <> 0 Or LEN(Session("erreur")) <> 0 Then %>
    <div class="alert">
        <span class="closebtn"
            onclick="this.parentElement.style.opacity = '0';setTimeout(function(){document.querySelector('.alert').style.display = 'none'; }, 1000);">&times;
        </span>
        <h4>
            <%
            
            If LEN(Session("erreur")) <> 0 Then
                Response.Write Session("erreur")
                Response.End
            Else
                Response.Write Session("msg")
            End If 

            %>
        </h4>
    </div>
<% End If %>