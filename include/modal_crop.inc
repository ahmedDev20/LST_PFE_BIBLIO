<div id="Crop-img" class="Crop-img-class">
  <div class="crop-content">
    <form name="CropForm" id="CropForm" method="POST" action="CropAction.asp">
      <span class="BTfermer">&times;</span>
      <table align="left">
        <tr style="height: 30px;">
          <td><input type="hidden" id="crd_x" name="crd_x" readonly /></td>
          <td><input type="hidden" id="crd_y" name="crd_y" readonly /></td>
          <td><input type="hidden" id="img_x" name="img_x" readonly /></td>
          <td><input type="hidden" id="img_y" name="img_y" readonly /></td>
          <td><input type="hidden" id="pos_x" name="pos_x" readonly /></td>
          <td><input type="hidden" id="pos_y" name="pos_y" readonly /></td>
        </tr>
      </table>
      <div class="ratio-menu">
        <input type="hidden" id="ratio" name="ratio" value="1.0" readonly />
        <img
          src="./img/zoom-in.png"
          alt="zoom-in"
          onclick="javscript:ResizeUp();"
        />
        <br />
        <img
          src="./img/zoom-out.png"
          alt="zoom-out"
          onclick="javscript:ResizeDown();"
        />
        <input
          type="button"
          name="BtCrop"
          id="BtCrop"
          value="Crop"
          onclick="javascript:Crop();"
        />
      </div>
    </form>
    <div class="img-content">
      <div id="img" class="dragDrop" style="top: 0px; left: 0px;">
        <img id="photo" style="border:1px dashed navy;"
        src="./img/Clients/<%=Session("fname")%>">
      </div>
      <div
        id="crd"
        class="dragDrop"
        style="
          top: 140px;
          left: 140px;
          border: 2px dashed navy;
          width: 250px;
          height: 300px;
        "
      ></div>
    </div>
  </div>
</div>
<script>
  var modal = document.getElementById("Crop-img");
  var span = document.getElementsByClassName("BTfermer")[0];
  span.onclick = function () {
    modal.style.display = "none";
  };
</script>
