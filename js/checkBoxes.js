let tab = document.querySelector(".table-wrap table");

tab.onclick = function () {
  let target = event.target;
  let id = target.id;
  let name = target.name;
  //si on clicke le checkbox selectAll
  if (id == "sel-all") {
    SelectAll();
  }
  //si on click un des checkboxes
  if (name == "cb[]") {
    isAllchecked();
  }
};
function SelectAll() {
  let checkAll = document.querySelector("#sel-all");
  let boxes = document.querySelectorAll("input[type=checkbox]");

  event.target.checked
    ? boxes.forEach((element) => {
        element.checked = true;
      })
    : boxes.forEach((element) => {
        element.checked = false;
      });
}
function isAllchecked() {
  let checkAll = document.querySelector("#sel-all");
  let boxes = document.querySelectorAll("tbody input[type=checkbox]");
  let checkedBoxes = document.querySelectorAll("tbody input[type=checkbox]:checked");
  checkAll.checked = checkedBoxes.length === boxes.length ? true : false;
}
