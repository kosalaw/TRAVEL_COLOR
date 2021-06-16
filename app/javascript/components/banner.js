import Typed from "typed.js";

let typedElement;
const loadDynamicBannerText = () => {
  typedElement = new Typed("#banner-typed-text", {
    strings: ["Hey ho", "Let's Go"],
    typeSpeed: 50,
    loop: true,
  });
};
const destroyDynamicBannerText = () => {
  typedElement.destroy();
};

export { loadDynamicBannerText, destroyDynamicBannerText };
