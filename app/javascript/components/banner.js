import Typed from "typed.js";

let typedElement;
const loadDynamicBannerText = () => {
  typedElement = new Typed("#banner-typed-text", {
    strings: ["Travel Colour", "Travel restriction free", "Travel Covid free", "Travel free", "Travel with smile"],
    typeSpeed: 50,
    loop: true,
  });
};
const destroyDynamicBannerText = () => {
  typedElement.destroy();
};

export { loadDynamicBannerText, destroyDynamicBannerText };
