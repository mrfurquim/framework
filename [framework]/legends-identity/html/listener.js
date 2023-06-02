$(function() {
  $('#idcard').hide();
  window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "ui" && item.display === true) {
      $('#idcard').show();
      document.getElementById('signature').innerHTML = generateSignature(item.completename); // Exibe a assinatura gerada usando completename
      // document.getElementById('completename').innerHTML = " " + item.completename;
      document.getElementById('birthdate').innerHTML = " " + item.birthdate;
      document.getElementById('corsivo').innerHTML = " " + item.corsivo;
      document.getElementById('citizenid').innerHTML = " " + item.citizenid;
      document.getElementById('gender').innerHTML = " " + item.gender1;

    } else {
      $('#idcard').hide();
    }
  }, false);
});