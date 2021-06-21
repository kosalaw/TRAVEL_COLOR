// Get the modal

const popUpModal = () => {
  var modals = document.getElementById("myMoodal");
  var spans = document.getElementsByClassName("close")[0];

  if (spans&&modals) {
  // When the user clicks on <span> (x), close the modal
  spans.onclick = function () {
    modals.style.display = "none";
  };

  // When the user clicks anywhere outside of the modal, close it
  window.onclick = function (event) {
    if (event.target == modals) {
      modals.style.display = "none";
    }
  };
  }
};

export { popUpModal };
