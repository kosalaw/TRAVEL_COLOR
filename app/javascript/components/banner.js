import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["COVID-19 travel info."],
    typeSpeed: 80,
    loop: true
  });
}

export { loadDynamicBannerText };