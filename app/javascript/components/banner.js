import Typed from "typed.js";

let typedElement;
const loadDynamicBannerText = () => {
  if (document.querySelector("#banner-typed-text")) {
  typedElement = new Typed("#banner-typed-text", {
    strings: ["Travel Colour", "Travel restriction free", "Travel Covid free", "Travel free", "Travel with smile"],
    typeSpeed: 50,
    loop: true,
  });}
};
const destroyDynamicBannerText = () => {
  if (document.querySelector("#banner-typed-text")) {
  typedElement.destroy();
  }
};

export { loadDynamicBannerText, destroyDynamicBannerText };
