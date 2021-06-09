const submitToggle = () => {
    const form = document.querySelector(".togglebtn");
    const alertSwitch = document.getElementById("togglebtn_key1"); 
    if (alertSwitch) {
        alertSwitch.addEventListener('click', () => {
            form.submit();
        });
    }
}

export default submitToggle;


