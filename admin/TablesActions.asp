<!--#include file="include/security.asp"-->
<%
Set connection = Server.CreateObject("ADODB.Connection")
Set rS = Server.CreateObject("ADODB.RecordSet")
Set rS2 = Server.CreateObject("ADODB.RecordSet")
connection.Open Application("DB")
rS.CursorLocation = adUseClient 
rS2.CursorLocation = adUseClient
On Error Resume Next

'recuperation des parametres 
TABLE         = Request.QueryString("table")
retourEmp     = Request.QueryString("retourEmp")
operation     = Request.queryString("opera")
etatAb        = Request.QueryString("etat")
previousPage  = Request.QueryString("previous")
origin        = Request.QueryString("origin")
multiAbonn    = Request.QueryString("multiAbonn")
IdEmprOnly    = Request.QueryString("emprOnly")
previousPage = previousPage & origin

' GESTION DES ERRUERS
Sub CheckErrors
  If Err.Number <> 0 Then
    Session("msg") = "Une Erreur est survenue ! <br> Description : "&Err.Description
    rS.Close()
    rS2.Close()
    connection.Close()
    Set rS = nothing
    Set rS2 = nothing
    Set connection = nothing
  Else  
    If TABLE = "TEMPRUNTS" Then
      Session("msg") = rS2("MSG")
    Else
      Session("msg") = "Operation effectué avec succès !"
    End If
      For j = 1 to i 
        Session("data"&j) = ""
      Next
  End If
End Sub

'recuperation des valeurs d'insertion
dim valeursForm(20), i
i = 1
for each valeur in Request.Form("data[]")
  valeursForm(i) = valeur
  valeur = Replace(valeur, "'", "''")
  valeur = Trim(valeur)
  Session("data"&i) = valeur
  Response.Write Session("data"&i) &"<br>"
  i = i + 1
Next

If  operation = "insert" Then
    If IdEmprOnly <> "true" Then previousPage = previousPage & "&table="&TABLE End If

  If  TABLE <> "TEMPRUNTS" and multiAbonn = "null" then
    rS.Open TABLE, connection, 3, 3
    rs.AddNew
    for j = 1 to i - 1
      rs(rs(j).name).value = valeursForm(j)
    Next
    rS.Update
    CheckErrors
    'si on ajoute un client on lui associe explicitement une offre    
    If TABLE = "TCLIENTS" Then
      rS2.Open "SELECT IDENT_CURRENT('TCLIENTS') AS NEWID", connection
      newID = rS2("NEWID")
      rS2.Close
      rS2.Open "TABONNEMENTS", connection, 3, 3
      rS2.AddNew
      rS2("IdClient") = newID
      rS2("IdOffre") = valeursForm(15)
      rS2.Update
      CheckErrors
    End If
    For j = 1 to i 
        Session("data"&j) = ""
      Next
    Response.Redirect previousPage

  ElseIf  TABLE = "TABONNEMENTS" AND LEN(multiAbonn) <> 0 Then
    'le cas d'association dune offre a un ou plusieurs abonns
    for each val in split(multiAbonn, " | ")
      Req = "INSERT INTO TABONNEMENTS(IdClient, IdOffre) VALUES  ('"&val&"','"&valeursForm(2)&"')"
      connection.execute Req
    Next
    CheckErrors
    Response.Redirect previousPage

  ElseIf  TABLE = "TEMPRUNTS" Then
    If retourEmp = "true" and IdEmprOnly = "true" Then 'retourner l'ex a partir des operations
      query = "SELECT IdAbonnement AS idAb, IdExemplaire AS idEx FROM TEMPRUNTS WHERE IdEmprunt ="&Request.Form("cb[]")(1)
      rS.Open query , connection, 3, 3
      idAb = rS("idAb")
      idEx = rS("idEx")
      query = "ps_emprunt_retour "&idAb&","&idEx
    ElseIf retourEmp = "true" and Len(withIdEmprOnly) = 0 Then 'retourner l'ex a partir du formulaire
      query = "ps_emprunt_retour "&valeursForm(1)&","&valeursForm(2)
    Else
      query = "ps_emprunt_sortie "&valeursForm(1)&","&valeursForm(2)
    End If
    rS2.open query, connection, 3, 3
    CheckErrors
    Response.Redirect previousPage
  End If
ElseIf  operation = "update" Then
  If TABLE = "TOFFRES" Then
    c = 0
    For j = 1 to CInt(i / 4)
        Req = "UPDATE TOFFRES SET DesignationOffre = '"&valeursForm(c + 1)&"' ,NbrLivresOffre ="&valeursForm(c+2)&",NbrJoursOffre ="&valeursForm(c+3)&",PrixOffre ="&valeursForm(c+4)&" WHERE IdOffre ="&Request.Form("ids[]")(j)
        c = c + 4
      connection.execute Req
    Next
  Else
    for each val in Request.Form("cb[]")
      Req = "UPDATE TABONNEMENTS SET EtatAbonnement = "&etatAb &" WHERE IdAbonnement = "&val
      connection.execute Req
    Next
  End If
  CheckErrors
  Response.Redirect previousPage
ElseIf  operation = "delete" Then
  for each val in Request.Form("cb[]")
    Req = "DELETE "&Session("nomTable")&" WHERE "&Session("nomId")&"="&val
    connection.execute Req
  Next
  CheckErrors
  Response.Redirect previousPage
End If

%>