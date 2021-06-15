import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  console.log("hello")
  if (document.getElementById("banner-typed-text")) {
    new Typed('#banner-typed-text', {
      strings: ["Travel Colour", "Travel restriction free", "Travel Covid free", "Travel free", "Travel with smile"],
      typeSpeed: 80,
      loop: true
    });
  }
}


const destroyDynamicBannerText = () => {
  document.getElementById("banner-typed-text").innerText = ""
}

export { loadDynamicBannerText, destroyDynamicBannerText };
